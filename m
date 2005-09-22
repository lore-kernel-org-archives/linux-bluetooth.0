Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid D-Bus patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05092105492fce2ff2@mail.gmail.com>
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <1127292701.495.11.camel@localhost.localdomain>
	 <e1effdeb05092105492fce2ff2@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1127398647.5344.24.camel@blade>
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
Date: Thu, 22 Sep 2005 16:17:27 +0200

Hi Claudio,

> I will analize our comments.
> 
> service_table_t and the function create_error_reply_message will be
> shared by other profiles(pan, hid, rfcomm, ...)
> this the reason to put in the dbus-internal.h file. 

if this is shared code then I like to have it in the common/ toplevel
directory. We should create the files dbus.[ch] and then use them from
there.

> Regarding the Bluetooth error codes, we can add the code in the D-Bus
> error messages as a argument. My proposal
> is use a standard like this:
> 
> org.bluez.hci.error.UnknowMethod
> org.bluez.hci.error.WrongSignature
> org.bluez.hci.error.WrongParam
> org.bluez.hci.error.Failed  /* here we can add the bluetooth error
> code */
> org.bluez.hci.error.Busy
> org.bluez.hci.error.NoDevFound
> 
> I will send a new path soon.

So a D-Bus error is always a method? I would simply use a general error
with an identifier number. Help me out here to understand what is the
best way to represent the errors.

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
