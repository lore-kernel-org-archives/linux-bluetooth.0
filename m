Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] dbus.c: cleanup/fix method parameter
	getting
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051105124837.GA27883@localhost.localdomain>
References: <20051105124837.GA27883@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1131313209.5824.4.camel@blade>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 06 Nov 2005 22:40:09 +0100

Hi Johan,

> These patches have the following changes:
> 
> 1. Return the right error if a matching handler is not found in the
> device message handler function. Eduardo said he would fix it in his
> next patch, but I think it's good to get the fix in as soon as possible.
> 
> 2. Change a couple of places which use DBusMessageIter to use
> dbus_message_get_args instead (just one function call and removes the
> need to have the DBusMessageIter variable).
> 
> 3. Use uint16 instead of uint8 for periodic inquiry period length
> parameters (since they are two octets each in the HCI spec).
> 
> 4. Fix checking for the range of inquiry parameters (HCI spec says
> length 0x01-0x30 and num_resp 0x00-0xFF).
> 
> The range checking for periodic inquiry and role switch should probably
> also be fixed at some point. However, the controller should return an
> error if invalid values are passed to it, so I'm not even sure that it
> should be hcid's task to check them. What do you think?
> 
> Another thing with the inquiry and periodic inquiry methods is that the
> inquiry method allows the caller to specify the num_responses parameter
> while the periodic inquiry method has it hardcoded to 100 currently.
> Should the parameter also be added to periodic inquiry or should it be
> removed from normal inquiry?
> 
> The reason why I'm submitting the changes in two patches is that there's
> currently a bug[1] in the python dbus bindings which prevents uint16
> values from being sent. The fix will probably go to the next dbus
> release but we may want to wait for it before applying the change at our
> end.

I decided to take both patches and hopefully the D-Bus Python support
will be fixed soon. However I applied another cleanup after your patches
that fixes some weird coding that ends up in unnecessary deep indented
lines. Please use this style for any loops and make use of labels for
the exit path in functions.

What do you think about using also tabs in dbus-test?

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
