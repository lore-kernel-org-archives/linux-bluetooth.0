Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d7dffb480611280055g6409c2ica54f78d3666674b@mail.gmail.com>
Date: Tue, 28 Nov 2006 14:25:55 +0530
From: "VANatFortuna amarnath" <van.bluez.list@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] RFCOMM connection problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2121138614=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============2121138614==
Content-Type: multipart/alternative;
	boundary="----=_Part_5823_32829061.1164704155681"

------=_Part_5823_32829061.1164704155681
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,
    I am new to BlueZ, and i downloaded bluez stack and i am runnig test
programs. I am running 'hstest.c'. It was working properly. It was
successfully opening both rfcomm com & sco connection and audio(wave file)
is redirecting to head set. But the problem is :

       AT commands passed by headset are not captured at rfcomm socket.
Means if i press headset button, as of i understood, it should sned
'AT+CKPD=200\r\n'. But it is not caputured at rfcomm socket in the program,
in the same way even volume controls(AT+VGS/M) also. I am not able to get
those AT commands from headset. Can anybody say where i am wrong.


Thanx all, let me know If any details  needed.
Amarnath

------=_Part_5823_32829061.1164704155681
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,<br>&nbsp;&nbsp;&nbsp; I am new to BlueZ, and i downloaded bluez stack and i am runnig test programs. I am running 'hstest.c'. It was working properly. It was successfully opening both rfcomm com &amp; sco connection and audio(wave file) is redirecting to head set. But the problem is :
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AT commands passed by headset are not captured at rfcomm socket. Means if i press headset button, as of i understood, it should sned 'AT+CKPD=200\r\n'. But it is not caputured at rfcomm socket in the program, in the same way even volume controls(AT+VGS/M) also. I am not able to get those AT commands from headset. Can anybody say where i am wrong.
<br><br><br>Thanx all, let me know If any details&nbsp; needed.<br>Amarnath<br>

------=_Part_5823_32829061.1164704155681--


--===============2121138614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2121138614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2121138614==--
