Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 10 Feb 2007 01:16:53 +0100
From: Michael Mauch <michael.mauch@gmx.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070210001653.GE18643@elmicha>
References: <45CA05A6.5000808@gmail.com>
	<20070207102742.gs40wgg8coc4048w@www.webmail4.com>
	<45CA1BE6.5040907@pracucci.com> <45CA257C.9020904@gmail.com>
	<5b9417770702071127t4dcc7835h2e860b7992e2bb0c@mail.gmail.com>
	<45CA29F7.6070607@gmail.com>
	<5b9417770702071206t733f7c64s966c9249f7eadf28@mail.gmail.com>
	<45CA47A8.5000109@gmail.com>
MIME-Version: 1.0
In-Reply-To: <45CA47A8.5000109@gmail.com>
Subject: Re: [Bluez-users] Is this list dead? Here is my problem...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Xamindar wrote:

> John H. wrote:
> > Yes, it looks as though you do.  Can you do a regular rfcomm connect?
> > What if you use rfcomm1?
> >   
> What is a regular rfcomm connect?  On the console it just gives me errors.
> 
> white-rabbit xamindar # rfcomm
> rfcomm1: 00:12:56:5A:92:59 channel 8 clean
> white-rabbit xamindar # rfcomm connect 1
> Can't create RFCOMM TTY: Address already in use
> white-rabbit xamindar #

You don't want to use "rfcomm connect". You already bound channel 8 on
your phone to /dev/rfcomm1 (probably in rfcomm.conf). That means that
rfcommd is waiting for a program that uses /dev/rfcomm1 like a serial
device.

Just use /dev/rfcomm1 with minicom and try sending some "AT" commands to
your phone, like "ATI", "ATI1" and so on.

In case you're not familiar with minicom: start "minicom -s rfcomm1" and
change the "Serial port setup" -> "Serial Device" to /dev/rfcomm1.
"Save setup as rfcomm1" and "exit from Minicom".

Now start "minicom rfcomm1". If your phone is too slow answering
bluetooth connection and minicom says "cannot open /dev/rfcomm1", just
try it again and again a few times.

If that works, use wvdial, kppp, gkdial or networkmanager to connect
using /dev/rfcomm1 (instead of /dev/modem, /dev/ttyS0).

Regards...
		Michael

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
