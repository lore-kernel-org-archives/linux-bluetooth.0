Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <c17fe92b0702191021q51d727b4ga2bd7d7e0abffa4b@mail.gmail.com>
Date: Mon, 19 Feb 2007 23:51:49 +0530
From: "suman karthik" <sumankarthik@gmail.com>
To: bluez <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Bluez-devel] HCI_MAX_DEV modification
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0336452470=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0336452470==
Content-Type: multipart/alternative;
	boundary="----=_Part_50169_14269834.1171909309810"

------=_Part_50169_14269834.1171909309810
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey guys,

Was just going through hci.h to see what are the maximum number of bluetooth
adapters bluez supported and saw that

HCI_MAX_DEV was 16

can i change this number (increase it) and would i have to rebuild the bluez
kernel module for the changes to take effect.

Any pointers on how to do this would be gr8, thank you.

-- 
-Suman
http://www.zerocaffe.in

------=_Part_50169_14269834.1171909309810
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey guys,<br><br>Was just going through hci.h to see what are the maximum number of bluetooth adapters bluez supported and saw that <br><br>HCI_MAX_DEV was 16<br><br>can i change this number (increase it) and would i have to rebuild the bluez kernel module for the changes to take effect. 
<br><br>Any pointers on how to do this would be gr8, thank you.<br clear="all"><br>-- <br>-Suman<br><a href="http://www.zerocaffe.in">http://www.zerocaffe.in</a>

------=_Part_50169_14269834.1171909309810--


--===============0336452470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0336452470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0336452470==--
