Return-Path: <cyrus@holtmann.org>
Message-ID: <1e9e22610803101718y7f11e322hb022b1ce722a23a1@mail.gmail.com>
Date: Mon, 10 Mar 2008 21:18:17 -0300
From: "Addo Del Grossi" <addo.delgrossi@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Inquiry Power Level
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0091027650=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0091027650==
Content-Type: multipart/alternative;
	boundary="----=_Part_17224_9310595.1205194697024"

------=_Part_17224_9310595.1205194697024
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am trying to set the inquiry transmit power level.
Using command hciconfig and get option inqtpl.
This configuration is depending bluetooth hardware ?

Command 1:

bc-00002:~# hciconfig hci0
hci0:   Type: USB
        BD Address: 00:11:E0:02:F7:3B ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1196 acl:0 sco:0 events:38 errors:0
        TX bytes:481 acl:0 sco:0 commands:37 errors:0

Command 2:

bc-00002:~# hciconfig hci0 inqtpl
Can't read inquiry transmit power level on hci0: Input/output error (5)


Att,
Addo

------=_Part_17224_9310595.1205194697024
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, <br><br>I am trying to set the inquiry transmit power level.<br>Using command hciconfig and get option inqtpl.<br>This configuration is depending bluetooth hardware ?<br><br>Command 1: <br><br>bc-00002:~# hciconfig hci0<br>
hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:11:E0:02:F7:3B ACL MTU: 384:8 SCO MTU: 64:8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1196 acl:0 sco:0 events:38 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:481 acl:0 sco:0 commands:37 errors:0<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>Command 2:<br><br>bc-00002:~# hciconfig hci0 inqtpl<br>Can&#39;t read inquiry transmit power level on hci0: Input/output error (5)<br><br><br>Att,<br>Addo<br>

------=_Part_17224_9310595.1205194697024--


--===============0091027650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0091027650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0091027650==--
