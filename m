Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Catalin Drula <catalin.drula@imag.fr>
Message-ID: <loom.20050330T204115-646@post.gmane.org>
References: <Pine.GSO.4.33.0503251434430.12451-100000@horus.imag.fr>  <42498E15.9000409@csr.com> <1112117413.9016.98.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Re: Hardware Error event patch
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
Date: Wed, 30 Mar 2005 19:01:46 +0000 (UTC)

Hi Marcel & Steven,

Marcel Holtmann <marcel <at> holtmann.org> writes:
 
> > > I've finished the patch for handling the Hardware Error event and you have
> > > it attached below.
> > > 
> > > To briefly remind the context: when H4 (HCI over UART) is used
> > > as the transport layer between the host and the Bluetooth controller
> > > and the controller detects a loss of synchronization, it sends a
> > > "Hardware Error" event to the host, which should then send a "Reset"
> > > command for resynchronization. The procedure is described under "Error
> > > Recovery" in the H:4 appendix of Bluetooth v1.1 specification.
> > 
> > Are you resetting for all hardware error events, or just when you think
> > that H4 synchronisation has been lost?
> > 
> > It is true that the spec says that a device will issue a hardware error
> > when synchronisation is lost but it doesn't say that that's the only
> > reason for a device to issue a hardware error.
> > 
> > CSR devices, for example, use hardware error code 0xFE to mean that H4
> > synchronisation has been lost. Other hardware error events mean other
> > things and HCI_Reset is not the appropriate action in all cases. In some
> > cases no action is required. In other cases user intervention will be
> > needed to clear the error and we'll emit a hardware error on every boot
> > until the problem is resolved. A few cases will require a harder reset
> > than an HCI_Reset.
> > 
> > You probably don't want to reset if you receive a hardware error and
> > you were not using the H4 host transport.
> 
> thanks for the information. You are making a good point here. However
> the error code is another weird vendor specific thing in the Bluetooth
> specification. Proposals on how to deal with it are very welcome.

Steven is clearly right, but I don't see how we could deal with the
vendor-specific code. The Bluetooth chip in the iPAQ h5550 (RTX Telecom, but in
fact rumour has it that it's a National Semiconductor LMX 9814) uses code 0x01
for H4 loss of synchronization. It would not be feasible to use these
vendor-specific codes, on the one hand because they are not (or not always)
publicly available, and on the other hand it would be overkill to match the
vendor string and hardware error codes anyway.

I would however argue that we do need to take action in case of a loss of
synchronization and that this patch is needed. I agree that this is one of the
things that "should not happen" (the UART should be error free), but it so
happens that so many devices on the market have these loss of sync problems, and
it would drastically improve their useability to have the stack recover properly
from a loss of synchronization. 

I suggest we do what Steven said and only perform our recovery procedure
if H4 is being used. That definitely makes sense. As for the other reasons a
hardware error event might arise (when using H4)... well, first of all, I
suppose that 99.99% of times it is a loss of synchronization causing the event,
and second, in the remaining 0.01%, I doubt sending a reset would hurt. 

By the way, Marcel I'll fix my patch up, according to your suggestions (and with
the modification that we only perform the procedure when H4 is the host
transport), but it will another couple of days.

Regards,

Catalin



-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
