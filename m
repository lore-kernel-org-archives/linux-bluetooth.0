Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <402D381D.1000306@handgranat.org>
From: Sunnan <sunnan@handgranat.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] apple wireless mouse on apple ibook (g4, builtin
 usb)
References: <402D07B8.8030504@handgranat.org>	 <1076694675.2671.191.camel@pegasus>  <402D1E8C.6020301@handgranat.org> <1076702197.18588.11.camel@pegasus>
In-Reply-To: <1076702197.18588.11.camel@pegasus>
Content-Type: multipart/mixed;
 boundary="------------070903010208090200010106"
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
Date: Fri, 13 Feb 2004 21:48:29 +0100

This is a multi-part message in MIME format.
--------------070903010208090200010106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi again,
after rebooting and loading my modules (and starting hcid, sdpd and 
rfcomm, the latter probably unnecessary but I'm erring on the side of 
caution?), I run:
sudo hcidump -w dumpdata

but just get:

HCIDump - HCI packet analyzer ver 1.5
Can't attach to device hci0. No such device(19)

and it exits without writing anything to the file.

and "hciconfig -a" exits silently.

then I run hid2hci anyway, it prints:
Switching device 05ac:1000 to HCI mode was successful

and then I can do hcidump -w dumpdata
which gives me to stdout:
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff

I had wait a while before it wrote anything to the file.
Then I waited a bit more, and it wrote a bit more. This is normal.
I've attached the file.

 > I don't know what kind of module this is. Please run "hcidump -w <file>"
 > before running "hciconfig -a" and send us the dump. Maybe we have a big
 > endian problem here. What bluez-utils version do you have installed?


2.4-6 from Debian sid, as well as utils2 from bluez cvs. hciconfig comes 
from that cvs checkout (though I have two version in my path, the cvs 
version takes precedence, while hcidump comes out of Edds bluez-hcidump 
package, version 1.5-2 for debian sid.


> Reboot your machine and show me this file before you run hid2hci.

I'm sorry, but it wasn't possible since hcidump wouldn't write one, as 
described above.

--------------070903010208090200010106
Content-Type: application/octet-stream;
 name="dumpdata"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dumpdata"

DQABAE80LUAEHQQABAQKV18BlQoAgCUAAQsAAABPNC1ANB0EAAEJBAdXXwGVCgABBwABAE80
LUDjcgQABA8EAAEJBA4AAQBPNC1AQZMJAAQDCwAtAFdfAZUKAAEACAAAAE80LUB1kwkAAQ0I
BC0ADwAKAAEATzQtQBuXCQAEIAdXXwGVCgABEQABAE80LUBxsgkAAi0gDAAIAAEAAgIEABEA
QAAVAAAATzQtQIqyCQACLSAQAAwAAQADAggAAABAAAIAAAAJAAEATzQtQH7ZCQAEDgYBDQgA
LQAIAAAATzQtQIrZCQABDwQELQAYzAcAAQBPNC1A/RcKAAQPBAABDwQIAAEATzQtQOUbCgAE
HQUALQAYAAgAAQBSNC1A3TUIAAQTBQEtAAEABwABAGs0LUB3mwwABAUEAC0ACA0AAQChNC1A
G1ADAAQECldfAZUKAIAlAAELAAAAoTQtQEtQAwABCQQHV18BlQoAAQcAAQChNC1A/KUDAAQP
BAABCQQOAAEAoTQtQD7KCAAEAwsALQBXXwGVCgABAAgAAAChNC1Ab8oIAAENCAQtAA8ACgAB
AKE0LUAazggABCAHV18BlQoAAREAAQChNC1AbukIAAItIAwACAABAAIDBAARAEMAFQAAAKE0
LUCG6QgAAi0gEAAMAAEAAwMIAAAAQwACAAAACQABAKE0LUCEEAkABA4GAQ0IAC0ACAAAAKE0
LUCcEAkAAQ8EBC0AGMwHAAEAoTQtQPpOCQAEDwQAAQ8ECAABAKE0LUDjUgkABB0FAC0AGAAH
AAEAtTQtQL6uCAAEBQQALQAI
--------------070903010208090200010106--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
