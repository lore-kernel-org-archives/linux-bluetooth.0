Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40F69A7B.7040802@informatics.bangor.ac.uk>
From: Rob Shepherd <robshep@informatics.bangor.ac.uk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms040007000501030906020408"
Subject: [Bluez-devel] access to hci devices
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 15 Jul 2004 15:53:47 +0100

This is a cryptographically signed message in MIME format.

--------------ms040007000501030906020408
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello developers

I've written a basic bluetooth stack in java which is fine for my embedded java systems 
and talks H4 to a device out of a serial port.

I would like to talk to USB devices in Linux using my stack also.
Rather than re-invent the wheel, how hard would it be for me to fire my HCI packets at a 
usb device using the HCI-USB / HCI_UART bluez drivers?

many thanks

Rob


-- 
/**
  *	Rob Shepherd,
  *	University Of Wales, Bangor,
  *	School of Informatics,
  *	Dean Street,
  *	Bangor,
  *	Gwynedd, UK     /\  /\
  * 	LL57 1UT       /  \/  \ /\
  * 	--------------/---/    \--\----
  *
  *	robshep@informatics.bangor.ac.uk
  *
  * 	+44 (0) 1248 38 27
  */

--------------ms040007000501030906020408
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJJTCC
Au0wggJWoAMCAQICAww71jANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDQwNTAxMTcyNDAxWhcNMDUwNTAxMTcyNDAx
WjBSMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMS8wLQYJKoZIhvcNAQkBFiBy
b2JzaGVwQGluZm9ybWF0aWNzLmJhbmdvci5hYy51azCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAJlVHijX1+vUA8T2jjUB7Hk2QigRRq4H1QvdrscFu/wGWGw/4YEwmlbp2+kX
kT7MLb6RqJ39GiqaRcPeTpyrT8hR2KapHJmtiws0OQ/n2EwKQhGWldLfrc03Of4icJF9cbcs
xn0voQmW838R3aGkDhuq6xzKsdQrUc8Rd0iLeE4cLULKxG43eM+x8tVR72j6yiVf7+AP9xpl
IJaSjg4Gk/naEiIE5s0lB27KIt8HGJFw7qrYVK+/y3zUgeaq38rjbUndagjewCSaEnMfH5s9
hOCwHannHLx00DmhsYzKU/tgPtH8t9xJalryjt34zHL9FyXOTga7pc/GjkaxzXoEVPsCAwEA
AaM9MDswKwYDVR0RBCQwIoEgcm9ic2hlcEBpbmZvcm1hdGljcy5iYW5nb3IuYWMudWswDAYD
VR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQBdwP/W35VAGiD9j3DiNi3crKuoiKjZ10vh
Wn5pVcQnCNiCv2AKrE+BEu4/Y00MbUvbg0OK0S0buXm4u/p4n/z/aSVKcTtxvSqk43Cy4KJ6
N6zNSlv65ECARqt9uA66J7AylKSyoIXNqsa44xSukkidGrsMHpHOdMVfEIxzdDRTuDCCAu0w
ggJWoAMCAQICAww71jANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDQwNTAxMTcyNDAxWhcNMDUwNTAxMTcyNDAxWjBS
MR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMS8wLQYJKoZIhvcNAQkBFiByb2Jz
aGVwQGluZm9ybWF0aWNzLmJhbmdvci5hYy51azCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAJlVHijX1+vUA8T2jjUB7Hk2QigRRq4H1QvdrscFu/wGWGw/4YEwmlbp2+kXkT7M
Lb6RqJ39GiqaRcPeTpyrT8hR2KapHJmtiws0OQ/n2EwKQhGWldLfrc03Of4icJF9cbcsxn0v
oQmW838R3aGkDhuq6xzKsdQrUc8Rd0iLeE4cLULKxG43eM+x8tVR72j6yiVf7+AP9xplIJaS
jg4Gk/naEiIE5s0lB27KIt8HGJFw7qrYVK+/y3zUgeaq38rjbUndagjewCSaEnMfH5s9hOCw
HannHLx00DmhsYzKU/tgPtH8t9xJalryjt34zHL9FyXOTga7pc/GjkaxzXoEVPsCAwEAAaM9
MDswKwYDVR0RBCQwIoEgcm9ic2hlcEBpbmZvcm1hdGljcy5iYW5nb3IuYWMudWswDAYDVR0T
AQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQBdwP/W35VAGiD9j3DiNi3crKuoiKjZ10vhWn5p
VcQnCNiCv2AKrE+BEu4/Y00MbUvbg0OK0S0buXm4u/p4n/z/aSVKcTtxvSqk43Cy4KJ6N6zN
Slv65ECARqt9uA66J7AylKSyoIXNqsa44xSukkidGrsMHpHOdMVfEIxzdDRTuDCCAz8wggKo
oAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0
ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRp
bmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMT
G1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwt
ZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIx
CzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSww
KgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzANBgkqhkiG
9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9VvyGna9fww6
YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOCdz0Dviv+
uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCBkTASBgNV
HRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNv
bS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzR
UIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6E
sZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341Yh
eILcIRk13iSx0x1G/11fZU8xggM7MIIDNwIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQK
ExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29u
YWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDDvWMAkGBSsOAwIaBQCgggGnMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA0MDcxNTE0NTM0N1owIwYJKoZIhvcN
AQkEMRYEFLSRDGAvgsYYb9xzpwjIRaJfaituMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcN
AwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMC
AgEoMHgGCSsGAQQBgjcQBDFrMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAgMMO9YwegYLKoZIhvcNAQkQAgsxa6BpMGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDDvWMA0GCSqGSIb3DQEBAQUABIIBADe6
Mk0Ez0OmngIjDUPuatiHA3ZEtwSRSoVdwHaADPChqj6l2rgDHteqIHtEy1eF/tyLTC0xRCBT
fyvDvc3nTLqJ8WONNRPzalDiKer4T8AI6uJ1fm2k5ZRMkTDIGfrNsi/bjxaSmMHyLZJiOwwl
2YRLveEjbvejo8rJLPV8B/Ejj2Hr+O8D8f+RWgcHoop74jdU6F9SSWwZC65hyBoa4bKRyPZb
zVclpI7o9fWPOWZYzSygs+EqZk6QOrC/AlIEg1ad03GJtc+UJVtq3qNRnNE2fqLqA1XajJcE
y9MMPtXP+fdCM5eEA8Dq+hDtygdBFskphffq7G2gJDZqyYPZD/sAAAAAAAA=
--------------ms040007000501030906020408--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
