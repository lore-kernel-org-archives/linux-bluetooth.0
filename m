Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0805190343l56fe321aye9a1e257165f2ee@mail.gmail.com>
Date: Mon, 19 May 2008 12:43:44 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] specifiy path to socket file (hcid)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1319178681=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1319178681==
Content-Type: multipart/alternative;
	boundary="----=_Part_5015_26131944.1211193824474"

------=_Part_5015_26131944.1211193824474
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

how can I specify a path where hcid should look for the socket which is
created by dbus?
Didn't find anything in "man hcid.conf" or other docs
At the moment the path seems to be just set to PREFIX ( which was set at
compile time) with the string added var/run/dbus.
Since Im crosscompiling PREFIX is the path to my toolchain and not my
favorite place of the socket file in my target system.

thanks.

-- 
Regards,
--Codefritz

------=_Part_5015_26131944.1211193824474
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>how can I specify a path where hcid should look for the socket which is created by dbus?<br>Didn&#39;t find anything in &quot;man hcid.conf&quot; or other docs<br>At the moment the path seems to be just set to PREFIX ( which was set at compile time) with the string added var/run/dbus.<br>
Since Im crosscompiling PREFIX is the path to my toolchain and not my favorite place of the socket file in my target system.<br><br>thanks.<br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_5015_26131944.1211193824474--


--===============1319178681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1319178681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1319178681==--
