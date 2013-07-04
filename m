Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 4 Jul 2013 14:49:11 +0200
Message-ID: <CANT-zCV0wkAZhVwaVo1Xb0Ch+zKiWHqOpHHyBn1PE+Giq43HTw@mail.gmail.com>
Subject: Multiple SCOs over USB
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

It's been a while since we detected and reported issues related to
multi-SCO support in the kernel. Although being quite unstable, it's
currently working but it does require carefully setting the SCO MTU
size.

We currently don't have time to research on this further but below you
can find the observed behavior, in case someone wants to dig into the
issue and improve the kernel support for this feature.

With one single SCO, everything works quite ok. Without any special
setup, using BlueZ 4.101, PulseAudio 4.0 and a 3.10 kernel, SCO
packets of size 48 bytes are exchanged over HCI.

> SCO data: handle 50 flags 0x00 dlen 48
> SCO data: handle 50 flags 0x00 dlen 48
< SCO data: handle 50 flags 0x00 dlen 48
< SCO data: handle 50 flags 0x00 dlen 48

This setup is widely used and seems to be quite stable, with the SCO
MTU set to 48 by default.

Enabling the kernel traces for btusb.c shows the following messages:

[ 3323.433728] [1187] btusb_send_frame:716: hci0
[ 3323.433744] [1187] __fill_isoc_descriptor:499: len 51 mtu 17
[ 3323.433761] [1187] btusb_send_frame:716: hci0
[ 3323.433770] [1187] __fill_isoc_descriptor:499: len 51 mtu 17
[ 3323.433778] [1187] btusb_send_frame:716: hci0
[ 3323.433783] [1187] __fill_isoc_descriptor:499: len 51 mtu 17
[ 3323.433791] [1187] btusb_send_frame:716: hci0
[ 3323.433797] [1187] __fill_isoc_descriptor:499: len 51 mtu 17
[ 3323.434308] <intr> btusb_isoc_tx_complete:600: hci0 urb
ffff8801a54e1c00 status 0 count 51
[ 3323.437309] <intr> btusb_isoc_tx_complete:600: hci0 urb
ffff8801a54e0c00 status 0 count 51
[ 3323.440310] <intr> btusb_isoc_tx_complete:600: hci0 urb
ffff8801a6654200 status 0 count 51
[ 3323.443314] <intr> btusb_isoc_tx_complete:600: hci0 urb
ffff8801a6655a00 status 0 count 51
[ 3323.443328] <intr> btusb_isoc_complete:455: hci0 urb
ffff8801a048ae00 status 0 count 170

Everything looks good here.

If you look closer and the MTU sizes and do some math, you'll realize
that the size of the SCO packet (48 bytes + 3 header bytes = 51 bytes
in total) is a multiple of the USB MTU size (17 bytes). Whether this
is a fortunate coincidence or not, I can't tell. In any case, it just
works.

However, when two SCOs exist, the setup becomes much more unstable,
sometimes leading to the adapter automatically powering down.

Prior to any issue, hcidump shows the following:

> SCO data: handle 49 flags 0x00 dlen 96
< SCO data: handle 49 flags 0x00 dlen 48
< SCO data: handle 50 flags 0x00 dlen 48
< SCO data: handle 50 flags 0x00 dlen 48
< SCO data: handle 49 flags 0x00 dlen 48
< SCO data: handle 49 flags 0x00 dlen 48
< SCO data: handle 49 flags 0x00 dlen 48
> SCO data: handle 50 flags 0x00 dlen 96
> SCO data: handle 49 flags 0x00 dlen 96

For some (unknown) reason, the adapter decides to use an MTU of 96
bytes as soon as (and while) a second SCO exists. This behavior has
been observed with different adapters from different manufacturers.

My best guess to explain this number is that the adapter tries to
maximize the usage of the USB frames. If we repeat the maths above,
the MTU sizes are again multiple of each other: 96 bytes payload + 3
header bytes = 99 bytes which is multiple of the USB MTU size (now 33,
see below). This is a wild guess though.

The kernel traces:

[ 3472.202296] [1186] btusb_send_frame:716: hci0
[ 3472.202309] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
[ 3472.202327] [1186] btusb_send_frame:716: hci0
[ 3472.202336] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
[ 3472.202350] [1186] btusb_send_frame:716: hci0
[ 3472.202357] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
[ 3472.202371] [1186] btusb_send_frame:716: hci0
[ 3472.202379] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
[ 3472.202390] [1186] btusb_send_frame:716: hci0
[ 3472.202399] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
[ 3472.202413] [1186] btusb_send_frame:716: hci0
[ 3472.202421] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
[ 3472.202432] Bluetooth: hci0 urb ffff8801a558b600 submission failed (27)
[ 3472.202735] [1186] btusb_send_frame:716: hci0
[ 3472.202750] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
[ 3472.202766] Bluetooth: hci0 urb ffff8801ac960800 submission failed (27)
[ 3472.202777] [1186] btusb_send_frame:716: hci0
[ 3472.202785] [1186] __fill_isoc_descriptor:499: len 51 mtu 33
[ 3472.202799] Bluetooth: hci0 urb ffff8801ac960800 submission failed (27)
[ 3472.202879] <intr> btusb_isoc_tx_complete:600: hci0 urb
ffff88019d55ba00 status 0 count 51
[ 3472.204880] <intr> btusb_isoc_tx_complete:600: hci0 urb
ffff8801a6634a00 status 0 count 51
[ 3472.206927] <intr> btusb_isoc_tx_complete:600: hci0 urb
ffff8801a04f3600 status 0 count 51
[ 3472.208927] <intr> btusb_isoc_tx_complete:600: hci0 urb
ffff8801ac9a5c00 status 0 count 51
[ 3472.210937] <intr> btusb_isoc_tx_complete:600: hci0 urb
ffff8801e17e8400 status 0 count 51
[ 3472.211940] <intr> btusb_isoc_complete:455: hci0 urb
ffff8801a54e1c00 status 0 count 330

This is logged in a loop, where the EFBIG (27) error always repeats.
According to URB.txt, it means "Too many requested ISO frames".

One thing I could point to is the fact that the USB packets are not
"filled" to their maximum size. In order to send an SCO packet of size
48 (51, including header), two USB frames need to be sent with sizes
33 (MTU) and 18 bytes. In this second frame, 15 bytes are "wasted".
Again, whether this is the root cause or not or even relevant at all,
I can't tell.

As stated before, the adapter sometimes degenerates to very strange
behavior, automatically powering down in the worst case.

Interestingly enough, setting the SCO socket MTU to 96 bytes (and a
patch in PulseAudio [1] to send packets of this size) solves the
problem. In this case, the result is:

> SCO data: handle 51 flags 0x00 dlen 96
> SCO data: handle 46 flags 0x00 dlen 96
> SCO data: handle 51 flags 0x00 dlen 96
> SCO data: handle 46 flags 0x00 dlen 96
< SCO data: handle 51 flags 0x00 dlen 96
< SCO data: handle 46 flags 0x00 dlen 96
< SCO data: handle 46 flags 0x00 dlen 96
< SCO data: handle 51 flags 0x00 dlen 96

And the kernel:

[ 6167.182690] [1186] btusb_send_frame:716: hci0
[ 6167.182702] [1186] __fill_isoc_descriptor:499: len 99 mtu 33
[ 6167.182893] [1186] btusb_send_frame:716: hci0
[ 6167.182896] [1186] __fill_isoc_descriptor:499: len 99 mtu 33
[ 6167.182934] [1186] btusb_send_frame:716: hci0
[ 6167.182937] [1186] __fill_isoc_descriptor:499: len 99 mtu 33
[ 6167.182988] [1186] btusb_send_frame:716: hci0
[ 6167.182991] [1186] __fill_isoc_descriptor:499: len 99 mtu 33
[ 6167.183296] <intr> btusb_isoc_tx_complete:600: hci0 urb
ffff88018aab3e00 status 0 count 99
[ 6167.186293] <intr> btusb_isoc_tx_complete:600: hci0 urb
ffff88018aab3000 status 0 count 99
[ 6167.189293] <intr> btusb_isoc_tx_complete:600: hci0 urb
ffff88018aab0c00 status 0 count 99
[ 6167.192294] <intr> btusb_isoc_tx_complete:600: hci0 urb
ffff88018aab2c00 status 0 count 99
[ 6167.192301] <intr> btusb_isoc_complete:455: hci0 urb
ffff88018f9b4200 status 0 count 330

As you can see, no errors reported in btusb.c when the SCO MTU is 96.

Why exactly this is happening? Unfortunately I have no answer to this
except for the ideas mentioned above. We currently don't have
resources to work on this further, so I'm sending this results in case
someone has the time and interest to closely look at this.

Cheers,
Mikel

[1] http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/16128
