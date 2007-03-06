Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <becc9d2c0703052336h55d9db5l625fde2def8e0f30@mail.gmail.com>
Date: Tue, 6 Mar 2007 08:36:34 +0100
From: "Andrea Carlevato" <andrea.carlevatoml@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>,
        bluez-devel-request@lists.sourceforge.net,
        bluez-users-request@lists.sourceforge.net
In-Reply-To: <becc9d2c0703050623v671d632bv9e58fb5628b4e450@mail.gmail.com>
MIME-Version: 1.0
References: <becc9d2c0703050623v671d632bv9e58fb5628b4e450@mail.gmail.com>
Subject: [Bluez-devel] BTSCO module loading FAILED !!!
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1374715441=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1374715441==
Content-Type: multipart/alternative;
	boundary="----=_Part_69592_8407855.1173166594586"

------=_Part_69592_8407855.1173166594586
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi to all,
a am trying to enable BTSCO on an arm device where i have
a completely monolitic kernel (with alsa and bluetooth support).

I have enable modules support and compiled btsco module
for my tree, but when i try "insmod snd-bt-sco.mod.ok" i get:

insmod: cannot insert `snd-bt-sco.ko': Unknown symbol in module (-1): No
such fi
le or directory

I tried with btsco 0.5, 0.42, 0.41 : same problem..

Note: i ve seen that, compiling my kernel module, i get
Warning: "snd_hwdep_new" undefine.
Could be this the issue ? But i can't find any option in my menuconfig to
enable it!


Can anyone help me ??

thank you

------=_Part_69592_8407855.1173166594586
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote"></span>Hi to all,<br>a am trying to enable BTSCO on an arm device where i have<br>a completely monolitic kernel (with alsa and bluetooth support).<br><br>I have enable modules support and compiled btsco module
<br>for my tree, but when i try &quot;insmod 
snd-bt-sco.mod.ok&quot; i get:<br><br>insmod: cannot insert `snd-bt-sco.ko&#39;: Unknown symbol in module (-1): No such fi<br>le or directory<br><br>I tried with btsco 0.5, 0.42, 0.41 : same problem..<br><br>Note: i ve seen that, compiling my kernel module, i get 
<br>Warning: &quot;snd_hwdep_new&quot; undefine. <br>Could be this the issue ? But i can&#39;t find any option in my menuconfig to enable it!<br><br><br>Can anyone help me ??<br><br>thank you<br><br>

------=_Part_69592_8407855.1173166594586--


--===============1374715441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1374715441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1374715441==--
