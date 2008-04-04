Return-Path: <cyrus@holtmann.org>
Message-Id: <B7288477-95BD-40EB-BC12-F78457376787@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080404173913.GA27374@suse.de>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 4 Apr 2008 20:37:45 +0200
References: <16c4cb990804040152m6a6a3eecsc8ff1539cd5df158@mail.gmail.com>
	<16c4cb990804040328i3af92a0x2db7d7297d323d31@mail.gmail.com>
	<20080404133817.GA8298@suse.de> <20080404173913.GA27374@suse.de>
Subject: Re: [Bluez-devel] Loading plugin error
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

Hi Stefan,

>>
>>
>> (enable-all should IIUC include enable-glib, but i used it anyway,  
>> it did not
>> change anything)
>
> This still applies: i gave "--enable-all" and this should, according  
> to the
> configure --help output also enable glib:
> ...
>  --enable-all            enable all extra options below
>  --enable-inotify        enable inotify support
>  --enable-hal            enable HAL support
>  --enable-usb            enable USB support
>  --enable-alsa           enable ALSA support
>  --enable-glib           enable GLib support
>  --enable-gstreamer      enable GStreamer support
> ...
>
> But it didn't.
> Also, IMHO we should refuse to build the plugins if glib is not  
> enabled.
> Unfortunately i know next to nothing about auto$foo, so i have no  
> patch
> handy :-(

it should work with eglib. That is actually a bug if it doesn't. Not  
that I care much since eglib is going away with 4.0, but it is a bug  
within 3.x series.

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
