Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ganapathi Bhat <gbhat@marvell.com>,
	Cathy Luo <cluo@marvell.com>
Subject: RE: [PATCH v10 1/3] Bluetooth: hci_uart: add prepare callbacks to
 hci_uart_proto structure.
Date: Thu, 5 May 2016 15:27:42 +0000
Message-ID: <55b348bd1f384dfaac8d8850127df018@SC-EXCH04.marvell.com>
References: <1462460902-25439-1-git-send-email-akarwar@marvell.com>
 <20160505161906.14267bd0@lxorguk.ukuu.org.uk>
In-Reply-To: <20160505161906.14267bd0@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alan,

> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of One Thousand Gnomes
> Sent: Thursday, May 05, 2016 8:49 PM
> To: Amitkumar Karwar
> Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org;
> Ganapathi Bhat
> Subject: Re: [PATCH v10 1/3] Bluetooth: hci_uart: add prepare callbacks
> to hci_uart_proto structure.
> 
> On Thu, 5 May 2016 08:08:20 -0700
> Amitkumar Karwar <akarwar@marvell.com> wrote:
> 
> > From: Ganapathi Bhat <gbhat@marvell.com>
> >
> > The new callback is used to prepare the device before HCI becomes
> > ready. One can use this to download firmware if the download process
> > doesn't use HCI commands. Also recv_for_prepare callback is introduced
> > for receiving data from devices during prepare phase.
> 
> If your device is not speaking HCI protocol then instead of hackig up
> the HCI ldisc would it not make more sense to have a tiny ldisc for your
> firmware loader instead of adding crap to the fast paths of what is
> currently a clean properly separated out interface ?
> 

Below is the code change. It won't add any overhead for existing receive path. 

-       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+       if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+               if (hu->proto->recv_for_prepare)
+                       hu->proto->recv_for_prepare(hu, data, count);
                return;
+       }

Regards,
Amitkumar
