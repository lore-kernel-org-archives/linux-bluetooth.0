Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid D-Bus patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05091607426f824afa@mail.gmail.com>
References: <e1effdeb05091607426f824afa@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1127292701.495.11.camel@localhost.localdomain>
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
Date: Wed, 21 Sep 2005 10:51:41 +0200

Hi Claudio,

> I am sending the initial patch that implementing the skeleton
> of the hcid D-Bus services.
> 
> Run hcid with a non-daemon option to see the output
> 
> Send the following messages to see the message handling.
> 
> dbus-send --system --type=method_call --dest=org.bluez /org/bluez/hci
> org.bluez.hci.PeriodicInqReq byte:1 byte:2 byte:3
> dbus-send --system --type=method_call --dest=org.bluez /org/bluez/hci
> org.bluez.hci.CancelPeriodicInqReq
> dbus-send --system --type=method_call --dest=org.bluez /org/bluez/hci
> org.bluez.hci.InquiryReq byte:1
> dbus-send --system --type=method_call --dest=org.bluez /org/bluez/hci
> org.bluez.hci.RoleSwitchReq string:panu byte:1
> 
> Suggestions are welcome!

I am not complete through all the changes yet, because the last week was
quite busy. However for what do we need a dbus-internal.h? I don't see
any need for it and it would be great if everything is inside dbus.h. If
we reach the level where stuff gets more generic and can also be reused
by pand etc. then we should think about moving it into the common/
toplevel directory. The same applies for common.c. For now simply put
into dbus.c and resend the patch.

I am not happy with EXEC_RESULT. We should simply use an uint32 for it
and then reuse the Bluetooth error codes and define some special ones
for us. The enum is the wrong choice here.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
