Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40D58C9E.5010001@informatics.bangor.ac.uk>
From: Rob Shepherd <robshep@informatics.bangor.ac.uk>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070400020403010603000808"
Subject: [Bluez-users] Rob is an idiot [ was: No communication with USB BT device ]
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
Date: Sun, 20 Jun 2004 14:09:50 +0100

This is a cryptographically signed message in MIME format.

--------------ms070400020403010603000808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

marcel wrote:

> Hi Rob,
> 
> 
>>> No HCI connection is possible with my Belkin Bluetooth module. (CSR chip)
>>> 
>>> __System__
>>> 
>>> Linux kernel 2.6.7
>>> 
>>> bluez-libs-2.7
>>> bluez-utils-2.7
>>> bluez-pin-0.23
>>> bluez-hcidump-1.8
>>> 
>>> __output__
>>> 
>>> $ dmesg | grep -i usb
>>> sbcore: registered new driver usbfs
>>> usbcore: registered new driver hub
>>> USB Universal Host Controller Interface driver v2.2
>>> uhci_hcd 0000:00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
>>> uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
>>> hub 1-0:1.0: USB hub found
>>> usbcore: registered new driver usblp
>>> drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
>>> Initializing USB Mass Storage driver...
>>> usbcore: registered new driver usb-storage
>>> USB Mass Storage support registered.
>>> usbcore: registered new driver usbhid
>>> drivers/usb/input/hid-core.c: v2.0:USB HID core driver
>>> usb 1-1: new full speed USB device using address 2
>>> Bluetooth: HCI USB driver ver 2.6
>>> usbcore: registered new driver hci_usb
>>> 
>>> __Order of events__
>>> 
>>> Boot system
>>> insert dongle [no hotplug system running]
>>> modprobe hci_usb
>>> /etc/init.d/bluetooth start [HIDP complains (ignoring)]
>>> 
>>> hciconfig shows...[no device params read from device]
>>> 
>>> hci0:   Type: USB
>>>          BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
>>>          DOWN
>>>          RX bytes:0 acl:0 sco:0 events:0 errors:0
>>>          TX bytes:6 acl:0 sco:0 commands:2 errors:0
>>> 
>>> hciconfig hci0 up times out.
>>> 
>>> hcidump show a hci_rlsf command but no response from chip.
>>> 
>>> This device works fine with Widcomm drivers/stack/application
>>> 
>>> when same machine is booted into windows XP (shudder)
>>> 
>>> Where might I be going wrong, What else could I try?
> 
> 
> what does /proc/bus/usb/devices and lspci say?
> 
> Regards
> 
> Marcel

Sorry about this problem, It turns out the machine  I was logging in to was actually linux 
running in a VMware system on WinXP.

I discovered this when lspci showed a VMWare IDE Bus.

I've since got hold of the machine, Rsync'd the linux off VMware and onto a native 
partition and it works fine..

At least now you know it won't work with VMWare 4.0

sorry again

keep up the good work

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

--------------ms070400020403010603000808
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
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA0MDYyMDEzMDk1MFowIwYJKoZIhvcN
AQkEMRYEFJw/tQQ1St3Ju+gH5psMAbhU4N2VMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcN
AwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMC
AgEoMHgGCSsGAQQBgjcQBDFrMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAgMMO9YwegYLKoZIhvcNAQkQAgsxa6BpMGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDDvWMA0GCSqGSIb3DQEBAQUABIIBACH+
ozsIfLBJdZBpecCOx9cjAR5qKVq6Wp80aC3kB0vIfnlpCTWU11c5379HbYIk26KHgj7mf9Sh
UpSB/OWzSFJRAj5qfBrpzlt6Vc5HJPdOncfoneNoDOVHuwGWxfAn5Cn2C5BD0Y1IyeY1GKF+
Sx2C7pp9GN0Zrj7ybWggvnAEK9Cs7EuzKvE3klaOQ9y8dUqcbqb8hytY+AisTnpsRVqkDvH2
juFQ8QFDjSW45PElWBvBM8bPZvYix5pSBys0LZ6TOOaZT80hRPNJ1iiUVe0XsslOyT955dKl
c5y1sHNhCzzmlxcdx/VgfCRzdI+7+R/Senlkc8kCMskKJxEDq78AAAAAAAA=
--------------ms070400020403010603000808--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
