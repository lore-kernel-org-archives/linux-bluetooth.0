Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <101bcd760611080146ie8fd149h4240e8ff876cad8a@mail.gmail.com>
References: <101bcd760611080146ie8fd149h4240e8ff876cad8a@mail.gmail.com>
Date: Mon, 13 Nov 2006 09:16:20 +0100
Message-Id: <1163405780.26272.38.camel@localhost>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Hakan,

> I'm facing the following problem on a TS-7200 board. The board is
> equipped with the standard TS-linux (debian)  release 
> and by loading the proper modules I'm able to use a single bluetooth
> dongle.
> 
> But when I plug another dongle into the 2nd USB port I'm unable to
> make it work.
>  
> The only way to bring it up is to make
> 
> hciconfig hci0 down
> and then
> hciconfig hci1 up
> and then it works.
>  
> But I'm only able to operate a single BT dongle at a time. On my
> development machine (redhat) everything works fine.

show us the content of /proc/bus/usb/devices and check the syslog for
any error messages.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
