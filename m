Return-Path: <charles@bueche.ch>
Date: Fri, 5 Mar 2004 13:18:33 +0100
From: Charles Bueche <charles@bueche.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: steven.singer@csr.com, bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] First HCI command sent to a device
Message-Id: <20040305131833.3bf6803f.charles@bueche.ch>
In-Reply-To: <1078415736.5347.62.camel@pegasus>
References: <1078411850.5347.43.camel@pegasus>
	<404749F3.9090006@csr.com>
	<1078415736.5347.62.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 04 Mar 2004 16:55:36 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Steven,
> 
> > Sending an HCI_Reset to a CSR device running firmware earlier than
> > 12.0 will cause the device to perform a full system reset. This
> > means that the host transport will be reset (USB devices will drop
> > off the bus and reattach, BCSP devices will need to perform link
> > establishment) and it means that settings will be reloaded from
> > persistent store (so the baud rate will reset).
> > 
> > Firmware version 12.0 and later are better behaved and will reset
> > all the LM and LC settings (drop all links etc.) but leave the host
> > transport up and running.
> 
> thanks for reminding me. I thought the reason was some of the Ericsson
> ROK's that had a problem, but in fact the old CSR firmware don't likes
> this command ;)
> 
> The i-Tec dongle needs the HCI_Reset command to switch from HID to HCI
> mode and I don't wanna break support for the old CSR firmware, because
> some of my dongles and some iPAQ's still run HCI 11.x or younger. How
> do we solve this?

Hi.

I haven't looked at the code so my idea will probably be unusable, but
how about maintaining a list of which dongles don't like the reset and
send it only to the other ones ?

Or reversing the test, only sending a reset to the dongles that need
it.

Of course, it implies that you can identify the device *before* deciding
on your action.

AFAIK, there is a similar "black-list" of controllers in the IDE layer
of Linux to decide on the supported features..

Charles

-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer
