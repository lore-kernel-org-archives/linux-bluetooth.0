Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20060824221125.35372.qmail@web61218.mail.yahoo.com>
Date: Thu, 24 Aug 2006 15:11:25 -0700 (PDT)
From: deva seetharam <tagsense@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] sensing client timeout/disconnect
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1475227941=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1475227941==
Content-Type: multipart/alternative; boundary="0-1233301669-1156457485=:35096"
Content-Transfer-Encoding: 8bit

--0-1233301669-1156457485=:35096
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


greetings!
i have developed an application that opens an rfcomm socket and waits for messages from bluetooth remote control devices. the application needs to know when the client disconnects (for example, when the remote control is taken out of the range). 

i see that hcidump prints a timeout message when the client is not heard for a while. i am wondering whether there is a signal/mechanism for the client app to know that the device has disconnected or timedout. 

pls. let me know.

thanks in advance,
david


 		
---------------------------------
Yahoo! Messenger with Voice. Make PC-to-Phone Calls to the US (and 30+ countries) for 2¢/min or less.
--0-1233301669-1156457485=:35096
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<br>greetings!<br>i have developed an application that opens an rfcomm socket and waits for messages from bluetooth remote control devices. the application needs to know when the client disconnects (for example, when the remote control is taken out of the range). <br><br>i see that hcidump prints a timeout message when the client is not heard for a while. i am wondering whether there is a signal/mechanism for the client app to know that the device has disconnected or timedout. <br><br>pls. let me know.<br><br>thanks in advance,<br>david<br><br><p>&#32;
		<hr size=1>Yahoo! Messenger with Voice. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman1/*http://us.rd.yahoo.com/evt=39663/*http://voice.yahoo.com">Make PC-to-Phone Calls</a> to the US (and 30+ countries) for 2¢/min or less.
--0-1233301669-1156457485=:35096--


--===============1475227941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1475227941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1475227941==--
