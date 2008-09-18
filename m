Return-Path: <cyrus@holtmann.org>
Message-ID: <4f9823290809180242j56115a6es3a77ffa21eabbf0a@mail.gmail.com>
Date: Thu, 18 Sep 2008 11:42:19 +0200
From: "Reto Bachmann" <reto.bachmann@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] What happens with bluetooth when connection is
	interrupted
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0937047296=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0937047296==
Content-Type: multipart/alternative;
	boundary="----=_Part_2224_22547388.1221730939968"

------=_Part_2224_22547388.1221730939968
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi to all,

I have a little question. I have to develop an Application where it can
happen that the connection interrupts. I poll the adapter every second to
see if I am still connected to the specific device. Now I have to know if
there is a possibility that the bluez-function "isConnected(string address)"
(D-Bus-Function) returns false but the connection itself is recovered by the
BT-Stack so the connection would still exist.

Kind regards,
Reto

------=_Part_2224_22547388.1221730939968
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi to all,<br><br>I have a little question. I have to develop an Application where it can happen that the connection interrupts. I poll the adapter every second to see if I am still connected to the specific device. Now I have to know if there is a possibility that the bluez-function &quot;isConnected(string address)&quot; (D-Bus-Function) returns false but the connection itself is recovered by the BT-Stack so the connection would still exist.<br>
<br>Kind regards,<br>Reto<br></div>

------=_Part_2224_22547388.1221730939968--


--===============0937047296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0937047296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0937047296==--
