Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 Nov 2011 14:35:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix mgmt response when adapter goes down or
 is removed
Message-ID: <20111103123551.GA16065@fusion.localdomain>
References: <1320317931-15260-1-git-send-email-johan.hedberg@gmail.com>
 <20111103123159.GA16087@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111103123159.GA16087@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Nov 03, 2011, Andrei Emeltchenko wrote:
> > @@ -1956,6 +1964,10 @@ int mgmt_index_added(u16 index)
> >  
> >  int mgmt_index_removed(u16 index)
> >  {
> > +	uint8_t status = ENODEV;
> 
> Does it make sense to mix type naming here and below? (u8, u16, uint8_t, uint16_t)

No, it doesn't make sense. It should be u8, u16, etc. This is just my
strong user-space background shining through. Will send a v2 in a
minute.

Johan
