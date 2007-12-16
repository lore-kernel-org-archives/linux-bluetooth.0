Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <8ccc3510712161042v197dbef8i4a4a23a5c7fd0be4@mail.gmail.com>
References: <8ccc3510712161042v197dbef8i4a4a23a5c7fd0be4@mail.gmail.com>
Date: Sun, 16 Dec 2007 20:21:39 +0100
Message-Id: <1197832899.8050.33.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Can't listen on HID control channel:
	Address	already in use
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

Hi,

> everytime I run
> 
> sudo hidd --server
> 
> I have this output.
> 
> I had no problem before, it started when I upgraded my ubuntu to the
> most recent release. Some fedora folks wrote it was a matter of order
> of service startup and I had to make hidd start before bluetooth. But
> there is no script named like "*hidd*" in my /etc/init.d/ directory.
> Have you heard of this problem? Do you know how to solve it? Thanks. 

that is wrong. The newer versions use the input service which replaces
hidd. Check wiki.bluez.org on how to configure you HID device. Or use
the Bluetooth properties dialog from GNOME.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
