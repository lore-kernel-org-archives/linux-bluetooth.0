Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0702280423h737f8190n1fa76f35ea4413@mail.gmail.com>
Date: Wed, 28 Feb 2007 17:53:00 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-users] error while making call to ioctl for releasing a
	device
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0568788842=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0568788842==
Content-Type: multipart/alternative;
	boundary="----=_Part_33840_3553863.1172665380046"

------=_Part_33840_3553863.1172665380046
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,
   I am trying to obex push a file through rfcomm channel. Everything goes
fine (including sending of file) until i try to release the device via call
to ioctl

exact call is

ioctl(sock,RFCOMMRELEASEDEV,&req)

with error  " Bad File Descriptor".

Can anyone give me a hint abt why can this happen..
Waiting for some reply

regards
siddhant

------=_Part_33840_3553863.1172665380046
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,<br>&nbsp;&nbsp; I am trying to obex push a file through rfcomm channel. Everything goes fine (including sending of file) until i try to release the device via call to ioctl<br><br>exact call is <br><br>ioctl(sock,RFCOMMRELEASEDEV,&amp;req)
<br><br>with error&nbsp; &quot; Bad File Descriptor&quot;.<br><br>Can anyone give me a hint abt why can this happen..<br>Waiting for some reply<br><br>regards<br>siddhant<br><br><br><br>

------=_Part_33840_3553863.1172665380046--


--===============0568788842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0568788842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0568788842==--
