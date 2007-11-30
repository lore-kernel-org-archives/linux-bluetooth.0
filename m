Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Christopher Reder" <creder@digitalcpt.com>
To: <bluez-users@lists.sourceforge.net>
Date: Fri, 30 Nov 2007 14:44:04 -0600
Message-ID: <02eb01c83391$bea8d7f0$2600a8c0@engineering5>
MIME-Version: 1.0
Subject: [Bluez-users] headset not connecting, pin issue?
Reply-To: creder@digitalcpt.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Hello all.  I have searched around and seen people with similar issues but
have not found a solution yet.  

I am trying to connect a headset to a linux box with a usb Bluetooth dongle.
I would like to listen to music through the headset.  

When I run mplayer -ao alsa:device=Bluetooth song.mp3, I get:

alsa-lib: pcm_bluetooth.c:1145:(bluetooth_init) Connection fail
alsa-init: playback open error: Connection refused
Could not open/initialize audio device -> no sound.

Which tells me that it sees the .asoundrc file and is trying to play via
Bluetooth.  However, I do not think that the headset is connected.  So, when
I hit the button on the headset, I get the following from the hcidump.  Keep
in mind that I have hcid.conf configured so that it points to a pin file
with the echo PIN="0000"
  pin_helper /home/root/bluepin;  (in hcid.conf)
#!/bin/sh   (in bluepin with chmod 777)
echo "PIN:0000"

root@sarge-at91:/etc/bluetooth$ > HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
> HCI Event: Command Status (0x0f) plen 4
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Read Remote Supported Features (0x0b) plen 11
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x004e
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004e result 0 status 0
      Connection successful
> HCI Event: Command Status (0x0f) plen 4
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x004e flags 0x00 result 0 clen 4
      Success
      MTU 48
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004e flags 0x00 clen 0
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
> HCI Event: Command Status (0x0f) plen 4
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Remote Name Req Complete (0x07) plen 255
> ACL data: handle 11 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x1 len 0xa
          pat uuid-32 0x111f (Handsfree AG)
          max 40
          cont 00
< ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x004e len 10 [psm 1]
        SDP SS Rsp: tid 0x1 len 0x5
          count 0
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 19
    L2CAP(d): cid 0x0040 len 15 [psm 1]
        SDP SS Req: tid 0x2 len 0xa
          pat uuid-32 0x1112 (Headset AG)
          max 40
          cont 00
< ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x004e len 10 [psm 1]
        SDP SS Rsp: tid 0x2 len 0x5
          count 0
          cont 00
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x004e
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x004e
> HCI Event: Number of Completed Packets (0x13) plen 5
> HCI Event: Disconn Complete (0x05) plen 4

I see from this that it sees the headset but is not connecting.  I don't
know if it is because of the pin not connecting, or if the hcid.conf is not
correct.  Can anyone offer a suggestion on this?

I can post more info if anyone needs something that I have not put in here.

Thanks
Christopher

Internal Virus Database is out-of-date.
Checked by AVG Free Edition. 
Version: 7.5.503 / Virus Database: 269.15.34/1134 - Release Date: 11/16/2007
9:52 AM
 


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
