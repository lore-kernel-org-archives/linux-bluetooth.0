Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Stephen Quattlebaum <stephen@covidimus.net>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1099090255.12760.26.camel@athene.covidimus.net>
Mime-Version: 1.0
Subject: [Bluez-users] Connection Timeout
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
Date: Fri, 29 Oct 2004 17:50:55 -0500

I'm a BT newbie having trouble with device timeouts using bluez.  I've
seen this issue posted a few other places but no answers yet.  Some
background:

I just bought a Microsoft BT mouse for a Win XP laptop and decided this
afternoon to take it for a spin on my Linux box.

I've got kernel 2.6.8 (what gentoo calls 2.6.8.1-ck9; don't know where
the .1 comes from but the ck9 refers to a set of desktop performance
tuning patches they apply).

I applied patch-2.6.9-mh2 from http://www.bluez.org/patches.html and
rebuilt my kernel and modules.

The mouse came with a little USB dongle that has the following info on
the backside:

"Wireless Transceiver for Bluetooth 2.0"
Model: 1003
IC: 3048A-1003

usbview shows the dongle with the name "Wireless Radio for Bluetooth",
and its name is in red, which I've been led to believe means that no
drivers have attached themselves to the device.  I don't know if that's
important here or not.  I'd paste in the usbview output but usbview
appears to not support whatever flavor of cut-and-paste gnome uses.
I'll pull out any info someone asks me for (it's a big listing).  Here's
the first several lines:

Manufacturer: Microsoft
Serial Number: 0050F2E8E590
Speed: 12Mb/s (full)
USB Version: 1.10
Device Class: e0(unk.)
Device Subclass: 01
Device Protocol: 01
Maximum Default Endpoint Size: 64
Number of Configurations: 1
Vendor Id: 045e
Product Id: 009c
Revision Number: 1.00


When I plug in the dongle, the mouse just starts working without me
having to do anything at all (though some of the buttons don't work,
even the scrollwheel, which is working on another USB mouse attached to
this system).  However, that's where the good times end.

Here are the results of various commands:

athene bluetooth # hciconfig
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0


athene bluetooth # hcitool scan
Device is not available: Success

athene bluetooth # hciconfig hci0 up
Can't init device hci0. Connection timed out(110)


I saw somewhere that I should try hcidump -x while doing that last one,
and here's what I get.

athene root # hcidump -x
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0
...

What you see there is the result of trying "hciconfig hci0 up" twice.  I
get a new "< HCI Command" line for each time I try.  I'm _guessing_ that
the < means "outgoing", and that maybe the problem is that the dongle is
never responding to that particular request like it should?

All through this, the mouse actually _works_, but it doesn't show up in
response to "hcitool dev" (nothing does) and I can't probe devices, so I
can't make a connection to my Sony Ericsson T610 (or, presumably, any
other devices).

I saw a suggestion to start hcid on the list, so I did, but it doesn't
appear to affect anything.  I tried "hcid -n" so I could see what it was
doing and got this:

athene bluetooth # hcid -n
hcid[13197]: Bluetooth HCI daemon
hcid[13198]: Can't init device hci0. Connection timed out(110)

hcid _does_ notice when I remove and replace the dongle, but it still
cant ever connect:

hcid[13197]: HCI dev 0 unregistered
hcid[13197]: HCI dev 0 registered
hcid[13445]: Can't init device hci0. Connection timed out(110)

The dongle works under XP SP2 just fine.  I thought at first that it
might be crippled, unable to do "real" bluetooth and supporting only the
Microsoft mouse & keyboard, but on my XP SP2 machine I'm able to see and
connect to my Sony Ericsson cellphone.  The dongle may still be
nonstandard in some way that breaks compatibility with bluez, but it is
at least known to work in XP SP2 to talk to non-MS equipment.

I hope that's enough information to help someone give me a clue as to
what to do for my problem.



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
