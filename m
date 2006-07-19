Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <20060719085107.34521.qmail@web15806.mail.cnb.yahoo.com>
Date: Wed, 19 Jul 2006 01:51:07 -0700 (PDT)
From: Mingfan lu <lucharse@yahoo.com.cn>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] About the transfering speed of bluez RFCOMM socket
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0168947832=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0168947832==
Content-Type: multipart/alternative; boundary="0-1546605997-1153299067=:32686"
Content-Transfer-Encoding: 8bit

--0-1546605997-1153299067=:32686
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Env:
  Machine A and machine B are the same.
  But
  suse10.1 for A   ---bluez
  windowsXP(SP2) for B ---bluesoleil
  We use the same bluetooth dongle and mobile device(symbian) in the test.
  When I use OpenObex(based on bluez Rfcomm socket) to send a file from machieA to the mobile device the transfering speed is about 10K BytePerSec.
  When I use Bluesoleil to send the same file from machine B to the mobile device the transfering speed is about 40K-50K BytePerSec.
   
  Why is  B much better than A?
  is it not efficient of Bluez Rfcomm socket? or other reason.


With respects,
        Mingfan.Lu 

 		
---------------------------------
How low will we go? Check out Yahoo! Messenger’s low  PC-to-Phone call rates.
--0-1546605997-1153299067=:32686
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV>Env:</DIV>  <DIV>Machine A and machine B are the same.</DIV>  <DIV>But</DIV>  <DIV>suse10.1 for A&nbsp;&nbsp; ---bluez</DIV>  <DIV>windowsXP(SP2) for B ---bluesoleil</DIV>  <DIV>We use the same bluetooth dongle and mobile device(symbian) in the test.</DIV>  <DIV>When I use OpenObex(based on bluez Rfcomm socket) to send a file from machieA to the mobile device the transfering speed is about 10K BytePerSec.</DIV>  <DIV>When I use Bluesoleil to send&nbsp;the same&nbsp;file from machine B to the mobile device the transfering speed is about 40K-50K BytePerSec.</DIV>  <DIV>&nbsp;</DIV>  <DIV>Why is&nbsp; B&nbsp;much better than A?</DIV>  <DIV>is it not efficient of Bluez Rfcomm socket? or other reason.</DIV><BR><BR><DIV id=RTEContent><FONT face="comic sans ms" color=#bc6e6e size=5>With respects,</FONT></DIV>  <DIV>&nbsp;<FONT size=4>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#ff0000>&nbsp;<FONT face="comic sans ms">Mingfan.Lu</FONT></FONT></FONT> <IMG
 src="http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/01.gif"></DIV><p>&#32;
		<hr size=1>How low will we go? Check out Yahoo! Messenger’s low <a href="http://us.rd.yahoo.com/mail_us/taglines/postman8/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com"> PC-to-Phone call rates.
--0-1546605997-1153299067=:32686--


--===============0168947832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0168947832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0168947832==--
