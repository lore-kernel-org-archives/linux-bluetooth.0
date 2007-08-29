Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20070829T092645-125@post.gmane.org>
References: <c669a7c70708240036j38c8f42bhdcdb5ee15a8ae4be@mail.gmail.com>
	<1187943850.15402.129.camel@violet>
	<000001c7e74d$e4e21bb0$aea65310$@com>
	<loom.20070829T092645-125@post.gmane.org>
Date: Wed, 29 Aug 2007 10:23:48 +0200
Message-Id: <1188375828.6109.31.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problem in parking device. bluez-libs	3.14,
	bluez-utils-3.14
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

Hi Mahin,

> > > the park mode support is always complicated. I would advise you to not
> > > support it. Especially with non CSR based chips. However you have to run
> > > hcidump -X -V to see what is really going on.
> > 
> > I would echo Marcel's comments. Use of Park Mode is generally discouraged
> > and at some point in the future there's a decent chance that Park Mode will
> > be deprecated.
> > 
> > Because of this, many of the devices that you might try to connect to may
> > support Park Mode but not enable it. You are much better off making sure
> > that Sniff Mode is working -- if your application needs to care.
>
>  I want to use Park mode to connect more than 7 devices at a time.
>  If I use sniff mode than is it possible that I can connect more than 7 devices ..
>  I learned that when we put any link in Park mode, it releases its AM_ADDR (
> Active Address, 3 bit ) and gets a new PM_ADDR ( park Mode address, 8 bit ). so
> now we can use the released AM_ADDR to create a new active link.
>  But in sniff mode link does not release AM_ADDR...
>  So may be we can not use sniff mode to connect more than 7 devices..

you can't use sniff mode to connect more than 7 devices, but that is
almost true for most chips with park mode. If they got park mode right.
See my previous posting. There is a difference between what the
specification says and what is actually implemented by the chip. The
memory is limited and storing 256 parked devices is normally out of
question for these small chips.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
