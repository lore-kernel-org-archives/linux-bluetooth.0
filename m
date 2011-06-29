Return-Path: <cyrus@holtmann.org>
From: "Li, Steven" <yongli@qca.qualcomm.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
CC: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: Ath3k keeps same PID/VID after downloading
 the patch and radio table
Date: Wed, 29 Jun 2011 06:14:34 +0000
Message-ID: <73DDB75979F36A42B75F3E2B6EB2943401031D2E@nasanexd02c.na.qualcomm.com>
References: <73DDB75979F36A42B75F3E2B6EB2943401031018@nasanexd02c.na.qualcomm.com>
 <1309308687.2208.22.camel@aeonflux>
 <73DDB75979F36A42B75F3E2B6EB2943401031CF1@nasanexd02c.na.qualcomm.com>
 <20110629043130.GA2712@joana>
In-Reply-To: <20110629043130.GA2712@joana>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Padovan:

> -----Original Message-----
> From: Gustavo F. Padovan [mailto:pao@profusion.mobi] On Behalf Of
> Gustavo F. Padovan
> Sent: Wednesday, June 29, 2011 12:32 PM
> To: Li, Steven
> Cc: Marcel Holtmann; linux-bluetooth@vger.kernel.org
> Subject: Re: [PATCH] Bluetooth: Ath3k keeps same PID/VID after
> downloading the patch and radio table
> 
> Hi Steven,
> 
> Please stop messy top postings like this one. It's not allowed on this mailing
> list. Thanks.
> 
> * Li, Steven <yongli@qca.qualcomm.com> [2011-06-29 03:51:03 +0000]:
> 
> > Hi Marcel:
> >
> > > please fix the coding style. It is if[space](.
> > Okay, I see.
> >
> > > I would say something similar in style
> > > to what I have done for the older CSR chips. See workaround above.
> > > And on that note, you could use data->udev to get the usb_device
> > > struct ;)
> > As to this point,  since now we are not using the btusb to download the
> patch and radio table,
> >  I think we do not need to alloc the data struct and use data->udev before
> the workaround.
> > So I'll still keep it was.  How do you think it ?
> 
> No, there is no extra allocation. data->udev is already there. Just use it as
> Marcel said.

There is somehow different with  the older CSR chips.
We need to return -NODEV directly if the bcd version of the 3012 chip is lower or equal to 0x0001,
And I think in such "return -NODEV" case, we totally do not need to alloc the btusb_data.

Thanks,
Best Regards,
Steven,


