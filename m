Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: ALBERT RIBAS GUASCH <albert.ribas@estudiants.urv.es>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Message-id: <9140293f27.93f2791402@estudiants.urv.es>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: [Bluez-users] Software caused connection abort
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
Date: Thu, 01 Apr 2004 13:45:29 +0200

Hi!!

I'm using rh7.3 with kernel 2.4.24. 
I've installed bluez-libs-2.5, bluez-utils-2.5,
bluez-sdp1.5, bluez-pan1.1, buez-hcidump-1.8,
bluez-hciemu-1.0 and bluez-bluefw-1.0, and I have an
usb-dongle that I want to rfcomm with an rs232
adapter in a robot.

I start hcid, then I do hciconfig hci0 up, obtain
the adress form the rs232 adapter using hciconfig
inq or hciconfig scan and normally there's no
problem, but then I try to connect via rfcomm and
sometimes I get a message with "Host is down" and
sometimes "Software caused connection abort". What
can I do???

I send you the output from hcidump, as you requested:

HCIDump - HCI packet analyzer ver 1.8
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry(0x01|0x0001) plen 5
  33 8B 9E 08 64 
> HCI Event: Command Status(0x0f) plen 4
  00 01 01 04 
> HCI Event: Inquiry Result(0x02) plen 15
  01 31 00 80 66 06 00 02 00 00 00 1F 00 3E 22 
< HCI Command: Reset(0x03|0x0003) plen 0
Receive falied: Broken pipe

Then, I do it again:


HCIDump - HCI packet analyzer ver 1.8
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry(0x01|0x0001) plen 5
  33 8B 9E 08 64 
> HCI Event: Command Status(0x0f) plen 4
  00 01 01 04 
> HCI Event: Inquiry Result(0x02) plen 15
  01 31 00 80 66 06 00 02 00 00 00 1F 00 43 22 
< HCI Command: Create Connection(0x01|0x0005) plen 13
  00 00 00 00 00 01 18 CC 01 00 00 00 01 
> HCI Event: Command Status(0x0f) plen 4
  00 01 05 04 
< HCI Command: Reset(0x03|0x0003) plen 0
Receive falied: Broken pipe

And I get a message with "Software caused connection
abort". I've tried to do rfcomm without hcidump
running, and the message I get is "Host is down".

Could you help me??
Thank you!!!!

Albert



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
