Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Dec 2014 20:48:36 -0800
From: Tristan Lelong <tristan@lelong.xyz>
To: linux-bluetooth@vger.kernel.org
Subject: BCSP line discipline
Message-ID: <20141211044836.GA21771@dunderer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I worked on a BCSP application recently and did a few kernel modification.

I was wondering how valid they were compared to the bluez userland stack, and what could eventually be contributed back.
I already get a few patches that I could cleanup and submit if it makes sense.

1) Implement BCSP link establisment protocol in kernel land.
I was surprised to actually see this in the bluez userland stack while this could be done in the hci_bcsp file along with bcsp ack handling and bcsp retransmittion (there is actually a function that is half implemented for this). Is there a technical reason to keep it userland?
This patch also handle clean reset of the link if a SYNC packet is ever received, resetting the stats, and sending an -EPIPE error to all the socket previously opened on their next read/write/... operation.

2) Add the configurable TX window size option in Kconfig rather than static kernel define. Simple and straight forward, but can be usefull.

3) Add an address to hci devices at init time when doing the hci_alloc_dev. This address is statically generated: 00:XX:54:54:79:XX (TTYX) where X is the tty minor number.
I might be missing something here, but I didn't find a way to assign an address to a HCI device, and this makes it impossible to then use the hci interface.

4) Prevent new HCI socket buffers to be sent in the TX queue if the TX window is full.
This will allow preventing the send of an infinite number of buffers if the BCSP link is stalling.

Let me know your thought about this, and I can work on cleaning up those patches for submission

Thanks
