Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 6 Apr 2007 03:24:40 -0700 (PDT)
From: Mahtab Hossain <mahtab_hossain2002@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <80236d750704050236u1e346ea4l54efbbd808955e56@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <994841.24484.qm@web50503.mail.re2.yahoo.com>
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
Content-Type: multipart/mixed; boundary="===============1410684290=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1410684290==
Content-Type: multipart/alternative; boundary="0-1911882254-1175855080=:24484"
Content-Transfer-Encoding: 8bit

--0-1911882254-1175855080=:24484
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Emanuele,
Sometimes, the Bluetooth module vendor provides absolute signal strength (like Wi-Fi) rather than the relative RSSI value indicated in Bluetooth Spec. I had one dongle which did just that. You may need to send your inquiry to them as well if it's really the case.

Thanks
Mahtab

Emanuele Novelli <ema.novelli@gmail.com> wrote: Hi Marcel,

I'm referring to this function (from bluez dbus-api) where the rssi parameter is int16

----
void RemoteDeviceFound(string address, uint32 class, int16 rssi)

            This signal will be send every time an inquiry result 
            has been found by the service daemon. In general they
            only appear during a device discovery.
----

you posted in another thread you can use that value to check how close is the remote device to the dongle who does inquiry. Maybe I'm wrong and that's not the correct value to check for this purpose? 
Anyway the third parameter I read with the snipped code I posted is negative.

 -------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 
---------------------------------
TV dinner still cooling?
Check out "Tonight's Picks" on Yahoo! TV.
--0-1911882254-1175855080=:24484
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Emanuele,<br>Sometimes, the Bluetooth module vendor provides absolute signal strength (like Wi-Fi) rather than the relative RSSI value indicated in Bluetooth Spec. I had one dongle which did just that. You may need to send your inquiry to them as well if it's really the case.<br><br>Thanks<br>Mahtab<br><br><b><i>Emanuele Novelli &lt;ema.novelli@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi Marcel,<br><br>I'm referring to this function (from bluez dbus-api) where the rssi parameter is int16<br><br>----<br>void RemoteDeviceFound(string address, uint32 class, int16 rssi)<br><br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; This signal will be send every time an inquiry result <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; has been found by the service daemon. In general they<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; only appear during
 a device discovery.<br>----<br><br>you posted in another thread you can use that value to check how close is the remote device to the dongle who does inquiry. Maybe I'm wrong and that's not the correct value to check for this purpose? <br>Anyway the third parameter I read with the snipped code I posted is negative.<br><br> -------------------------------------------------------------------------<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net's Techsay panel and you'll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br>http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV_______________________________________________<br>Bluez-users mailing list<br>Bluez-users@lists.sourceforge.net<br>https://lists.sourceforge.net/lists/listinfo/bluez-users<br></blockquote><br><p>&#32;

<hr size=1>TV dinner still cooling?<br><a href="http://us.rd.yahoo.com/evt=49979/*http://tv.yahoo.com/">Check out "Tonight's Picks"</a> on Yahoo! TV.
--0-1911882254-1175855080=:24484--


--===============1410684290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1410684290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1410684290==--
