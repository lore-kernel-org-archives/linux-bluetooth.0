Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Use hci_recv_stream_fragment() in UART
 driver
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <20100724044856.GB9787@vigoh>
References: <1279946817-18060-1-git-send-email-gustavo@padovan.org>
	 <20100724044856.GB9787@vigoh>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 25 Jul 2010 11:43:22 -0700
Message-ID: <1280083402.2621.25.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > Use the new hci_recv_stream_fragment() to reassembly incoming UART
> > streams.
> > 
> > Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> > ---
> >  drivers/bluetooth/hci_h4.c |  103 +-------------------------------------------
> >  1 files changed, 2 insertions(+), 101 deletions(-)
> > 
> 
> Please, can someone test this code? I don't have such UART hardware to
> make sure that this patch is working.

I think that Johan or Claudio can test this easily with their LE dongles
since they only talk H4 anyway.

Regards

Marcel


