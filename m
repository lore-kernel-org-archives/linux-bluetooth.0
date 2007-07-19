Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 19 Jul 2007 08:23:25 -0700 (PDT)
From: Robert Schmidt <itsmy_emale@yahoo.com>
To: Bluez User <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <624812.65481.qm@web38507.mail.mud.yahoo.com>
Subject: [Bluez-users] Frequency hopping(channel)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0682899025=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0682899025==
Content-Type: multipart/alternative; boundary="0-837798558-1184858605=:65481"
Content-Transfer-Encoding: 8bit

--0-837798558-1184858605=:65481
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

I have one question to the folks in Bluez group. I saw that we have to specify channel for L2CAP and RFCOMM connections:

struct sockaddr_rc rfcommclient = { 0 };

rfcommclient.rc_channel = channel;

Since Bluetooth uses frequency hopping and hops from one channel to another what is the need to specify this field??

Also, I see that throughout the L2CAP or RFCOMM connections it shows the same PSM value(one we specify for the channel) in the hcidump.

Does that mean no hopping is taking place ??

I am sorry if its a silly question but expecting an answer ??

thanks

robert.


       
---------------------------------
Choose the right car based on your needs.  Check out Yahoo! Autos new Car Finder tool.
--0-837798558-1184858605=:65481
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,<br><br>I have one question to the folks in Bluez group. I saw that we have to specify channel for L2CAP and RFCOMM connections:<br><br>struct sockaddr_rc rfcommclient = { 0 };<br><br>rfcommclient.rc_channel = channel;<br><br>Since Bluetooth uses frequency hopping and hops from one channel to another what is the need to specify this field??<br><br>Also, I see that throughout the L2CAP or RFCOMM connections it shows the same PSM value(one we specify for the channel) in the hcidump.<br><br>Does that mean no hopping is taking place ??<br><br>I am sorry if its a silly question but expecting an answer ??<br><br>thanks<br><br>robert.<br><br><p>&#32;
      <hr size=1>Choose the right car based on your needs.  
Check out <a href="http://us.rd.yahoo.com/evt=48518/*http://autos.yahoo.com/carfinder/;_ylc=X3oDMTE3NWsyMDd2BF9TAzk3MTA3MDc2BHNlYwNtYWlsdGFncwRzbGsDY2FyLWZpbmRlcg-- ">Yahoo! Autos new Car Finder tool.</a>

--0-837798558-1184858605=:65481--


--===============0682899025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0682899025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0682899025==--
