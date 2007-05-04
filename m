Return-Path: <ohad@bencohen.org>
Message-ID: <bd5b16740705040630o58f22ddfi39b6399092c1677a@mail.gmail.com>
Date: Fri, 4 May 2007 16:30:06 +0300
From: "Ohad Ben-Cohen" <ohad@bencohen.org>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: [PATCH 2.6.21] Bluetooth: add support for TI's HCILL UART protocol
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <1178261528.25425.38.camel@violet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200704301140.46336.ohad@bencohen.org>
	 <1178261528.25425.38.camel@violet>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

On 5/4/07, Marcel Holtmann <marcel@holtmann.org> wrote:
> please explain the usefulness of HCIUARTGETDEVICE to me.

Most of the initializing commands should be (and thus are) sent normally,
before the new device is added (and notification is sent to hcid).

But, there is one initialization command (deep sleep configuration),
which must be sent _after_ the HCILL protocol is set.

This command is signalling the device that it can start initiating deep sleep.
The device may immediate request to do so, so the HCILL protocol must
already be there to receive this request.

That's why I let hciattach do its HCIUARTSETPROTO, and only then
I send the remaining init commands.

But, at this stage, in order to send commands to the device,
I must use Bluez' sockets interface, and for that I must know the device
number (for hci_open_dev).

In order to be able to easily know the hci device number, I have
added HCIUARTGETDEVICE.

If there's a better way of knowing the hci device number please tell me.

> And the ll_dbg_data() has to go away. On LKML they discussing a generic
> hexdump function. I could accept the usage of that, but no crazy own
> debug routine in the kernel code.

Of course :)
I am aware of Randy's hexdumper, and once it will be merged I will make
use of it.

Thanks,
Ohad.
