Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050224100445.73941.qmail@web60905.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] sdp problem
To: bluez-users@lists.sourceforge.net
In-Reply-To: <421C9D77.7040606@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
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
Date: Thu, 24 Feb 2005 18:04:45 +0800 (CST)

Hi all!
    I've read the email from Marco Trudel and Luis.
Then I tried the things they have stated. I'd like to
reply their mail here.
    For Luis's mail, I tried to add services in my
Linux PC. Then my T610 can find it. But then, how can
I do so that the T610 can be offered a real service so
that it can access my PC? And what I want is:  when my
main program is running, the PC will wait until T610
and, in the later case, iPAQ to connect to PC and then
do the access in my PC. So, after I added the services
in my PC, how can I do for T610 and/or PC?
    For Marco's email, firstly, I've asked y tutor,
and he said that for T610, the possible way using sdp
and connecting to Linux PC is to let T610 as headset,
and then do for it. About KDE, actually, in my
project, it may not be used, but does it work like
GTK+, and can it be really implemented in T610? For
the program that listens on a rfcomm channel, I think
that the most important thing is how I put the
functions from sdptool in my main program as I found
that the way to do is to let the main program to add
services once it runs the program. But then what I
have to solve is even though the services are added,
how can I do so that the T610 and other bluetooth
mobile devices such as iPAQ can find the services that
my PC provides and then connect to PC i.e. how can the
program wait for accepting connections from outside
bodies? (That's the point what I think.) And you told
me to write a client program for T610 that listens for
rfcomm channel and then type "sdptool add --channel=6
OPUSH", but does my thought better? Finally, here is
the output when I run "hcidump -t- X" after I added
headset service in my PC:
[root@cm218-253-8-120 root]# hcidump -t -X
HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
1109237997.436839 > HCI Event: Connect Request (0x04)
plen 10
  0000: a8 d8 dd d9 0a 00 04 02  52 01                
   ........R.
1109237997.437040 < HCI Command: Accept Connection
Request (0x01|0x0009) plen 7
    bdaddr 00:0A:D9:DD:D8:A8 role 0x01
    Role: Slave
1109237997.455844 > HCI Event: Command Status (0x0f)
plen 4
  0000: 00 01 09 04                                   
   ....
1109237997.476836 > HCI Event: Connect Complete (0x03)
plen 11
  0000: 00 29 00 a8 d8 dd d9 0a  00 01 00             
   .).........
1109237997.477840 < HCI Command: Write Link Policy
Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
1109237997.478837 > HCI Event: Page Scan Repetition
Mode Change (0x20) plen 7
  0000: a8 d8 dd d9 0a 00 01                          
   .......
1109237997.494834 > HCI Event: Command Complete (0x0e)
plen 6
  0000: 01 0d 08 00 29 00                             
   ....).
1109237997.495833 < HCI Command: Change Connection
Packet Type (0x01|0x000f) ple
n 4
    handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
  0000: 29 00 18 cc                                   
   )...
1109237997.510833 > HCI Event: Command Status (0x0f)
plen 4
  0000: 00 01 0f 04                                   
   ....
1109237997.512830 > HCI Event: Connection Packet Type
Changed (0x1d) plen 5
  0000: 00 29 00 18 00                                
   .)...
1109237997.528831 > ACL data: handle 41 flags 0x02
dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0043
1109237997.532192 < ACL data: handle 41 flags 0x02
dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0043
result 0 status 0
1109237997.538828 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1109237997.542826 > ACL data: handle 41 flags 0x02
dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen
4
      MTU 251
1109237997.544863 < ACL data: handle 41 flags 0x02
dlen 14
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00
result 0 clen 0
1109237997.544873 < ACL data: handle 41 flags 0x02
dlen 12
    L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen
0
1109237997.550820 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1109237997.552818 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1109237997.556828 > ACL data: handle 41 flags 0x02
dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00
result 0 clen 0
1109237997.561823 > ACL data: handle 41 flags 0x02
dlen 17
1109237997.563845 > ACL data: handle 41 flags 0x01
dlen 17
    L2CAP(d): cid 0x0040 len 30 [psm 1]
        SDP SSA Req: tid 0x0 len 0x19
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTPro
fileDescList) 0x0100 (SrvName) 0x0302 (unknown)
          cont 00
1109237997.564242 < ACL data: handle 41 flags 0x02
dlen 69
    L2CAP(d): cid 0x0043 len 65 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x3c
          count 57
          record #0
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1108 (Headset) uuid-16
0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x5 > >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint
0x100 > >
              aid 0x0100 (SrvName)
                 str "Headset"
          cont 00
1109237997.575821 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1109237997.586821 > ACL data: handle 41 flags 0x02
dlen 17
1109237997.588822 > ACL data: handle 41 flags 0x01
dlen 17
    L2CAP(d): cid 0x0040 len 30 [psm 1]
        SDP SSA Req: tid 0x0 len 0x19
          pat uuid-16 0x111e (Handsfree)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTPro
fileDescList) 0x0100 (SrvName) 0x0311 (unknown)
          cont 00
1109237997.589204 < ACL data: handle 41 flags 0x02
dlen 14
    L2CAP(d): cid 0x0043 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
1109237997.595815 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1109237997.605820 > ACL data: handle 41 flags 0x02
dlen 17
1109237997.607819 > ACL data: handle 41 flags 0x01
dlen 14
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SSA Req: tid 0x0 len 0x16
          pat uuid-16 0x1107 (IRMCSyncCmd)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTPro
fileDescList) 0x0100 (SrvName)
          cont 00
1109237997.608241 < ACL data: handle 41 flags 0x02
dlen 14
    L2CAP(d): cid 0x0043 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
1109237997.614814 > HCI Event: Number of Completed
Packets (0x13) plen 5
 0000: 01 29 00 01 00                                 
  .)...
1109237997.623845 > ACL data: handle 41 flags 0x02
dlen 17
1109237997.626806 > ACL data: handle 41 flags 0x01
dlen 17
    L2CAP(d): cid 0x0040 len 30 [psm 1]
        SDP SSA Req: tid 0x0 len 0x19
          pat uuid-16 0x1105 (OBEXObjPush)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTPro
fileDescList) 0x0100 (SrvName) 0x0303
(SuppFormatsList)
          cont 00
1109237997.627228 < ACL data: handle 41 flags 0x02
dlen 14
    L2CAP(d): cid 0x0043 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
1109237997.633810 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1109237997.642832 > ACL data: handle 41 flags 0x02
dlen 17
1109237997.644810 > ACL data: handle 41 flags 0x01
dlen 14
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SSA Req: tid 0x0 len 0x16
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTPro
fileDescList) 0x0100 (SrvName)
          cont 00
1109237997.645280 < ACL data: handle 41 flags 0x02
dlen 14
    L2CAP(d): cid 0x0043 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
1109237997.652807 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1109237997.661825 > ACL data: handle 41 flags 0x02
dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0043
1109237997.661885 < ACL data: handle 41 flags 0x02
dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0043
1109237997.667805 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1109237997.763783 > HCI Event: Disconn Complete (0x05)
plen 4
  0000: 00 29 00 13                                   
   .)..
    I do hope that you all can help me to solve my
problem and confusing based on my information given to
all of you. Thank you very much for your kindness.
Michael


_______________________________________________________________________
Yahoo! 工具列 - 內置防止彈出視窗工能！
http://toolbar.yahoo.com.hk


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
