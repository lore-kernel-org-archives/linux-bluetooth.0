Return-Path: <cyrus@holtmann.org>
Message-ID: <1333647992.16897.13.camel@aeonflux>
Subject: Re: [PATCH v3] Bluetooth: Fix packet type for ESCO Link
From: Marcel Holtmann <marcel@holtmann.org>
To: Hemant Gupta <hemantgupta.ste@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemant.gupta@stericsson.com>
Date: Thu, 05 Apr 2012 10:46:32 -0700
In-Reply-To: <CACj007m7_3B=MiFZHGr9UHu2Fuq0_KOvgM1mhRXStp+se=nvvg@mail.gmail.com>
References: <1333597594-21532-1-git-send-email-hemant.gupta@stericsson.com>
	 <CACj007nwsZumYtKkFcEu2jQa=f7dZJYJ=szXEMVhO0n5goRCjg@mail.gmail.com>
	 <1333642493.16897.7.camel@aeonflux>
	 <CACj007m7_3B=MiFZHGr9UHu2Fuq0_KOvgM1mhRXStp+se=nvvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

> >> > This patch uses the corect packet type for ESCO Link.
> >> > Without this patch esco packet types were anded with ~EDR_ESCO_MASK
> >> > resulting in setting bits that are not supported by controller
> >> > to 0 which means that corresponding EDR ESCO packet type is
> >> > supported(EDR Packet types are inverted as per BT Spec) which might
> >> > not be the case.
> >> >
> >> Any comments on this patch ?
> >
> > as I said before, I like to see a hcidump in the commit messages that
> > shows the failure.
> >
> I am not sure the hcidump would indicate the exact problem, because the problem
> is of selecting wrong eSCO edr pkt type of local device and moreover
> my code base is bit different from upstream code.
> 
> For eg:
> Local Controller supports only 3-EV5, 2-EV5 and 3-EV3 of the EDR eSCO packet
> types and does not support 2-EV3 packet type.
> 
> This would mean that while creating the esco_type in function
> hci_cc_read_local_features()
> the ESCO_2EV3 bit would not be set and all other EDR eSCO bits would be set.
> Resulting hdev->esco_type = 0x0380
> 
> Now in hci_conn_add() when the pkt_type is being calculated for eSCO
> Link, wrong calculation
> would take place as below:
> 
> conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
>                       = 0x0380 & ~0x03C0 = 0x0380 & 0xFC3F = 0x0000
> Since the EDR eSCO bits are invertedThis indicates that ultimately all
> EDR eSCO packet types are supported, which is not correct as local
> controller is not supporting the 2-EV3 packet type.
> 
> As per calculations of the patch
> conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
>                       = 0x0380 ^ 0x03C0 = 0x0040
> which correctly indicates that packet type used excludes the 2-EV3
> packet type not supported by local controller.
> 
> Please let me know your views on this.

this sounds like a really good explanation that should go into the
commit message. Don't you agree?

Regards

Marcel


