Return-Path: <hdegoede@redhat.com>
Subject: Re: RTL8723BS bluetooth almost working with serdev enumeration, need
 help
From: Hans de Goede <hdegoede@redhat.com>
To: Jeremy Cline <jcline@redhat.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-acpi <linux-acpi@vger.kernel.org>
References: <208ad44f-ade6-5f27-47f1-7fe012be1bdc@redhat.com>
Message-ID: <bd04fc51-ba64-c759-377c-de71b89dfc57@redhat.com>
Date: Sun, 27 May 2018 20:48:34 +0200
MIME-Version: 1.0
In-Reply-To: <208ad44f-ade6-5f27-47f1-7fe012be1bdc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

Doing a top-level reply here because
my mail client did not save a copy of
my last mail to my send folder for some reason.

Here is what I wrote in that mail:

"""

I noticed the following statement in hci_h5.c:

        BT_DBG("hu %p retransmitting %u pkts", hu, h5->unack.qlen);

So on a hunch I changed that to a dev_warn, and it triggers
in the scenario where bt3wire is not working. Which is
weird because AFAICT that means the controller actually
dropped a packet, even though we are doing flow-control,
which is a bit unexpected, so maybe the flow control is
not the (only?) problem and we also need to add retry
logic to resend unacked packets like hci_h5.c has...


It seems that the H5 protocol / code is a bit complicated
and somewhat tricky / finicky to get right, so I'm not
sure doing a second implementation is a good idea.

I know that now that we've serdev enumeration you eventually
want to get rid of the hci_uart man in the middle and
bt3wire.c is moving in that direction.

But IMHO since this is tricky code I do believe that
adding serdev support to hci_h5.c (which we won't be
able to remove for a while) is if not better certainly
easier (and uses well tested code). So I gave this a shot:

https://github.com/jwrdegoede/linux-sunxi/commit/e71884d8f7ffd75fbe7bd381c26d64b7a13bd361

As you can see adding basic serdev support takes only
40 lines and it works well.

I know this is not the direction you want to go in
but I believe that this is the right way for now,
rather then doing 2 implementations.

I know the hci_bcm code is a mess but that is because
of historic reasons with the ACPI integration being
in place while using hciattach from userspace. As
you can see the hci_h5.c serdev integration is
quite clean and only needs a tiny amount of code.

We of-course also need to add vendor specific init
to load the firmware, etc. to hci_h5.c for this to
work, but that is no different then using bt3wire.c
where we need the same.

I actually ended up porting Jeremy's patches to add
vendor specific init to bt3wire.c pretty much 1:1 to
hci_h5.c and now I have a setup which works, see:

https://github.com/jwrdegoede/linux-sunxi/commits/master

This is currently lacking GPIO support, so it won't work
unless you poke the enable and device-wake GPIOs through
sysfs. I plan to add GPIO support tomorrow, run some more
tests and then post this series upstream.

"""

Unfortunately I hit a hard to solve problem, which
took me most of Friday + the entire weekend to figure
out. The problem as that the device would not come
back up properly after a suspend/resume or after
a "rfkill block bluetooth" + rfkill unblock bluetooth".

The problem turns out to be the RTL8723BS not liking
being reset after a power-off / not liking the
HCI_QUIRK_RESET_ON_CLOSE quirk which the hci_uart code
sets by default. I already tried not setting that
quirk yesterday, but then the device would not init
properly.

The trick turns out to be using HCI_UART_RESET_ON_INIT +
a msleep(10). With that in place everything seems to
work well. So I'm going to submit the promised series
now.

Regards,

Hans
