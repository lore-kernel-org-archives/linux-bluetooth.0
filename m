Return-Path: <cyrus@holtmann.org>
Message-ID: <1329468286.28848.137.camel@aeonflux>
Subject: Re: [RFC 1/4] Bluetooth: Prepare start_discovery
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 09:44:46 +0100
In-Reply-To: <CACJA=fXw2Dx2bWE-=GKhmJKBTKK3NvNWjTqATSLvi2xgFi0m1A@mail.gmail.com>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
	 <1329429041-30715-2-git-send-email-andre.guedes@openbossa.org>
	 <20120216221526.GA4446@x220.ger.corp.intel.com>
	 <CACJA=fXw2Dx2bWE-=GKhmJKBTKK3NvNWjTqATSLvi2xgFi0m1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> > On Thu, Feb 16, 2012, Andre Guedes wrote:
> >> +#define DISCOV_TYPE_BREDR            (BIT(0))
> >> +#define DISCOV_TYPE_LE                       (BIT(1) | BIT(2))
> >> +#define DISCOV_TYPE_INTERLEAVED              (BIT(0) | BIT(1) | BIT(2))
> >
> > Defining these like this looks a bit (no pun intended) odd. The previous
> > code was at least using the mgmt defs instead of magic numbers (which is
> > how these values have been originally chosen too).
> 
> Do you think this would be better?
> 
> +#define DISCOV_TYPE_BREDR            (BIT(MGMT_ADDR_BREDR))
> +#define DISCOV_TYPE_LE               (BIT(MGMT_ADDR_LE_PUBLIC) |
> BIT(MGMT_ADDR_LE_RANDOM))
> +#define DISCOV_TYPE_INTERLEAVED      (BIT(MGMT_ADDR_BREDR) |
> BIT(MGMT_ADDR_LE_PUBLIC) | \
> +
> BIT(MGMT_ADDR_LE_RANDOM))

even while I already acked the previous patch, this is a bit better.

Regards

Marcel


