Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Vesa Halttunen <vesuri@jormas.com>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1087757523.839.10.camel@pc.vesuri.net>
Mime-Version: 1.0
Subject: [Bluez-users] Jerky MX900 mouse movement with 2.6.7-mh1, hidp and hidd
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
Date: Sun, 20 Jun 2004 21:52:03 +0300

Hi,

I have a Logitech Cordless Desktop Bluetooth (an MX900 mouse and an
Elite keyboard). Earlier I used them in HCI mode by using hid2hci, hcid
and bthid but Marcelo Holtmann hinted it might be a good idea to
try the hidp kernel module and hidd instead.

I'm now running kernel 2.6.7-mh1 and I have the hidp module loaded and
hidd running. The keyboard works fine but mouse movement is very jerky.
There pointer lags behind and stops for approximately 100ms (or
whatever) every 0.5 seconds. This happens both on the console with GPM
and in X.

What might be the problem? The mouse movement was smooth with bthid.
To get things up and running I'm modprobing uhci-hcd, bluetooth and
hidp, uinput and hci_usb, then running hid2hci, bringing hci0 up with
hciconfig hci0 up and finally starting hidd with hidd -i hci0 --server.

The system is a hyperthreaded P4 system running on a i865 motherboard.
Hidp vermagic says 2.6.7-mh1 SMP preempt PENTIUM4 gcc-3.4.

Regards,

-Vesa
-- 
            · Vesa Halttunen - http://www.jormas.com/~vesuri/ ·



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
