Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: =?iso-8859-1?Q?H=E5kan_Lager?= <digiloo.data@telia.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Mon, 13 Nov 2006 18:08:01 +0100
Message-ID: <006001c70746$476c1800$0200a8c0@BLACKBIRD>
MIME-Version: 1.0
In-Reply-To: <1163405780.26272.38.camel@localhost>
Subject: Re: [Bluez-users] Problem with 2nd second dongle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Marcel,

Thank you for your concern.

Here is the information you requested:

Nov 13 16:56:00 ts7200 daemon.info hcid[214]: Bluetooth HCI daemon
Nov 13 16:56:00 ts7200 daemon.info sdpd[217]: Bluetooth SDP daemon
Nov 13 16:57:50 ts7200 daemon.info hcid[214]: HCI dev 0 registered
Nov 13 16:57:50 ts7200 daemon.info hcid[214]: HCI dev 0 up
Nov 13 16:57:50 ts7200 daemon.info hcid[214]: Starting security manager 0
Nov 13 16:57:50 ts7200 daemon.info hcid[214]: HCI dev 0 down
Nov 13 16:57:50 ts7200 daemon.info hcid[214]: Stoping security manager 0
Nov 13 16:57:51 ts7200 daemon.info hcid[214]: HCI dev 0 unregistered
Nov 13 16:57:51 ts7200 daemon.info hcid[214]: HCI dev 0 registered
Nov 13 16:57:51 ts7200 daemon.info hcid[214]: HCI dev 0 up
Nov 13 16:57:51 ts7200 daemon.info hcid[214]: Starting security manager 0
Nov 13 16:58:05 ts7200 daemon.info hcid[214]: HCI dev 1 registered
Nov 13 16:58:15 ts7200 daemon.err hcid[252]: Can't init device hci1:
Connection timed out (110)

$ ls /proc/bus/usb/devices
ls: /proc/bus/usb/devices: No such file or directory
$ ls /proc/devices
/proc/devices
$ cat /proc/devices
Character devices:
  1 mem
  2 pty/m%d
  3 pty/s%d
  4 tts/%d
  5 cua/%d
  7 vcs
 10 misc
 29 fb
 90 mtd
128 ptm
129 ptm
130 ptm
131 ptm
136 pts/%d
137 pts/%d
138 pts/%d
139 pts/%d
162 raw
180 usb
204 ttyAM%d
205 cuaam%d
216 bluetooth/rfcomm/%d
234 ttyTS%d
235 cuats%d

Block devices:
  1 ramdisk
  8 sd
 31 mtdblock
 65 sd
 66 sd
$

-----Ursprungligt meddelande-----
Fr=E5n: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] F=F6r Marcel Holtmann
Skickat: den 13 november 2006 09:16
Till: BlueZ users
=C4mne: Re: [Bluez-users] Problem with 2nd second dongle

Hi Hakan,

> I'm facing the following problem on a TS-7200 board. The board is
> equipped with the standard TS-linux (debian) release =

> and by loading the proper modules I'm able to use a single bluetooth
> dongle.
> =

> But when I plug another dongle into the 2nd USB port I'm unable to
> make it work.
>  =

> The only way to bring it up is to make
> =

> hciconfig hci0 down
> and then
> hciconfig hci1 up
> and then it works.
>  =

> But I'm only able to operate a single BT dongle at a time. On my
> development machine (redhat) everything works fine.

show us the content of /proc/bus/usb/devices and check the syslog for
any error messages.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job
easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
