Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS PATCH] scan mode timeout
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602150611s60763bb4u6362fd401cafd4ba@mail.gmail.com>
References: <e1effdeb0602150611s60763bb4u6362fd401cafd4ba@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1140013222.26072.80.camel@localhost>
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
Date: Wed, 15 Feb 2006 15:20:22 +0100

Hi Claudio,

> Here is the first proposal to support the discoverable timeout.
> 
> Current behaviour:
> * it's using SIGALARM. We can try integrate in the main loop in the future..
> * the scan mode is changed automatically to connectable mode after 3 min
> * multiple local adapters are handled: there are separated timers.
> * scan mode changes requested by other applications(hciconfig and
> other dbus clients) are monitored too.
> 
> 
> Some points to things about:
> * bluez_timeout_add consider the function handler and the user data to
> compare if it's necessary update or add new timer. Is this approach
> acceptable?
> * Is it necessary handle race condition when updating the timeout array?
> * 8 positions to timeout handler are enough?
> 
> Any comments?

maybe you wanna separate the {Set|Get}DiscoverableTimeout code, because
this is obviously correct and would apply right away.

Using an array of 8 handles is actually not enough. Even if no sane
person would ever attach more than 8 dongles, but I might do ;)

However you need at least to support HCI_MAX_DEV from hci.h and this is
currently 16 adapters. Remember that the kernel will still accept more
than 16 device, but the userspace simply can't handle them (except you
recompile the Bluetooth library).

Do we have a function to iterate over the registered device paths and
retrieve their hci_dbus_data structures? If yes, then I would prefer to
include everything from timeout_settings there and use it.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
