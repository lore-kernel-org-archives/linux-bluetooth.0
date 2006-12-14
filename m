Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <20061214204404.75141.qmail@web58803.mail.re1.yahoo.com>
Date: Thu, 14 Dec 2006 12:44:04 -0800 (PST)
From: Hiita Road <hittaroad@yahoo.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] diagnosing 2000E card issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0238048874=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0238048874==
Content-Type: multipart/alternative; boundary="0-324250681-1166129044=:74566"
Content-Transfer-Encoding: 8bit

--0-324250681-1166129044=:74566
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi

I'm trying to get my ambicom 2000E based chipset CF card working, it  works with the 2.4 bt950_cs driver but no longer works with the new stuff for 2.6 (see archives here for more on those with same problem). The interface will never UP on 2.6.

Anyway i've modified some of the init commands in hciattach so it will now UP and can be seen by other bluetooth devices. However try to do anything and it times out, and hciattach is locked up.

I tried stepping into hcitool when doing a scan to see where it having the issue, its in hci_inquiry hci.c at ret = ioctl(dd, HCIINQUIRY, (unsigned long) buf);

where it times out.

Any suggestions on where I should check next? At the moment i'm just trying to ensure the serial port and the uart are using compatible settings, i'm not sure where to go from here.  Other than tearing into all kinds of other code like hci_uart or what have you.

thanks

 
---------------------------------
Everyone is raving about the all-new Yahoo! Mail beta.
--0-324250681-1166129044=:74566
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi<br><br>I'm trying to get my ambicom 2000E based chipset CF card working, it&nbsp; works with the 2.4 bt950_cs driver but no longer works with the new stuff for 2.6 (see archives here for more on those with same problem). The interface will never UP on 2.6.<br><br>Anyway i've modified some of the init commands in hciattach so it will now UP and can be seen by other bluetooth devices. However try to do anything and it times out, and hciattach is locked up.<br><br>I tried stepping into hcitool when doing a scan to see where it having the issue, its in hci_inquiry hci.c at ret = ioctl(dd, HCIINQUIRY, (unsigned long) buf);<br><br>where it times out.<br><br>Any suggestions on where I should check next? At the moment i'm just trying to ensure the serial port and the uart are using compatible settings, i'm not sure where to go from here.&nbsp; Other than tearing into all kinds of other code like hci_uart or what have you.<br><br>thanks<br><p>&#32;

<hr size=1>Everyone is raving about <a href="http://us.rd.yahoo.com/evt=45083/*http://advision.webevents.yahoo.com/mailbeta">the all-new Yahoo! Mail beta.</a>
--0-324250681-1166129044=:74566--


--===============0238048874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0238048874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0238048874==--
