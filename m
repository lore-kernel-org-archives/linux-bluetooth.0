Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060413210242.53178.qmail@web61218.mail.yahoo.com>
From: deva seetharam <tagsense@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1239310292-1144962162=:53157"
Subject: [Bluez-users] connecting multiple rfcomm clients to a single rfcomm socket server
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
Date: Thu, 13 Apr 2006 14:02:42 -0700 (PDT)

--0-1239310292-1144962162=:53157
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hello,
 i am trying to connect multiple bluetooth rfcomm clients to a single rfcomm server. only the first client is able to connect, the subsequent ones just fail. 
 
 here is my setup:
 server
 ====
 kernel: debian 2.6.12-1-686
 bluez version 2.25
 hardware: D-Link DBT-120 bluetooth dongle
 
 client
 ====
 National lmx9820 bluetooth module
 
 on the server, i edited hcid.conf to change link mode to 
 lm accept,master;
 
 despite that the linkmode always comes up as "slave, accept" when i do hciconfig -a.
 
 i have included more info below.  pls. see if you could give me some debugging tips. 
 
 thanks in advance,
 deva
 
 
 when i do a hciconfig -a, i get the following:
 
 hci0:   Type: USB
         BD Address: 00:0D:88:C0:61:55 ACL MTU: 192:8 SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:2304 acl:23 sco:0 events:65 errors:0
         TX bytes:1429 acl:23 sco:0 commands:29 errors:0
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy:
         Link mode: SLAVE ACCEPT
         Name: 'BlueZ (0)'
         Class: 0x000000
         Service Classes: Unspecified
         Device Class: Miscellaneous,
         HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
         Manufacturer: Cambridge Silicon Radio (10)
 
 from a different linux box (with another d-link dbt-120 bluetooth dongle), when i run hctiool info:
 
 Requesting information ...
         BD Address:  00:0D:88:C0:61:55
         Device Name: BlueZ (0)
         LMP Version: 1.1 (0x1) LMP Subversion: 0x1bb
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                 <3-slot packets> <5-slot packets> <encryption> <slot offset>
                 <timing accuracy> <role switch> <hold mode> <sniff mode>
                 <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                 <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                 <power control> <transparent SCO>
 
 
		
---------------------------------
Blab-away for as little as 1¢/min. Make  PC-to-Phone Calls using Yahoo! Messenger with Voice.
--0-1239310292-1144962162=:53157
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

hello,<br> i am trying to connect multiple bluetooth rfcomm clients to a single rfcomm server. only the first client is able to connect, the subsequent ones just fail. <br> <br> here is my setup:<br> server<br> ====<br> kernel: debian 2.6.12-1-686<br> bluez version 2.25<br> hardware: D-Link DBT-120 bluetooth dongle<br> <br> client<br> ====<br> National lmx9820 bluetooth module<br> <br> on the server, i edited hcid.conf to change link mode to <br> lm accept,master;<br> <br> despite that the linkmode always comes up as "slave, accept" when i do hciconfig -a.<br> <br> i have included more info below.&nbsp; pls. see if you could give me some debugging tips. <br> <br> thanks in advance,<br> deva<br> <br> <br> when i do a hciconfig -a, i get the following:<br> <br> hci0:&nbsp;&nbsp; Type: USB<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:0D:88:C0:61:55 ACL MTU: 192:8 SCO MTU: 64:8<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:2304 acl:23 sco:0 events:65 errors:0<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:1429 acl:23 sco:0 commands:29 errors:0<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy:<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'BlueZ (0)'<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x000000<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Unspecified<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Miscellaneous,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon
 Radio (10)<br> <br> from a different linux box (with another d-link dbt-120 bluetooth dongle), when i run hctiool info:<br> <br> Requesting information ...<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:0D:88:C0:61:55<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: BlueZ (0)<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.1 (0x1) LMP Subversion: 0x1bb<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt; &lt;slot offset&gt;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff mode&gt;<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt; &lt;HV2 packets&gt;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt; &lt;paging scheme&gt;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;power control&gt; &lt;transparent SCO&gt;<br> <br> <p>
		<hr size=1>Blab-away for as little as 1¢/min. Make <a href="http://us.rd.yahoo.com/mail_us/taglines/postman2/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com"> PC-to-Phone Calls</a> using Yahoo! Messenger with Voice.
--0-1239310292-1144962162=:53157--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
