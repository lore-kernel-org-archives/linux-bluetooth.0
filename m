Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech MX900 oddities and solutions
From: Marcel Holtmann <marcel@holtmann.org>
To: fd@cisco.com
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1078912919.32148.356.camel@metal.cisco.com>
References: <1078912919.32148.356.camel@metal.cisco.com>
Content-Type: text/plain
Message-Id: <1078915401.2537.14.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 10 Mar 2004 11:43:21 +0100

Hi Frederic,

> For starters, I patched a stock 2.6.3 Linux kernel with the -mh4 patch,
> then I downloaded and installed bluez-libs2 and bluez-utils2 from CVS in
> order to obtain hid2hci. First problem is that the "compat" tools
> Makefile (including hcitool) needed to be compiled separately. This is
> sad since hcitool is very useful to ensure your hub is really alive.

you can enable it with the --enable-compat switch for configure, but by
default this is not on.

> Second problem is that hid2hci needs to pass multibyte commands to the
> USB-BT hub and the -mh4 patch does not support that. I had to manually
> overpatch the kernel with instructions found here:
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=3803086&forum_id=1883
> 
> I would have expected this patch to be part of -mh4 (that is what I
> remember having read) but it was not there. It should! :-) I can't wait
> to have the patches synced to the 2.6 kernel tree.

I never said that I include the multi-byte patch into -mh4. It seems
that some people assume this, but this is not true. Use diffstat to
check the patch and you will see that it only changes Bluetooth stuff.

However Vojtech Pavlik told me that he will push these patches for
mainline integration.

> Third problem is that hid2hci did not recognize my Logitech hub. Looking
> through the code showed that the vendor/product id's are hardcoded
> (that's fair) but my device was not in the list. Here is an excerpt of
> lsusb:
> 
> Bus 001 Device 009: ID 046d:c705 Logitech, Inc.
>                                ^
>                                |
>      culprit ------------------+
> 
> So I patched hid2hci to recognize 046d:c705 as a Logitech thingy. Beware
> that I bought the mouse in Belgium and there may be more unknown ID's in
> the world wild wireless mess (wireMess?).

I add your device ID to the CVS.

> Well... I stopped and restarted bthid (both versions) a gazillion times
> with various options, disconnected all my wireless stuff at home to rule
> out interferences, re-paired the mouse,... without success; the mouse
> was still jumpy. Until this morning when I compiled hcid (from util2
> compat), launched it and restarted bthid. The mouse movement was super
> fine! I am dumb wrt/ Bluetooth but I did not understand. So I stopped
> hcid and bthid and restarted bthid alone (the Bluez one) and the mouse
> still worked perfectly.
> 
> Sounds like spraying chicken blood on the keyboard or doing the magic
> dance. I am looking for an explanation... what has hcid got to do with
> that ?

If you start the hcid it will modifiy your link policy settings and it
is important that RSWITCH and SNIFF is on.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
