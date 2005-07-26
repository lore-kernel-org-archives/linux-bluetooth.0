Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: John Gruenenfelder <johng@as.arizona.edu>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20050726042812.GA16828@as.arizona.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Can't get btsco to connect to Plantronics M2500 headset
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 25 Jul 2005 21:28:12 -0700

I am having no end to troubles getting my Plantronics M2500 headset working
under Linux.  As I am quite new to using Bluetooth, I'm not sure where the
problem might lie.

I am using a Linksys USBBT100 adapter to connect with the headset.

This is with Linux 2.6.12 on an AMD64 machines using the latest Bluez packages
from the amd64 Debian port.

hciconfig output appears correct and I can talk to the adapter just fine.  SCO
mapping is "HCI".

"hcitool info 00:03:89:6E:C9:11" just gives:

Requesting information ...
Can't create connection: Input/output error

Clearly, that can't be good.  But I do not see any error messages in the logs
so I can't really tell why it is failing.  Even the hcidump output doesn't
appear to have and noticable error messages.

hcidump -X output after turning on headset:

> HCI Event: Connect Request (0x04) plen 10
  0000: 11 c9 6e 89 03 00 0c 04  20 01                    ..n..... .
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: 11 c9 6e 89 03 00 00                              ..n....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Role Change (0x12) plen 8
  0000: 00 11 c9 6e 89 03 00 00                           ...n....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 11 c9 6e 89 03 00                                 ..n...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 11 c9 6e 89 03 00 32 b5  cd e8 3c 27 06 39 dc 56  ..n...2...<'.9.V
  0010: 91 aa ea c5 cb af                                 ......
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 11 c9 6e 89  03 00                    ......n...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 05 29 00 11 c9 6e 89 03  00 01 00                 .)...n.....
> HCI Event: Connect Request (0x04) plen 10
  0000: 11 c9 6e 89 03 00 0c 04  20 01                    ..n..... .
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: 11 c9 6e 89 03 00 00                              ..n....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Role Change (0x12) plen 8
  0000: 00 11 c9 6e 89 03 00 00                           ...n....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 11 c9 6e 89 03 00                                 ..n...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 11 c9 6e 89 03 00 32 b5  cd e8 3c 27 06 39 dc 56  ..n...2...<'.9.V
  0010: 91 aa ea c5 cb af                                 ......
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 11 c9 6e 89  03 00                    ......n...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 05 2a 00 11 c9 6e 89 03  00 01 00                 .*...n.....
> HCI Event: Connect Request (0x04) plen 10
  0000: 11 c9 6e 89 03 00 0c 04  20 01                    ..n..... .
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: 11 c9 6e 89 03 00 00                              ..n....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Role Change (0x12) plen 8
  0000: 00 11 c9 6e 89 03 00 00                           ...n....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 11 c9 6e 89 03 00                                 ..n...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 11 c9 6e 89 03 00 32 b5  cd e8 3c 27 06 39 dc 56  ..n...2...<'.9.V
  0010: 91 aa ea c5 cb af                                 ......
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 11 c9 6e 89  03 00                    ......n...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 05 2b 00 11 c9 6e 89 03  00 01 00                 .+...n.....
> HCI Event: Connect Request (0x04) plen 10
  0000: 11 c9 6e 89 03 00 0c 04  20 01                    ..n..... .
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: 11 c9 6e 89 03 00 00                              ..n....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Role Change (0x12) plen 8
  0000: 00 11 c9 6e 89 03 00 00                           ...n....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 11 c9 6e 89 03 00                                 ..n...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 11 c9 6e 89 03 00 32 b5  cd e8 3c 27 06 39 dc 56  ..n...2...<'.9.V
  0010: 91 aa ea c5 cb af                                 ......
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 11 c9 6e 89  03 00                    ......n...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 05 2c 00 11 c9 6e 89 03  00 01 00                 .,...n.....


hcidump -X output when running "hcitool info 00:03:89:6E:C9:11" :

< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 11 c9 6e 89 03 00 18 cc  02 00 00 00 01           ..n..........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 11 c9 6e 89 03 00                                 ..n...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 11 c9 6e 89 03 00 32 b5  cd e8 3c 27 06 39 dc 56  ..n...2...<'.9.V
  0010: 91 aa ea c5 cb af                                 ......
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 11 c9 6e 89  03 00                    ......n...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 05 2a 00 11 c9 6e 89 03  00 01 00                 .*...n.....


hcidump -X output when running "btsco 00:03:89:6E:C9:11"

< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 11 c9 6e 89 03 00 18 cc  02 00 00 00 00           ..n..........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 11 c9 6e 89 03 00                                 ..n...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 11 c9 6e 89 03 00 32 b5  cd e8 3c 27 06 39 dc 56  ..n...2...<'.9.V
  0010: 91 aa ea c5 cb af                                 ......
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 11 c9 6e 89  03 00                    ......n...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 05 29 00 11 c9 6e 89 03  00 01 00                 .)...n.....
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 25 0c 00 60 00                                 .%..`.
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 11 c9 6e 89 03 00 18 cc  02 00 00 00 00           ..n..........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 11 c9 6e 89 03 00                                 ..n...
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 11 c9 6e 89 03 00 32 b5  cd e8 3c 27 06 39 dc 56  ..n...2...<'.9.V
  0010: 91 aa ea c5 cb af                                 ......
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 11 c9 6e 89  03 00                    ......n...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 05 2a 00 11 c9 6e 89 03  00 01 00                 .*...n.....


btsco itself gives:

swordfish:~# btsco 00:03:89:6E:C9:11
Error: Failed to connect to SDP server: Permission denied
Assuming channel 2

Can't connect RFCOMM channel: Permission denied


I've been working at this for a few days and I'm no closer to understanding
what the problem is.  A few extra notes:

* When I first got the adapter and headset, I trtied to use it in Windows XP.
  This occured before the first use in Linux.  There, I was able to pair the
  device, but when checking the "services" tab there was nothing listed.
  Also, I had no way of testing it in Windows.

* The first time I tried to use the headset in Linux, I encountered these same
  problems, but I *did* get it to work.  I was even able to play and record
  audio.  After a short time, btsco exited and I haven't gotten it to work
  again.  :(

* That first time, I also found an entry in the logs which I have never seen
  again: 
  hcid[4365]: pin_code_request (sba=00:0C:41:E1:E2:F1, dba=00:03:89:6E:C9:11)
  This comes immediately after a link_key_request.  I still see the
  link_key_request messages every time I I do any bluetooth commands, but I
  have not seen the pin_code_request line again.  I don't know if that is
  significant.

Please help!


-- 
--John Gruenenfelder    Research Assistant, Steward Observatory, U of Arizona
                        johng@as.arizona.edu
Try Weasel Reader for PalmOS  --  http://gutenpalm.sf.net
"This is the most fun I've had without being drenched in the blood
of my enemies!"
        --Sam of Sam & Max


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
