Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060109092540.65589.qmail@web50506.mail.yahoo.com>
From: Mahtab Hossain <mahtab_hossain2002@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1052697919-1136798736=:64904"
Subject: [Bluez-users] hci_read_rssi command
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
Date: Mon, 9 Jan 2006 01:25:36 -0800 (PST)

--0-1052697919-1136798736=:64904
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

 Dear Users,
 My project is to work with rssi/tpl/lq. My initial goal is to read them and show them graphically with some handy features!
 
 I have gone through hcitool.c (most of the code) and tried to exactly copy the necessary things only to retrieve RSSI. But, I couldn't call "hci_read_rssi" as them. Compiling my program gave this error:
 
 mySignalScan.c:102: warning: implicit declaration of function `hci_read_rssi'
 mySignalScan.c: At top level:
 /tmp/cc4x36ri.o(.text+0x25b): In function `cmd_rssi':
 : undefined reference to `hci_read_rssi'
 collect2: ld returned 1 exit status
 
 I couldn't find "hci_read_rssi" function listed in my current "hci_lib.h" header file. I have exactly all the header files added as in "hcitool.c".  hcitool works just fine and gives me the values (e.g. rssi, lq). But my aim is to have those values in my program so that, I can use them in my desired way! I wonder how hcitool could call "hci_read_rssi" file and I can't.
 
 I tried to write my "hci_read_rssi" function stated exactly the same way as in "hci.c". But my program gives this error while run and couldn't retrieve RSSI:
 
 Read RSSI failed: Input/output error
 
 Upto calling to "my_hci_read_rssi" (my function imitating the main hci_read_rssi function), all the things are alright. I checked the connection information and printed them out:
 
 Device name: Mahtab
 Device Address: 00:13:70:C3:88:37
 Handle: 6
 Role: 1
 Direction: 1
 Link mode: 5
 State: 1
 ** These were also exactly the same values shown by my KDE-bluetooth utilities about the connection.
 
 I made the connection with the following command:
 rfcomm connect 0 00:13:70:C3:88:37
 Connected /dev/rfcomm0 to 00:13:70:C3:88:37 on channel 1
 Press CTRL-C for hangup
 
 hcidump shows exactly the same sequence for both my program and while ran
 "hcitool rssi 00:13:70:C3:88:37".
 
 My Program:
 < HCI Command: Read RSSI (0x05|0x0005) plen 2
 > HCI Event: Command Complete (0x0e) plen 7
 
 hcitool rssi 00:13:70:C3:88:37:
 < HCI Command: Read RSSI (0x05|0x0005) plen 2
 > HCI Event: Command Complete (0x0e) plen 7
  
 Right now, I am stuck. I will appreciate any suggestions.
 Thanks
 Mahtab
 
 
 

		
---------------------------------
 Yahoo! DSL Something to write home about. Just $16.99/mo. or less
--0-1052697919-1136798736=:64904
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div id="RTEContent">&nbsp;Dear Users,<br> My project is to work with rssi/tpl/lq. My initial goal is to read them and show them graphically with some handy features!<br> <br> I have gone through hcitool.c (most of the code) and tried to exactly copy the necessary things only to retrieve RSSI. But, I couldn't call "hci_read_rssi" as them. Compiling my program gave this error:<br> <br> mySignalScan.c:102: warning: implicit declaration of function `hci_read_rssi'<br> mySignalScan.c: At top level:<br> /tmp/cc4x36ri.o(.text+0x25b): In function `cmd_rssi':<br> : undefined reference to `hci_read_rssi'<br> collect2: ld returned 1 exit status<br> <br> I couldn't find "hci_read_rssi" function listed in my current "hci_lib.h" header file. I have exactly all the header files added as in "hcitool.c".&nbsp; hcitool works just fine and gives me the values (e.g. rssi, lq). But my aim is to have those values in my program so that, I can use them in my desired way! I wonder how hcitool could 
 call
 "hci_read_rssi" file and I can't.<br> <br> I tried to write my "hci_read_rssi" function stated exactly the same way as in "hci.c". But my program gives this error while run and couldn't retrieve RSSI:<br> <br> Read RSSI failed: Input/output error<br> <br> Upto calling to "my_hci_read_rssi" (my function imitating the main hci_read_rssi function), all the things are alright. I checked the connection information and printed them out:<br> <br> Device name: Mahtab<br> Device Address: 00:13:70:C3:88:37<br> Handle: 6<br> Role: 1<br> Direction: 1<br> Link mode: 5<br> State: 1<br> ** These were also exactly the same values shown by my KDE-bluetooth utilities about the connection.<br> <br> I made the connection with the following command:<br> rfcomm connect 0 00:13:70:C3:88:37<br> Connected /dev/rfcomm0 to 00:13:70:C3:88:37 on channel 1<br> Press CTRL-C for hangup<br> <br> hcidump shows exactly the same sequence for both my program and while ran<br> "hcitool rssi 00:13:70:C3:88:37".<b
 r> <br>
 My Program:<br> &lt; HCI Command: Read RSSI (0x05|0x0005) plen 2<br> &gt; HCI Event: Command Complete (0x0e) plen 7<br> <br> hcitool rssi 00:13:70:C3:88:37:<br> &lt; HCI Command: Read RSSI (0x05|0x0005) plen 2<br> &gt; HCI Event: Command Complete (0x0e) plen 7<br> &nbsp;<br> Right now, I am stuck. I will appreciate any suggestions.<br> Thanks<br> Mahtab<br> <br> <br> </div><p>
		<hr size=1> <a href="http://pa.yahoo.com/*http://us.rd.yahoo.com/evt=37474/*http://promo.yahoo.com/broadband/ ">Yahoo! DSL</a> Something to write home about. Just $16.99/mo. or less
--0-1052697919-1136798736=:64904--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
