Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] D-Bus tasks planning
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: Claudio Takahasi <cktakahasi@gmail.com>
In-Reply-To: <e1effdeb0601170535yadd5f6fy93c3a5ea64a8499f@mail.gmail.com>
References: <e1effdeb0601170535yadd5f6fy93c3a5ea64a8499f@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1137505788.28239.18.camel@localhost>
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
Date: Tue, 17 Jan 2006 14:49:48 +0100

Hi Claudio,

> I've just started planning the activities for this year. I would like
> receive feedbacks/comments about the items below. There are some tasks
> suggested and a lot of clouds :)  I consider these tasks essential to
> make the D-Bus services usable and necessary to start the development
> of Network, Serial, HID, ... services over D-Bus.
> 
> * Move hcid to bluetoothd

since I don't wanna use threads, we need a good and safe event loop
implementation that integrates nicely with D-Bus. The one from Glib is
no option.

> * BlueZ SDP D-Bus
>     - How design it?  According with an old discussion, the SDP should
> be implemented inside the bluetoothd completelly, because this gives
> the possibility of SDP record caching. Considering this assumption,
> what are the drawbacks and the side-effects to the current
> applications?

The problem with the current SDP API is that it is blocking and at some
places really horrible. We need an event driven API and if we don't
wanna use threads, we have to rewrite it.

> * Kernel/Userspace communication interface
>     - kernel inquiry cache. At the momment, one important enhancement
> is provide a easy access and non-blocking inquiry operation.
>     - probably this communication interface will be usefull to avoid
> another blocking operations. eg: connection control stuffs.

The first thing is to fully implement the kernel internal security
manager and make the new bluetoothd handle the PIN code and link key
requests/notification send over this new interface.

At the moment we do that all inside hcid in userspace. It works great,
but the code to keep track of new devices etc. is not really what I like
to have in the future. It is actually not bad, but why should we do it
inside the kernel and again outside the kernel. The kernel HCI layer is
already capable of handling all the tasks of tracking HCI message flow.
We only need to define a nice interface to give the userspace access to
this information.

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
