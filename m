Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH] more cleanup
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: Claudio Takahasi <cktakahasi@gmail.com>
In-Reply-To: <e1effdeb0511030532w61ccb889haee2e766a631f618@mail.gmail.com>
References: <e1effdeb0511030532w61ccb889haee2e766a631f618@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1131026420.6634.26.camel@localhost.localdomain>
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
Date: Thu, 03 Nov 2005 15:00:20 +0100

Hi Claudio,

> Here are some cleanups that I detected when I was reading the last modification.
> 
> 1. Fallback
> I changed the return message when the path is not registered.
> Currently, the dbus-daemon returns the following message: 'Error
> org.freedesktop.DBus.Error.UnknownMethod: Method "Inquiry" with
> signature "yy" on interface "org.bluez.Device" doesn't exist'
> Now it's returning "Unknow D-Bus path when a client sent a message to
> invalid path(the path was unregistered or wrong).
> 
> 2. msg unref
>  It's not necessary check if the message is NULL, this verification is
> already done inside the dbus_message_unref.
> 
> 3. up_adapters removed
> 
> 4. Added some comments
> 
> 5. device path checking
>    It's not necessary check if the message belongs to the device path
> hierarchy because we split the msg_func(msg_func_device and
> msg_func_manager)

I applied the patch, but I don't like the BTADDR_LEN thingy. The size of
BD_ADDR in string representation is always 18 and so do addr[18] inside
the code. That's just fine. Please send me a patch that removes the
BTADDR_LEN stuff and replaces it with 18.

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
