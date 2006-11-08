Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <101bcd760611080146ie8fd149h4240e8ff876cad8a@mail.gmail.com>
Date: Wed, 8 Nov 2006 10:46:37 +0100
From: "Hakan Lager" <digiloo@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Problem with 2nd second dongle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1616329631=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1616329631==
Content-Type: multipart/alternative;
	boundary="----=_Part_19717_23554397.1162979197690"

------=_Part_19717_23554397.1162979197690
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I'm facing the following problem on a TS-7200 board. The board is equipped
with the standard TS-linux (debian)  release
and by loading the proper modules I'm able to use a single bluetooth dongle.

But when I plug another dongle into the 2nd USB port I'm unable to make it
work.

The only way to bring it up is to make

hciconfig hci0 down
and then
hciconfig hci1 up
and then it works.

But I'm only able to operate a single BT dongle at a time. On my
development machine (redhat) everything works fine.

Anyone facing the same problem?

/ Hakan

------=_Part_19717_23554397.1162979197690
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,<br><br>I'm facing the following problem on a TS-7200 board. The board is equipped with the standard TS-linux (debian) &nbsp;release </div>
<div>and by loading the proper modules I'm able to use a single bluetooth dongle.<br><br>But when I plug another dongle into the 2nd USB port I'm unable to make it work.<br>&nbsp;</div>
<div>The only way to bring it up is to make<br><br>hciconfig hci0 down<br>and then<br>hciconfig hci1 up<br>and then it works.<br>&nbsp;</div>
<div>But I'm only able to operate a single BT dongle at a time. On my<br>development machine (redhat) everything works fine.<br><br>Anyone facing the same problem?<br>&nbsp;</div>
<div>/ Hakan</div>

------=_Part_19717_23554397.1162979197690--


--===============1616329631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1616329631==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1616329631==--
