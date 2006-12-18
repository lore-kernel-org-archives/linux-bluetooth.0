Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60612172156l60a7124bsc9a02b4d1a68c455@mail.gmail.com>
Date: Sun, 17 Dec 2006 21:56:40 -0800
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] minicom over /dev/rfcomm0 failed
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1844844730=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1844844730==
Content-Type: multipart/alternative;
	boundary="----=_Part_13854_14477097.1166421400390"

------=_Part_13854_14477097.1166421400390
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:
I am trying to use minicom on my SuSE box to receive connections from an
external device that connect, via Bluetooth, and handshake with the AT
command set.
I have /dev/rfcomm0.  I also have entries in /dev/rfcomm0 that binds to the
BT_ADDR of that external device.
However, when I run minicom (with serial device set to /dev/rfcomm0), I got
back:

  minicom: cannot open /dev/rfcomm0: No such file or directory.

I do have /dev/rfcomm0 and the permission on it looks correct.

Am I missing a step somewhere?
Any help much appreciated.


Mark

------=_Part_13854_14477097.1166421400390
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi:<br>I am trying to use minicom on my SuSE box to receive connections from an external device that connect, via Bluetooth, and handshake with the AT command set.<br>I have /dev/rfcomm0.&nbsp; I also have entries in /dev/rfcomm0 that binds to the BT_ADDR of that external device.
<br>However, when I run minicom (with serial device set to /dev/rfcomm0), I got back:<br><br>&nbsp; minicom: cannot open /dev/rfcomm0: No such file or directory.<br><br>I do have /dev/rfcomm0 and the permission on it looks correct.
<br><br>Am I missing a step somewhere?<br>Any help much appreciated.<br><br><br>Mark<br>

------=_Part_13854_14477097.1166421400390--


--===============1844844730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1844844730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1844844730==--
