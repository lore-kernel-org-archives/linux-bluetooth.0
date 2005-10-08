Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Robert Siemer <Robert.Siemer@backsla.sh>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Jumpy cursor with Wacom Graphire Bluetooth
Message-ID: <20051008163032.GC954@polar.elf12.net>
References: <20051008132533.GA954@polar.elf12.net> <1128778167.5212.8.camel@blade> <20051008142318.GB954@polar.elf12.net> <1128783693.5212.12.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1128783693.5212.12.camel@blade>
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
Date: Sat, 8 Oct 2005 18:30:32 +0200

On Sat, Oct 08, 2005 at 05:01:33PM +0200, Marcel Holtmann wrote:
> Hi Robert,
> 
> > > > hcidump is telling me that my tablet sends packets only after six pixels
> > > > of mouse movement or together with button events. - I suppose that some
> > > > parameters exchanged during connection handshake are the cause.
> > > > 
> > > > -Who is making the connectinon? (hidp kernel module?)
> > > > -Who can/could influence it's outcome? (hidd userspace daemon? Plays
> > > >  hcid an important role?)
> > > > -Has the latency thing something to do with it?
> > > > -Which spec should I first dig into - Bluetooth or HID?
> > > 
> > > try again with patch-2.6.13-mh1 to add report mode protocol support.
> > 
> > I definitly will try it, but I belong to that kind of people who like to
> > understand. (-:
> 
> check the USB HID specification for the difference between boot protocol
> and report protocol mode.

Ah. I was aware of the boot protocol and the other. - But I didn't know the
name of the non-boot-protocol mode... (-:

Some time ago I noticed 'hidd --show' telling me being in boot protocol
mode. Also your HID web page sugested patching the kernel for full HID
support. - I did the patching with patch-2.6.12-mh3 and found no serious
HID changes in later patches.

Anyway, hidd isn't any more telling me about being in boot protocol mode:

siemer@panorama:~$ hidd --show
00:13:C2:00:11:2C WACOM Pen Tablet [056a:0081] connected 

> > The Wacom people told me that it should work perfect as a simple HID
> > device. What will report mode do?
> 
> I think it will at least improve it, because devices in boot protocol
> mode are very limited.

Am I wrong thinking my tablet is already working in report mode? - It's
as bad as before.

> > And to refine my other questios: when and where in the communication
> > scheme do hidp and hidd jump into the boat?
> 
> HIDP is the protocol for HID over Bluetooth and this is handles inside
> the kernel. The hidd handles the lower level L2CAP connections for it.

So hidd is responsible of L2CAP MTU and QoS settings and could influence
these during connection establishment?


Bye,
	Robert


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
