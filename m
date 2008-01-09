Return-Path: <cyrus@holtmann.org>
Mime-Version: 1.0 (Apple Message framework v753)
In-Reply-To: <d89ddf300801082015h2e6595aew179fe502d6ea3e0c@mail.gmail.com>
References: <478448C4.3020102@psu.edu>
	<d89ddf300801082015h2e6595aew179fe502d6ea3e0c@mail.gmail.com>
Message-Id: <CAEA8AA4-10DE-45EE-A13C-E0F701977BDB@psu.edu>
From: Chip McArtor <mcm262@psu.edu>
Date: Wed, 9 Jan 2008 09:01:00 -0500
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Headset audio capture failing when using Bluez's
	ALSA plugin
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0313149826=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0313149826==
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-1-389245552;
	protocol="application/pkcs7-signature"


--Apple-Mail-1-389245552
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Excellent, I tried the bluez-utils cvs, and now both playback and  
recording seem to be working.  I'm not at home right now, so I  
couldn't do an actual voice recording, but the headset mic seems to  
record the noise of humming computer fans perfectly. XD

Thanks for your help!
Chip

On Jan 8, 2008, at 11:15 PM, Brad Midgley wrote:

> Chip
>
> A possible fix was just committed to bluez-utils cvs.
>
> Brad

--Apple-Mail-1-389245552
Content-Transfer-Encoding: base64
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Disposition: attachment;
	filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGOTCCAvIw
ggJboAMCAQICDyIwHzRAyYcVEXqp2OhBsDANBgkqhkiG9w0BAQUFADBiMQswCQYDVQQGEwJaQTEl
MCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDcwMjAzMTcyNDMzWhcNMDgwMjAzMTcyNDMz
WjBdMRAwDgYDVQQEEwdNY0FydG9yMRAwDgYDVQQqEwdNaWNoYWVsMRgwFgYDVQQDEw9NaWNoYWVs
IE1jQXJ0b3IxHTAbBgkqhkiG9w0BCQEWDm1jbTI2MkBwc3UuZWR1MIIBIjANBgkqhkiG9w0BAQEF
AAOCAQ8AMIIBCgKCAQEAxHmPEiAzr3xETa2/Xg6ajPb1eHeIo8vp35FiPkuTLyw8KlRSVWWqvaB6
gDHyzOTL4agarShlMDMyCbAbh1aalyjbGqecVw55HxbjhuaKLy0FEMfGdP8c51IbdEj7vWJMEk9p
HbJCRB3PywOPcWsyBY5bclxQz1ZtyeAd8Saq2ndar3OzmcDqLs5gwAmOBVIk27NOPka9lVv5vSJ5
+81RzNOCrEe3YOiO8QIelcTSQe0GUODSY5M9Vq2deUwZvC2FvWE9qcqJnTJuBOUEtVIMtJpkSFtg
AAbAU/V89ueuGaXm0EBLOPg+saAtXw+nAAsF4w9G/V7nnh4xrMFbj+J0nwIDAQABoyswKTAZBgNV
HREEEjAQgQ5tY20yNjJAcHN1LmVkdTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBAEVe
OSqfdxKAJyyddcYgoNDv6waLgQTwK8lZgQGPGA9MNdIqSk8P5Cdl5LfjVRNOWSBJUBq3+dTlNwBT
v8GBSzaK7u7SiRXgHUlLWST0P8p8MjjTqt7dY7Zt0FdoQQKaEKXPIsbV5AhWBM5OXtRyhkLQGPDl
ceHs7uRsf0btBQ3uMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMC
WkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFU
aGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lv
bjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxw
ZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1
OVowYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4x
LDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3
DQEBAQUAA4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9R
zgHU5VAKMNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CA
AmTXp6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYB
Af8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNv
bmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQ
cml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+wheh
Q5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3d
qZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCAw0wggMJ
AgEBMHUwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0
ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAg8iMB80QMmH
FRF6qdjoQbAwCQYFKw4DAhoFAKCCAW0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMDgwMTA5MTQwMTAxWjAjBgkqhkiG9w0BCQQxFgQUSSlyr6hSlO/tpF4ExpkWskfd
CMswgYQGCSsGAQQBgjcQBDF3MHUwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25z
dWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1
aW5nIENBAg8iMB80QMmHFRF6qdjoQbAwgYYGCyqGSIb3DQEJEAILMXegdTBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3Rl
IFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECDyIwHzRAyYcVEXqp2OhBsDANBgkqhkiG9w0B
AQEFAASCAQAr421jlH1VJi1e/kLdiC7XaerEdYKBtsebvciSn5ifnfffIu8jQCfoLDkIDiBpyXHy
h8ph2bRny3wXqKZDle/gDvqxZLBFEqp/nKeLG9hDHb3IIgo7test8J7mbTUXwKsnR01oTa9Uahrk
9KVFGmVQuX+124P77djwGrwlGYaFHne+FQPnMGgGJIYxPuzSeduZ+h2/avJaqKZNuOkXVWCAny59
ifuhmQU6u8E4pBgsgp2wNM8Pr8c/s+rzgjurachM+Kc+o8Mwot/JD1UPRRnNxnvp8DUY0QDjjhFz
HgodmCHEn6xamAK0aEOhbaQpTZuZGjSrT3oZLLR+gF0shJVKAAAAAAAA

--Apple-Mail-1-389245552--


--===============0313149826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0313149826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0313149826==--
