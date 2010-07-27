Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Use hci_recv_stream_fragment() in UART
 driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: "ext Gustavo F. Padovan" <gustavo@padovan.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <4C4E9809.2090107@nokia.com>
References: <1279946817-18060-1-git-send-email-gustavo@padovan.org>
	 <4C4E9809.2090107@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 12:35:37 -0700
Message-ID: <1280259337.2621.90.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > Use the new hci_recv_stream_fragment() to reassembly incoming UART
> > streams.
> >
> > Signed-off-by: Gustavo F. Padovan<padovan@profusion.mobi>
> > ---
> 
> I tried with h4 transport over usb serial. Seems to work like earlier.
> 
> Tested-by: Ville Tervo <ville.tervo@nokia.com>

patch has been applied.

Regards

Marcel


