Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <becc9d2c0703120144g75a690del256c5598a68ba7bf@mail.gmail.com>
Date: Mon, 12 Mar 2007 09:44:18 +0100
From: "Andrea Carlevato" <andrea.carlevatoml@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Btsco and ALSA problem, please help !!!
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0006946440=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0006946440==
Content-Type: multipart/alternative;
	boundary="----=_Part_30950_29234354.1173689058946"

------=_Part_30950_29234354.1173689058946
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 Hi to all guys,

i am trying to run btsco on an embedded linux device. I got ALSA compiled
into the kernel (2.6.15) and i have successfully compiled snd-bt-sco module
for my target. I also load it correctly (its the only module in my system).

But when i try to run btsco i get this error:

ALSA lib control.c:739:(snd_ctl_open_noupdate) Invalid CTL hw:0
Error: control open (hw:0): No such file or directory
Error: Can't find device. Bail


Surely i miss some ALSA config steps...

Can someone help me ??


thanks a lot

------=_Part_30950_29234354.1173689058946
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&nbsp;Hi to all guys,<br><br>i am trying to run btsco on an embedded linux device. I got ALSA compiled into the kernel (2.6.15) and i have successfully compiled snd-bt-sco module for my target. I also load it correctly (its the only module in my system).
<br><br>But when i try to run btsco i get this error:<br><br>ALSA lib control.c:739:(snd_ctl_open_noupdate) Invalid CTL hw:0<br>Error: control open (hw:0): No such file or directory<br>Error: Can&#39;t find device. Bail<br>
<br><br>Surely i miss some ALSA config steps...<br><br>Can someone help me ??<br><br><br>thanks a lot<br><br>

------=_Part_30950_29234354.1173689058946--


--===============0006946440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0006946440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0006946440==--
