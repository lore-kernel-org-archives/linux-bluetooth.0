Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060718225953.76507.qmail@web51415.mail.yahoo.com>
Date: Tue, 18 Jul 2006 15:59:53 -0700 (PDT)
From: manojt ambe <mp_tambe@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] HCID startup error
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1176240594=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1176240594==
Content-Type: multipart/alternative; boundary="0-1470763403-1153263593=:75389"
Content-Transfer-Encoding: 8bit

--0-1470763403-1153263593=:75389
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

I have installed following on CentOS 3.3.
  
bluez-libs-3.1.tar.gz   
bluez-utils-3.1.tar.gz   
bluez-firmware-1.2.tar.gz   
bluez-hcidump-1.31.tar.gz   I see following errors when i start hcid in /var/log/messages/ 
           hcid[4770]: Bluetooth HCI daemon
           hcid[4770]: Service could not become primary owner
           hcid[4770]: Unable to get on D-Bus
   
  I have started dbus using dbus-daemon and dbus-launch --system. The files system-bus-socket and messgebus.pid exist under /usr/local/var/run and /usr/local/var/run/dbus/.
   
  Pls let me know what am i missing?  Is there any documentation available to get bluez working with dbus?
  Any help is greatly appreciated.
   
  Regards,
  Manoj
   
   

 		
---------------------------------
Yahoo! Music Unlimited - Access over 1 million songs.Try it free. 
--0-1470763403-1153263593=:75389
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>I have installed following on CentOS 3.3.</div>  <LI><A onmouseover="window.status='http://bluez.sf.net/download/bluez-libs-3.1.tar.gz'; return true;" onmouseout="window.status=''; return true;" href="http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-libs-3.1.tar.gz"><FONT color=#3854c6>bluez-libs-3.1.tar.gz</FONT></A>   <LI><A onmouseover="window.status='http://bluez.sf.net/download/bluez-utils-3.1.tar.gz'; return true;" onmouseout="window.status=''; return true;" href="http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-utils-3.1.tar.gz"><FONT color=#3854c6>bluez-utils-3.1.tar.gz</FONT></A>   <LI><A onmouseover="window.status='http://bluez.sf.net/download/bluez-firmware-1.2.tar.gz'; return true;" onmouseout="window.status=''; return true;" href="http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-firmware-1.2.tar.gz"><FONT color=#3854c6>bluez-firmware-1.2.tar.gz</FONT></A> 
  <LI><A onmouseover="window.status='http://bluez.sf.net/download/bluez-hcidump-1.31.tar.gz'; return true;" onmouseout="window.status=''; return true;" href="http://www.bluez.org/redirect.php?url=http%3A%2F%2Fbluez.sf.net%2Fdownload%2Fbluez-hcidump-1.31.tar.gz"><FONT color=#3854c6>bluez-hcidump-1.31.tar.gz</FONT></A> </LI>  <div>I see following errors when i start hcid in /var/log/messages/ </div>  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hcid[4770]: Bluetooth HCI daemon</div>  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hcid[4770]: Service could not become primary owner</div>  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;hcid[4770]: Unable to get on D-Bus</div>  <div>&nbsp;</div>  <div>I have started dbus using dbus-daemon and dbus-launch --system. The files system-bus-socket and messgebus.pid exist under /usr/local/var/run and /usr/local/var/run/dbus/.</div>  <div>&nbsp;</div>  <div>Pls let me know what am i missing?&nbsp; Is
 there any documentation available to get bluez working with dbus?</div>  <div>Any help is greatly appreciated.</div>  <div>&nbsp;</div>  <div>Regards,</div>  <div>Manoj</div>  <div>&nbsp;</div>  <div>&nbsp;</div><p>&#32;
		<hr size=1>Yahoo! Music Unlimited - Access over 1 million songs.
<a href="http://pa.yahoo.com/*http://us.rd.yahoo.com/evt=36035/*http://music.yahoo.com/unlimited/ 
">Try it free.</a> 
--0-1470763403-1153263593=:75389--


--===============1176240594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1176240594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1176240594==--
