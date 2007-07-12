Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <cfd8c35a0707112246m4dd4cd44ke18b4620a7f92572@mail.gmail.com>
Date: Thu, 12 Jul 2007 07:46:06 +0200
From: "Adrian van Dongen" <adrianvandongen@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <cfd8c35a0707112244j1f2d9f4ex6718237d700ce480@mail.gmail.com>
MIME-Version: 1.0
References: <cfd8c35a0707112244j1f2d9f4ex6718237d700ce480@mail.gmail.com>
Subject: [Bluez-users] problems with bluetooth and pairing (Samsung E900 and
	MDA Vario )
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1928105489=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1928105489==
Content-Type: multipart/alternative;
	boundary="----=_Part_2238_6994716.1184219166766"

------=_Part_2238_6994716.1184219166766
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am having some problems with pairing my mobile devices. I saw the
btproximity monitor on the gentoo wiki and here on the ubuntu forums and i
thought it would be nice to install it on my machine to but i run into some
problems.

URL: http://ubuntuforums.org/showthread.php?t=486735&highlight=proximity

First of all let me explain what i am using:

* Ubuntu Fiesty Fawn
* Samsung SGH-E900
* T-mobile MDA Vario
* Bluetooth USB dongle

The script didn't work so i tried the steps by hand to see where things go
wrong. Didn't take long to see that there was no connection being made. I
first tried it on the samsung but didn't work at all. Then i tried it with
the MDA (which gives some responce) but this would also not work.

So let me explain what i did:

First i checked if my bluetooth was up and running:


avdongen@Masahiro:~$ hciconfig
  hci0:   Type: USB
        BD Address: 00:10:60:A9:10:28 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:2841 acl:34 sco:0 events:105 errors:0
        TX bytes:1226 acl:33 sco:0 commands:40 errors:0

When i try to search for my devices via hidd i get nothing..

avdongen@Masahiro:~$ sudo hidd --search
Password:
Searching ...

but when i search with the hcitool i find both my phones

avdongen@Masahiro:~$ sudo hcitool scan
Scanning ...
        00:12:37:A7:C8:93       Avdongen
        00:17:D5:59:F0:16       Avdongen2

So my first guess is, there is something wrong when i use hidd so i continue
to use hcitool. So next i try to connect to the one of the devices:

avdongen@Masahiro :~$ sudo hcitool cc 00:17:D5:59:F0:16
avdongen@Masahiro:~$ sudo hcitool cc 00:12:37:A7:C8:93

nothing.. no error, no warning on the either of the phones... so i try hidd
to connect:

avdongen@Masahiro:~$ sudo hidd --connect 00:17:D5:59:F0:16
avdongen@Masahiro:~$ sudo hidd --connect 00:12:37:A7:C8:93
Can't connect: Connection reset by peer (104)

Finally some reaction, the Samsung doesn't do anything but the MDA asks me
if my machine is allowed to connect and then asks me for a pin. I enter 1234
(this also the default in in my bluetooth config) but then i get the
connection reset by peer error.

I can ping both my phones l2ping:

root@Masahiro:/home/avdongen# l2ping 00:12:37:A7:C8:93
Ping: 00:12:37:A7:C8:93 from 00:10:60:A9:10:28 (data size 44) ...
94 bytes from 00:12:37:A7:C8:93 id 0 time 31.71ms
94 bytes from 00:12:37:A7:C8:93 id 1 time 39.77ms
94 bytes from 00:12:37:A7:C8:93 id 2 time 34.70ms
94 bytes from 00:12:37:A7:C8:93 id 3 time 30.63ms
4 sent, 4 received, 0% loss

root@Masahiro:/home/avdongen# l2ping 00:17:D5:59:F0:16
Ping: 00:17:D5:59:F0:16 from 00:10:60:A9:10:28 (data size 44) ...
4 bytes from 00:17:D5:59:F0:16 id 0 time 44.92ms
4 bytes from 00:17:D5:59:F0:16 id 1 time 43.80ms
4 bytes from 00:17:D5:59:F0:16 id 2 time 37.71ms
4 bytes from 00:17:D5:59:F0:16 id 3 time 27.64ms
4 sent, 4 received, 0% loss

Some searching here on ubuntu forums and google suggest that this has
something todo with the error:

avdongen@Masahiro:~$ hcid -n
hcid[5592]: Bluetooth HCI daemon
hcid[5592]: Could not become the primary owner of org.bluez
hcid[5592]: Unable to get on D-Bus

but there is no real solution to be found anywhere as far as i can see.

Does anyone have a clue whats wrong and how to fix this ?

Regards,

Adrian.

PS this is my hcid.conf

/etc/bluetooth/hcid.conf

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

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # Default PIN code for incoming connections
        passkey "1234";

}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "%h-%d";

        # Local device class
        class 0x3e0100;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;
        discovto 0;

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

------=_Part_2238_6994716.1184219166766
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote"></span>Hi,<br><br>I am having some problems with pairing my mobile devices. I saw the btproximity monitor on the gentoo wiki and here on the ubuntu forums and i thought it would be nice to install it on my machine to but i run into some problems.
<br><br>URL: <a href="http://ubuntuforums.org/showthread.php?t=486735&amp;highlight=proximity" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">http://ubuntuforums.org/showthread.php?t=486735&amp;highlight=proximity
</a><br><br>First of all let me explain what i am using:
<br><br>* Ubuntu Fiesty Fawn<br>* Samsung SGH-E900<br>* T-mobile MDA Vario<br>* Bluetooth USB dongle<br><br>The script didn&#39;t work so i tried the steps by hand to see where things go wrong. Didn&#39;t take long to see that there was no connection being made. I first tried it on the samsung but didn&#39;t work at all. Then i tried it with the MDA (which gives some responce) but this would also not work.
<br><br>So let me explain what i did:<br><br>First i checked if my bluetooth was up and running:<br><br><br>avdongen@Masahiro:~$ hciconfig<br>&nbsp; hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:10:60:A9:10:28 ACL MTU: 192:8 SCO MTU: 64:8
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:2841 acl:34 sco:0 events:105 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:1226 acl:33 sco:0 commands:40 errors:0<br><br>When i try to search for my devices via hidd i get nothing..<br>

<br>avdongen@Masahiro:~$ sudo hidd --search<br>Password:<br>Searching ...<br><br>but when i search with the hcitool i find both my phones<br><br>avdongen@Masahiro:~$ sudo hcitool scan<br>Scanning ...<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:12:37:A7:C8:93&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Avdongen
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:17:D5:59:F0:16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Avdongen2<br><br>So my first guess is, there is something wrong when i use hidd so i continue to use hcitool. So next i try to connect to the one of the devices:<br><br>avdongen@Masahiro

:~$ sudo hcitool cc 00:17:D5:59:F0:16<br>avdongen@Masahiro:~$ sudo hcitool cc 00:12:37:A7:C8:93<br><br>nothing.. no error, no warning on the either of the phones... so i try hidd to connect:<br><br>avdongen@Masahiro:~$ sudo hidd --connect 00:17:D5:59:F0:16
<br>avdongen@Masahiro:~$ sudo hidd --connect 00:12:37:A7:C8:93<br>Can&#39;t connect: Connection reset by peer (104)<br><br>Finally some reaction, the Samsung doesn&#39;t do anything but the MDA asks me if my machine is allowed to connect and then asks me for a pin. I enter 1234 (this also the default in in my bluetooth config) but then i get the connection reset by peer error.
<br><br>I can ping both my phones l2ping:<br><br>root@Masahiro:/home/avdongen# l2ping 00:12:37:A7:C8:93<br>Ping: 00:12:37:A7:C8:93 from 00:10:60:A9:10:28 (data size 44) ...<br>94 bytes from 00:12:37:A7:C8:93 id 0 time 31.71ms

<br>94 bytes from 00:12:37:A7:C8:93 id 1 time 39.77ms<br>94 bytes from 00:12:37:A7:C8:93 id 2 time 34.70ms<br>94 bytes from 00:12:37:A7:C8:93 id 3 time 30.63ms<br>4 sent, 4 received, 0% loss<br><br>root@Masahiro:/home/avdongen# l2ping 00:17:D5:59:F0:16
<br>Ping: 00:17:D5:59:F0:16 from 00:10:60:A9:10:28 (data size 44) ...<br>4 bytes from 00:17:D5:59:F0:16 id 0 time 44.92ms<br>4 bytes from 00:17:D5:59:F0:16 id 1 time 43.80ms<br>4 bytes from 00:17:D5:59:F0:16 id 2 time 37.71ms

<br>4 bytes from 00:17:D5:59:F0:16 id 3 time 27.64ms<br>4 sent, 4 received, 0% loss<br><br>Some searching here on ubuntu forums and google suggest that this has something todo with the error:<br><br>avdongen@Masahiro:~$ hcid -n
<br>hcid[5592]: Bluetooth HCI daemon<br>hcid[5592]: Could not become the primary owner of org.bluez<br>hcid[5592]: Unable to get on D-Bus<br><br>but there is no real solution to be found anywhere as far as i can see.<br>
<br>
Does anyone have a clue whats wrong and how to fix this ?<br><br>Regards,<br><br>Adrian.<br><br>PS this is my hcid.conf<br><br>/etc/bluetooth/hcid.conf<br><br>#<br># HCI daemon configuration file.<br>#<br><br># HCId options
<br>options {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Automatically initialize new devices<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; autoinit yes;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Security Manager mode<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none - Security manager disabled<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; auto - Use local PIN for incoming connections
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; user - Always ask user for a PIN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; security auto;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Pairing mode<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none&nbsp; - Pairing disabled<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; multi - Allow pairing with already paired devices
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; once&nbsp; - Pair once and deny successive attempts<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pairing multi;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Default PIN code for incoming connections<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; passkey &quot;1234&quot;;<br><br>}<br><br># Default settings for HCI devices
<br>device {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Local device name<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; %d - device id<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; %h - host name<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name &quot;%h-%d&quot;;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Local device class<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; class 0x3e0100;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Default packet type
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #pkt_type DH1,DM1,HV1;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Inquiry and Page scan<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iscan enable; pscan enable;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; discovto 0;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Default link mode<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none&nbsp;&nbsp; - no specific policy<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; accept - always accept incoming connections
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; master - become master on incoming connections,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deny role switch on outgoing connections<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lm accept;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Default link policy<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none&nbsp;&nbsp;&nbsp; - no specific policy
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; rswitch - allow role switch<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; hold&nbsp;&nbsp;&nbsp; - allow hold mode<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; sniff&nbsp;&nbsp; - allow sniff mode<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; park&nbsp;&nbsp;&nbsp; - allow park mode<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lp rswitch,hold,sniff,park;<br>}<br><br>

------=_Part_2238_6994716.1184219166766--


--===============1928105489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1928105489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1928105489==--
