Return-Path: <cyrus@holtmann.org>
Message-ID: <1351018989.1785.46.camel@aeonflux>
Subject: Re: [PATCH 2/7] Bluetooth: mgmt: Restrict BR/EDR settings to
 BR/EDR-only adapters
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 23 Oct 2012 12:03:09 -0700
In-Reply-To: <CAJdJm_PoB=e_pi2gAN4AOn_ETyHz3nDihUy8yu2bthe0+p5cxw@mail.gmail.com>
References: <1351011241-32515-1-git-send-email-johan.hedberg@gmail.com>
	 <1351011241-32515-3-git-send-email-johan.hedberg@gmail.com>
	 <CAJdJm_PoB=e_pi2gAN4AOn_ETyHz3nDihUy8yu2bthe0+p5cxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> > @@ -377,15 +377,15 @@ static u32 get_supported_settings(struct hci_dev *hdev)
> >         u32 settings = 0;
> >
> >         settings |= MGMT_SETTING_POWERED;
> > -       settings |= MGMT_SETTING_CONNECTABLE;
> > -       settings |= MGMT_SETTING_FAST_CONNECTABLE;
> > -       settings |= MGMT_SETTING_DISCOVERABLE;
> >         settings |= MGMT_SETTING_PAIRABLE;
> >
> >         if (lmp_ssp_capable(hdev))
> >                 settings |= MGMT_SETTING_SSP;
> >
> >         if (lmp_bredr_capable(hdev)) {
> > +               settings |= MGMT_SETTING_CONNECTABLE;
> > +               settings |= MGMT_SETTING_FAST_CONNECTABLE;
> > +               settings |= MGMT_SETTING_DISCOVERABLE;
> >                 settings |= MGMT_SETTING_BREDR;
> >                 settings |= MGMT_SETTING_LINK_SECURITY;
> 
> "Discoverable" (at least as a Discovery mode from GAP) is mandatory
> for LE Peripheral role (see page 1698). Same for "Connectable" (see
> page 1706).
> 
> Unless you have other plans to implement this for single mode LE
> peripherals running bluez?

at this moment, we plan to keep LE a bit independent from BR/EDR.

Regards

Marcel


