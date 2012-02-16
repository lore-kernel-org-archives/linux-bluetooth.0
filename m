Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 00:15:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/4] Bluetooth: Prepare start_discovery
Message-ID: <20120216221526.GA4446@x220.ger.corp.intel.com>
References: <1329429041-30715-1-git-send-email-andre.guedes@openbossa.org>
 <1329429041-30715-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329429041-30715-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, Feb 16, 2012, Andre Guedes wrote:
> +#define DISCOV_TYPE_BREDR		(BIT(0))
> +#define DISCOV_TYPE_LE			(BIT(1) | BIT(2))
> +#define DISCOV_TYPE_INTERLEAVED		(BIT(0) | BIT(1) | BIT(2))

Defining these like this looks a bit (no pun intended) odd. The previous
code was at least using the mgmt defs instead of magic numbers (which is
how these values have been originally chosen too).

Johan
