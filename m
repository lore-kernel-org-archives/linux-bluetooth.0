Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 04 Oct 2006 21:12:30 +0200
From: Michel Leconte <leconte.michel@cegetel.net>
To: bluez-users@lists.sourceforge.net
Message-id: <001701c6e7e9$0a0f2a00$78b44856@claudia>
MIME-version: 1.0
Subject: [Bluez-users] Use an ACL link when an SCO link  is established
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1361897382=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1361897382==
Content-type: multipart/alternative;
	boundary="Boundary_(ID_zePGruFG2hWBUJk5IMxZDA)"

This is a multi-part message in MIME format.

--Boundary_(ID_zePGruFG2hWBUJk5IMxZDA)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT

Hi all,

my goal is to use an ACL link when an SCO link is established.

I work with two bluetooth development kits from Semtech-Xemics (SE1441). 

They are compliant Bluetooth v1.2. For the following explanations, one kit is noted "A" and the other "B".

1) First, I create an ACL link between "A" and "B" with : hcitool cc BD_ADDR of "B",

2) Once the ACL link is done, "A" execute an "HCI_Setup_Synchronous_Connection" command to "B",

3) At the event of an SCO request connection, "B" respond with an "HCI_Accept_Synchronous_Connection_Request" command.

4) When the SCO link is established, a "Synchronous Connection Complete" HCI event is visible from the hci layer of each kit.

the "hcitool con" gives :

> SCO AA:AA:AA:AA:AA:04 handle 0 state 5 lm SLAVE

> ACL AA:AA:AA:AA:AA:04 handle 0 state 1 lm SLAVE



5) I try to use the ACL link with a l2ping command from B to A

the l2ping command gives :

l2ping AA:AA:AA:AA:AA:04 (BD_ADDR of A)

Ping: AA:AA:AA:AA:AA:04 from AA:AA:AA:AA:AA:05 (data size 44) ...

no response from AA:AA:AA:AA:AA:04: id 0

no response from AA:AA:AA:AA:AA:04: id 1

---------------------------------------------------------------------------------------------------------------------

Question 1 : With this configuration (SCO and ACL links between A and B), why l2ping doesn't work ? 

The ACL link can be used isn't it ?



Question 2 : From the hci dump of each side, I notice that there is a difference between the information

of the command and the OGF and OCF between the parenthesises. See below the hcidump results, the 

 red lines are those which give me a problem. At the "A" side, I send an "HCI_Setup_Asynchronous_Connection" and hcidump indicates an  "HCI_Accept_Synchronous_Connection". I get a similar problem in "B" side an "HCI_Reject_Synchronous_Connection " instead of an " HCI_Accept_Synchronous_Connection ".

When you see the bluetooth spec :

HCI_Setup_Asynchronous_Connection is OGF=0x01 and OCF=0x28 

HCI_Accept_Synchronous_Connection is OGF=0x01 and OCF=0x29 

HCI_Reject_Synchronous_Connection is OGF=0x01 and OCF=0x2A 

 

Do these differences are benign for the bluez stack or they can be the origine

of my problem ??




************************** HCI dump from "A" ***********************************************

HCI sniffer - Bluetooth packet analyzer ver 1.30

device: hci0 snap_len: 1028 filter: 0xffffffff

< HCI Command: Create Connection (0x01|0x0005) plen 13

bdaddr AA:AA:AA:AA:AA:05 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000

Packet type: DM1 DM3 DM5 DH1 DH3 DH5 

> HCI Event: Command Status (0x0f) plen 4

Create Connection (0x01|0x0005) status 0x00 ncmd 1

> HCI Event: Connect Complete (0x03) plen 11

status 0x00 handle 0 bdaddr AA:AA:AA:AA:AA:05 type ACL encrypt 0x00

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

handle 0 policy 0x0f

Link policy: RSWITCH HOLD SNIFF PARK 

> HCI Event: Command Complete (0x0e) plen 6

Write Link Policy Settings (0x02|0x000d) ncmd 1

status 0x00 handle 0

< HCI Command: Accept Synchronous Connection (0x01|0x0028) plen 17

handle 0

40 1F 00 00 40 1F 00 00 FF FF C1 01 00 04 00 

> HCI Event: Max Slots Change (0x1b) plen 3

handle 0 slots 5

> HCI Event: Command Status (0x0f) plen 4

Accept Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1

> HCI Event: Synchronous Connect Complete (0x2c) plen 17

status 0x00 handle 256 bdaddr AA:AA:AA:AA:AA:05 type SCO

Air mode: u-law log

************************** HCI dump from "B" ***********************************************


HCI sniffer - Bluetooth packet analyzer ver 1.30

device: hci0 snap_len: 1028 filter: 0xffffffff

> HCI Event: Connect Request (0x04) plen 10

bdaddr AA:AA:AA:AA:AA:04 class 0x3e0100 type ACL

< HCI Command: Accept Connection Request (0x01|0x0009) plen 7

bdaddr AA:AA:AA:AA:AA:04 role 0x01

Role: Slave

> HCI Event: Command Status (0x0f) plen 4

Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1

> HCI Event: Connect Complete (0x03) plen 11

status 0x00 handle 0 bdaddr AA:AA:AA:AA:AA:04 type ACL encrypt 0x00

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

handle 0 policy 0x0f

Link policy: RSWITCH HOLD SNIFF PARK 

> HCI Event: Command Complete (0x0e) plen 6

Write Link Policy Settings (0x02|0x000d) ncmd 1

status 0x00 handle 0

< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4

handle 0 ptype 0xcc18

Packet type: DM1 DM3 DM5 DH1 DH3 DH5 

> HCI Event: Command Status (0x0f) plen 4

Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1

> HCI Event: Connection Packet Type Changed (0x1d) plen 5

status 0x00 handle 0 ptype 0x0018

Packet type: DM1 DH1 

> HCI Event: Connect Request (0x04) plen 10

bdaddr AA:AA:AA:AA:AA:04 class 0x3e0100 type SCO

< HCI Command: Accept Connection Request (0x01|0x0009) plen 7

bdaddr AA:AA:AA:AA:AA:04 role 0x01

Role: Slave

> HCI Event: Command Status (0x0f) plen 4

Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1

< HCI Command: Reject Synchronous Connection (0x01|0x0029) plen 21

bdaddr AA:AA:AA:AA:AA:04

FF FF FF FF FF FF FF FF FF FF C1 01 FF 04 00 

> HCI Event: Command Status (0x0f) plen 4

Reject Synchronous Connection (0x01|0x0029) status 0x00 ncmd 1

> HCI Event: Synchronous Connect Complete (0x2c) plen 17

status 0x00 handle 256 bdaddr AA:AA:AA:AA:AA:04 type SCO

Air mode: u-law log



Question 3 : The event "Synchronous Connect Complete" gives the handle of the SCO link

in my case the handle value is 256. But when you see upside the hcitool

con result gives a handle 0 ? Is it normal ? 


Question 4 : Here's my software configurations : hcidump 1.30 bluez-libs-2.25 bluez-utils-2.25 linux-debian 2.6.12.2 with an ARM target 



As I have to keep the kernel 2.6.12.2, with wich higher version of bluez-libs, bluez-utils and hcidump can I use to be compliant with my kernel ? 



Thanks to all for any suggestions..

warm regards

Michel

---------------------------------------------------------------------------------------------------------------------

the result of an "hciconfig -a" is :

hci0: Type: UART

BD Address: AA:AA:AA:AA:AA:04 ACL MTU: 339:8 SCO MTU: 180:8

UP RUNNING PSCAN ISCAN

RX bytes:522 acl:0 sco:0 events:61 errors:0

TX bytes:1367 acl:15 sco:0 commands:26 errors:0

Features: 0xff 0xff 0xbd 0xf8 0x1b 0x18 0x00 0x80

Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3

Link policy: RSWITCH HOLD SNIFF PARK

Link mode: SLAVE ACCEPT

Name: 'BlueZ (0)'

Class: 0x3e0100

Service Classes: Networking, Rendering, Capturing

Device Class: Computer, Uncategorized

HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0xc

Manufacturer: Newlogic (23)

---------------------------------------------------------------------------------------------------------------------------

--Boundary_(ID_zePGruFG2hWBUJk5IMxZDA)
Content-type: text/html; charset=iso-8859-1
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<META content="MSHTML 6.00.2800.1106" name=GENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=#ffffff>
<DIV><FONT face=Arial size=2><FONT size=2>
<P>Hi all,</P>
<P>my goal is to use an ACL link when an SCO link is established.</P>
<P>I work with two bluetooth development kits from Semtech-Xemics (SE1441). </P>
<P>They are compliant Bluetooth v1.2. For the following explanations, one kit is 
noted "A" and the other "B".</P>
<P>1) First, I create an ACL link between "A" and "B" with : hcitool cc BD_ADDR 
of "B",</P>
<P>2) Once the ACL link is done, "A" execute an 
"HCI_Setup_Synchronous_Connection" command to "B",</P>
<P>3) At the event of an SCO request connection, "B" respond with an 
"HCI_Accept_Synchronous_Connection_Request" command.</P>
<P>4) When the SCO link is established, a "Synchronous Connection Complete" HCI 
event is visible from the hci layer of each kit.</P>
<P>the "hcitool con" gives :</P></FONT><FONT face="Courier New" size=2>
<P>&gt; SCO AA:AA:AA:AA:AA:04 handle 0 state 5 lm SLAVE</P>
<P>&gt; ACL AA:AA:AA:AA:AA:04 handle 0 state 1 lm SLAVE</P></FONT><FONT size=2>
<P>&nbsp;</P>
<P>5) I try to use the ACL link with a l2ping command from B to A</P>
<P>the l2ping command gives :</P></FONT><FONT face="Courier New" size=2>
<P>l2ping AA:AA:AA:AA:AA:04 (BD_ADDR of A)</P>
<P>Ping: AA:AA:AA:AA:AA:04 from AA:AA:AA:AA:AA:05 (data size 44) ...</P>
<P>no response from AA:AA:AA:AA:AA:04: id 0</P>
<P>no response from AA:AA:AA:AA:AA:04: id 1</P></FONT><FONT size=2>
<P>---------------------------------------------------------------------------------------------------------------------</P></FONT><FONT 
color=#0000ff size=2>
<P>Question 1 : With this configuration (SCO and ACL links between A and B), why 
l2ping doesn't work ? </P>
<P>The ACL link can be used isn't it ?</P></FONT><FONT size=2>
<P>&nbsp;</P></FONT><FONT color=#0000ff size=2>
<P>Question 2 : From the hci dump of each side, I notice that there is a 
difference between the information</P>
<P>of the command and the OGF and OCF between the parenthesises. See below the 
hcidump results, the </P>
<P>&nbsp;red lines are those which give me a problem. At the "A" side, I send an 
"HCI_Setup_Asynchronous_Connection" and hcidump 
indicates&nbsp;an&nbsp;&nbsp;"HCI_Accept_Synchronous_Connection". I&nbsp;get a 
similar problem in "B" side an "HCI_Reject_Synchronous_Connection&nbsp;" instead 
of an "&nbsp;HCI_Accept_Synchronous_Connection ".</P>
<P>When you see the bluetooth spec :</P>
<P>HCI_Setup_Asynchronous_Connection is OGF=0x01 and OCF=0x28 </P>
<P>HCI_Accept_Synchronous_Connection is OGF=0x01 and OCF=0x29 </P>
<P>HCI_Reject_Synchronous_Connection is OGF=0x01 and OCF=0x2A&nbsp;</P>
<P>&nbsp;</P>
<P>Do&nbsp;these differences are benign for the bluez stack or they can be the 
origine</P>
<P>of my problem ??</P></FONT><FONT size=2>
<P></P>
<P>&nbsp;</P>
<P>************************** HCI dump from "A" 
***********************************************</P></FONT><FONT 
face="Courier New" size=2>
<P>HCI sniffer - Bluetooth packet analyzer ver 1.30</P>
<P>device: hci0 snap_len: 1028 filter: 0xffffffff</P>
<P>&lt; HCI Command: Create Connection (0x01|0x0005) plen 13</P>
<P>bdaddr AA:AA:AA:AA:AA:05 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000</P>
<P>Packet type: DM1 DM3 DM5 DH1 DH3 DH5 </P>
<P>&gt; HCI Event: Command Status (0x0f) plen 4</P>
<P>Create Connection (0x01|0x0005) status 0x00 ncmd 1</P>
<P>&gt; HCI Event: Connect Complete (0x03) plen 11</P>
<P>status 0x00 handle 0 bdaddr AA:AA:AA:AA:AA:05 type ACL encrypt 0x00</P>
<P>&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4</P>
<P>handle 0 policy 0x0f</P>
<P>Link policy: RSWITCH HOLD SNIFF PARK </P>
<P>&gt; HCI Event: Command Complete (0x0e) plen 6</P>
<P>Write Link Policy Settings (0x02|0x000d) ncmd 1</P>
<P>status 0x00 handle 0</P>
<P>&lt; </FONT><FONT face="Courier New" color=#ff0000 size=2>HCI Command: Accept 
Synchronous Connection (0x01|0x0028) plen 17</P>
<P>handle 0</P></FONT><FONT face="Courier New" size=2>
<P>40 1F 00 00 40 1F 00 00 FF FF C1 01 00 04 00 </P>
<P>&gt; HCI Event: Max Slots Change (0x1b) plen 3</P>
<P>handle 0 slots 5</P>
<P>&gt; HCI Event: Command Status (0x0f) plen 4</P>
<P>Accept Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1</P>
<P>&gt; HCI Event: Synchronous Connect Complete (0x2c) plen 17</P>
<P>status 0x00 handle 256 bdaddr AA:AA:AA:AA:AA:05 type SCO</P>
<P>Air mode: u-law log</P></FONT><FONT size=2>
<P>************************** HCI dump from "B" 
***********************************************</P>
<P></P>
<P></FONT><FONT face="Courier New" size=2>HCI sniffer - Bluetooth packet 
analyzer ver 1.30</P>
<P>device: hci0 snap_len: 1028 filter: 0xffffffff</P>
<P>&gt; HCI Event: Connect Request (0x04) plen 10</P>
<P>bdaddr AA:AA:AA:AA:AA:04 class 0x3e0100 type ACL</P>
<P>&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7</P>
<P>bdaddr AA:AA:AA:AA:AA:04 role 0x01</P>
<P>Role: Slave</P>
<P>&gt; HCI Event: Command Status (0x0f) plen 4</P>
<P>Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1</P>
<P>&gt; HCI Event: Connect Complete (0x03) plen 11</P>
<P>status 0x00 handle 0 bdaddr AA:AA:AA:AA:AA:04 type ACL encrypt 0x00</P>
<P>&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4</P>
<P>handle 0 policy 0x0f</P>
<P>Link policy: RSWITCH HOLD SNIFF PARK </P>
<P>&gt; HCI Event: Command Complete (0x0e) plen 6</P>
<P>Write Link Policy Settings (0x02|0x000d) ncmd 1</P>
<P>status 0x00 handle 0</P>
<P>&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4</P>
<P>handle 0 ptype 0xcc18</P>
<P>Packet type: DM1 DM3 DM5 DH1 DH3 DH5 </P>
<P>&gt; HCI Event: Command Status (0x0f) plen 4</P>
<P>Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1</P>
<P>&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5</P>
<P>status 0x00 handle 0 ptype 0x0018</P>
<P>Packet type: DM1 DH1 </P>
<P>&gt; HCI Event: Connect Request (0x04) plen 10</P>
<P>bdaddr AA:AA:AA:AA:AA:04 class 0x3e0100 type SCO</P>
<P>&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7</P>
<P>bdaddr AA:AA:AA:AA:AA:04 role 0x01</P>
<P>Role: Slave</P>
<P>&gt; HCI Event: Command Status (0x0f) plen 4</P>
<P>Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1</P>
<P>&lt; </FONT><FONT face="Courier New" color=#ff0000 size=2>HCI Command: Reject 
Synchronous Connection (0x01|0x0029) plen 21</P></FONT><FONT face="Courier New" 
size=2>
<P>bdaddr AA:AA:AA:AA:AA:04</P>
<P>FF FF FF FF FF FF FF FF FF FF C1 01 FF 04 00 </P>
<P>&gt; HCI Event: Command Status (0x0f) plen 4</P>
<P>Reject Synchronous Connection (0x01|0x0029) status 0x00 ncmd 1</P>
<P>&gt; HCI Event: Synchronous Connect Complete (0x2c) plen 17</P>
<P>status 0x00 handle 256 bdaddr AA:AA:AA:AA:AA:04 type SCO</P>
<P>Air mode: u-law log</P></FONT><FONT size=2>
<P>&nbsp;</P></FONT><FONT color=#0000ff size=2>
<P>Question 3 : The event "</FONT><FONT face="Courier New" color=#0000ff 
size=2>Synchronous Connect Complete" gives the handle of the SCO link</P>
<P>in my case the handle value is 256. But when you see upside the hcitool</P>
<P>con result gives a handle 0 ? Is it normal ? </P></FONT><FONT 
face="Courier New" size=2>
<P></FONT><FONT size=2></P></FONT><FONT color=#0000ff size=2>
<P>Question 4 : Here's my software configurations : hcidump 1.30 bluez-libs-2.25 
bluez-utils-2.25 linux-debian 2.6.12.2 with an ARM target </P></FONT><FONT 
size=2>
<P>&nbsp;</P></FONT><FONT color=#0000ff size=2>
<P>As I have to&nbsp;keep the kernel 2.6.12.2, with wich higher version of 
bluez-libs, bluez-utils and hcidump can I use to be compliant with my kernel ? 
</P></FONT><FONT size=2>
<P>&nbsp;</P>
<P>Thanks to all for any suggestions..</P>
<P>warm regards</P>
<P>Michel</P>
<P>---------------------------------------------------------------------------------------------------------------------</P>
<P>the result of an "hciconfig -a" is :</P></FONT><FONT face="Courier New" 
size=2>
<P>hci0: Type: UART</P>
<P>BD Address: AA:AA:AA:AA:AA:04 ACL MTU: 339:8 SCO MTU: 180:8</P>
<P>UP RUNNING PSCAN ISCAN</P>
<P>RX bytes:522 acl:0 sco:0 events:61 errors:0</P>
<P>TX bytes:1367 acl:15 sco:0 commands:26 errors:0</P>
<P>Features: 0xff 0xff 0xbd 0xf8 0x1b 0x18 0x00 0x80</P>
<P>Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3</P>
<P>Link policy: RSWITCH HOLD SNIFF PARK</P>
<P>Link mode: SLAVE ACCEPT</P>
<P>Name: 'BlueZ (0)'</P>
<P>Class: 0x3e0100</P>
<P>Service Classes: Networking, Rendering, Capturing</P>
<P>Device Class: Computer, Uncategorized</P>
<P>HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0xc</P>
<P>Manufacturer: Newlogic (23)</P></FONT><FONT size=2>
<P>---------------------------------------------------------------------------------------------------------------------------</P></FONT></FONT></DIV></BODY></HTML>

--Boundary_(ID_zePGruFG2hWBUJk5IMxZDA)--


--===============1361897382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1361897382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1361897382==--
