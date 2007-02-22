Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 21 Feb 2007 19:25:27 -0800 (PST)
From: walt shekrota <penguinacity@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <666968.34457.qm@web62301.mail.re1.yahoo.com>
Subject: [Bluez-users] plantronics 320 working minor problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0655022006=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0655022006==
Content-Type: multipart/alternative; boundary="0-801428081-1172114727=:34457"
Content-Transfer-Encoding: 8bit

--0-801428081-1172114727=:34457
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,
 
 I posted ealier under another id but your list penalizes those who's provider 
 does not respond appropriately with a postmaster address. Mine is 
 optonline.net and they control most of the NY NYC and LI area.
 Funny they would keep us from posting. Trying to get the provider to 
 understand is like feeding a duck nails.
 
 So now to my problems.
 dongle == DLINK DBT120 B4
 headset == Plantronics Explorer 320
 
 #
 # HCI daemon configuration file.
 #
 
 # HCId options
 options {
         # Automatically initialize new devices
         autoinit yes;
 
         # Security Manager mode
         #   none - Security manager disabled
         #   auto - Use local PIN for incoming connections
         #   user - Always ask user for a PIN
         #
         security user;
 
         # Pairing mode
         #   none  - Pairing disabled
         #   multi - Allow pairing with already paired devices
         #   once  - Pair once and deny successive attempts
         pairing multi;
 
         # PIN helper
         pin_helper /etc/bluetooth/pin;
 
         # D-Bus PIN helper
         #dbus_pin_helper;
 }
 
 # Default settings for HCI devices
 device {
         # Local device name
         #   %d - device id
         #   %h - host name
         name "BlueZ (%d)";
 
         # Local device class
 #       class 0x3e0100;
         class 0x200404;
         # Default packet type
         pkt_type DH1,DM1,HV1;
 
         # Inquiry and Page scan
         iscan enable; pscan enable;
 
         # Default link mode
         #   none   - no specific policy 
         #   accept - always accept incoming connections
         #   master - become master on incoming connections,
         #            deny role switch on outgoing connections
         lm accept;
 
         # Default link policy
         #   none    - no specific policy
         #   rswitch - allow role switch
         #   hold    - allow hold mode
         #   sniff   - allow sniff mode
         #   park    - allow park mode
         lp rswitch,hold,sniff,park;
 
         # Authentication and Encryption (Security Mode 3)
         auth enable;
         encrypt enable;
 }
 
 #
 # RFCOMM configuration file.
 #
 
 rfcomm0 {
         # Automatically bind the device at startup
         bind yes;
 
         # Bluetooth address of the device
          device 00:13:46:47:67:F4;
 
         # RFCOMM channel for the connection
         channel 1;
 
         # Description of the connection
 #       comment "Example Bluetooth device";
 }
 
 
  hciconfig -a revision
  hci0:   Type: USB
          BD Address: 00:13:46:47:67:F4 ACL MTU: 192:8 SCO MTU: 64:8
          UP RUNNING PSCAN ISCAN AUTH ENCRYPT
          RX bytes:68484755 acl:2206 sco:1341684 events:2384 errors:0
          TX bytes:68389547 acl:2179 sco:1340183 commands:112 errors:1
          Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
          Packet type: DM1 DH1 HV1
          Link policy: RSWITCH HOLD SNIFF PARK
          Link mode: SLAVE ACCEPT
          Name: 'BlueZ (0)'
          Class: 0x3e0100
          Service Classes: Networking, Rendering, Capturing
          Device Class: Computer, Uncategorized
          HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 
 0x20d
          Manufacturer: Cambridge Silicon Radio (10)
 
  hcitool inq
 Inquiring ...
         00:03:89:F7:A9:78       clock offset: 0x40ac    class: 0x200404
 
  hcitool scan
 Scanning ...
         00:03:89:F7:A9:78       320Plantronics
 
 using btsco-0.5
 I use it frequently mostly so I could understand the quirks.
 With the headset waiting connect never happens the first time.
 btsco -v  <addr> 
 just fails out with only an RFCOMM message
 second time it connects....
 Here is a log of this:
 
 btsco -v 00:03:89:F7:A9:78
 btsco v0.42
 Device is 1:0
 Voice setting: 0x0060
 Can't connect RFCOMM channel: Connection refused
 
 then on retry
 
 btsco -v 00:03:89:F7:A9:78
 btsco v0.42
 Device is 1:0
 Voice setting: 0x0060
 RFCOMM channel 1 connected
 Using interface hci0
 
 I notice that even once connected I have to frequently hit the button on the 
 headset once to get sound thus dropping the channel I guess making it 
 available.
 This probably relates to a problem after a call when channel dropped and 
 headset is in standby. Frequently if its a long time in standby I have 
 trouble.
 Sometimes the only out is stop/start alsa.
 
 Any ideas for these symptoms.
 Thanks!
 -Walt
 
---------------------------------
Want to start your own business? Learn how on Yahoo! Small Business.
--0-801428081-1172114727=:34457
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br> <br> I posted ealier under another id but your list penalizes those who's provider <br> does not respond appropriately with a postmaster address. Mine is <br> optonline.net and they control most of the NY NYC and LI area.<br> Funny they would keep us from posting. Trying to get the provider to <br> understand is like feeding a duck nails.<br> <br> So now to my problems.<br> dongle == DLINK DBT120 B4<br> headset == Plantronics Explorer 320<br> <br> #<br> # HCI daemon configuration file.<br> #<br> <br> # HCId options<br> options {<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Automatically initialize new devices<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autoinit yes;<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Security Manager mode<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none - Security manager disabled<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; auto - Use local PIN for incoming connections<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; user - Always ask user for a PIN<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; security user;<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Pairing mode<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none&nbsp; - Pairing disabled<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; multi - Allow pairing with already paired devices<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; once&nbsp; - Pair once and deny successive attempts<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pairing multi;<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # PIN helper<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pin_helper /etc/bluetooth/pin;<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # D-Bus PIN helper<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #dbus_pin_helper;<br> }<br> <br> # Default settings for HCI devices<br> device
 {<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Local device name<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; %d - device id<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; %h - host name<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name "BlueZ (%d)";<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Local device class<br> #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; class 0x3e0100;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; class 0x200404;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Default packet type<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pkt_type DH1,DM1,HV1;<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Inquiry and Page scan<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iscan enable; pscan enable;<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Default link mode<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none&nbsp;&nbsp; - no specific policy <br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; accept - always accept incoming connections<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; master - become master on incoming connections,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deny role switch on outgoing connections<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lm accept;<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Default link policy<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none&nbsp;&nbsp;&nbsp; - no specific policy<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; rswitch - allow role switch<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; hold&nbsp;&nbsp;&nbsp; - allow hold mode<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; sniff&nbsp;&nbsp; - allow sniff mode<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; park&nbsp;&nbsp;&nbsp; - allow
 park mode<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lp rswitch,hold,sniff,park;<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Authentication and Encryption (Security Mode 3)<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; auth enable;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; encrypt enable;<br> }<br> <br> #<br> # RFCOMM configuration file.<br> #<br> <br> rfcomm0 {<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Automatically bind the device at startup<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bind yes;<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Bluetooth address of the device<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device 00:13:46:47:67:F4;<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # RFCOMM channel for the connection<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; channel 1;<br> <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Description of the connection<br> #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comment "Example
 Bluetooth device";<br> }<br> <br> <br> &nbsp;hciconfig -a revision<br> &nbsp;hci0:&nbsp;&nbsp; Type: USB<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:13:46:47:67:F4 ACL MTU: 192:8 SCO MTU: 64:8<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN AUTH ENCRYPT<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:68484755 acl:2206 sco:1341684 events:2384 errors:0<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:68389547 acl:2179 sco:1340183 commands:112 errors:1<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DH1 HV1<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'BlueZ (0)'<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x3e0100<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Networking, Rendering, Capturing<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: <br> 0x20d<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br> <br> &nbsp;hcitool inq<br> Inquiring ...<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:03:89:F7:A9:78&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock offset: 0x40ac&nbsp;&nbsp;&nbsp; class: 0x200404<br> <br> &nbsp;hcitool scan<br> Scanning ...<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:03:89:F7:A9:78&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 320Plantronics<br> <br> using btsco-0.5<br> I use it frequently mostly so I could understand the quirks.<br> With the headset waiting connect never happens
 the first time.<br> btsco -v&nbsp; &lt;addr&gt; <br> just fails out with only an RFCOMM message<br> second time it connects....<br> Here is a log of this:<br> <br> btsco -v 00:03:89:F7:A9:78<br> btsco v0.42<br> Device is 1:0<br> Voice setting: 0x0060<br> Can't connect RFCOMM channel: Connection refused<br> <br> then on retry<br> <br> btsco -v 00:03:89:F7:A9:78<br> btsco v0.42<br> Device is 1:0<br> Voice setting: 0x0060<br> RFCOMM channel 1 connected<br> Using interface hci0<br> <br> I notice that even once connected I have to frequently hit the button on the <br> headset once to get sound thus dropping the channel I guess making it <br> available.<br> This probably relates to a problem after a call when channel dropped and <br> headset is in standby. Frequently if its a long time in standby I have <br> trouble.<br> Sometimes the only out is stop/start alsa.<br> <br> Any ideas for these symptoms.<br> Thanks!<br> -Walt<p>&#32;

<hr size=1>Want to start your own business? Learn how on <a href="http://us.rd.yahoo.com/evt=41244/*http://smallbusiness.yahoo.com/r-index">Yahoo! Small Business.</a>
--0-801428081-1172114727=:34457--


--===============0655022006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0655022006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0655022006==--
