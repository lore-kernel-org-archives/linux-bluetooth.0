Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Mar 2015 14:04:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
Subject: Re: [PATCH ] monitor: Add AVDTP support to btmon
Message-ID: <20150320120459.GA20347@t440s.ger.corp.intel.com>
References: <1426851395-29076-1-git-send-email-bharat.panda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426851395-29076-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Fri, Mar 20, 2015, Bharat Panda wrote:
> +static char *pt2str(uint8_t hdr)

This should be static const char *

> +static char *mt2str(uint8_t hdr)

Same here.

> +static char *sig2str(uint8_t tsid)

And here.

Johan
