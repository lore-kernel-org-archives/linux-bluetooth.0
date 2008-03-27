Return-Path: <cyrus@holtmann.org>
Message-Id: <B970CA2C-B007-4DD6-BBA7-5B9A81828C1A@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <003901c8900a$a282e860$6701a8c0@freqonedev>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 27 Mar 2008 16:03:36 +0100
References: <003901c8900a$a282e860$6701a8c0@freqonedev>
Subject: Re: [Bluez-devel] TODO: --enable/--disable options in bluez-utils
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi David,

> Subsequent to yesterday's post, I found all of the configure options  
> to enable/disable various options.
>
> In my application, I have no real need (at this point, at least) for  
> audio streaming, and I might like to diable -gstreamer, -alsa, and  
> similar options.  Probably would also disable -serial and certain  
> other profiles.
>
> And there are other things, like --enable-usb, which if I disable it  
> might turn off my USB-connected Bluetooth dongle.

I will not. It is only needed for using libusb.

> However, at this point I am using --enable-all, since there is no  
> real documentation of the dependencies.  Any chance these might be  
> documented: with 27 options, that's about 268 million permutations,  
> which would take a while to figure out...

A lot of these options will go away when we hit 4.0, but feel free to  
start a wiki page and start documenting them.

Regards

Marcel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
