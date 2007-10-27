Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <ec2bd4d50710260607y3d03d774h982915ed9f2f5dda@mail.gmail.com>
References: <ec2bd4d50710231042h3fd2cf9bod90e25fdc65fbfe3@mail.gmail.com>
	<1193352665.6184.295.camel@violet>
	<ec2bd4d50710251938j6617bd7dq931aefa5086ea868@mail.gmail.com>
	<1193372316.6184.331.camel@violet>
	<ec2bd4d50710260607y3d03d774h982915ed9f2f5dda@mail.gmail.com>
Date: Sat, 27 Oct 2007 12:26:30 +0200
Message-Id: <1193480790.4416.14.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Bluez-Gnome applet 'pair' function
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi George,

> > > > > I am using the bluez-gnome applet; I've tried both the 'official' and
> > > > > Gnome:Community versions - where is the option to pair a new device?
> > > > > I'm trying to pair my Logitech BT mouse.
> > > >
> > > > a Bluetooth mouse will not be paired according to the specification. How
> > > > do you wanna enter the pin code? With morse code and the mouse
> > > > buttons ;)
> > >
> > > Why reply with sarcasm?  Don't you know that BT devices that dont
> > > accept user input have the default code of 0000?
> >
> > if you would read the HID specification, then you would see that it
> > explicitly says that mice don't pair with the host.
> >
> > Also there is no relation between the 0000 pin code and not having user
> > input. That 90% of all devices do it this way, doesn't make it a
> > standard and no way it makes it secure. A default pin code (no matter
> > what it is) doesn't give you a useful authentication and hence no useful
> > encryption either.
>
> Are you saying that there's no way to use a BT mouse with
> Suse10.3/Gnome?  If you're not saying that then please tell me how to
> do it.

of course there is, but that is a different topic. You were talking
about pairing a mouse. Not making a mouse work. Check the BlueZ wiki
pages on how to make a input device work.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
