Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 24 Apr 2007 06:02:39 -0700 (PDT)
From: walt shekrota <penguinacity@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b92d97be0704232057m648388a9w1748fe6312d25164@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <904725.56342.qm@web62313.mail.re1.yahoo.com>
Subject: Re: [Bluez-users] headset and input noise
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0423674304=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0423674304==
Content-Type: multipart/alternative; boundary="0-1733945936-1177419759=:56342"
Content-Transfer-Encoding: 8bit

--0-1733945936-1177419759=:56342
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
 
 may sound silly but did you mute 'line' in alsamixer? If you have a device it can
 cause static. I have a TV card. You may have a capture builtin your laptop.
 
 -Walt

Adam Dixon <adamtdixon@gmail.com> wrote: Hello All.

I have bluetooth going on my laptop, and have got btsco working with
my X3 micro bt headset. However I get mass static / noise from the
input randomly.
I have reproduced on skype, twinkle and now on arecord. So currently I
dont want to use it for the phone (its intended use).

I have searched the list, and found some people having reference the
'noise', but found no clear fix.

I followed a guide to get everything installed and this is how I bring
up my headset;
hcitool cc 00:0F:79:04:7A:11
modprobe snd_bt_sco  (not done if already loaded)
hciconfig hci0 voice 0x0060
btsco 00:0F:79:04:7A:11

Has anyone had this problem and know how to get around it? As I am
very happy with it other wise. If anyone could lend a hand that would
be great.

Adam



Some information;

btsco v0.5c

uname -a
Linux dixon 2.6.20-1.2933.fc6 #1 SMP Mon Mar 19 11:00:19 EDT 2007
x86_64 x86_64 x86_64 GNU/Linux

hciconfig -a
hci0:   Type: USB
        BD Address: 00:1A:6B:1E:E9:A6 ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:6909425 acl:20 sco:135398 events:111 errors:0
        TX bytes:6889503 acl:18 sco:135074 commands:57 errors:5
        Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'dixon-0'
        Class: 0x120104
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Desktop workstation
        HCI Ver: 2.0 (0x3) HCI Rev: 0xdd2 LMP Ver: 2.0 (0x3) LMP Subver: 0xdd2
        Manufacturer: Cambridge Silicon Radio (10)

hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:1A:6B:1E:E9:A6 ACL MTU: 384:8 SCO MTU: 64:8
        Build 3538
        Chip version: BlueCore4-External
        Max key size: 56 bit
        SCO mapping:  HCI

hcitool scan
Scanning ...
        00:0F:79:04:7A:11       X3 micro

 hcitool info 00:0F:79:04:7A:11
Requesting information ...
        BD Address:  00:0F:79:04:7A:11
        Device Name: X3 micro
        LMP Version: 1.2 (0x2) LMP Subversion: 0x610
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
                   
                  
  
                    
                 
 
 
                 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users





       
---------------------------------
Ahhh...imagining that irresistible "new car" smell?
 Check outnew cars at Yahoo! Autos.
--0-1733945936-1177419759=:56342
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br> <br> may sound silly but did you mute 'line' in alsamixer? If you have a device it can<br> cause static. I have a TV card. You may have a capture builtin your laptop.<br> <br> -Walt<br><br><b><i>Adam Dixon &lt;adamtdixon@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hello All.<br><br>I have bluetooth going on my laptop, and have got btsco working with<br>my X3 micro bt headset. However I get mass static / noise from the<br>input randomly.<br>I have reproduced on skype, twinkle and now on arecord. So currently I<br>dont want to use it for the phone (its intended use).<br><br>I have searched the list, and found some people having reference the<br>'noise', but found no clear fix.<br><br>I followed a guide to get everything installed and this is how I bring<br>up my headset;<br>hcitool cc 00:0F:79:04:7A:11<br>modprobe snd_bt_sco  (not done if already loaded)<br>hciconfig hci0
 voice 0x0060<br>btsco 00:0F:79:04:7A:11<br><br>Has anyone had this problem and know how to get around it? As I am<br>very happy with it other wise. If anyone could lend a hand that would<br>be great.<br><br>Adam<br><br><br><br>Some information;<br><br>btsco v0.5c<br><br>uname -a<br>Linux dixon 2.6.20-1.2933.fc6 #1 SMP Mon Mar 19 11:00:19 EDT 2007<br>x86_64 x86_64 x86_64 GNU/Linux<br><br>hciconfig -a<br>hci0:   Type: USB<br>        BD Address: 00:1A:6B:1E:E9:A6 ACL MTU: 384:8 SCO MTU: 64:8<br>        UP RUNNING PSCAN<br>        RX bytes:6909425 acl:20 sco:135398 events:111 errors:0<br>        TX bytes:6889503 acl:18 sco:135074 commands:57 errors:5<br>        Features: 0xff 0xff 0x9f 0xfe 0x9b 0xf9 0x00 0x80<br>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>        Link policy: RSWITCH HOLD SNIFF PARK<br>        Link mode: SLAVE ACCEPT<br>        Name: 'dixon-0'<br>        Class: 0x120104<br>        Service Classes: Networking, Object Transfer<br>        Device
 Class: Computer, Desktop workstation<br>        HCI Ver: 2.0 (0x3) HCI Rev: 0xdd2 LMP Ver: 2.0 (0x3) LMP Subver: 0xdd2<br>        Manufacturer: Cambridge Silicon Radio (10)<br><br>hciconfig hci0 revision<br>hci0:   Type: USB<br>        BD Address: 00:1A:6B:1E:E9:A6 ACL MTU: 384:8 SCO MTU: 64:8<br>        Build 3538<br>        Chip version: BlueCore4-External<br>        Max key size: 56 bit<br>        SCO mapping:  HCI<br><br>hcitool scan<br>Scanning ...<br>        00:0F:79:04:7A:11       X3 micro<br><br> hcitool info 00:0F:79:04:7A:11<br>Requesting information ...<br>        BD Address:  00:0F:79:04:7A:11<br>        Device Name: X3 micro<br>        LMP Version: 1.2 (0x2) LMP Subversion: 0x610<br>        Manufacturer: Cambridge Silicon Radio (10)<br>        Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00<br>                <encryption> <slot offset=""> <timing accuracy=""> <role switch=""><br>                <hold mode=""> <sniff mode=""> <park state=""> <RSSI> <channel
 quality=""><br>                <SCO link=""> <HV2 packets=""> <HV3 packets=""> <u-law log=""> <A-law log=""><br>                <CVSD> <paging scheme=""> <power control=""> <transparent sco=""><br>                <AFH cap="" slave=""> <AFH cap="" master=""><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by DB2 Express<br>Download DB2 Express C - the FREE version of DB2 express and take<br>control of your XML. No limits. Just data. Click to get it now.<br>http://sourceforge.net/powerbar/db2/<br>_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></AFH></AFH></transparent></power></paging></CVSD></A-law></u-law></HV3></HV2></SCO></channel></RSSI></park></sniff></hold></role></timing></slot></encryption></blockquote><br><p>&#32;



      <hr size=1>Ahhh...imagining that irresistible "new car" smell?<br> Check out
<a href="http://us.rd.yahoo.com/evt=48245/*http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE1YW1jcXJ2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3LWNhcnM-">new cars at Yahoo! Autos.</a>

--0-1733945936-1177419759=:56342--


--===============0423674304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0423674304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0423674304==--
