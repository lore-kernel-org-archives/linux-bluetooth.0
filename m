Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <350247599@web.de>
MIME-Version: 1.0
From: Irene Heinz <irene.heinz@web.de>
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/alternative;
 boundary="=-------------1141982877817518672"
Subject: [Bluez-users] pand does not work
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 10 Mar 2006 10:27:57 +0100

This is a multi-part message in MIME format.

--=-------------1141982877817518672
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit



Hi everyone,

I am trying to connect a PDA via Bluetooth to a Linux PC (currently Suse, but later on it should work on an embedded linux). I am using a USB Bluetooth stick. The Linux PC is set as NAP with the following command:

pand --listen --role NAP --master

Afterwards, I set the IP address of bnep0 with ifconfig. The connection already worked yesterday. But when I tried it again this morning, bnep0 was not created, and I found the following message in /var/log/messages:

pand: Bind failed. Address already in use(98).

I disabled the standard ethernet connection (in case there might be some interference), restarted the PC, all in vain. Then I tried it on another Linux PC and got the same error message. hcitool scan works, and I can also send a successfull ping from Linux to the PDA. So what address is meant? What could I do?

Regards, Irene


	
Erweitern Sie FreeMail zu einem noch leistungsstarkeren E-Mail-Postfach!	
Mehr Infos unter *http://freemail.web.de/home/landingpad/?mc=021131* [http://freemail.web.de/home/landingpad/?mc=021131] 

--=-------------1141982877817518672
Content-Type: text/html; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

<html><body bgcolor='#ffffff' style='margin-left:0px; font-size:9pt; margin:0px; font-family:Verdana; margin-left:0px; margin-right:0px; margin-top:0px; margin-bottom:0px; font-family: Verdana' ><P>Hi everyone,</P><P>I am trying to connect a PDA via Bluetooth to a Linux PC (currently Suse, but later on it should work on an embedded linux). I am using a USB Bluetooth stick. The Linux PC is set as NAP with the following command:</P><P>pand --listen --role NAP --master</P><P>Afterwards, I set&nbsp;the IP address of bnep0 with ifconfig. The connection already worked yesterday. But when I tried it again this morning, bnep0 was not created, and I found the following message in&nbsp;/var/log/messages:</P><P>pand: Bind failed. Address already in use(98).</P><P>I disabled the standard ethernet connection (in case there might be some interference), restarted the PC, all in vain. Then I tried it on another Linux PC and got the same error message. hcitool scan works, and I can also send!
  a successfull ping from Linux to the PDA. So what address is meant? What could I do?</P><P>Regards, Irene</P><br><br><table cellpadding="0" cellspacing="0" border="0"><tr><td bgcolor="#000000"><img src="https://img.web.de/p.gif" width="1" height="1" border="0" alt="" /></td></tr><tr><td style="font-family:verdana; font-size:12px; line-height:17px;">Erweitern Sie FreeMail zu einem noch leistungsstarkeren E-Mail-Postfach!		&nbsp;&nbsp;&nbsp;<br>Mehr Infos unter <A HREF="http://freemail.web.de/home/landingpad/?mc=021131"><B>http://freemail.web.de/home/landingpad/?mc=021131</B></A>&nbsp;&nbsp;</td></tr></table></body></html>

--=-------------1141982877817518672--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
