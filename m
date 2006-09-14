Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20609132122ue951876kcdfaacae30110f66@mail.gmail.com>
Date: Thu, 14 Sep 2006 12:22:16 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: Bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] About concurrency sdp_connect
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0022002730=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0022002730==
Content-Type: multipart/alternative;
	boundary="----=_Part_122582_27895988.1158207736443"

------=_Part_122582_27895988.1158207736443
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In my program, I have several concurrent threads to do sdp_connect. Here,
each thead tries to connect to one device while, only one dongle is used.
I find that if the amount of concurrency threads is large, all threads will
time out.
As we all know, sdp use L2cap connection. can't we create concurrent sdp
connections?
Wait for your nice help ;)
-- 
With respects,
   Mingfan.Lu

------=_Part_122582_27895988.1158207736443
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>In my program, I have several concurrent threads to&nbsp;do sdp_connect. Here, each thead tries to connect to one device while, only one dongle is&nbsp;used.</div>
<div>I find that if the amount of concurrency&nbsp;threads is large, all threads will time out.&nbsp;</div>
<div>As we all know, sdp use L2cap connection. can't we&nbsp;create concurrent sdp connections?<br clear="all"></div>
<div>Wait for your nice help ;)<br>-- <br>With respects,<br>&nbsp;&nbsp; Mingfan.Lu </div>

------=_Part_122582_27895988.1158207736443--


--===============0022002730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0022002730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0022002730==--
