Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <80236d750704050236u1e346ea4l54efbbd808955e56@mail.gmail.com>
Date: Thu, 5 Apr 2007 11:36:14 +0200
From: "Emanuele Novelli" <ema.novelli@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1175765322.5815.594.camel@violet>
MIME-Version: 1.0
References: <80236d750704050226m1563a49dw74214b6e847c495e@mail.gmail.com>
	<1175765322.5815.594.camel@violet>
Subject: Re: [Bluez-users] reading RSSI value with D-Bus Api
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1396848557=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1396848557==
Content-Type: multipart/alternative;
	boundary="----=_Part_41110_14606336.1175765774806"

------=_Part_41110_14606336.1175765774806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

I'm referring to this function (from bluez dbus-api) where the rssi
parameter is int16

----
void RemoteDeviceFound(string address, uint32 class, int16 rssi)

            This signal will be send every time an inquiry result
            has been found by the service daemon. In general they
            only appear during a device discovery.
----

you posted in another thread you can use that value to check how close is
the remote device to the dongle who does inquiry. Maybe I'm wrong and that's
not the correct value to check for this purpose?
Anyway the third parameter I read with the snipped code I posted is
negative.

------=_Part_41110_14606336.1175765774806
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br><br>I&#39;m referring to this function (from bluez dbus-api) where the rssi parameter is int16<br><br>----<br>void RemoteDeviceFound(string address, uint32 class, int16 rssi)<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; This signal will be send every time an inquiry result
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; has been found by the service daemon. In general they<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; only appear during a device discovery.<br>----<br><br>you posted in another thread you can use that value to check how close is the remote device to the dongle who does inquiry. Maybe I&#39;m wrong and that&#39;s not the correct value to check for this purpose?
<br>Anyway the third parameter I read with the snipped code I posted is negative.<br><br>

------=_Part_41110_14606336.1175765774806--


--===============1396848557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1396848557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1396848557==--
