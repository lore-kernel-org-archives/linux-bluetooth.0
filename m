Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Francesco <guybrush.t@libero.it>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1112223455.7866.14.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] btsco + Plantronics headset + Trust bt dongle - stops after 1 sec
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 31 Mar 2005 00:57:35 +0200

Hi everybody and thanks for the help.
I'm running ubuntu warty (kernel 2.6.8.1) compiled for K7, using
bluez-utils 2.7.
I've got a Plantronics M3000 headset and a Trust BT120 bluetooth USB
dongle and i can't for my life get them to work together.
I compiled btsco from CVS, kernel module included, the dongle's drivers
get loaded (it works, at least partially, because i used it with my old
nokia to browse the web), the snd-bt-sco module too, without warnings or
errors. 
Launching btsco, it seems to work, the RFCOMM connection works, clicks
on the headset buttons are reported and acted upon, but any application
trying to record from the headset gets only 1 second of (bad) audio and
then stops, while playback never works, just gives background noise (but
the headset actually becomes 'active' when an app tries to play
something)
Hcidump shows SCO packets from handset with voice in it (packets payload
varies with audio in input in the microphone)
I also failed when trying the same setup with chan_bluetooth in asterisk
in more or less in the same way, so i suppose it's a matter of
compatibility ?

Only strange findings are the following:
#1: output from "hciconfig hci0 revision"

root@franz:~ # hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0B:0D:21:58:A4 ACL MTU: 339:4  SCO MTU: 64:0
        Unsupported manufacturer


#2: strange error in hcidump decode while running "sdptool search hs" :

--------------------------------------------
> ACL data: handle 0x0001 flags 0x02 dlen 27
> ACL data: handle 0x0001 flags 0x01 dlen 25
    L2CAP(d): cid 0x40 len 48 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2b
          cnt 0x26
 len 0x26 frm->len 0x26 n 0x54
          srv rec #0
            aid 0x0000 (SrvRecHndl)
               uint 0x10000
            aid 0x0001 (SrvClassIDList)
               uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio)
            aid 0x0004 (ProtocolDescList)
               uuid-16 0x0100 (L2CAP)
               uuid-16 0x0200 uint 0x200000000000000

ERROR: Unexpected syntax

          srv rec #1

ERROR: Unexpected syntax
          srv rec #2

[snip... get up to 35]

ERROR: Unexpected syntax
          cont 
< ACL data: handle 0x0001 flags 0x02 dlen 26
    L2CAP(d): cid 0x41 len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x1108 (Headset)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 31 
---------------------------------------------------

#3 Tons of kernel messages when finished recording (btsco idle)

Mar 31 00:21:19 localhost kernel: hci_scodata_packet: hci0 SCO packet
for unknown connection handle 0
Mar 31 00:21:27 localhost last message repeated 39430 times
--------------------------------------------------

I omitted the output that i thought was less important, hoping not to
clutter the message too much.
THANKS A LOT to anyone who can help me solve this problem,

Francesco



# follows the output from a couple of diag commands

root@franz:~ # hciconfig hci0   
hci0:   Type: USB
        BD Address: 00:0B:0D:21:58:A4 ACL MTU: 339:4  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN 
        RX bytes:867 acl:10 sco:0 events:50 errors:0
        TX bytes:849 acl:7 sco:0 commands:36 errors:0

root@franz:~ # sdptool search hs
Inquiring ...
Searching for hs on 00:03:89:43:2A:58 ...
Service Name: HS-Audio
Service RecHandle: 0x10000
Service Class ID List:
  "Headset" (0x1108)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100






-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
