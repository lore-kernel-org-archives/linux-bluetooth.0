Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <beb7688e0609150702x738ad4d8re64815d12f457a76@mail.gmail.com>
Date: Fri, 15 Sep 2006 10:02:52 -0400
From: "Chris S" <chrisspen@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Celluon Laserkey Bluetooth Keyboard
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

First, I apologize if this is off-topic for this list, but I'm not
sure where to post general Bluetooth+Linux related questions.

I recently bought a Celluon CL800BT Bluetooth keyboard/mouse
(http://celluon.com/products/laserkey.htm?sm=2_1) and I'd like to use
it in Linux (Fedora Core 5). I've tried the Gnome and KDE utilities,
but haven't had much luck. I was able to use kbluetoothd to see some
sort of "Serial Port" file on the device, but I wasn't able to do
anything further. I've also gotten some feedback from hcitool and hidd:

$ hcitool scan
Scanning ...
       00:0B:24:40:C7:83       CL800BT
$ hcitool inq
Inquiring ...
       00:0B:24:40:C7:83       clock offset: 0x3ab6    class: 0x400210
$ hcitool info 00:0B:24:40:C7:83
Requesting information ...
       BD Address:  00:0B:24:40:C7:83
       Device Name: CL800BT
       LMP Version: 1.1 (0x1) LMP Subversion: 0x291
       Manufacturer: Cambridge Silicon Radio (10)
       Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
               <3-slot packets> <5-slot packets> <encryption> <slot
offset>
               <timing accuracy> <role switch> <hold mode> <sniff mode>
               <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>
               <HV3 packets> <u-law log> <A-law log> <CVSD> <paging
scheme>
               <power control> <transparent SCO>
$ hidd --connect 00:0B:24:40:C7:83
Connected to 00:0B:24:40:C7:83 on channel 1
Press CTRL-C for hangup
Unknown event code 165
Unknown event code 165
Unknown event code 1
Unknown event code 0
Unknown event code 0
Unknown event code 0
Unknown event code 1
Unknown event code 255
Unknown event code 1
Unknown event code 18
Unknown event code 0
Unknown event code 1
Unknown event code 255
Unknown event code 255
Unknown event code 255
Unknown event code 0
Unknown event code 1

The last part is interesting, because the three 255s repeat for every
keypress and mouse movement made with the device.

Does this output match any known Bluetooth keyboard/mouse protocol?
How can I configure Xorg to interpret this device as a keyboard and mouse?

I've been Googling, but I haven't found many resources on the topic,
and even less on using Bluetooth keyboards with Linux. I found the
kbdd project (http://handhelds.org/moin/moin.cgi/kbdd) but I'm not
sure if it's compatible with the CL800BT.

I have experience with C/C++ and Python, so if there's no current
software for handling this device, I could try and work
something out if someone could point me in the right direction to get
started.

Any help is greatly appreciated.

Regards,
Chris Spencer

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
