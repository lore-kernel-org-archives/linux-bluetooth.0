Return-Path: <bluez-users-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v612)
To: bluez-users@lists.sourceforge.net
Message-Id: <D303E807-5443-11D8-9C26-000A959C67D2@mac.com>
Content-Type: multipart/signed; micalg=sha1; boundary=Apple-Mail-6-647164607; protocol="application/pkcs7-signature"
From: Alex Eiser <alexe@mac.com>
Subject: [Bluez-users] Creating a new SDP service
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 31 Jan 2004 18:18:48 -0500


--Apple-Mail-6-647164607
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Hi,

I need to create a custom SDP service to perform some communications 
between a Mac OS X machine and a linux machine. While I could 
accomplish this by using serial ports, this makes the macos programing 
a lot uglier.

Is there a way to create a new service with the SDP tool, with out 
adding new code to sdptool.c?

Alex


--Apple-Mail-6-647164607
Content-Transfer-Encoding: base64
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Disposition: attachment;
	filename=smime.p7s

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGDjCCAscw
ggIwoAMCAQICAws8qjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDMxMTI5MDYzODQ4WhcNMDQxMTI4MDYzODQ4WjA/MR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMRwwGgYJKoZIhvcNAQkBFg1hbGV4ZUBtYWMuY29tMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA26D0SquOKhbzwu+3wyMOR09HA0TBwWsI7MM4
Y+nbF99cLapwXpuvF+aO5NLJuHd7DlNTWpTqS00mIg8HbqqdyIwhgr88YrW46txE0B8ZEt4E3inx
9f16+/cTbF9OalzCps/6m7VoreQSH8EZnE+27uAPPm69+ArJ6YqKQSLJJ8+7naCKWwiWW4GhOF/j
QiGOnxL4T6uqDSFX72DtaVPhNckhMzIAx7MjSaK+ec398M3vkkWLw9X2WUrgq2yp1fRTcf5NM4ix
wYQucxPAnyILyfRczrluFiblYLIn2/lUhimASo+4d6FdTDujJs9/VfWzSciXufPgdoEGqz9Clb6B
owIDAQABoyowKDAYBgNVHREEETAPgQ1hbGV4ZUBtYWMuY29tMAwGA1UdEwEB/wQCMAAwDQYJKoZI
hvcNAQEEBQADgYEAWxgmAHBiAkEmZZtXfrlDOCRk2eboiXry6LVYRSdh5T4R/GPKi+ZVRawFpIKU
sII+HJyLtR6gkj8FSObAQShK3WM0c8NfkKyZ4CMGoq/8pm2hv9Ti2PGRKeFsFChQIKr+u8FBAs+a
12kfwasK4+XMSmQ/xYgnrLYkHsxvZi/RCIkwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUA
MIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRv
d24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNl
cnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzAp
BgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAw
WhcNMTMwNzE2MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRp
bmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vpbmcg
Q0EwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9
zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xz
gnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEw
EgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5j
b20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQe
MBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsu
zA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguC
dJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMd
Rv9dX2VPMYIC5zCCAuMCAQEwaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1
bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vp
bmcgQ0ECAws8qjAJBgUrDgMCGgUAoIIBUzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNDAxMzEyMzE4NDlaMCMGCSqGSIb3DQEJBDEWBBRl6nHmBSWh8XgJj8sLGJi5
YoUDszB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIDCzyqMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZy
ZWVtYWlsIElzc3VpbmcgQ0ECAws8qjANBgkqhkiG9w0BAQEFAASCAQB1EjlvwHlQi9xHz/9ecLGm
8/JQFw1CHupctsYDgYzgJNBliM+9k21nLrJh/ddoMwJXVzvyRx8VaKM2Ggax0z/rU2Ofy4HwGMu3
9cPmGik1niNzcMtS0sCnVWXRflwKL9t5whdiQkdpGtIhd1OfEBD60bdO5CTWnkAUdLjQ6n/4vlmE
z4uF34GHmLzYIpn0AMY2+JZpYWCZJUArwfZ4GtP49qnh7Ce6ND2Fb/SlF4nCNk2IL+rqgUttLwtS
VQgm4g6WLn7yMQN4CTvmC3hvXzMuAbOdk6ftnTf63XhX+ywWgc3yBDY6n1pUtal50Lc4n0HbIfH1
DwiUDuUEjOYjSH7hAAAAAAAA

--Apple-Mail-6-647164607--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
