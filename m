Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 11:31:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] Bluetooth: Update mgmt_read_info and related mgmt
 messages
Message-ID: <20111215093109.GA18059@x220>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
 <1323899524-13653-2-git-send-email-johan.hedberg@gmail.com>
 <20111215090245.GC15283@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111215090245.GC15283@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Dec 15, 2011, Andrei Emeltchenko wrote:
> > +#define MGMT_SETTING_POWERED		0x00000001
> > +#define MGMT_SETTING_CONNECTABLE	0x00000002
> > +#define MGMT_SETTING_FAST_CONNECTABLE	0x00000004
> > +#define MGMT_SETTING_DISCOVERABLE	0x00000008
> > +#define MGMT_SETTING_PAIRABLE		0x00000010
> > +#define MGMT_SETTING_LINK_SECURITY	0x00000020
> > +#define MGMT_SETTING_SSP		0x00000040
> > +#define MGMT_SETTING_BREDR		0x00000080
> > +#define MGMT_SETTING_HS			0x00000100
> > +#define MGMT_SETTING_LE			0x00000200
> 
> Just a minor comment.
> Can we use set_bit style for the defines above?

I was considering it, but the set_bit/test_bit functions expect pointers
to unsigned long whereas we're dealing with a fixed-size u32 in the mgmt
protocol. In the best case that'd require adding type-casts to avoid
compiler warnings/errors and in the worst case it could even cause bugs
on some architectures.

Johan
