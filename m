Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <44DB5364.8020009@myTUM.de>
Date: Thu, 10 Aug 2006 17:40:20 +0200
From: Walter Bamberger <Walter.Bamberger@myTUM.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Inquiry time
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0277994344=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--===============0277994344==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms080203090206020000050509"

This is a cryptographically signed message in MIME format.

--------------ms080203090206020000050509
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I have a Nokia N70 mobile phone and a MSI 3X BTOES (Ver. 476-BW). Both
claim to be Bluetooth 2.0+EDR devices. As I read, those device have an
improved device inquiry time of about 4 seconds.

However when I do a

	hcitool scan

or a
	
	hcitool inq

both take the usual 10 to 12 seconds as of Bluetooth 1.1. What is the
reason for this behaviour and how can I change it?

Below I added some information about the devices.

Thanks, Simon




$ sudo hcitool info 00:17:4B:14:F2:A8
Requesting information ...
        BD Address:  00:17:4B:14:F2:A8
        Device Name: Nokia N70
        LMP Version: 2.0 (0x3) LMP Subversion: 0x6cc
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xbf 0xee 0x0f 0x46 0x98 0x19 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <sniff mode> <RSSI>
                <channel quality> <SCO link> <HV3 packets> <u-law log>
                <A-law log> <CVSD> <paging scheme> <power control>
                <transparent SCO> <EDR ACL 2 Mbps> <EDR ACL 3 Mbps>
                <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
                <3-slot EDR ACL> <5-slot EDR ACL> <AFH cap. master>
                <AFH class. master>


$ sudo hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:72:CA:36:97 ACL MTU: 1017:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1905 acl:0 sco:0 events:61 errors:0
        TX bytes:419 acl:0 sco:0 commands:29 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'ldvpc19-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x204d LMP Ver: 2.0 (0x3) LMP
Subver: 0x4127        Manufacturer: Broadcom Corporation (15)


$ hciconfig hci0 features
hci0:   Type: USB
        BD Address: 00:02:72:CA:36:97 ACL MTU: 1017:8 SCO MTU: 64:8
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO> <broadcast encrypt> <EDR ACL 2 Mbps>
                <EDR ACL 3 Mbps> <enhanced iscan> <interlaced iscan>
                <interlaced pscan> <inquiry with RSSI> <extended SCO>
                <EV4 packets> <EV5 packets> <AFH cap. slave>
                <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
                <AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps>
                <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features>


$ hciconfig hci0 inqmode
hci0:   Type: USB
        BD Address: 00:02:72:CA:36:97 ACL MTU: 1017:8 SCO MTU: 64:8
        Inquiry mode: Standard Inquiry


wbam@ldvpc19:~$ hciconfig hci0 inqtype
hci0:   Type: USB
        BD Address: 00:02:72:CA:36:97 ACL MTU: 1017:8 SCO MTU: 64:8
        Inquiry scan type: Interlaced Inquiry Scan

--------------ms080203090206020000050509
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIHyDCC
A+AwggNJoAMCAQICDwDy4wABAALmiKckCv67EDANBgkqhkiG9w0BAQQFADCBvDELMAkGA1UE
BhMCREUxEDAOBgNVBAgTB0hhbWJ1cmcxEDAOBgNVBAcTB0hhbWJ1cmcxOjA4BgNVBAoTMVRD
IFRydXN0Q2VudGVyIGZvciBTZWN1cml0eSBpbiBEYXRhIE5ldHdvcmtzIEdtYkgxIjAgBgNV
BAsTGVRDIFRydXN0Q2VudGVyIENsYXNzIDEgQ0ExKTAnBgkqhkiG9w0BCQEWGmNlcnRpZmlj
YXRlQHRydXN0Y2VudGVyLmRlMB4XDTA1MTAxODEyNDkyNloXDTA2MTEyNjEyNDkyNlowUjEL
MAkGA1UEBhMCREUxGTAXBgNVBAMTEFdhbHRlciBCYW1iZXJnZXIxKDAmBgkqhkiG9w0BCQEW
GVdhbHRlci5CYW1iZXJnZXJAbXl0dW0uZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQD0uW+wwsM6iOmbz6+JEHsxidD7zTtNXMIADCKyyr8FuG403lPqwZc/faj1SFzTteYX
/WlGSZP1U2FZufeHuj6QGq1jFL5gyF8OAhoIlONO00RpHa/qtNdqsxoYY+vfbZDK30AQkAdz
sAtg4TRk21KX7iIZkf7GhqJ0QvD2bcDTkgBXEW5tutd8rI57kps80tIUqDCbm30TjdP16Tan
GisVJojl2FJK2BcE1bS//n/XdBGBpUG/RXCiYmCgbAUNYJcgsh12Ff11jtEmoIJSKbanKE7s
a81383hjaaW/IgjZq2n0gxf1fCC3n44sDFVzATi0fMZFLRRnWYVziteVy8efAgMBAAGjgcgw
gcUwDAYDVR0TAQH/BAIwADAOBgNVHQ8BAf8EBAMCBeAwMwYJYIZIAYb4QgEIBCYWJGh0dHA6
Ly93d3cudHJ1c3RjZW50ZXIuZGUvZ3VpZGVsaW5lczARBglghkgBhvhCAQEEBAMCBaAwXQYJ
YIZIAYb4QgEDBFAWTmh0dHBzOi8vd3d3LnRydXN0Y2VudGVyLmRlL2NnaS1iaW4vY2hlY2st
cmV2LmNnaS9GMkUzMDAwMTAwMDJFNjg4QTcyNDBBRkVCQjEwPzANBgkqhkiG9w0BAQQFAAOB
gQB8ksHJYHCVxuJ8eaGyHCfwwXyay1ayYh0oG6lBDy2hamuZs7r6lagAOEcRntK+u5v/jz/G
LG6bOtwmjr0sl1lc9KCDMpbxNTRi7BdYv1GfnyypXydiqymq2mSv+N5hKQ4Ob3khGQgaCnh2
tILScCsCEgb2a5P3xi6QM387CeN7yTCCA+AwggNJoAMCAQICDwDy4wABAALmiKckCv67EDAN
BgkqhkiG9w0BAQQFADCBvDELMAkGA1UEBhMCREUxEDAOBgNVBAgTB0hhbWJ1cmcxEDAOBgNV
BAcTB0hhbWJ1cmcxOjA4BgNVBAoTMVRDIFRydXN0Q2VudGVyIGZvciBTZWN1cml0eSBpbiBE
YXRhIE5ldHdvcmtzIEdtYkgxIjAgBgNVBAsTGVRDIFRydXN0Q2VudGVyIENsYXNzIDEgQ0Ex
KTAnBgkqhkiG9w0BCQEWGmNlcnRpZmljYXRlQHRydXN0Y2VudGVyLmRlMB4XDTA1MTAxODEy
NDkyNloXDTA2MTEyNjEyNDkyNlowUjELMAkGA1UEBhMCREUxGTAXBgNVBAMTEFdhbHRlciBC
YW1iZXJnZXIxKDAmBgkqhkiG9w0BCQEWGVdhbHRlci5CYW1iZXJnZXJAbXl0dW0uZGUwggEi
MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQD0uW+wwsM6iOmbz6+JEHsxidD7zTtNXMIA
DCKyyr8FuG403lPqwZc/faj1SFzTteYX/WlGSZP1U2FZufeHuj6QGq1jFL5gyF8OAhoIlONO
00RpHa/qtNdqsxoYY+vfbZDK30AQkAdzsAtg4TRk21KX7iIZkf7GhqJ0QvD2bcDTkgBXEW5t
utd8rI57kps80tIUqDCbm30TjdP16TanGisVJojl2FJK2BcE1bS//n/XdBGBpUG/RXCiYmCg
bAUNYJcgsh12Ff11jtEmoIJSKbanKE7sa81383hjaaW/IgjZq2n0gxf1fCC3n44sDFVzATi0
fMZFLRRnWYVziteVy8efAgMBAAGjgcgwgcUwDAYDVR0TAQH/BAIwADAOBgNVHQ8BAf8EBAMC
BeAwMwYJYIZIAYb4QgEIBCYWJGh0dHA6Ly93d3cudHJ1c3RjZW50ZXIuZGUvZ3VpZGVsaW5l
czARBglghkgBhvhCAQEEBAMCBaAwXQYJYIZIAYb4QgEDBFAWTmh0dHBzOi8vd3d3LnRydXN0
Y2VudGVyLmRlL2NnaS1iaW4vY2hlY2stcmV2LmNnaS9GMkUzMDAwMTAwMDJFNjg4QTcyNDBB
RkVCQjEwPzANBgkqhkiG9w0BAQQFAAOBgQB8ksHJYHCVxuJ8eaGyHCfwwXyay1ayYh0oG6lB
Dy2hamuZs7r6lagAOEcRntK+u5v/jz/GLG6bOtwmjr0sl1lc9KCDMpbxNTRi7BdYv1Gfnyyp
Xydiqymq2mSv+N5hKQ4Ob3khGQgaCnh2tILScCsCEgb2a5P3xi6QM387CeN7yTGCBHcwggRz
AgEBMIHQMIG8MQswCQYDVQQGEwJERTEQMA4GA1UECBMHSGFtYnVyZzEQMA4GA1UEBxMHSGFt
YnVyZzE6MDgGA1UEChMxVEMgVHJ1c3RDZW50ZXIgZm9yIFNlY3VyaXR5IGluIERhdGEgTmV0
d29ya3MgR21iSDEiMCAGA1UECxMZVEMgVHJ1c3RDZW50ZXIgQ2xhc3MgMSBDQTEpMCcGCSqG
SIb3DQEJARYaY2VydGlmaWNhdGVAdHJ1c3RjZW50ZXIuZGUCDwDy4wABAALmiKckCv67EDAJ
BgUrDgMCGgUAoIICezAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0wNjA4MTAxNTQwMjBaMCMGCSqGSIb3DQEJBDEWBBTK4MmDgiGUxKpoxOdoIb7cj/fOkjBS
BgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0D
AgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCB4QYJKwYBBAGCNxAEMYHTMIHQMIG8MQsw
CQYDVQQGEwJERTEQMA4GA1UECBMHSGFtYnVyZzEQMA4GA1UEBxMHSGFtYnVyZzE6MDgGA1UE
ChMxVEMgVHJ1c3RDZW50ZXIgZm9yIFNlY3VyaXR5IGluIERhdGEgTmV0d29ya3MgR21iSDEi
MCAGA1UECxMZVEMgVHJ1c3RDZW50ZXIgQ2xhc3MgMSBDQTEpMCcGCSqGSIb3DQEJARYaY2Vy
dGlmaWNhdGVAdHJ1c3RjZW50ZXIuZGUCDwDy4wABAALmiKckCv67EDCB4wYLKoZIhvcNAQkQ
AgsxgdOggdAwgbwxCzAJBgNVBAYTAkRFMRAwDgYDVQQIEwdIYW1idXJnMRAwDgYDVQQHEwdI
YW1idXJnMTowOAYDVQQKEzFUQyBUcnVzdENlbnRlciBmb3IgU2VjdXJpdHkgaW4gRGF0YSBO
ZXR3b3JrcyBHbWJIMSIwIAYDVQQLExlUQyBUcnVzdENlbnRlciBDbGFzcyAxIENBMSkwJwYJ
KoZIhvcNAQkBFhpjZXJ0aWZpY2F0ZUB0cnVzdGNlbnRlci5kZQIPAPLjAAEAAuaIpyQK/rsQ
MA0GCSqGSIb3DQEBAQUABIIBADAv0osDzTeLtrEzM55p7uiFOKu+IM5f3BG6hE7VzEO30tMq
CnK8QltTu8DzLZwOwW2jMEYyJLIEL1TTRWXYKxmPZmPgb361vbCqYG1A61O1DpQQbKbq+Oe0
nsaZ812MT1I6Lg/qNV5+Pn+QfwUduBoQ9+Eo/ch11/pVX+7gb0lf3iuY882mGVTC0b+F9OLi
ClZbbhgnE36w/Oez7EABjxCFdG7rJwc2JJPY8fEkKFQYAE8sKy1DpOnjar1Z4oRzB+3uYfZN
73N/RCK4Zz/G7MmGj4qKksaNVzpBkFwJhX37wqQ+oVN1noudzvC98YRxFXge+Cv1zsAWojtw
5QczUQAAAAAAAAA=
--------------ms080203090206020000050509--


--===============0277994344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0277994344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0277994344==--
