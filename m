Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c669a7c70708240036j38c8f42bhdcdb5ee15a8ae4be@mail.gmail.com>
Date: Fri, 24 Aug 2007 13:06:22 +0530
From: "Mahin Gupta" <mahingupta@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] problem in parking device. bluez-libs 3.14,
	bluez-utils-3.14
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1375783313=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1375783313==
Content-Type: multipart/alternative;
	boundary="----=_Part_61670_32704640.1187940982550"

------=_Part_61670_32704640.1187940982550
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi
I am trying to park one bluetooth device.

First of all i have tried to use the bluez hci.c function hci_park_mode() to
park this device.
I have used the function in following manner


       if( hci_park_mode(dd, handle, 0x200, 0x100, 25000) < 0 )
      {
         printf("\n Unable to park ...\n");
      }
       I am getting the handle correct here.

These is the concerned part of code.. but I am not getting the device
parked...
then I tried to check whether I can park it using hcitool cmd or not

This is the hciconfig -a output of my Master device

// Master
# hciconfig -a
hci0:   Type: UART
        BD Address: 00:80:37:2E:4C:C3 ACL MTU: 339:11 SCO MTU: 93:14
        UP RUNNING PSCAN ISCAN
        RX bytes:152425 acl:2402 sco:0 events:10389 errors:0
        TX bytes:87079 acl:2791 sco:0 commands:3526 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'LB:[unknown]'
        Class: 0x820116
        Service Classes: Networking
        Device Class: Computer, Palm
        HCI Ver: 2.0 (0x3) HCI Rev: 0x62b9 LMP Ver: 2.0 (0x3) LMP Subver:
0x62b9
        Manufacturer: Infineon Technologies AG (9)

Slave has the same configuration and its Link policy is also   Link policy:
RSWITCH HOLD SNIFF PARK

These is the output of hcitool con
# hcitool con
Connections:
        < ACL 11:11:11:11:11:11 handle 512 state 1 lm MASTER
        < ACL 00:80:37:2E:45:1E handle 256 state 1 lm MASTER

# hcitool cmd 0x02 0x005 0x0200 0x0090 0x000E
< HCI Command: ogf 0x02, ocf 0x0005, plen 3
  00 90 0E
> HCI Event: 0x0f plen 4
  12 01 05 08

# hcitool cmd 0x02 0x005 0x0100 0x0090 0x000E
< HCI Command: ogf 0x02, ocf 0x0005, plen 3
  00 90 0E
> HCI Event: 0x0f plen 4
  12 01 05 08

By searching into mailing list archieve ( link :
http://article.gmane.org/gmane.linux.bluez.devel/269/match=park )
I came to know that may be my parameters are wrong but I am not able to
understand what is wrong ..

One more thing.. hcitool con returns me handle as 256 ( hex 0x100 ).. Now
when I am giving this as first parameter in hcitool cmd the hex_dump
function in
hcitool.c prints only last two digits i.e. 00 . .. so I am a bit confused
that is my handle is passing correctly or not ?

Thnx for any help in advance...

Regards,
Mahin Gupta

------=_Part_61670_32704640.1187940982550
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi <br>I am trying to park one bluetooth device.<br><br>First of all i have tried to use the bluez hci.c function hci_park_mode() to park this device.<br>I have used the function in following manner <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if( 
<span style="font-weight: bold;">hci_park_mode(dd, handle, 0x200, 0x100, 25000) &lt; 0 </span>)<br>&nbsp;&nbsp; &nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;\n Unable to park ...\n&quot;);<br>&nbsp; &nbsp; &nbsp; }<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; I am getting the handle correct here.
<br><br>These is the concerned part of code.. but I am not getting the device parked...
<br>then I tried to check whether I can park it using hcitool cmd or not<br><br>This is the hciconfig -a output of my Master device<br>
<br>
// Master <br>
# hciconfig -a<br>
hci0:&nbsp;&nbsp; Type: UART<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:80:37:2E:4C:C3 ACL MTU: 339:11 SCO MTU: 93:14<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:152425 acl:2402 sco:0 events:10389 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:87079 acl:2791 sco:0 commands:3526 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: &#39;LB:[unknown]&#39;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x820116<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Networking<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Palm<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 2.0 (0x3) HCI Rev: 0x62b9 LMP Ver: 2.0 (0x3) LMP Subver: 0x62b9<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Infineon Technologies AG (9)<br>
<br>
Slave has the same configuration and its Link policy is also &nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br><br>These is the output of hcitool con<br># hcitool con<br>Connections:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; ACL 11:11:11:11:11:11 handle 512 state 1 lm MASTER
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; ACL 00:80:37:2E:45:1E handle 256 state 1 lm MASTER
<br><br># hcitool cmd 0x02 0x005 0x0200 0x0090 0x000E<br>&lt; HCI Command: ogf 0x02, ocf 0x0005, plen 3<br>&nbsp; 00 90 0E<br>&gt; HCI Event: 0x0f plen 4<br>&nbsp; 12 01 05 08<br><br># hcitool cmd 0x02 0x005 0x0100 0x0090 0x000E<br>

&lt; HCI Command: ogf 0x02, ocf 0x0005, plen 3<br>&nbsp; 00 90 0E<br>&gt; HCI Event: 0x0f plen 4<br>&nbsp; 12 01 05 08<br><br>By searching into mailing list archieve ( link : <a href="http://article.gmane.org/gmane.linux.bluez.devel/269/match=park" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

http://article.gmane.org/gmane.linux.bluez.devel/269/match=park</a> )<br>I came to know that may be my parameters are wrong but I am not able to understand what is wrong ..<br><br>One
more thing.. hcitool con returns me handle as 256 ( hex 0x100 ).. Now
when I am giving this as first parameter in hcitool cmd the hex_dump
function in <br>hcitool.c prints only last two digits i.e. 00 . .. so I am a bit confused that is my handle is passing correctly or not ?<br><br>Thnx for any help in advance...<br><br>Regards,<br><span class="sg">Mahin Gupta
</span>

------=_Part_61670_32704640.1187940982550--


--===============1375783313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============1375783313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1375783313==--
