Return-Path: <cyrus@holtmann.org>
From: "Keren, Doron" <doronkeren@ti.com>
To: victor yeo <victoryeo1974@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: BT LMP
Date: Thu, 5 Jul 2012 08:25:19 +0000
Message-ID: <2DC28D85CE3B364AB56B408582B25C8E18E38E2A@DNCE04.ent.ti.com>
References: <CADX0rsZBM+2Sz564FrkVxe318dCFue_pea_OLpxvrk5bd9cHWQ@mail.gmail.com>
	<1341472848.1963.34.camel@aeonflux>
 <CADX0rsYksswwWK-4-UYXt_k7squWeCFhwK18=mDAZ=P6L1-zVw@mail.gmail.com>
In-Reply-To: <CADX0rsYksswwWK-4-UYXt_k7squWeCFhwK18=mDAZ=P6L1-zVw@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Victor,

The LMP not_accepted event will lead to Authentication failure.
Some devices will then initiate disconnection with error code :
Authentication Failure error code (0x05).

Thanks,
Doron Keren
Texas Instruments

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of victor yeo
> Sent: Thursday, July 05, 2012 10:43 AM
> To: Marcel Holtmann
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: BT LMP
> 
> Hi Marcel,
> 
> When LMP_not_accepted is received by Bluetooth Chip's firmware, it
> will send a HCI event to the linux kernel bluetooth portion. Do i
> understand correctly? What is the HCI event name?
> 
> Thanks,
> Victor
> 
> On Thu, Jul 5, 2012 at 3:20 PM, Marcel Holtmann <marcel@holtmann.org>
> wrote:
> > Hi Victor,
> >
> >> Anyone know which part of linux kernel processes the LMP au_rand and
> >> LMP not_accepted event?
> >>
> >> I want to modify the Bluetooth kernel code so that when it receives
> >> LMP not_accepted event, it will do re-pairing.
> >
> > LMP is implemented in the Bluetooth chip's firmware and not the kernel.
> >
> > Regards
> >
> > Marcel
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
