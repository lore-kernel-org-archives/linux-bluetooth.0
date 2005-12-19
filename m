Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051219094442.64827.qmail@web36106.mail.mud.yahoo.com>
From: Swathi Mathur80 <swathi_mathur80@yahoo.com>
Subject: Re: [Bluez-users] Can't connect RFCOMM channel: Resource temporarily unavailable
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1134982495.6881.52.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-587243780-1134985482=:61539"
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
Date: Mon, 19 Dec 2005 01:44:42 -0800 (PST)

--0-587243780-1134985482=:61539
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hello Marcel,
 As per your request i have attached the "hcidump -X -V" output when i execute the command "btsco 00:08:C6:3E:54:2C 2"
 
 output of hcidump -X -V
 =====================================================
                     HCI sniffer - Bluetooth packet analyzer ver 1.18
 device: hci0 snap_len: 1028 filter: 0xffffffff
 < HCI Command: Read Voice Setting (0x03|0x0025) plen 0
 > HCI Event: Command Complete (0x0e) plen 6
     Read Voice Setting (0x03|0x0025) ncmd 1
     status 0x00 voice setting 0x0060
 < HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: PIN Code Request (0x16) plen 6
     bdaddr 00:08:C6:3E:54:2C
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x22 handle 41 bdaddr 00:08:C6:3E:54:2C type ACL encrypt 0x00
     Error: LMP Error Transaction Collision
 =====================================================
 
 I hope i will be able to get a solution for this.
 Regards,
 Swathi
 
 
 
 
 
 

Marcel Holtmann <marcel@holtmann.org> wrote: Hi Swathi,

> When i try to pair my PC with the nokia headset-hs 11w, ie when i
> execute the below command 
> btsco 00:08:C6:3E:54:2C 1
> i get the below error. Can somebody point what might have went wrong ?
> Can't connect RFCOMM channel: Resource temporarily unavailable

show us the output of "hcidump -X -V" for this problem.

Regards

Marcel





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-587243780-1134985482=:61539
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div id="RTEContent">Hello Marcel,<br> As per your request i have attached the "hcidump -X -V" output when i execute the command "btsco 00:08:C6:3E:54:2C 2"<br> <br> output of hcidump -X -V<br> =====================================================<br>     <meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8"><title></title><meta name="GENERATOR" content="OpenOffice.org 1.9.104  (Linux)"><meta name="CREATED" content="20051219;17342700"><meta name="CHANGED" content="16010101;0">          <style>  <!--   @page { size: 8.5in 11in; margin: 0.79in }   P { margin-bottom: 0.08in }  -->  </style>  <div style="margin-bottom: 0in;">HCI sniffer - Bluetooth packet analyzer ver 1.18</div> <div style="margin-bottom: 0in;">device: hci0 snap_len: 1028 filter: 0xffffffff</div> <div style="margin-bottom: 0in;">&lt; HCI Command: Read Voice Setting (0x03|0x0025) plen 0</div> <div style="margin-bottom: 0in;">&gt; HCI Event: Command Complete (0x0e) plen 6</div> <div style="margin-botto
 m:
 0in;">    Read Voice Setting (0x03|0x0025) ncmd 1</div> <div style="margin-bottom: 0in;">    status 0x00 voice setting 0x0060</div> <div style="margin-bottom: 0in;">&lt; HCI Command: Create Connection (0x01|0x0005) plen 13</div> <div style="margin-bottom: 0in;">    bdaddr 00:08:C6:3E:54:2C ptype 0xcc18 rswitch 0x01 clkoffset 0x0000</div> <div style="margin-bottom: 0in;">    Packet type: DM1 DM3 DM5 DH1 DH3 DH5</div> <div style="margin-bottom: 0in;">&gt; HCI Event: Command Status (0x0f) plen 4</div> <div style="margin-bottom: 0in;">    Create Connection (0x01|0x0005) status 0x00 ncmd 1</div> <div style="margin-bottom: 0in;">&gt; HCI Event: PIN Code Request (0x16) plen 6</div> <div style="margin-bottom: 0in;">    bdaddr 00:08:C6:3E:54:2C</div> <div style="margin-bottom: 0in;">&gt; HCI Event: Connect Complete (0x03) plen 11</div> <div style="margin-bottom: 0in;">    status 0x22 handle 41 bdaddr 00:08:C6:3E:54:2C type ACL encrypt 0x00</div> <div style="margin-bottom: 0in;">    E
 rror:
 LMP Error Transaction Collision</div> =====================================================<br> <br> I hope i will be able to get a solution for this.<br> Regards,<br> Swathi<br> <br> <br> <br> <br> <br> <br><br><b><i>Marcel Holtmann &lt;marcel@holtmann.org&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi Swathi,<br><br>&gt; When i try to pair my PC with the nokia headset-hs 11w, ie when i<br>&gt; execute the below command <br>&gt; btsco 00:08:C6:3E:54:2C 1<br>&gt; i get the below error. Can somebody point what might have went wrong ?<br>&gt; Can't connect RFCOMM channel: Resource temporarily unavailable<br><br>show us the output of "hcidump -X -V" for this problem.<br><br>Regards<br><br>Marcel<br><br><br><br><br><br>-------------------------------------------------------<br>This SF.net email is sponsored by: Splunk Inc. Do you grep through log files<br>for problems?  Stop!  Download the ne
 w AJAX
 search engine that makes<br>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!<br>http://ads.osdn.com/?ad_id=7637&amp;alloc_id=16865&amp;op=click<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br></div><p>__________________________________________________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>http://mail.yahoo.com 
--0-587243780-1134985482=:61539--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
