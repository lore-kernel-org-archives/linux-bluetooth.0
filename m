Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <bc2917430712040950x21220f7an64d0d558939d42f7@mail.gmail.com>
Date: Tue, 4 Dec 2007 18:50:59 +0100
From: "Franck F" <celos94@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Dell D830 laptop BT card doesn't start
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1877038726=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1877038726==
Content-Type: multipart/alternative;
	boundary="----=_Part_12183_1648162.1196790659652"

------=_Part_12183_1648162.1196790659652
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I've been trying to make my embedded bluetooth card work, but it seems i
have a big problem...
Before explaining it, here is my hardware specification:
Dell D830 laptop, and my bluetooth card (running lsusb):
Bus 001 Device 003: ID 413c:8140 Dell Computer Corp. Wireless 360 Bluetooth

I have installed bluez-utils, bluez-libs, bluetooth, everything that is seem
to be needed.

Here is what hciconfig give me:
hci0:   Type: USB
        BD Address: 00:1A:6B:8A:xx:xx ACL MTU: 310:10 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:4134 acl:0 sco:0 events:136 errors:0
        TX bytes:2047 acl:0 sco:0 commands:133 errors:0

So my BT card seems to work ... but when I run a scan or an inq (with
hcitool), nothing is found. Also, the bluetooth led of my laptop is off ...

After doing many test, i was wondering if it was not a hardware problem, so
i have boot to windows to see if my card words. Everything worked fine, the
led was on, the scan showed my phone. Then i reboot on linux, and here is
the thing weird, my bluetooth card was still working (the led was on).

So i start bluetooth daemon (hcid, sdpd), i run a scan, and my phone is
found !!!

The problem seems to be the bluetooth card doesn't "start"/"stop" on linux
(the led story confirms that). So, is there a way to solve this thing ? Have
I done something wrong ?

Thanks
-- 
Franck F.

------=_Part_12183_1648162.1196790659652
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I&#39;ve been trying to make my embedded bluetooth card work, but it seems i have a big problem...<br>Before explaining it, here is my hardware specification:<br>Dell D830 laptop, and my bluetooth card (running lsusb):
<br>Bus 001 Device 003: ID 413c:8140 Dell Computer Corp. Wireless 360 Bluetooth<br clear="all"><br>I have installed bluez-utils, bluez-libs, bluetooth, everything that is seem to be needed.<br><br>Here is what hciconfig give me:
<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:1A:6B:8A:xx:xx ACL MTU: 310:10 SCO MTU: 64:8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:4134 acl:0 sco:0 events:136 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:2047 acl:0 sco:0 commands:133 errors:0
<br><br>So my BT card seems to work ... but when I run a scan or an inq (with hcitool), nothing is found. Also, the bluetooth led of my laptop is off ...<br><br>After doing many test, i was wondering if it was not a hardware problem, so i have boot to windows to see if my card words. Everything worked fine, the led was on, the scan showed my phone. Then i reboot on linux, and here is the thing weird, my bluetooth card was still working (the led was on).
<br><br>So i start bluetooth daemon (hcid, sdpd), i run a scan, and my phone is found !!!<br><br>The problem seems to be the bluetooth card doesn&#39;t &quot;start&quot;/&quot;stop&quot; on linux (the led story confirms that). So, is there a way to solve this thing ? Have I done something wrong ?
<br><br>Thanks<br>-- <br>Franck F.

------=_Part_12183_1648162.1196790659652--


--===============1877038726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--===============1877038726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1877038726==--
