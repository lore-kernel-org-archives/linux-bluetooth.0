Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050218033309.99437.qmail@web60904.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] rfcomm question 3
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4214CE86.3010701@gmx.ch>
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
Date: Fri, 18 Feb 2005 11:33:09 +0800 (CST)

Hi Marco!
    Sorry for that. there is one thing missing. 
    When I ran "hcidump -t -X" and then I let my phone
to update the "local service", the output is like
this:
[root@csg457-kinlok-cyc722 root]# hcidump -t -X
HCIDump - HCI packet analyzer ver 1.16
device: hci0 snap_len: 1028 filter: 0xffffffff
1108694591.032437 > HCI Event: Connect Request (0x04)
plen 10
  0000: a8 d8 dd d9 0a 00 04 02  52 01                
   ........R.
1108694591.032900 < HCI Command: Accept Connection
Request (0x01|0x0009) plen 7
  0000: a8 d8 dd d9 0a 00 01                          
   .......
1108694591.042439 > HCI Event: Command Status (0x0f)
plen 4
  0000: 00 01 09 04                                   
   ....
1108694591.057439 > HCI Event: Connect Complete (0x03)
plen 11
  0000: 00 29 00 a8 d8 dd d9 0a  00 01 00             
   .).........
1108694591.058447 < HCI Command: Write Link Policy
Settings (0x02|0x000d) plen 4
  0000: 29 00 0f 00                                   
   )...
1108694591.059437 > HCI Event: Page Scan Repetition
Mode Change (0x20) plen 7
  0000: a8 d8 dd d9 0a 00 01                          
   .......
1108694591.066448 > HCI Event: Command Complete (0x0e)
plen 6
  0000: 01 0d 08 00 29 00                             
   ....).
1108694591.067441 < HCI Command: Change Connection
Packet Type (0x01|0x000f) ple
n 4
  0000: 29 00 18 cc                                   
   )...
1108694591.075434 > HCI Event: Command Status (0x0f)
plen 4
  0000: 00 01 0f 04                                   
   ....
1108694591.076430 > HCI Event: Connection Packet Type
Changed (0x1d) plen 5
  0000: 00 29 00 18 00                                
   .)...
1108694591.103432 > ACL data: handle 0x0029 flags 0x02
dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
1108694591.104425 < ACL data: handle 0x0029 flags 0x02
dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040
result 0 status 0
1108694591.111432 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1108694591.114443 > ACL data: handle 0x0029 flags 0x02
dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000
clen 4
    MTU 251
1108694591.119481 < ACL data: handle 0x0029 flags 0x02
dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000
result 0 clen 0
1108694591.119502 < ACL data: handle 0x0029 flags 0x02
dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000
clen 0
1108694591.125426 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1108694591.127424 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1108694591.130429 > ACL data: handle 0x0029 flags 0x02
dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000
result 0 clen 0
1108694591.135434 > ACL data: handle 0x0029 flags 0x02
dlen 17
1108694591.137449 > ACL data: handle 0x0029 flags 0x01
dlen 17
    L2CAP(d): cid 0x0040 len 30 [psm 1]
        SDP SSA Req: tid 0x0 len 0x19
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTPro
fileDescList) 0x0100 (SrvName) 0x0302 (unknown)
          cont 00
1108694591.138414 < ACL data: handle 0x0029 flags 0x02
dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
1108694591.144450 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1108694591.153430 > ACL data: handle 0x0029 flags 0x02
dlen 17
1108694591.155429 > ACL data: handle 0x0029 flags 0x01
dlen 17
    L2CAP(d): cid 0x0040 len 30 [psm 1]
        SDP SSA Req: tid 0x0 len 0x19
          pat uuid-16 0x111e (Handsfree)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTPro
fileDescList) 0x0100 (SrvName) 0x0311 (unknown)
          cont 00
1108694591.156030 < ACL data: handle 0x0029 flags 0x02
dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
1108694591.164449 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1108694591.173426 > ACL data: handle 0x0029 flags 0x02
dlen 17
1108694591.176423 > ACL data: handle 0x0029 flags 0x01
dlen 14
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SSA Req: tid 0x0 len 0x16
          pat uuid-16 0x1107 (IRMCSyncCmd)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTPro
fileDescList) 0x0100 (SrvName)
          cont 00
1108694591.176892 < ACL data: handle 0x0029 flags 0x02
dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
1108694591.184438 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1108694591.193441 > ACL data: handle 0x0029 flags 0x02
dlen 17
1108694591.195438 > ACL data: handle 0x0029 flags 0x01
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
1108694591.196315 < ACL data: handle 0x0029 flags 0x02
dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
1108694591.203415 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1108694591.212423 > ACL data: handle 0x0029 flags 0x02
dlen 17
1108694591.214446 > ACL data: handle 0x0029 flags 0x01
dlen 14
    L2CAP(d): cid 0x0040 len 27 [psm 1]
        SDP SSA Req: tid 0x0 len 0x16
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 65535
          aid(s) 0x0001 (SrvClassIDList) 0x0004
(ProtocolDescList) 0x0009 (BTPro
fileDescList) 0x0100 (SrvName)
          cont 00
1108694591.215070 < ACL data: handle 0x0029 flags 0x02
dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x5
          count 2
          cont 00
1108694591.222411 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1108694591.231413 > ACL data: handle 0x0029 flags 0x02
dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
1108694591.231500 < ACL data: handle 0x0029 flags 0x02
dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
1108694591.239408 > HCI Event: Number of Completed
Packets (0x13) plen 5
  0000: 01 29 00 01 00                                
   .)...
1108694591.329386 > HCI Event: Disconn Complete (0x05)
plen 4
  0000: 00 29 00 13                                   
   .)..
    What does it mean? And is there any error? If so,
how can I do?
Thanks a lot!
Michael

_______________________________________________________________________
新年願望第一位 : 找到友緣人
http://personals.yahoo.com.hk


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
