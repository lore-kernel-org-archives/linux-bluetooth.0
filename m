Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Hardware Error event patch
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.33.0503251434430.12451-100000@horus.imag.fr>
References: <Pine.GSO.4.33.0503251434430.12451-100000@horus.imag.fr>
Content-Type: text/plain
Message-Id: <1111837626.9195.176.camel@pegasus>
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
Date: Sat, 26 Mar 2005 12:47:06 +0100

Hi Catalin,

> I've finished the patch for handling the Hardware Error event and you have
> it attached below.
> 
> To briefly remind the context: when H4 (HCI over UART) is used
> as the transport layer between the host and the Bluetooth controller
> and the controller detects a loss of synchronization, it sends a
> "Hardware Error" event to the host, which should then send a "Reset"
> command for resynchronization. The procedure is described under "Error
> Recovery" in the H:4 appendix of Bluetooth v1.1 specification.

the EXPORT_SYMBOL is not needed and check the tab versus spaces thing. I
think that also a hci_req_cancel() is needed.

> The patch mainly follows your suggested steps for resetting the stack
> state (a reset of the acl_cnt and sco_cnt was missing).

I don't like to do that via a command. Simply reset them.

> There is only one thing that's not quite right in that patch: I'm enabling
> page and inquiry scanning after the reset. That's because on my hardware
> after the reset it disables page and inquiry scanning. The specification
> (v1.1) says that after a reset the controller reverts to the default
> values of configuration parameters (for Scan_Enable that default value is
> "no scans"). I don't think we maintain the state of Scan_Enable in the stack
> although we could (of course, we can't do anything if the Write Scan Enable
> command is issued directly from userspace with hci_send_cmd). It probably
> makes more sense to remove that Write Scan Enable command.

You will find the current state in hdev->flags. However I am not sure
who should take care of setting it again. Maybe we should send a reset
notification to the userspace.

> The Bluetooth module in the HP PocketPC iPAQ h5550 is very buggy as you
> can see. It turns out that going into "no scan" mode improves stability by
> quite a lot (instead of hw error events occuring immediately, they occur
> after some hours of testing, if at all). In fact, the Widcomm stack under
> Windows CE on this machine appears to do two things:
> 
> 1. Whenever a connection is established it goes into non-discoverable,
> non-connectable mode.
> 2. Whenever a connection is ongoing, it refuses to open a second
> connection to another device.
> 
> So basically it's limiting the user to one connection at a time.

That is a crazy thing to do and actually I think the chip itself is
totally broken if you need to use such procedure.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
