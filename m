Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Krisztian Mark Szentes <office@produktivIT.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bt3c_cs time out - no firmware loaded? - problem
	persists.
References: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
	<5.1.0.14.2.20030512132833.0d19d8a0@unixmail.qualcomm.com>
In-Reply-To: <5.1.0.14.2.20030512132833.0d19d8a0@unixmail.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200305130316.56691.office@produktivIT.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 13 May 2003 03:16:56 +0200

On Monday 12 May 2003 22:29, Max Krasnyansky wrote:
> At 06:43 AM 5/8/2003, Krisztian Mark Szentes wrote:
> >May  8 15:02:20 tomcat cardmgr[1071]: socket 0: 3Com Bluetooth PC Card
> >May  8 15:02:20 tomcat cardmgr[1071]: executing: 'modprobe bt3c_cs'
> >May  8 15:02:21 tomcat hcid[1428]: HCI dev 0 registered
> >May  8 15:02:31 tomcat hcid[1616]: Can't init device hci0. Connection
> > timed out(110)
>
> Hmm, you should see bluefw messages before HCI dev 0 registered.
> I guess you'd need to ping Marcel on that one.

I observed cardmgr to cause a line
cardmgr[xxx]: executing: 'modprobe bt3c_cs' line

I deleted the /sbin/bluefw symlink to /usr/sbin/bluefw to see if it gets 
invoked, which gives:
bt3c_cs: Failed to exec "/sbin/bluefw pccard 03f8".

in /proc/ioports bt3c_cs shows up at 000003f8-000003ff

if I manually call /usb/sbin/bluefw pccard 03f8 it gives no error; but it 
does not touch the /etc/bluetooth/firmware/BT3CPCC.bin file either.
I tried the bluez-bluefw both in version 1.0-1 and 0.9-2 (powerpc) and 
compiled 1.0 from source, but the firmware still does not even get 
touched, let alone loaded. And I get no bluefw messages in syslog.


Any hints?

Mark

P.S. The /sbin/bluefw symlink is not included in the Debian packages but 
the kernel module loads this and not /usr/sbin/bluefw.
-- 
produktivIT   -  Open-Source Solution Provider
Siebenbrunnengasse 55/7
A-1050 Wien



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
