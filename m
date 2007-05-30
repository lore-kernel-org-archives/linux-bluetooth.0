Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <12a679470705291925s2016d074j34d4097cb6936396@mail.gmail.com>
Date: Wed, 30 May 2007 03:25:01 +0100
From: "=?ISO-8859-1?Q?Jos=E9_Pedro_Saraiva?=" <nocive@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] opd binded to a specific HCI device?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0433996043=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0433996043==
Content-Type: multipart/alternative;
	boundary="----=_Part_139350_28542054.1180491901136"

------=_Part_139350_28542054.1180491901136
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I'm not sure if BlueZ mailing list is the more appropriate place to present
my question but anyhow, I hope that someone can enlight me on this matter.
I'm trying to run Obejct Push Daemon (opd) binded to a specific hci device,
but not sure if this is the correct way...

$ sdptool -i hci3 add OPUSH
$ ./opd --mode OBEX --metadata --path PATH

... or should I do a rfcomm bind and run ./opd --channel <rfcomm_channel>?

Thanks in advance!


Best regards,

Jos=E9 Pedro Saraiva

------=_Part_139350_28542054.1180491901136
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,<br><br>I&#39;m not sure if BlueZ mailing list is the more appropria=
te place to present my question but anyhow, I hope that someone can enlight=
 me on this matter.<br>I&#39;m trying to run Obejct Push Daemon (opd) binde=
d to a specific hci device, but not sure if this is the correct way...
<br><br>$ sdptool -i hci3 add OPUSH<br>$ ./opd --mode OBEX --metadata --pat=
h PATH<br><br>... or should I do a rfcomm bind and run ./opd --channel &lt;=
rfcomm_channel&gt;?<br><br>Thanks in advance!<br><br><br>Best regards,<br>
<br>Jos=E9 Pedro Saraiva<br>

------=_Part_139350_28542054.1180491901136--


--===============0433996043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0433996043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0433996043==--
