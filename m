Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051219080204.30483.qmail@web36111.mail.mud.yahoo.com>
From: Swathi Mathur80 <swathi_mathur80@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2042625364-1134979324=:20763"
Subject: [Bluez-users] problem pairing headset and pc(NONE OF THE SOLUTION WORKED)
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
Date: Mon, 19 Dec 2005 00:02:04 -0800 (PST)

--0-2042625364-1134979324=:20763
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

 Hello,
 I am unable to connect to my Nokia headset HS-11W from my linux PC. I followed all the steps given in bluetooth alsa project aswell as tried to solve the problem by taking some of the suggestions given in the mailing list but nothing worked. Many people have faced the similar problem but none of the solutions given on the mailing list worked. I edited hcid.conf with
 pin_helper /etc/bluetooth/pin;
 edited rfcomm.conf for binding the headset device
 I have installed bluez-libs and bluez-utils and PC is running Fedora Core 4 having kernel-2.6.11. 
 
 CAN SOMEBODY PLS HELP ME AS I AM FACING THIS PROBLEM FROM LAST ONE WEEK.
 
 when it comes to the step given in bluetooth-alsa project
                     btsco -v 00:08:C6:3E:54:2C 2
 I get the below error msg
           ==================================================
 
                 btsco v0.4c Device is 1:0
 Voice setting: 0x0060
  Can't connect RFCOMM channel: Resource temporarily unavailable

 In the background if i run hcidump -x
 I see the below msg
 ==============================================
                     HCI sniffer - Bluetooth packet analyzer ver 1.18
 device: hci0 snap_len: 1028 filter: 0xffffffff
 < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Command Complete (0x0e) plen 6
   01 25 0C 00 60 00
 < HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
   00 01 05 04
 > HCI Event: PIN Code Request (0x16) plen 6
   2C 54 3E C6 08 00
 > HCI Event: Connect Complete (0x03) plen 11
   22 29 00 2C 54 3E C6 08 00 01 00
 < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Command Complete (0x0e) plen 6
                       01 25 0C 00 60 00
  
 ==============================================
 
 
 
 
 
 
 
 
  
 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-2042625364-1134979324=:20763
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div id="RTEContent">&nbsp;Hello,<br> I am unable to connect to my Nokia headset HS-11W from my linux PC. I followed all the steps given in bluetooth alsa project aswell as tried to solve the problem by taking some of the suggestions given in the mailing list but nothing worked. Many people have faced the similar problem but none of the solutions given on the mailing list worked. I edited hcid.conf with<br> pin_helper /etc/bluetooth/pin;<br> edited rfcomm.conf for binding the headset device<br> I have installed bluez-libs and bluez-utils and PC is running Fedora Core 4 having kernel-2.6.11. <br> <br> CAN SOMEBODY PLS HELP ME AS I AM FACING THIS PROBLEM FROM LAST ONE WEEK.<br> <br> when it comes to the step given in bluetooth-alsa project<br>     <meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8"><title></title><meta name="GENERATOR" content="OpenOffice.org 1.9.104  (Linux)"><meta name="CREATED" content="20051219;12460000"><meta name="CHANGED"
 content="20051219;15261300">          <style>  <!--   @page { size: 8.5in 11in; margin: 0.79in }   P { margin-bottom: 0.08in }  -->  </style>  <div style="margin-bottom: 0in;">btsco -v 00:08:C6:3E:54:2C 2<br> I get the below error msg<br>     <meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8"><title></title><meta name="GENERATOR" content="OpenOffice.org 1.9.104  (Linux)"><meta name="CREATED" content="20051219;12460000"><meta name="CHANGED" content="20051219;15261300"><style>  <!--   @page { size: 8.5in 11in; margin: 0.79in }   P { margin-bottom: 0.08in }  --></style>    ==================================================<br> <br>     <meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8"><title></title><meta name="GENERATOR" content="OpenOffice.org 1.9.104  (Linux)"><meta name="CREATED" content="20051219;12460000"><meta name="CHANGED" content="20051219;15261300">          <style>  <!--   @page { size: 8.5in 11in; margin: 0.79in }   P { margin-botto
 m:
 0.08in }  --</style>btsco v0.4c <div style="margin-bottom: 0in;">Device is 1:0</div> <div style="margin-bottom: 0in;">Voice setting: 0x0060</div> <div style="border-style: none none solid; border-color: -moz-use-text-color -moz-use-text-color rgb(0, 0, 0); border-width: medium medium 1px; padding: 0in 0in 0.03in; margin-bottom: 0in;"> Can't connect RFCOMM channel: Resource temporarily unavailable</div><br> In the background if i run hcidump -x<br> I see the below msg<br> ==============================================<br>     <meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8"><title></title><meta name="GENERATOR" content="OpenOffice.org 1.9.104  (Linux)"><meta name="CREATED" content="20051219;12460000"><meta name="CHANGED" content="20051219;15261300">          <style>  <!--   @page { size: 8.5in 11in; margin: 0.79in }   P { margin-bottom: 0.08in }  -->  </style>  <div style="margin-bottom: 0in;">HCI sniffer - Bluetooth packet analyzer ver 1.18</div> <div
 style="margin-bottom: 0in;">device: hci0 snap_len: 1028 filter: 0xffffffff</div> <div style="margin-bottom: 0in;">&lt; HCI Command: Read Voice Setting (0x03|0x0025) plen 0</div> <div style="margin-bottom: 0in;">&gt; HCI Event: Command Complete (0x0e) plen 6</div> <div style="margin-bottom: 0in;">  01 25 0C 00 60 00</div> <div style="margin-bottom: 0in;">&lt; HCI Command: Create Connection (0x01|0x0005) plen 13</div> <div style="margin-bottom: 0in;">    bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01 clkoffset 0x0000</div> <div style="margin-bottom: 0in;">    Packet type: DM1 DM3 DM5 DH1 DH3 DH5</div> <div style="margin-bottom: 0in;">&gt; HCI Event: Command Status (0x0f) plen 4</div> <div style="margin-bottom: 0in;">  00 01 05 04</div> <div style="margin-bottom: 0in;">&gt; HCI Event: PIN Code Request (0x16) plen 6</div> <div style="margin-bottom: 0in;">  2C 54 3E C6 08 00</div> <div style="margin-bottom: 0in;">&gt; HCI Event: Connect Complete (0x03) plen 11</div> <div
 style="margin-bottom: 0in;">  22 29 00 2C 54 3E C6 08 00 01 00</div> <div style="margin-bottom: 0in;">&lt; HCI Command: Read Voice Setting (0x03|0x0025) plen 0</div> <div style="margin-bottom: 0in;">&gt; HCI Event: Command Complete (0x0e) plen 6</div> <div style="margin-bottom: 0in;">    <meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8"><title></title><meta name="GENERATOR" content="OpenOffice.org 1.9.104  (Linux)"><meta name="CREATED" content="20051219;12460000"><meta name="CHANGED" content="20051219;15261300">          <style>  <!--   @page { size: 8.5in 11in; margin: 0.79in }   P { margin-bottom: 0.08in }  -->  </style>  <div style="margin-bottom: 0in;">  01 25 0C 00 60 00</div>  </div> ==============================================<br> </div> <div style="margin-bottom: 0in;"><br> </div> <div style="margin-bottom: 0in;"><br> </div> <div style="margin-bottom: 0in;"><br> <br> </div>  <br> </div><p>__________________________________________________<br>Do You
 Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-2042625364-1134979324=:20763--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
