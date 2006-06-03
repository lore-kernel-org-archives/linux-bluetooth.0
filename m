Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5d12691e0606021931hd95b058u38f464d30af8fd56@mail.gmail.com>
Date: Fri, 2 Jun 2006 21:31:49 -0500
From: "Aaron Miller" <armantic101@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] bluez udev rules for Slackware 10.2
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0167127924=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0167127924==
Content-Type: multipart/alternative;
	boundary="----=_Part_13936_1059105.1149301909630"

------=_Part_13936_1059105.1149301909630
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

First off I have to say I am somewhat of a Linux newbie so I apologize if
this question may seem obvious.

I am trying to get bluetooth working on my Slackware 10.2 and udev does not
seem to be creating any devices for my usb dongle. When I searched google,
all I found in regards to the topic was a recent patch which added some new
files to the source for udev rules.

So I downloaded bluez from the cvs (05/31/2006) and also dbus-0.61 since the
./configure was complaining about missing the headers. After installing
bluez-libs I built bluez-utils as so:

./configure --prefix=/usr/local --sysconfdir=/etc --localstatedir=/var
--enable-all
make
make install DESTDIR=<temporary build directory>

>>From there I went to my build directory and changed the init script to the
Slackware standard (<BuildDIr>/etc/rc.d/rc.bluetooth) and modified the file
a bit to reflect these changes. I then proceeded to build into a
slack-package and installed it to my system.

Now I can run 'sh /etc/rc.d/rc.bluetooth start' just fine and get the
following output:
Starting Bluetooth subsystem: hcid sdpd hidd hid2hci rfcomm.

But still no device from udev.

I didn't see any of the files in the source directory this
patch<http://lists.pld-linux.org/mailman/pipermail/pld-cvs-commit/Week-of-Mon-20060515/105676.html>refers
to, nor did I see any udev rules in my build directory. Did I miss a
step somewhere?

Sorry this is so long, I wans't sure what information was needed so I tried
to be as descriptive as possible.

Thank you for taking the time to read this.
...aaron

------=_Part_13936_1059105.1149301909630
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>First off I have to say I am somewhat of a Linux newbie so I apologize if this question may seem obvious.<br><br>I am trying to get bluetooth working on my Slackware 10.2 and udev does not seem to be creating any devices for my usb dongle. When I searched google, all I found in regards to the topic was a recent patch which added some new files to the source for udev rules.
<br><br>So I downloaded bluez from the cvs (05/31/2006) and also dbus-0.61 since the ./configure was complaining about missing the headers. After installing bluez-libs I built bluez-utils as so:<br><br>./configure --prefix=/usr/local --sysconfdir=/etc --localstatedir=/var --enable-all
<br>make<br>make install DESTDIR=&lt;temporary build directory&gt;<br><br>From there I went to my build directory and changed the init script to the Slackware standard (&lt;BuildDIr&gt;/etc/rc.d/rc.bluetooth) and modified the file a bit to reflect these changes. I then proceeded to build into a slack-package and installed it to my system.
<br><br>Now I can run 'sh /etc/rc.d/rc.bluetooth start' just fine and get the following output:<br>Starting Bluetooth subsystem: hcid sdpd hidd hid2hci rfcomm.<br><br>But still no device from udev. <br><br>I didn't see any of the files in the source directory 
<a href="http://lists.pld-linux.org/mailman/pipermail/pld-cvs-commit/Week-of-Mon-20060515/105676.html">this patch</a>  refers to, nor did I see any udev rules in my build directory. Did I miss a step somewhere?<br><br>Sorry this is so long, I wans't sure what information was needed so I tried to be as descriptive as possible.
<br><br>Thank you for taking the time to read this.<br>...aaron<br><br><br>

------=_Part_13936_1059105.1149301909630--


--===============0167127924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0167127924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0167127924==--
