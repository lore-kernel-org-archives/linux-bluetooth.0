Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <7e36c64c0611012122p257a64a1x590bc1859e119db1@mail.gmail.com>
Date: Thu, 2 Nov 2006 10:52:08 +0530
From: "shantibhushan sale" <shantibhushan.sale@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] pairing problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0995624878=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0995624878==
Content-Type: multipart/alternative;
	boundary="----=_Part_293_2859479.1162444928775"

------=_Part_293_2859479.1162444928775
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I m not able to pair to my soni ericcson or any other phone from Blutooth
Dongle which is connected  to the computer.
Please,help me in this regard.I have to connect from computer to phone.
I am entering passcode 1234.it doestn accept the connection.

I have following configuration for my etc/bluetooth/hcid.conf

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
    security auto;
     #security none;

    # Pairing mode
    #   none  - Pairing disabled
    #   multi - Allow pairing with already paired devices
    #   once  - Pair once and deny successive attempts
    pairing multi;
#    pairing none;

    # Default PIN code for incoming connections
    passkey "0000";
}

# Default settings for HCI devices
device {
    # Local device name
    #   %d - device id
    #   %h - host name
    name "BlueZ (%d)";

    # Local device class
    class 0x3e0100;

    # Default packet type
    #pkt_type DH1,DM1,HV1;

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
}

------=_Part_293_2859479.1162444928775
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I m not able to pair to my soni ericcson or any other phone from Blutooth Dongle which is connected&nbsp; to the computer.<br>Please,help me in this regard.I have to connect from computer to phone.<br>I am entering passcode <a href="http://1234.it">
1234.it</a> doestn accept the connection.<br><br>I have following configuration for my etc/bluetooth/hcid.conf<br><br>#<br># HCI daemon configuration file.<br>#<br><br># HCId options<br>options {<br>&nbsp;&nbsp;&nbsp; # Automatically initialize new devices
<br>&nbsp;&nbsp;&nbsp; autoinit yes;<br><br>&nbsp;&nbsp;&nbsp; # Security Manager mode<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none - Security manager disabled<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; auto - Use local PIN for incoming connections<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; user - Always ask user for a PIN<br>&nbsp;&nbsp;&nbsp; #<br>&nbsp;&nbsp;&nbsp; security auto;
<br>&nbsp;&nbsp;&nbsp; &nbsp;#security none;<br><br>&nbsp;&nbsp;&nbsp; # Pairing mode<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none&nbsp; - Pairing disabled<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; multi - Allow pairing with already paired devices<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; once&nbsp; - Pair once and deny successive attempts<br>&nbsp;&nbsp;&nbsp; pairing multi;
<br>#&nbsp;&nbsp;&nbsp; pairing none;<br><br>&nbsp;&nbsp;&nbsp; # Default PIN code for incoming connections<br>&nbsp;&nbsp;&nbsp; passkey &quot;0000&quot;;<br>}<br><br># Default settings for HCI devices<br>device {<br>&nbsp;&nbsp;&nbsp; # Local device name<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; %d - device id
<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; %h - host name<br>&nbsp;&nbsp;&nbsp; name &quot;BlueZ (%d)&quot;;<br><br>&nbsp;&nbsp;&nbsp; # Local device class<br>&nbsp;&nbsp;&nbsp; class 0x3e0100;<br><br>&nbsp;&nbsp;&nbsp; # Default packet type<br>&nbsp;&nbsp;&nbsp; #pkt_type DH1,DM1,HV1;<br><br>&nbsp;&nbsp;&nbsp; # Inquiry and Page scan<br>&nbsp;&nbsp;&nbsp; iscan enable; pscan enable;
<br><br>&nbsp;&nbsp;&nbsp; # Default link mode<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none&nbsp;&nbsp; - no specific policy <br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; accept - always accept incoming connections<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; master - become master on incoming connections,<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deny role switch on outgoing connections
<br>&nbsp;&nbsp;&nbsp; lm accept;<br><br>&nbsp;&nbsp;&nbsp; # Default link policy<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none&nbsp;&nbsp;&nbsp; - no specific policy<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; rswitch - allow role switch<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; hold&nbsp;&nbsp;&nbsp; - allow hold mode<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; sniff&nbsp;&nbsp; - allow sniff mode<br>&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; park&nbsp;&nbsp;&nbsp; - allow park mode
<br>&nbsp;&nbsp;&nbsp; lp rswitch,hold,sniff,park;<br>}<br><br><br><br><br>

------=_Part_293_2859479.1162444928775--


--===============0995624878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0995624878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0995624878==--
