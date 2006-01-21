Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Francesco <francesco.doffizi@email.it>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;boundary="Boundary-00=_Ifq0DG8unemfLOF"
Message-Id: <200601212129.44576.francesco.doffizi@email.it>
Subject: [Bluez-users] Trust 5300M BT Mouse
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
Date: Sat, 21 Jan 2006 21:29:44 +0000

--Boundary-00=_Ifq0DG8unemfLOF
Content-Type: text/plain;charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've bought this mouse to use it with the bt module in my toshiba Satellite 
5200-801 but I can't make it work.
I applied used this howto http://www.bueche.ch/comp/mx900/mx900.html to make 
the configuration of my linux box but I can't get my arrow moving on the 
screen.
The stack seems connecting to the device, I can se for half a second some 
movements on the screen but suddenly it stops. I attached a dump from hcidump 
about what is happening.

This is hciconfig -a output.

hci0:   Type: USB
        BD Address: 00:03:7A:07:6F:12 ACL MTU: 60:20 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:426 acl:0 sco:0 events:23 errors:0
        TX bytes:349 acl:0 sco:0 commands:25 errors:0
        Features: 0xff 0x02 0x04 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'ITOSHY'
        Class: 0x120301
        Service Classes: Networking
        Device Class: LAN Access, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver: 0x514
        Manufacturer: Silicon Wave (11)

I tried with different classes in hcid.conf without any improvements. Can you 
give me some hints how can I understand how to solve this problem?

Thanks

Francesco

 

 

 --

 Email.it, the professional e-mail, gratis per te: http://www.email.it/f

 

 Sponsor:

 America, Africa, Australia, Asia...con Email Phone Card chiami ovunque spendendo meno di una telefonata interurbana

 Clicca qui: http://adv.email.it/cgi-bin/foclick.cgi?mid=2688&d=21-1
--Boundary-00=_Ifq0DG8unemfLOF
Content-Type: text/plain;charset="us-ascii";name="rep.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;filename="rep.txt"

HCI sniffer - Bluetooth packet analyzer ver 1.21
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Disconn Complete (0x05) plen 4
  00 00 00 08 
> HCI Event: Connect Request (0x04) plen 10
  1A 35 C1 94 0A 00 80 25 00 01 
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:0A:94:C1:35:1A role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04 
> HCI Event: Connect Complete (0x03) plen 11
  00 00 00 1A 35 C1 94 0A 00 01 00 
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 0 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Max Slots Change (0x1b) plen 3
  00 00 05 
> ACL data: handle 0 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x004a
< ACL data: handle 0 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x004a result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 00 00 
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 0 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04 
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 00 00 18 CC 
> ACL data: handle 0 flags 0x02 dlen 40
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 28
      MTU 48 QoS 0x01 (Best effort) 
< ACL data: handle 0 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004a flags 0x00 result 0 clen 0
      Success
< ACL data: handle 0 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x004a flags 0x00 clen 4
      MTU 48 
> HCI Event: QoS Setup Complete (0x0d) plen 21
  00 00 00 00 01 00 00 04 00 00 00 04 00 00 00 00 00 00 00 00 
  00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> HCI Event: Role Change (0x12) plen 8
  00 1A 35 C1 94 0A 00 00 
> HCI Event: Max Slots Change (0x1b) plen 3
  00 00 05 
> ACL data: handle 0 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 0 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x004b
< ACL data: handle 0 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x004b result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> ACL data: handle 0 flags 0x02 dlen 40
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 28
      MTU 48 QoS 0x01 (Best effort) 
< ACL data: handle 0 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004b flags 0x00 result 0 clen 0
      Success
< ACL data: handle 0 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x004b flags 0x00 clen 4
      MTU 48 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> ACL data: handle 0 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 0 flags 0x02 dlen 10
    L2CAP(d): cid 0x004b len 6 [psm 19]
      HIDP: Data: Output report
      02 00 00 00 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> ACL data: handle 0 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 F9 03 00 
> ACL data: handle 0 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 13 06 00 
> ACL data: handle 0 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 13 07 00 
> ACL data: handle 0 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 0F 04 00 
> ACL data: handle 0 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 0F 02 00 
> HCI Event: Mode Change (0x14) plen 6
  00 00 00 02 14 00 
> ACL data: handle 0 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 10 00 00 
> HCI Event: Disconn Complete (0x05) plen 4
  00 00 00 08 
> HCI Event: Connect Request (0x04) plen 10
  1A 35 C1 94 0A 00 80 25 00 01 
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:0A:94:C1:35:1A role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04 
> HCI Event: Connect Complete (0x03) plen 11
  00 00 00 1A 35 C1 94 0A 00 01 00 
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 0 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Max Slots Change (0x1b) plen 3
  00 00 05 
> ACL data: handle 0 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0040
< ACL data: handle 0 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 00 00 
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 0 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04 
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 00 00 18 CC 
> ACL data: handle 0 flags 0x02 dlen 17
> ACL data: handle 0 flags 0x01 dlen 23
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 28
      MTU 48 QoS 0x01 (Best effort) 
< ACL data: handle 0 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 0 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> HCI Event: QoS Setup Complete (0x0d) plen 21
  00 00 00 00 01 00 00 04 00 00 00 04 00 00 00 00 00 00 00 00 
  00 
> ACL data: handle 0 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 0 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0041
< ACL data: handle 0 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> HCI Event: Role Change (0x12) plen 8
  00 1A 35 C1 94 0A 00 00 
> HCI Event: Max Slots Change (0x1b) plen 3
  00 00 05 
> ACL data: handle 0 flags 0x02 dlen 17
> ACL data: handle 0 flags 0x01 dlen 17
> ACL data: handle 0 flags 0x01 dlen 6
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 28
      MTU 48 QoS 0x01 (Best effort) 
< ACL data: handle 0 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 0 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 48 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> ACL data: handle 0 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 0 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Output report
      02 00 00 00 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 00 00 01 00 
> ACL data: handle 0 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 02 FF 00 
> ACL data: handle 0 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 01 FF 00 
> ACL data: handle 0 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 03 FD 00 
> ACL data: handle 0 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 06 0C 00 
> HCI Event: Mode Change (0x14) plen 6
  00 00 00 02 14 00 
> ACL data: handle 0 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      02 00 F2 FC 00 
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
  00 01 01 04 
> HCI Event: Disconn Complete (0x05) plen 4
  00 00 00 08 

--Boundary-00=_Ifq0DG8unemfLOF--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
