Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <be976db60606301615j2f7fe75n3ec26ead68ef724a@mail.gmail.com>
Date: Fri, 30 Jun 2006 16:15:19 -0700
From: "Mark S. Townsley" <mstownsley@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] bluetooth protocol question
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0864468796=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0864468796==
Content-Type: multipart/alternative;
	boundary="----=_Part_32746_12051446.1151709319664"

------=_Part_32746_12051446.1151709319664
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I am somewhat new to Bluetooth and Bluez so this may be somewhat of a newbie
question.

I have a bluetooth device that I am trying to write code to work with it on
my Suse box.   In my log
file, I see link_key_request, and then pin_code_request and then
link_key_notify.  All seems successful.
And then after a few minutes I get this line in my system log:

  sdpd[8619]: close_sock:  Read error: Connection timed out

What is sdpd trying to do?  I think there must be something about the
bluetooth protocol that I am missing.
Is sdpd trying to read data out of the device?   Is there a good doc
somewhere I can understand the bluetooth protocol (handshake etc...)

Thanks for any tips.

Mark

------=_Part_32746_12051446.1151709319664
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi <br><br>I am somewhat new to Bluetooth and Bluez so this may be somewhat of a newbie question.<br><br>I have a bluetooth device that I am trying to write code to work with it on my Suse box.&nbsp;&nbsp; In my log<br>file, I see link_key_request, and then pin_code_request and then link_key_notify.&nbsp; All seems successful.
<br>And then after a few minutes I get this line in my system log:<br><br>&nbsp; sdpd[8619]: close_sock:&nbsp; Read error: Connection timed out<br><br>What is sdpd trying to do?&nbsp; I think there must be something about the bluetooth protocol that I am missing.
<br>Is sdpd trying to read data out of the device?&nbsp;&nbsp; Is there a good doc somewhere I can understand the bluetooth protocol (handshake etc...)<br><br>Thanks for any tips.<br><br>Mark<br>

------=_Part_32746_12051446.1151709319664--


--===============0864468796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0864468796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0864468796==--
