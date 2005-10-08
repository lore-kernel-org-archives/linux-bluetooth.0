Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Jumpy cursor with Wacom Graphire Bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20051008142318.GB954@polar.elf12.net>
References: <20051008132533.GA954@polar.elf12.net>
	 <1128778167.5212.8.camel@blade>  <20051008142318.GB954@polar.elf12.net>
Content-Type: text/plain
Message-Id: <1128783693.5212.12.camel@blade>
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
Date: Sat, 08 Oct 2005 17:01:33 +0200

Hi Robert,

> > > hcidump is telling me that my tablet sends packets only after six pixels
> > > of mouse movement or together with button events. - I suppose that some
> > > parameters exchanged during connection handshake are the cause.
> > > 
> > > -Who is making the connectinon? (hidp kernel module?)
> > > -Who can/could influence it's outcome? (hidd userspace daemon? Plays
> > >  hcid an important role?)
> > > -Has the latency thing something to do with it?
> > > -Which spec should I first dig into - Bluetooth or HID?
> > 
> > try again with patch-2.6.13-mh1 to add report mode protocol support.
> 
> I definitly will try it, but I belong to that kind of people who like to
> understand. (-:

check the USB HID specification for the difference between boot protocol
and report protocol mode.

> The Wacom people told me that it should work perfect as a simple HID
> device. What will report mode do?

I think it will at least improve it, because devices in boot protocol
mode are very limited.

> And to refine my other questios: when and where in the communication
> scheme do hidp and hidd jump into the boat?

HIDP is the protocol for HID over Bluetooth and this is handles inside
the kernel. The hidd handles the lower level L2CAP connections for it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
