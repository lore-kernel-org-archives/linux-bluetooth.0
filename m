Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY111-F16FFF3FC5BB2814CF14434C1090@phx.gbl>
In-Reply-To: <01c7b97e$58d4afe0$5a8bbe54@olavoo>
From: "Clark Pope" <cepope13@hotmail.com>
To: bluez-devel@lists.sourceforge.net, bluez-devel@lists.sf.net
Date: Thu, 28 Jun 2007 09:40:38 -0400
Mime-Version: 1.0
Subject: [Bluez-devel] Trouble with bluetooth headset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


I have a colleague that is stuck trying to get a bluetooth headset working. 
The system is montavista linux 2.6.10 on x86 for development and PPC for 
deployment. Below is his request to me. Any help/guidance you can provide is 
greatly appreciated. Also, if you can recommend a known good combination of 
headset and usb dongle that has working drivers for PPC405 (Xilinx SOC) it 
would save us the trouble of fixing this one. Thanks, Clark

-----

Well, I'll accept any help I can get. As I understand it, Montavista gave us 
Bluetooth packages as not officially supported software, but I would feel 
free to ask them questions if I thought their software was the issue.

With the headset device, I think the problem is with the alsa-bluetooth 
connection. I am getting my guidance from:

http://bluetooth-alsa.sourceforge.net

I am using the "legacy driver" approach with the snd-bt-sco driver and the 
btsco/btsco2 app. One issue involves whether configuration files are set up 
so I don't have to enter the passkey. Normally this is done with a Gnome 
(desktop) app, and that can't work on the 9479. Some of the messages on the 
hcidump trace lead me to believe I don't have all the configuration files 
set up correctly - to get access without a passkey, on the correct RF 
channel, etc.

With hci0 set up, aplay shows the headphone connection:

# aplay -l

**** List of PLAYBACK Hardware Devices ****

card 0: Headset [BT Headset], device 0: Bluetooth SCO PCM [BT SCO PCM]

Subdevices: 1/1

Subdevice #0: subdevice #0

When btsco2 initializes, it tries to connect to the headphone, and there 
seem to be errors in the output (I'm not sure what all of it means, but the 
"connection refused" message seems significant):

# ./btsco2 00:0B:2E:75:D0:07 &

# Device is 0:0

< HCI Command: Read Voice Setting (0x03|0x0025) plen 0

>HCI Event: Command Complete (0x0e) plen 6

Voice setting: 0x0060

< HCI Command: Create Connection (0x01|0x0005) plen 13

>HCI Event: Command Status (0x0f) plen 4

>HCI Event: Connect Complete (0x03) plen 11

< ACL data: handle 5 flags 0x02 dlen 12

L2CAP(s): Connect req: psm 1 scid 0x0040

>HCI Event: Connection Packet Type Changed (0x1d) plen 5

>HCI Event: Number of Completed Packets (0x13) plen 5

>ACL data: handle 5 flags 0x02 dlen 16

L2CAP(s): Connect rsp: dcid 0x0046 scid 0x0040 result 1 status 2

Connection pending - Authorization pending

>ACL data: handle 5 flags 0x02 dlen 16

L2CAP(s): Connect rsp: dcid 0x0046 scid 0x0040 result 0 status 0

Connection successful

< ACL data: handle 5 flags 0x02 dlen 12

L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 0

>HCI Event: Number of Completed Packets (0x13) plen 5

>ACL data: handle 5 flags 0x02 dlen 14

L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0

Success

>ACL data: handle 5 flags 0x02 dlen 16

L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4

MTU 48

< ACL data: handle 5 flags 0x02 dlen 14

L2CAP(s): Config rsp: scid 0x0046 flags 0x00 result 0 clen 0

Success

>HCI Event: Number of Completed Packets (0x13) plen 5

< ACL data: handle 5 flags 0x02 dlen 24

L2CAP(d): cid 0x0046 len 20 [psm 0]

>HCI Event: Number of Completed Packets (0x13) plen 5

>ACL data: handle 5 flags 0x02 dlen 27

>ACL data: handle 5 flags 0x01 dlen 25

L2CAP(d): cid 0x0040 len 48 [psm 0]

< ACL data: handle 5 flags 0x02 dlen 26

L2CAP(d): cid 0x0046 len 22 [psm 0]

>HCI Event: Number of Completed Packets (0x13) plen 5

>ACL data: handle 5 flags 0x02 dlen 27

>ACL data: handle 5 flags 0x01 dlen 25

L2CAP(d): cid 0x0040 len 48 [psm 0]

< ACL data: handle 5 flags 0x02 dlen 26

L2CAP(d): cid 0x0046 len 22 [psm 0]

>HCI Event: Number of Completed Packets (0x13) plen 5

>ACL data: handle 5 flags 0x02 dlen 22

L2CAP(d): cid 0x0040 len 18 [psm 0]

< ACL data: handle 5 flags 0x02 dlen 12

L2CAP(s): Disconn req: dcid 0x0046 scid 0x0040

>HCI Event: Number of Completed Packets (0x13) plen 5

>ACL data: handle 5 flags 0x02 dlen 12

L2CAP(s): Disconn rsp: dcid 0x0046 scid 0x0040

< ACL data: handle 5 flags 0x02 dlen 12

L2CAP(s): Connect req: psm 3 scid 0x0040

>HCI Event: Number of Completed Packets (0x13) plen 5

>ACL data: handle 5 flags 0x02 dlen 16

L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0040 result 1 status 2

Connection pending - Authorization pending

>HCI Event: Link Key Request (0x17) plen 6

Can't connect RFCOMM channel< ACL data: handle 5 flags 0x02 dlen 12

L2CAP(s): Connect req: psm 3 scid 0x0040

>HCI Event: Number of Completed Packets (0x13) plen 5

>ACL data: handle 5 flags 0x02 dlen 16

L2CAP(s): Connect rsp: dcid 0x0047 scid 0x0040 result 1 status 2

Connection pending - Authorization pending

>ACL data: handle 5 flags 0x02 dlen 16

L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 3 status 0

Connection refused - security block

Can't connect RFCOMM channel> HCI Event: Disconn Complete (0x05) plen 4

< HCI Command: Create Connection (0x01|0x0005) plen 13

>HCI Event: Command Status (0x0f) plen 4

>HCI Event: Connect Complete (0x03) plen 11

< ACL data: handle 6 flags 0x02 dlen 12

L2CAP(s): Connect req: psm 3 scid 0x0040

>HCI Event: Connection Packet Type Changed (0x1d) plen 5

>HCI Event: Number of Completed Packets (0x13) plen 5

>ACL data: handle 6 flags 0x02 dlen 16

L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0040 result 1 status 2

Connection pending - Authorization pending

>HCI Event: Link Key Request (0x17) plen 6

snd-bt-sco: playback_open

snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 2000

snd-bt-sco: playback_trigger 1

snd-bt-sco: setting playback to bspcm

snd-bt-sco: playback_trigger 0

snd-bt-sco: setting playback to NULL

Can't connect RFCOMM channel< ACL data: handle 6 flags 0x02 dlen 12

L2CAP(s): Connect req: psm 3 scid 0x0040

>HCI Event: Number of Completed Packets (0x13) plen 5

>ACL data: handle 6 flags 0x02 dlen 16

L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0040 result 1 status 2

Connection pending - Authorization pending

>ACL data: handle 6 flags 0x02 dlen 16

L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 3 status 0

Connection refused - security block

Can't connect RFCOMM channel> HCI Event: Disconn Complete (0x05) plen 4

< HCI Command: Create Connection (0x01|0x0005) plen 13

>HCI Event: Command Status (0x0f) plen 4

>HCI Event: Connect Complete (0x03) plen 11

>HCI Event: Connection Packet Type Changed (0x1d) plen 5

< ACL data: handle 7 flags 0x02 dlen 12

L2CAP(s): Connect req: psm 3 scid 0x0040

>HCI Event: Number of Completed Packets (0x13) plen 5

>ACL data: handle 7 flags 0x02 dlen 16

L2CAP(s): Connect rsp: dcid 0x004a scid 0x0040 result 1 status 2

Connection pending - Authorization pending

>HCI Event: Link Key Request (0x17) plen 6

snd-bt-sco: playback_open

snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 2000

snd-bt-sco: playback_trigger 1

snd-bt-sco: setting playback to bspcm

Can't connect RFCOMM channel< ACL data: handle 7 flags 0x02 dlen 12

L2CAP(s): Connect req: psm 3 scid 0x0040

>HCI Event: Number of Completed Packets (0x13) plen 5

>ACL data: handle 7 flags 0x02 dlen 16

L2CAP(s): Connect rsp: dcid 0x004a scid 0x0040 result 1 status 2

Connection pending - Authorization pending

>ACL data: handle 7 flags 0x02 dlen 16

L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 result 3 status 0

Connection refused - security block

Can't connect RFCOMM channel> HCI Event: Disconn Complete (0x05) plen 4

< HCI Command: Create Connection (0x01|0x0005) plen 13

>HCI Event: Command Status (0x0f) plen 4

>HCI Event: Connect Complete (0x03) plen 11

>HCI Event: Connection Packet Type Changed (0x1d) plen 5

< ACL data: handle 8 flags 0x02 dlen 12

L2CAP(s): Connect req: psm 3 scid 0x0040

>HCI Event: Number of Completed Packets (0x13) plen 5

>ACL data: handle 8 flags 0x02 dlen 16

L2CAP(s): Connect rsp: dcid 0x004c scid 0x0040 result 1 status 2

Connection pending - Authorization pending

>HCI Event: Link Key Request (0x17) plen 6


etc.

More later - when I return from vacation I'll spend more time on it. Any 
help I can get would be appreciated.

Bob

_________________________________________________________________
Get a preview of Live Earth, the hottest event this summer - only on MSN 
http://liveearth.msn.com?source=msntaglineliveearthhm


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
