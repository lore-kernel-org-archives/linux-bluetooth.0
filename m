Return-Path: <cyrus@holtmann.org>
Message-ID: <012d01c8a8d3$4669be00$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Sun, 27 Apr 2008 20:57:52 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_012A_01C8A8A9.5BE6A240"
Subject: [Bluez-devel] Bluez-utils-3.30 (patched) plugins failing at startup
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_012A_01C8A8A9.5BE6A240
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

As stated in my last message, I caught up with all recent patches from hcid, and now find that when initializing the libxxxxx.so 
plugins, the call to g_module_open STILL fails as shown in the following:

Apr 27 20:35:25 freqonec001 hcid[2790]: Loading plugins /usr/lib/bluetooth/plugins
Apr 27 20:35:25 freqonec001 hcid[2790]: Can't load plugin: /usr/lib/bluetooth/plugins/libnetwork.so: undefined symbol: 
error_invalid_arguments
Apr 27 20:35:25 freqonec001 hcid[2790]: Can't load plugin: /usr/lib/bluetooth/plugins/libserial.so: undefined symbol: 
error_invalid_arguments
Apr 27 20:35:25 freqonec001 hcid[2790]: Can't load plugin: /usr/lib/bluetooth/plugins/libinput.so: undefined symbol: 
error_invalid_arguments
Apr 27 20:35:25 freqonec001 hcid[2790]: Can't load plugin: /usr/lib/bluetooth/plugins/libaudio.so: undefined symbol: 
error_invalid_arguments

Also, when I do try to ActivateService, the activation fails because it is still looking for bluetoothd-service-audio.

Logs attached...


David Stockwell
Frequency One

------=_NextPart_000_012A_01C8A8A9.5BE6A240
Content-Type: application/octet-stream;
	name="20080427 Bluez startup.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="20080427 Bluez startup.log"

Apr 27 16:42:20 freqonec001 hcid[2817]: Cleanup plugins=20
Apr 27 16:42:20 freqonec001 hcid[2817]: Stopping SDP server=20
Apr 27 16:42:20 freqonec001 hcid[2817]: release_services=20
Apr 27 16:42:20 freqonec001 hcid[2817]: Unregistering service object: =
/org/bluez/service_audio=20
Apr 27 16:42:20 freqonec001 hcid[2817]: Unregister path: /org/bluez/hci0 =

Apr 27 16:42:20 freqonec001 hcid[2817]: Exit=20
Apr 27 20:35:24 freqonec001 hcid[2790]: Bluetooth HCI daemon=20
Apr 27 20:35:24 freqonec001 hcid[2790]: Enabling debug information=20
Apr 27 20:35:24 freqonec001 hcid[2790]: Registering experimental manager =
path=20
Apr 27 20:35:24 freqonec001 hcid[2790]: Registering experimental manager =
interface=20
Apr 27 20:35:24 freqonec001 hcid[2790]: HCI dev 0 registered=20
Apr 27 20:35:24 freqonec001 hcid[2790]: Starting SDP server=20
Apr 27 20:35:24 freqonec001 hcid[2790]: Adding rec : 0x8089bf0=20
Apr 27 20:35:24 freqonec001 hcid[2790]: with handle : 0x1=20
Apr 27 20:35:24 freqonec001 hcid[2790]: Adding rec : 0x8089dd0=20
Apr 27 20:35:24 freqonec001 hcid[2790]: with handle : 0x0=20
Apr 27 20:35:24 freqonec001 hcid[2790]: Service classes 0x00=20
Apr 27 20:35:25 freqonec001 kernel: uhci_hcd 0000:00:10.0: UHCI Host =
Controller=20
Apr 27 20:35:25 freqonec001 kernel: uhci_hcd 0000:00:10.0: new USB bus =
registered, assigned bus number 1=20
Apr 27 20:35:25 freqonec001 kernel: uhci_hcd 0000:00:10.0: irq 16, io =
base 0x0000e400=20
Apr 27 20:35:25 freqonec001 kernel: uhci_hcd 0000:00:10.1: UHCI Host =
Controller=20
Apr 27 20:35:25 freqonec001 kernel: uhci_hcd 0000:00:10.1: new USB bus =
registered, assigned bus number 2=20
Apr 27 20:35:25 freqonec001 kernel: uhci_hcd 0000:00:10.1: irq 16, io =
base 0x0000e800=20
Apr 27 20:35:25 freqonec001 kernel: uhci_hcd 0000:00:10.2: UHCI Host =
Controller=20
Apr 27 20:35:25 freqonec001 kernel: uhci_hcd 0000:00:10.2: new USB bus =
registered, assigned bus number 3=20
Apr 27 20:35:25 freqonec001 kernel: uhci_hcd 0000:00:10.2: irq 16, io =
base 0x0000ec00=20
Apr 27 20:35:25 freqonec001 kernel: ehci_hcd 0000:00:10.3: EHCI Host =
Controller=20
Apr 27 20:35:25 freqonec001 kernel: ehci_hcd 0000:00:10.3: new USB bus =
registered, assigned bus number 4=20
Apr 27 20:35:25 freqonec001 kernel: ehci_hcd 0000:00:10.3: irq 16, io =
mem 0xdfffff00=20
Apr 27 20:35:25 freqonec001 kernel: usb 2-1: new low speed USB device =
using uhci_hcd and address 2=20
Apr 27 20:35:25 freqonec001 kernel: ehci_hcd 0000:00:10.3: USB 2.0 =
started, EHCI 1.00, driver 10 Dec 2004=20
Apr 27 20:35:25 freqonec001 hcid[2790]: Loading plugins =
/usr/lib/bluetooth/plugins=20
Apr 27 20:35:25 freqonec001 kernel: usb 3-1: new low speed USB device =
using uhci_hcd and address 2=20
Apr 27 20:35:25 freqonec001 kernel: usb 3-2: new low speed USB device =
using uhci_hcd and address 3=20
Apr 27 20:35:25 freqonec001 hcid[2790]: Can't load plugin: =
/usr/lib/bluetooth/plugins/libnetwork.so: undefined symbol: =
error_invalid_arguments=20
Apr 27 20:35:25 freqonec001 kernel: usb 2-2: new full speed USB device =
using uhci_hcd and address 4=20
Apr 27 20:35:25 freqonec001 hcid[2790]: Can't load plugin: =
/usr/lib/bluetooth/plugins/libserial.so: undefined symbol: =
error_invalid_arguments=20
Apr 27 20:35:25 freqonec001 kernel: usbcore: registered new interface =
driver hci_usb=20
Apr 27 20:35:25 freqonec001 hcid[2790]: Can't load plugin: =
/usr/lib/bluetooth/plugins/libinput.so: undefined symbol: =
error_invalid_arguments=20
Apr 27 20:35:25 freqonec001 hcid[2790]: Can't load plugin: =
/usr/lib/bluetooth/plugins/libaudio.so: undefined symbol: =
error_invalid_arguments=20
Apr 27 20:35:25 freqonec001 hcid[2790]: Registering service object: =
ident=3Daudio, name=3DAudio service (/org/bluez/service_audio)=20
Apr 27 20:35:25 freqonec001 hcid[2790]: HCI dev 0 up=20
Apr 27 20:35:25 freqonec001 hcid[2790]: Device hci0 has been added=20
Apr 27 20:35:25 freqonec001 hcid[2790]: Starting security manager 0=20
Apr 27 20:35:25 freqonec001 hcid[2790]: Device hci0 has been activated=20
Apr 27 20:35:25 freqonec001 hcid[2790]: child 2817 exited=20
Apr 27 20:35:25 freqonec001 hcid[2790]: child 2926 exited=20
Apr 27 20:39:19 freqonec001 hcid[2790]: /org/bluez: =
org.bluez.Manager.ActivateService()=20
Apr 27 20:39:19 freqonec001 hcid[2790]: Unable to execute =
/usr/lib/bluetooth/bluetoothd-service-audio=20

------=_NextPart_000_012A_01C8A8A9.5BE6A240
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
------=_NextPart_000_012A_01C8A8A9.5BE6A240
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_012A_01C8A8A9.5BE6A240--
