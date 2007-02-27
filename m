Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <3d3168e50702270853u31b66304w5e95b23386a88a54@mail.gmail.com>
Date: Tue, 27 Feb 2007 17:53:21 +0100
From: "=?ISO-8859-2?Q?Micha=B3_Majchrowicz?=" <mmajchrowicz@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Problem with PAN. Bnep doesn't work ?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0204776192=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0204776192==
Content-Type: multipart/alternative;
	boundary="----=_Part_16723_12055440.1172595201969"

------=_Part_16723_12055440.1172595201969
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi I have a problem with PAN.
I have succesfully configured pand connection
on sever:
 pand -l
bnep0 11:22:33:44:55:66 NAP
on client:
pand -l
bnep0 66:55:44:33:22:11 NAP
where 66:55.... is MAC of server and 11:22.... is MAC of client.
According to all infor I just should do ifconfig bnep0 10.0.0.1 on
server and ifconfig bnep0 10.0.0.2 on client. And ping should work.
But it doesn't :( What may be the reason.
I just wanted to explain that 10.0.0.0/24 is free and not used by
another device and I don't have firewall. Please help me :)
Regards Michael.

------=_Part_16723_12055440.1172595201969
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi I have a problem with PAN.<br>I have succesfully configured pand connection<br>on sever:<br>&nbsp;pand -l<br>bnep0 11:22:33:44:55:66 NAP<br>on client:<br>pand -l<br>
bnep0 66:55:44:33:22:11 NAP<br>where 66:55.... is MAC of server and 11:22.... is MAC of client.<br>According to all infor I just should do ifconfig bnep0 <a href="http://10.0.0.1">10.0.0.1</a> on<br>server and ifconfig bnep0 
<a href="http://10.0.0.2">10.0.0.2</a> on client. And ping should work.<br>But it doesn&#39;t :( What may be the reason.<br>I just wanted to explain that <a href="http://10.0.0.0/24">10.0.0.0/24</a> is free and not used by
<br>another device and I don&#39;t have firewall. Please help me :)<br>Regards Michael.<br>
<br>

------=_Part_16723_12055440.1172595201969--


--===============0204776192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0204776192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0204776192==--
