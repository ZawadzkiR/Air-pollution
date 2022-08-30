# Air-pollution
Estimation of air pollution parameters using the maximum likelihood method and the Weibull distribution and log-normal distribution

<h3>Abstract</h3>
<br>
The aim of this study is an attempt to estimate the parameters of air pollution. An exemplary analysis of the PM10 dust measurement
at the Warszawa Ursynów metering station for 2020 was carried out. An attempt was made to estimate the parameters of log-normal and Weibull distributions using 
the maximum likelihood method. The study did not show positive results when using the maximum likelihood method based on both distributions when estimating PM10 dust.
<br>
<br>

<h3>Dataset</h3>
<br>
The data used in the study come from the website http://powiekieta.gios.gov.pl, the owner of the data is the Inspectorate for Environmental Protection. 
The database contains daily PM10 dust measurements in 2020.
<br>
<br>

<h3>Methodology</h3>
<br>

Two distributions were used in the study: log normal distribution and Weibull distribution. 
Maximum likelihood estimation using gradient and Hessian was used for both distributions, and then the 
simple hypothesis (one parameter test) and the complex hypothesis (two parameter test) were verified. The simple null hypothesis 
is based on the European Union's Air Quality Directive (2008 / EC / 50) and assumes that the PM10 value must not exceed 40 micrograms per cubic meter. 
On the other hand, the complex hypothesis poses the question of not exceeding 40 µg / m3 and the standard deviation of 10. To test the truth of the simple hypothesis, 
the Z statistic was used, while for the complex hypothesis, the likelihood ratio (LR) test was used.
<br>
<br>
<h3>Results</h3>

<table>
<thead>
  <tr>
    <th></th>
    <th colspan="3">Log-normal distribution</th>
    <th colspan="3">Weibull distribution</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td rowspan="2">H0: mu/k &lt; 40</td>
    <td>Statistic value</td>
    <td>p-value</td>
    <td>Results</td>
    <td>Statistic value</td>
    <td>p-value</td>
    <td>Results</td>
  </tr>
  <tr>
    <td>-685,39</td>
    <td>0</td>
    <td>Reject null hypotesis</td>
    <td>-52326,1</td>
    <td>0</td>
    <td>Reject null hypotesis</td>
  </tr>
  <tr>
    <td>H0: mu/k &lt; 40<br>&amp; sigma/lambda = 10</td>
    <td>1233,02</td>
    <td>0</td>
    <td>Reject null hypotesis</td>
    <td>3.82688x10^32</td>
    <td>0</td>
    <td>Reject null hypotesis</td>
  </tr>
</tbody>
</table>

<br>


The analysis carried out in this paper, taking into account the test results and the verification of the hypotheses, 
allows to state that it is impossible to estimate the parameters positively, using the maximum likelihood method when estimating PM10 dust with Weibull distributions
and log-normal. No test has shown that there is no reason to reject the null hypothesis. In particular, the Weibull distribution showed too high value of the LR test
statistic. It is possible that the estimation using the method of moments would have obtained better results. Also, the improvement of the results 
would be influenced by the logarithm of the dependent variable in order to bring the data closer to the normal distribution.

