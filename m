Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <7b9ca310608071427nb9b9d28u86251148f66d7bac@mail.gmail.com>
Date: Mon, 7 Aug 2006 17:27:41 -0400
From: "Michael Ellis" <michael.f.ellis@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] dbus-1.pc not found
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1884724212=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1884724212==
Content-Type: multipart/alternative;
	boundary="----=_Part_209823_27055757.1154986061638"

------=_Part_209823_27055757.1154986061638
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Apologies if this has already been discussed, but I've searched on Google
and Gmane and haven't found anything that seems to fit exactly.

Trying to configure bluez-utils-3.2 on slackware 10.1 with a 2.6.11 kernel,
I get

checking for DBUS... Package dbus-1 was not found in the pkg-config search
path.
Perhaps you should add the directory containing `dbus-1.pc'
to the PKG_CONFIG_PATH environment variable
No package 'dbus-1' found
configure: error: dbus > 0.35 is required

Installing dbus-0.91, apparently successfully, does not cure the error.  Is
there something I needed to do other than the usual ./configure;  make;
sudo make install?  My dbus executables were installed in /usr/local/bin.

I also tried building bluez-utils-3.2 with  ./configure --disable-dbus.  No
effect, same error.  FWIW, I'm using the FCE4 desktop rather than Gnome or
KDE. I mention this because I get the impression the need for dbus is
typically associated with Desktop support.

 I very much need to get bluez-utils working for simple serial comm to an
embedded device and could care less about GUIs.  What's the most
straightforward way get past this hurdle?
Thanks,
Mike Ellis

------=_Part_209823_27055757.1154986061638
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Apologies if this has already been discussed, but I've searched on
Google and Gmane and haven't found anything that seems to fit exactly.<br>
<br>
Trying to configure bluez-utils-3.2 on slackware 10.1 with a 2.6.11 kernel,&nbsp; I get&nbsp;  <br>
<br clear="all">checking for DBUS... Package dbus-1 was not found in the pkg-config search path.<br>
Perhaps you should add the directory containing `dbus-1.pc'<br>
to the PKG_CONFIG_PATH environment variable<br>
No package 'dbus-1' found<br>
configure: error: dbus &gt; 0.35 is required<br>
<br>
Installing dbus-0.91, apparently successfully, does not cure the
error.&nbsp; Is there something I needed to do other than the usual
./configure;&nbsp; make;&nbsp; sudo make install?&nbsp; My dbus
executables were installed in /usr/local/bin.<br>
<br>
I also tried building bluez-utils-3.2 with&nbsp; ./configure
--disable-dbus.&nbsp; No effect, same error.&nbsp; FWIW, I'm using the
FCE4 desktop rather than Gnome or KDE. I mention this because I get the
impression the need for dbus is typically associated with Desktop
support. &nbsp; <br>
<br>
&nbsp;I very much need to get bluez-utils working for simple serial
comm to an embedded device and could care less about GUIs.&nbsp; What's
the most straightforward way get past this hurdle?&nbsp; <br>
Thanks,<br>
Mike Ellis<br>
<br>
<br>
<br><br>

------=_Part_209823_27055757.1154986061638--


--===============1884724212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1884724212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1884724212==--
