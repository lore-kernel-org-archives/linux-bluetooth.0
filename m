Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 13 Apr 2007 12:36:06 -0700 (PDT)
From: walt shekrota <penguinacity@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <803748.28626.qm@web62302.mail.re1.yahoo.com>
Subject: [Bluez-users] SDP server Invalid Exchange
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1966561802=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1966561802==
Content-Type: multipart/alternative; boundary="0-1158312424-1176492966=:28626"
Content-Transfer-Encoding: 8bit

--0-1158312424-1176492966=:28626
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I have had a plantronics explorer 320 working with my DBT-120 dongle for some time now.
 
 I got hold of a motorola H350. To try it I started poking around and made changes to rfcomm.conf.
 I could do
 hcitool scan
 sdptool browse
 both fine.
 I could ping the headset but I could not get it to pair with btsco, getting connection refused.
 I got fed up and set all files back except for the auth and encrypt settings in hcid.conf. They had been at enable with the plantronic before but I remember hearing they should be disabled?
 so I get this with the plantronics now.....
 
 sdptool browse 00:03:89:F7:A9:78
 Failed to connect to SDP server on 00:03:89:F7:A9:78: Invalid exchange
 
 swordfish ~ # hcidump -x                   (during above)
 HCI sniffer - Bluetooth packet analyzer ver 1.30
 device: hci0 snap_len: 1028 filter: 0xffffffff
 < HCI Command: Create Connection (0x01|0x0005) plen 13
   78 A9 F7 89 03 00 18 00 02 00 00 00 00
   > HCI Event: Command Status (0x0f) plen 4
     00 01 05 04
     > HCI Event: Link Key Request (0x17) plen 6
       78 A9 F7 89 03 00
       < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
         78 A9 F7 89 03 00
         > HCI Event: Command Complete (0x0e) plen 10
           01 0C 04 00 78 A9 F7 89 03 00
           > HCI Event: PIN Code Request (0x16) plen 6
             78 A9 F7 89 03 00
             < HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
               78 A9 F7 89 03 00
               > HCI Event: Command Complete (0x0e) plen 10
                 01 0E 04 00 78 A9 F7 89 03 00
                 > HCI Event: Connect Complete (0x03) plen 11
                   06 29 00 78 A9 F7 89 03 00 01 00
 
 Any ideas what happened here? My pin code is set to 0000 as it was when working.
 Thanks. -Walt
 
       
---------------------------------
Ahhh...imagining that irresistible "new car" smell?
 Check outnew cars at Yahoo! Autos.
--0-1158312424-1176492966=:28626
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I have had a plantronics explorer 320 working with my DBT-120 dongle for some time now.<br> <br> I got hold of a motorola H350. To try it I started poking around and made changes to rfcomm.conf.<br> I could do<br> hcitool scan<br> sdptool browse<br> both fine.<br> I could ping the headset but I could not get it to pair with btsco, getting connection refused.<br> I got fed up and set all files back except for the auth and encrypt settings in hcid.conf. They had been at enable with the plantronic before but I remember hearing they should be disabled?<br> so I get this with the plantronics now.....<br> <br> sdptool browse 00:03:89:F7:A9:78<br> Failed to connect to SDP server on 00:03:89:F7:A9:78: Invalid exchange<br> <br> swordfish ~ # hcidump -x &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (during above)<br> HCI sniffer - Bluetooth packet analyzer ver 1.30<br> device: hci0 snap_len: 1028 filter: 0xffffffff<br> &lt; HCI Command: Create Connection
 (0x01|0x0005) plen 13<br> &nbsp; 78 A9 F7 89 03 00 18 00 02 00 00 00 00<br> &nbsp; &gt; HCI Event: Command Status (0x0f) plen 4<br> &nbsp;&nbsp;&nbsp; 00 01 05 04<br> &nbsp;&nbsp;&nbsp; &gt; HCI Event: Link Key Request (0x17) plen 6<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 78 A9 F7 89 03 00<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 78 A9 F7 89 03 00<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; HCI Event: Command Complete (0x0e) plen 10<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 0C 04 00 78 A9 F7 89 03 00<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; HCI Event: PIN Code Request (0x16) plen 6<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 78 A9 F7 89 03 00<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6<br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 78 A9 F7 89 03 00<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; HCI Event: Command Complete (0x0e) plen 10<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 01 0E 04 00 78 A9 F7 89 03 00<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; HCI Event: Connect Complete (0x03) plen 11<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 06 29 00 78 A9 F7 89 03 00 01 00<br> <br> Any ideas what happened here? My pin code is set to 0000 as it was when working.<br> Thanks. -Walt<br> <p>&#32;

      <hr size=1>Ahhh...imagining that irresistible "new car" smell?<br> Check out
<a href="http://us.rd.yahoo.com/evt=48245/*http://autos.yahoo.com/new_cars.html;_ylc=X3oDMTE1YW1jcXJ2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDbmV3LWNhcnM-">new cars at Yahoo! Autos.</a>

--0-1158312424-1176492966=:28626--


--===============1966561802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1966561802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1966561802==--
