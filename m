Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4227A238.5030003@emenaker.com>
From: Joe Emenaker <joe@emenaker.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="=_fruitpie-2336-1109893399-0001-2"
To: Bluez Users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Automatically accepting pairing from a mouse?
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 03 Mar 2005 15:48:08 -0800

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_fruitpie-2336-1109893399-0001-2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please forgive the newbie question... I'm still a little new to how 
bluetooth devices interact.

I've got bluez-utils running on my debian laptop and I can use it to 
find my bluetooth mouse.
I can run "hcitool scan" and, provided that I've clicked the little 
"pairing" button on my mouse, the scan finds it.
Then, I can run "hidd --connect aa:bb:cc:dd:ee:ff" (not the actual hw 
address I use) and it connects!

However, I'd like to avoid having to open a konsole window and do this 
pairing every time I boot my laptop. Furthermore, the mouse I have likes 
to go to sleep after about 5-10 minutes of inactivity... at which point 
it requires pairing again.

It would be nice if I could just click the pairing button on my mouse 
and have the rest happen automatically.

In an attempt to do this, I've changed my "HIDD_OPTIONS=--master 
--server" to "HIDD_OPTIONS=-i aa:bb:cc:dd:ee:ff --server", but this 
doesn't seem to have done anything.

So now, I'm kinda stuck. I guess I'm looking for a bluetooth equivalent 
to "waproamd" for WiFi, where it periodically scans for available 
devices and connects to them if it has a configuration for it.

Is there anything in bluez-utils that does auto-scan-and-connect like that?

If not, what's the alternative? Do I have to find a mouse that can 
scan-and-connect from *it's* end?

Lastly, does anyone have any suggestions for a better mouse? My current 
one is pretty nifty, though. It has an on/off switch so that I can save 
batteries when the laptop is packed away. And it's a mini-style. But the 
timeout-sleep thing is just killing me....

- Joe

--=_fruitpie-2336-1109893399-0001-2
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJBTCC
At0wggJGoAMCAQICAwwUfTANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDQwNDA2MjI0MTU5WhcNMDUwNDA2MjI0MTU5
WjBCMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMR8wHQYJKoZIhvcNAQkBFhBq
b2VAZW1lbmFrZXIuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3awIQN2H
/KxzHtV1DiCWKsliYiK5DvptqV118BRgEmlBnSFWPWfP/sJKSfd/Wrb/QNX7j3VEiOEJVBiZ
OLIb28NK4BPZhtOT8+2ZJkKqLZd+JqZIlvGX4xpVJb7O3wZ8gcfMX4YGk3J+BVjevuIbabTF
IXTYF8YqgH664sUat4DgjPeLzXNED+Mq58L4EvcH7BN6F1o2BD1xz4kCQMQctAXqDukGKZ40
nTv+wPvnwBlROda1NzzO2DPDedNUnN6YJiTJTULaRJ7v/fDKcjPIE/+QAkV5PTCbrL15bcPH
ECFI0PCGFmZhDGMr71EFVu7TgeD0Lf2R3892qLN3VD7yvwIDAQABoz0wOzAOBgNVHQ8BAf8E
BAMCBLAwGwYDVR0RBBQwEoEQam9lQGVtZW5ha2VyLmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqG
SIb3DQEBBAUAA4GBAEm2mlN1ERyAsZ33tO+l4FOAKQiTvLqQCzr960kANyKhFfhHcP+l+eJf
KJFmBu5Nx0l+mcQuf6CuT5mKUmgcHo7TkmNPvDE30uhfN/UCPA3EFRE4iIMlhq84yRbkRCRA
TjebkrMaiAfH/LGQwGrphf7+Xi6p4Y32nhARDM74sEFwMIIC3TCCAkagAwIBAgIDDBR9MA0G
CSqGSIb3DQEBBAUAMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGlu
ZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQTAeFw0wNDA0MDYyMjQxNTlaFw0wNTA0MDYyMjQxNTlaMEIxHzAdBgNVBAMTFlRoYXd0
ZSBGcmVlbWFpbCBNZW1iZXIxHzAdBgkqhkiG9w0BCQEWEGpvZUBlbWVuYWtlci5jb20wggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDdrAhA3Yf8rHMe1XUOIJYqyWJiIrkO+m2p
XXXwFGASaUGdIVY9Z8/+wkpJ939atv9A1fuPdUSI4QlUGJk4shvbw0rgE9mG05Pz7ZkmQqot
l34mpkiW8ZfjGlUlvs7fBnyBx8xfhgaTcn4FWN6+4htptMUhdNgXxiqAfrrixRq3gOCM94vN
c0QP4yrnwvgS9wfsE3oXWjYEPXHPiQJAxBy0BeoO6QYpnjSdO/7A++fAGVE51rU3PM7YM8N5
01Sc3pgmJMlNQtpEnu/98MpyM8gT/5ACRXk9MJusvXltw8cQIUjQ8IYWZmEMYyvvUQVW7tOB
4PQt/ZHfz3aos3dUPvK/AgMBAAGjPTA7MA4GA1UdDwEB/wQEAwIEsDAbBgNVHREEFDASgRBq
b2VAZW1lbmFrZXIuY29tMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEASbaaU3UR
HICxnfe076XgU4ApCJO8upALOv3rSQA3IqEV+Edw/6X54l8okWYG7k3HSX6ZxC5/oK5PmYpS
aBwejtOSY0+8MTfS6F839QI8DcQVETiIgyWGrzjJFuREJEBON5uSsxqIB8f8sZDAaumF/v5e
LqnhjfaeEBEMzviwQXAwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYD
VQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAY
BgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZp
Y2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzAp
BgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAw
MDAwWhcNMTMwNzE2MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENv
bnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWls
IElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5o
wHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuv
PAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAe
ZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0
hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDAL
BgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4
MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6ot
nzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V
2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDOzCCAzcCAQEwaTBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEs
MCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwwUfTAJBgUr
DgMCGgUAoIIBpzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0w
NTAzMDMyMzQ4MDhaMCMGCSqGSIb3DQEJBDEWBBQFoLMhiP2Wc3D2XLDQ47m+eOQImzBSBgkq
hkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDBR9MHoGCyqGSIb3DQEJEAIL
MWugaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkg
THRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwwU
fTANBgkqhkiG9w0BAQEFAASCAQDcCp2bvsX6f4L7rxXJmyzkge1lfI1u5pAcUZ4Nn4M+P5AR
olkQCIxB4BteDd24p6UJDdSbvrZQTidCYYxqZWeQ/0PqFuU13IV3ZWD3vyQqRMGd7QXKsG/X
gP7BF0uB5FI/5Bo+DXDT3k4qkB6zmZYIhaZKj9An8e/xE8jq6gPG7qL9ayT7EHdf2AdeG2Pt
6uoLc5FusZiSh0SaXc6e89lYPHF8gkw9DJjYB1SaYeTRag/UIaU5/eknxfeHx5FE/rbiooJ7
zz1HQp2LnTgL73d84ZbaUiMDqLtHkhHAZnCCDPQNjI8/AMN7gaPjuPsSxZ4MX5BcYh9eDHGd
KDwXb/UzAAAAAAAA
--=_fruitpie-2336-1109893399-0001-2--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
