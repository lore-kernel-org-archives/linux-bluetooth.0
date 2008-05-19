Return-Path: <cyrus@holtmann.org>
Message-ID: <3e9cdced0805190124x1fced786h16c3475cf76a4a80@mail.gmail.com>
Date: Mon, 19 May 2008 10:24:41 +0200
From: "Fritz Code" <codefritz@googlemail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] using bluez without the dbus-daemon,
	just dbus-lib as peer-to-peer connection
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0692599228=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0692599228==
Content-Type: multipart/alternative;
	boundary="----=_Part_4858_32495731.1211185481356"

------=_Part_4858_32495731.1211185481356
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

dbus can be used in two modes, on the one hand just the dbus library in
order to establish a point-to-point communication between two processes,
on the other hand with the dbus-daemon which uses the library in order to
allow the communication of many different processes with each other.

In my specific scenario I have to safe system resources since I'm developing
for an embedded arm system and I only have one single application which has
to communicate with bluez.

Is it possible to use bluez only with the dbuslib (without dbus-daemon) in
order to establish a point-to-point communication between bluez and an
application which uses the bluez/bluetooth features?
If yes which part of bluez is responsible for doing that?
Are there any differences in the view of bluez-functionalities between this
two modes of communication besides the obvious that there can be only one
peer-to-peer connection?

thanks a lot.

-- 
Regards,
--Codefritz

------=_Part_4858_32495731.1211185481356
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>dbus can be used in two modes, on the one hand just the dbus library in order to establish a point-to-point communication between two processes,<br>on the other hand with the dbus-daemon which uses the library in order to allow the communication of many different processes with each other.<br>
<br>In my specific scenario I have to safe system resources since I&#39;m developing for an embedded arm system and I only have one single application which has to communicate with bluez.<br><br>Is it possible to use bluez only with the dbuslib (without dbus-daemon) in order to establish a point-to-point communication between bluez and an application which uses the bluez/bluetooth features?<br>
If yes which part of bluez is responsible for doing that?<br>Are there any differences in the view of bluez-functionalities between this two modes of communication besides the obvious that there can be only one peer-to-peer connection?<br>
<br>thanks a lot.<br clear="all"><br>-- <br>Regards,<br>--Codefritz<br><br><br><br>

------=_Part_4858_32495731.1211185481356--


--===============0692599228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0692599228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0692599228==--
