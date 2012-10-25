Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 14:48:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/6] Bluetooth: mgmt: Add support for switching to LE
 peripheral mode
Message-ID: <20121025114817.GA2197@x220>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
 <1351112996-9597-6-git-send-email-johan.hedberg@gmail.com>
 <20121024221341.GA22764@samus>
 <20121024223635.GA11976@x220.P-661HNU-F1>
 <20121025005842.GB22764@samus>
 <1351130085.1785.84.camel@aeonflux>
 <20121025045605.GB12303@echo>
 <20121025075045.GA22397@x220>
 <CAJdJm_Odk8_8dLjcYw9kfr+CCD0Q0bNgu9duhRo6oKXYAo9cKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJdJm_Odk8_8dLjcYw9kfr+CCD0Q0bNgu9duhRo6oKXYAo9cKA@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Oct 25, 2012, Anderson Lizardo wrote:
> On Thu, Oct 25, 2012 at 3:50 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> > Hi Vinicius,
> >
> > On Thu, Oct 25, 2012, Vinicius Costa Gomes wrote:
> >> So, what information will we use to set the advertising type and the
> >> Flags field in the advertising event (think general/limited
> >> discoverable modes)?
> >
> > Take a look at the create_ad() function in the last patch of this set.
> > Setting the right flags value is really quite simple. The advertising
> > type could be selected in a similar way, i.e. through hdev->dev_flags.
> 
> I don't see any use now, but "actual" LE peripherals allow to use
> directed advertising when for instance, they need to send an ATT
> notification just to a specific device, and not let anyone else
> connect to them. Do you see an easy way of selecting an specific
> device to advertise to?
> 
> The issue here is that once LE Peripheral is enabled, any device can
> connect to you (e.g. other previously bonded devices will for sure
> attempt to reconnect). If you want to be connected by a specific
> device, you need to use directed advertising from the beginning.

This will need some more thinking. We could add a new mgmt command for
that, or if you wanna go crazy why not map this to the L2CAP socket
interface's connect() system call. I.e. if LE GAP is in peripheral mode
instead of doing HCI_LE_Create_Connection or just failing with "not
allowed" a socket connect() would simply trigger directed advertising to
the device in question and deliver the successful connection in the same
way as a central role triggered connect would do (unless we time out
waiting for the remote device to connect). Now that I think of this
second option it actually sounds quite natural and not so crazy after
all :)

> Also is LE advertising re-enabled when a connection is established
> (remember it is disabled automatically by the controller after
> connection is established)? And after an HCI Reset ?

The "after a connection" part is still missing and I'll have that as a
separate patch not to grow the already quite big patch. As for reset,
right now that's only sent when power-cycling the adapter and the HCI
init sequence then takes care of enabling advertising.

Johan
