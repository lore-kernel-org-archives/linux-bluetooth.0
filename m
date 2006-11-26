Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <c49421c50611261142i2d525f85yd67cb43d28a06e3d@mail.gmail.com>
Date: Sun, 26 Nov 2006 16:42:30 -0300
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] reading RSSI (continuation)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1169058352=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1169058352==
Content-Type: multipart/alternative;
	boundary="----=_Part_82047_18198170.1164570150232"

------=_Part_82047_18198170.1164570150232
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry the short previous message, let me being more specific.

I read that a device may send a DAC packet to another one, which will answer
with another DAC packet. Thus, the first device can read the RSSI to the
other device without establishing a baseband connection among them. In such
a scenario, the first device has previous knowledge of the BD_ADDR and clock
offset of the queried device.

The doubt is: is there any way of doing this using BlueZ??

Thanks for any hint!

Loreno

------=_Part_82047_18198170.1164570150232
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry the short previous message, let me being more specific.<br><br>I read that a device may send a DAC packet to another one, which will answer with another DAC packet. Thus, the first device can read the RSSI to the other device without establishing a baseband connection among them. In such a scenario, the first device has previous knowledge of the BD_ADDR and clock offset of the queried device.
<br><br>The doubt is: is there any way of doing this using BlueZ??<br><br>Thanks for any hint!<br><br>Loreno<br>

------=_Part_82047_18198170.1164570150232--


--===============1169058352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1169058352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1169058352==--
