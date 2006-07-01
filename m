Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44A6A236.8010006@runbox.com>
Date: Sat, 01 Jul 2006 17:26:30 +0100
From: Tom K <tomk@runbox.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] hcid fails to start after upgrade to
	bluez-libs/bluez-utils 3.1
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I was looking for a bug-tracker, and couldn't find it, so I hope this is 
in the right place.

Yesterday I upgraded bluez-libs and bluez-utils from 2.25 to 3.1. hcid 
now fails to start - here are the log entries:

Jul  1 16:47:43 tk-i5ka hcid[4240]: Bluetooth HCI daemon
Jul  1 16:47:43 tk-i5ka hcid[4240]: Unknown option 'pin_helper' line 26
Jul  1 16:47:43 tk-i5ka hcid[4240]: syntax error line 26
Jul  1 16:47:43 tk-i5ka hcid[4240]: Unknown option 'auth' line 70
Jul  1 16:47:43 tk-i5ka hcid[4240]: Can't open system message bus 
connection: Failed to connect to socket /var/run/dbus/system_bus_socket: 
Connection refused
Jul  1 16:47:43 tk-i5ka hcid[4240]: Unable to get on D-Bus

Downgrading to 2.25 again solves the problem:

Jul  1 16:53:38 tk-i5ka hcid[4316]: Bluetooth HCI daemon
Jul  1 16:53:38 tk-i5ka hcid[4316]: HCI dev 0 up
Jul  1 16:53:38 tk-i5ka hcid[4316]: Starting security manager 0

The system is running kernel 2.6.17-ck1, using hci_usb with a 3Com 
3CREB96 USB dongle. No changes were made to hcid.conf or any other conf 
files.

Please advise if any additional information is required.

Regards
Tom K.

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
