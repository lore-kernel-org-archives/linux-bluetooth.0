Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcid D-Bus patch
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05092209516bbcb31a@mail.gmail.com>
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <1127292701.495.11.camel@localhost.localdomain>
	 <e1effdeb05092105492fce2ff2@mail.gmail.com>
	 <1127398647.5344.24.camel@blade>
	 <e1effdeb05092209516bbcb31a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1127411650.12287.15.camel@blade>
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
Date: Thu, 22 Sep 2005 19:54:10 +0200

Hi Claudio,

> Regarding the shared code I will analize the shared functions
> and move to the common directory.
> 
> 
> The D-Bus error is a message created based on a received message.
> There are 4 message types:
> 1. method call message
> 2. method reply message
> 3. error message
> 4. signal
> 
> First of all you have to understand the difference bus name, path and 
> interface. Read
> http://dbus.freedesktop.org/doc/dbus-faq.html#id2778454
> for more information. There is a FAQ with this topic.

this is one of my basic problems with D-Bus and object oriented
programming in general. They try to abstract and solve everything and
this is not working. The reality is always different. We now need to
find a way to make it usable in a sane way.

> After this discussion I would suggest the following structure:
> 
> >>> Message Error Names:
> org.bluez.EFailed
> org.bluez.ENoMemory
> /* open to more error names */
> 
> >>>org.bluez.EFailed
> This error message will have the signature(string+uint16+uint32).
> Where the first argument is the error description. The second is
> the error class and the third is the error code.
> The error class can be system error, D-Bus error or HCI errors.
> This structure mane possible return to the app clients any kind of 
> error. System error includes socket error, IO, ENODEV... D-Bus error
> includes no service, no connection, security error and no method
> found.
> HCI errors are listed in the bluetooth specification.

We have three different categories of errors. The Bluetooth errors
defined in the specification. They are the same for the complete HCI.
Then we have the Unix/Linux error codes (errno) and we will have
additional codes defined by us. I don't like the idea of splitting the
errors into classes. This is confusing and not a nice API. We should
choose a base for the errors and these should be the Bluetooth error
codes defined in the HCI part specification. So for my point of view an
error org.bluez.error with string+uint16 is enough. The range 0x00-0xff
will be used by the Bluetooth errors and we define the rest for specific
errors that are currently not covered by the specification. This means
we have to match the Unix/Linux error codes somehow, but I don't see any
problems with that.

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
