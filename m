Return-Path: <cyrus@holtmann.org>
Message-ID: <1352935217.20338.21.camel@aeonflux>
Subject: Re: [PATCH v4 11/16] sbc: Add SBC_MSBC flag to enable 15 block
 encoding
From: Marcel Holtmann <marcel@holtmann.org>
To: frederic.dalleau@linux.intel.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 15 Nov 2012 08:20:17 +0900
In-Reply-To: <50A3B9FC.3070009@linux.intel.com>
References: <1351589975-22640-1-git-send-email-frederic.dalleau@linux.intel.com>
	  <1351589975-22640-12-git-send-email-frederic.dalleau@linux.intel.com>
	 <1352904577.20338.10.camel@aeonflux> <50A3B9FC.3070009@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> > I am debating to actually call this SBC_FLAG_MSBC instead of just
> > SBC_MSBC. Anyone any comments?
> 
> The use of the flag may not be the most elegant API. As an alternative,
> maybe we could have a specific function for msbc initialization. Then,
> instead of sbc_init(), sbc_encode() sbc_decode(), we could have
> msbc_init(), sbc_encode(), sbc_decode().
> The biggest advantage is that parameters like bitpool, subbands,
> allocation, and other parts could be specified inside this function
> instead of being given from the application.

we could do an sbc_init_msbc() function.

As this is the only real external visible API change, we need to be 100%
sure with this one.

Regards

Marcel


