Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <57c68ddc0701012354u4137d1d3s93b28cafaa53f849@mail.gmail.com>
Date: Tue, 2 Jan 2007 13:24:29 +0530
From: "siddhant tewari" <siddhant.tewari@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] problem in making multiple connections using single
	bluetooth adapter using bluez
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0128664188=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0128664188==
Content-Type: multipart/alternative;
	boundary="----=_Part_135306_1488323.1167724469924"

------=_Part_135306_1488323.1167724469924
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,
    I am trying to open multiple connections by connecting to OBEX push
servers on different mobiles using single blue tooth adapter. The steps that
i am taking right now are as follows:-

i) Detecting bluetooth devices.
ii) Sending data to any detected device through a different process (i do a
fork in the main program). This new process first sets up  a RFCOMM channel
to the devices OBEX push server and then sends data to it through using open
obex API.

But the above scheme  is not working correctly. Can someone tell me the
mistake i am making and how should i correct it. Please help me as i find
my  self quite clueless abt to how to proceed now. Also it would be great
help if anyone can even give me a direction in which i should proceed now.

Eagerly waiting for reply.Thanks in advance.

bye bye

------=_Part_135306_1488323.1167724469924
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,<br>&nbsp;&nbsp;&nbsp; I am trying to open multiple connections by connecting to OBEX push servers on different mobiles using single blue tooth adapter. The steps that i am taking right now are as follows:-<br><br>i) Detecting bluetooth devices.
<br>ii) Sending data to any detected device through a different process (i do a fork in the main program). This new process first sets up&nbsp; a RFCOMM channel to the devices OBEX push server and then sends data to it through using open obex API.
<br><br>But the above scheme&nbsp; is not working correctly. Can someone tell me the mistake i am making and how should i correct it. Please help me as i find my&nbsp; self quite clueless abt to how to proceed now. Also it would be great help if anyone can even give me a direction in which i should proceed now.
<br><br>Eagerly waiting for reply.Thanks in advance.<br><br>bye bye<br>

------=_Part_135306_1488323.1167724469924--


--===============0128664188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0128664188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0128664188==--
