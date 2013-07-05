Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCV0wkAZhVwaVo1Xb0Ch+zKiWHqOpHHyBn1PE+Giq43HTw@mail.gmail.com>
References: <CANT-zCV0wkAZhVwaVo1Xb0Ch+zKiWHqOpHHyBn1PE+Giq43HTw@mail.gmail.com>
Date: Fri, 5 Jul 2013 11:35:11 +0300
Message-ID: <CABBYNZLDku=bYx_tVE3n0WA8NCv+FqmLr8bko1oZNxoYzVBQ1A@mail.gmail.com>
Subject: Re: Multiple SCOs over USB
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Jul 4, 2013 at 3:49 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:

> My best guess to explain this number is that the adapter tries to
> maximize the usage of the USB frames. If we repeat the maths above,
> the MTU sizes are again multiple of each other: 96 bytes payload + 3
> header bytes = 99 bytes which is multiple of the USB MTU size (now 33,
> see below). This is a wild guess though.
>
> The kernel traces:
>
> [ 3472.202296] [1186] btusb_send_frame:716: hci0
> [ 3472.202309] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
> [ 3472.202327] [1186] btusb_send_frame:716: hci0
> [ 3472.202336] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
> [ 3472.202350] [1186] btusb_send_frame:716: hci0
> [ 3472.202357] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
> [ 3472.202371] [1186] btusb_send_frame:716: hci0
> [ 3472.202379] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
> [ 3472.202390] [1186] btusb_send_frame:716: hci0
> [ 3472.202399] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
> [ 3472.202413] [1186] btusb_send_frame:716: hci0
> [ 3472.202421] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
> [ 3472.202432] Bluetooth: hci0 urb ffff8801a558b600 submission failed (27)
> [ 3472.202735] [1186] btusb_send_frame:716: hci0
> [ 3472.202750] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
> [ 3472.202766] Bluetooth: hci0 urb ffff8801ac960800 submission failed (27)
> [ 3472.202777] [1186] btusb_send_frame:716: hci0
> [ 3472.202785] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
> [ 3472.202799] Bluetooth: hci0 urb ffff8801ac960800 submission failed (27)
> [ 3472.202879] <intr> btusb_isoc_tx_complete:600: hci0 urb
> ffff88019d55ba00 status 0 count 51
> [ 3472.204880] <intr> btusb_isoc_tx_complete:600: hci0 urb
> ffff8801a6634a00 status 0 count 51
> [ 3472.206927] <intr> btusb_isoc_tx_complete:600: hci0 urb
> ffff8801a04f3600 status 0 count 51
> [ 3472.208927] <intr> btusb_isoc_tx_complete:600: hci0 urb
> ffff8801ac9a5c00 status 0 count 51
> [ 3472.210937] <intr> btusb_isoc_tx_complete:600: hci0 urb
> ffff8801e17e8400 status 0 count 51
> [ 3472.211940] <intr> btusb_isoc_complete:455: hci0 urb
> ffff8801a54e1c00 status 0 count 330
>
> This is logged in a loop, where the EFBIG (27) error always repeats.
> According to URB.txt, it means "Too many requested ISO frames".
>
> One thing I could point to is the fact that the USB packets are not
> "filled" to their maximum size. In order to send an SCO packet of size
> 48 (51, including header), two USB frames need to be sent with sizes
> 33 (MTU) and 18 bytes. In this second frame, 15 bytes are "wasted".
> Again, whether this is the root cause or not or even relevant at all,
> I can't tell.

I think we should concentrate on -EFBIG problem, Ive grep the code and
it seems there is a couple of places where it could be generated:

host/ehci-sched.c:1457: status = -EFBIG;
if (unlikely(start - base + span - period >= mod)) {
     ehci_dbg(ehci, "request %p would overflow (%u+%u >= %u)\n",
     urb, start - base, span - period, mod);
     status = -EFBIG;
     goto fail;
}

/host/uhci-q.c:1267: return -EFBIG;
* Values must not be too big (could overflow below) */
if (urb->interval >= UHCI_NUMFRAMES ||
                                urb->number_of_packets >= UHCI_NUMFRAMES)
     return -EFBIG;

host/uhci-q.c:1327: return -EFBIG;
/* Make sure we won't have to go too far into the future */
if (uhci_frame_before_eq(uhci->last_iso_frame + UHCI_NUMFRAMES,
                                frame + urb->number_of_packets * urb->interval))
     return -EFBIG;

I suspect it is either 1 or 3 and that indicate that we either are too
fast or because we don't actually fill the URB completely the
subsequent URBs will be added with next interval which is too far into
the future so we would have to start feeding the URBs with data from
multiple SCO connections/skbs. The other option is to update the MTU
so that each connection skb would fill completely the URB, but we need
to some infra to make the driver to announce what is the expected size
so we can read and set in socket.
