Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Matthew Wilson <matt@tplus1.com>
Date: Mon, 29 Oct 2007 22:10:02 +0000 (UTC)
Message-ID: <slrnficmht.ogv.matt@coleridge.tplus1.com>
Subject: [Bluez-users] I need help pulling photos off my phone with bluetooth
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I have a Samsung A707 phone with AT&T.  They call this the SYNC phone.
Anyway, I can export photos off the phone when I boot into Windows, but
all attempts to do this with my Ubuntu linux box have failed.

I have a D-Link USB dongle and I can scan and find my phone:

$ hcitool dev
Devices:
        hci0    00:1B:11:6F:9F:3E

$ hcitool scan
Scanning ...
        00:1D:F6:55:7E:D9       MattPhone

My phone seems to advertise that it supports file transfer:

$ sdptool search FTP
Inquiring ...
Searching for FTP on 00:1D:F6:55:7E:D9 ...
Service Name: File Transfer
Service RecHandle: 0x10006
Service Class ID List:
  "OBEX File Transfer" (0x1106)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 6
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX File Transfer" (0x1106)
    Version: 0x0100

So, I started hcid with the -n option in one terminal and then ran
obexftp -b 00:1D:F6:55:7E:D9 -l in another terminal.

Then my phone asks me to punch in my PIN.  So I enter the same 4 digits
that are in my /etc/bluetooth/pin, and then I get prompted to enter it
again.

Here is what appears in the terminal where I start hcid:

$ sudo hcid -n
hcid[23210]: Bluetooth HCI daemon
hcid[23210]: Unknown option 'pin_helper' line 27
hcid[23210]: syntax error line 27
hcid[23210]: HCI dev 0 registered
hcid[23210]: HCI dev 0 already up
hcid[23210]: Device hci0 has been added
hcid[23210]: Starting security manager 0
hcid[23210]: Device hci0 has been activated
hcid[23210]: Created local server at
unix:abstract=/var/run/dbus-QMQCuP3UEA,guid=b51f2e4da7410c4a5269ec0047265623
audio[23213]: Bluetooth Audio daemon
audio[23213]: Parsing /etc/bluetooth/audio.conf failed: No such file or
directory
audio[23213]: Unix socket created: 5
hcid[23210]: Can't connect to SDP daemon:(Connection refused, 111)
hcid[23210]: Failed to register service record
audio[23213]: Adding service record failed: Connection refused
audio[23213]: Unable to register HS AG service record
audio[23213]: Unregistered manager path
audio[23213]: Audio init failed!
input[23214]: Bluetooth Input daemon
input[23214]: Registered input manager path:/org/bluez/input
hcid[23210]: link_key_request (sba=00:1B:11:6F:9F:3E,
dba=00:1D:F6:55:7E:D9)
hcid[23210]: pin_code_request (sba=00:1B:11:6F:9F:3E,
dba=00:1D:F6:55:7E:D9)
hcid[23210]: link_key_request (sba=00:1B:11:6F:9F:3E,
dba=00:1D:F6:55:7E:D9)

And this is what I see when I run obexftp:

$ obexftp -b 00:1D:F6:55:7E:D9 -l
Browsing 00:1D:F6:55:7E:D9 ...
Channel: 6
Connecting...failed: connect
Still trying to connect
Connecting...failed: connect
Still trying to connect
Connecting...failed: connect
Still trying to connect

Finally, here's the output to /var/log/syslog while all of this is going
on:

Oct 29 17:52:12 coleridge hcid[23196]: Bluetooth HCI daemon
Oct 29 17:52:12 coleridge hcid[23196]: Unknown option 'pin_helper' line
27
Oct 29 17:52:12 coleridge hcid[23196]: syntax error line 27
Oct 29 17:52:12 coleridge hcid[23196]: Could not become the primary
owner of org.bluez
Oct 29 17:52:12 coleridge hcid[23196]: Unable to get on D-Bus
Oct 29 17:52:35 coleridge hcid[23210]: Bluetooth HCI daemon
Oct 29 17:52:35 coleridge hcid[23210]: Unknown option 'pin_helper' line
27
Oct 29 17:52:35 coleridge hcid[23210]: syntax error line 27
Oct 29 17:52:35 coleridge hcid[23210]: HCI dev 0 registered
Oct 29 17:52:35 coleridge hcid[23210]: HCI dev 0 already up
Oct 29 17:52:35 coleridge hcid[23210]: Device hci0 has been added
Oct 29 17:52:35 coleridge hcid[23210]: Starting security manager 0
Oct 29 17:52:35 coleridge hcid[23210]: Device hci0 has been activated
Oct 29 17:52:35 coleridge hcid[23210]: Created local server at
unix:abstract=/var/run/dbus-QMQCuP3UEA,guid=b51f2e4da7410c4a5269ec0047265623
Oct 29 17:52:35 coleridge audio[23213]: Bluetooth Audio daemon
Oct 29 17:52:35 coleridge audio[23213]: Parsing
/etc/bluetooth/audio.conf failed: No such file or directory
Oct 29 17:52:35 coleridge audio[23213]: Unix socket created: 5
Oct 29 17:52:35 coleridge hcid[23210]: Can't connect to SDP
daemon:(Connection refused, 111)
Oct 29 17:52:35 coleridge hcid[23210]: Failed to register service record
Oct 29 17:52:35 coleridge audio[23213]: Adding service record failed:
Connection refused
Oct 29 17:52:35 coleridge audio[23213]: Unable to register HS AG service
record
Oct 29 17:52:35 coleridge audio[23213]: Unregistered manager path
Oct 29 17:52:35 coleridge audio[23213]: Audio init failed!
Oct 29 17:52:35 coleridge input[23214]: Bluetooth Input daemon
Oct 29 17:52:35 coleridge input[23214]: Registered input manager
path:/org/bluez/input
Oct 29 17:52:43 coleridge NetworkManager: <debug> [1193694762.951781]
nm_hal_device_added(): New device added (hal udi is
'/org/freedesktop/Hal/devices/usb_device_a12_1_noserial_if0_bluetooth_hci_bluetooth_hci').
Oct 29 17:52:43 coleridge hcid[23210]: link_key_request
(sba=00:1B:11:6F:9F:3E, dba=00:1D:F6:55:7E:D9)
Oct 29 17:52:50 coleridge hcid[23210]: pin_code_request
(sba=00:1B:11:6F:9F:3E, dba=00:1D:F6:55:7E:D9)
Oct 29 17:52:51 coleridge hcid[23210]: link_key_request
(sba=00:1B:11:6F:9F:3E, dba=00:1D:F6:55:7E:D9)
Oct 29 17:52:51 coleridge NetworkManager: <debug> [1193694771.446616]
nm_hal_device_removed(): Device removed (hal udi is
'/org/freedesktop/Hal/devices/usb_device_a12_1_noserial_if0_bluetooth_hci_bluetooth_hci').
Oct 29 17:52:51 coleridge NetworkManager: <debug> [1193694771.446928]
nm_hal_device_added(): New device added (hal udi is
'/org/freedesktop/Hal/devices/usb_device_a12_1_noserial_if0_bluetooth_hci_bluetooth_hci').
Oct 29 17:53:53 coleridge NetworkManager: <debug> [1193694833.073638]
nm_hal_device_removed(): Device removed (hal udi is
'/org/freedesktop/Hal/devices/usb_device_a12_1_noserial_if0_bluetooth_hci_bluetooth_hci').

Any ideas?

TIA


Matt

--
I'm trying to make money off my blog.
http://blog.tplus1.com



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
