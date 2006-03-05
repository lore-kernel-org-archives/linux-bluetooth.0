Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060305203957.82446.qmail@web51307.mail.yahoo.com>
From: lady jane <lady3jane2002@yahoo.com>
To: Bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-575780547-1141591197=:80365"
Subject: [Bluez-users] Re: socket rev.h
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
Date: Sun, 5 Mar 2006 12:39:57 -0800 (PST)

--0-575780547-1141591197=:80365
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

uname -r
  2.6.12.2
  
  hciattach ttyS0 bcsp 115200
  bcsp initialization timed out
  
  hciattach ttyS0 bcsp 57600
    bcsp initialization timed out
  
  hciattach ttyS0 any
  
  hciconfig
  hci0: type uart
  bd address: 00:00:00:00:00:00 acl mtu: 0:0 sco mtu: 0:0
  down
  <snip>
  
  hciconfig hci0 up
  can't init device hci0: connection timed out (110)
  
		
---------------------------------
Yahoo! Mail
Bring photos to life! New PhotoMail  makes sharing a breeze. 
--0-575780547-1141591197=:80365
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

uname -r<br>  2.6.12.2<br>  <br>  hciattach ttyS0 bcsp 115200<br>  bcsp initialization timed out<br>  <br>  hciattach ttyS0 bcsp 57600<br>    bcsp initialization timed out<br>  <br>  hciattach ttyS0 any<br>  <br>  hciconfig<br>  hci0: type uart<br>  bd address: 00:00:00:00:00:00 acl mtu: 0:0 sco mtu: 0:0<br>  down<br>  &lt;snip&gt;<br>  <br>  hciconfig hci0 up<br>  can't init device hci0: connection timed out (110)<br>  <p>
		<hr size=1>Yahoo! Mail<br>
Bring photos to life! <a href="http://pa.yahoo.com/*http://us.rd.yahoo.com/evt=39174/*http://photomail.mail.yahoo.com">New PhotoMail </a> makes sharing a breeze. 

--0-575780547-1141591197=:80365--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
