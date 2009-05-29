Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 May 2009 16:20:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: alokbarsode@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Alok Barsode <alok.barsode@azingo.com>
Subject: Re: [PATCH 1/1] Adding start_discovery functionality to hciops
	plugin.
Message-ID: <20090529132046.GA10997@jh-x301>
References: <1243601080-27314-1-git-send-email-alok.barsode@azingo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1243601080-27314-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

One minor comment:

On Fri, May 29, 2009, alokbarsode@gmail.com wrote:
> +static int hciops_start_discovery(int index, gboolean periodic)
> +{
> +	inquiry_cp inq_cp;
> +	periodic_inquiry_cp cp;

Put these two variables into the if-else statement since that's the only
place where they are used. Otherwise the patch looks pretty good.

Johan
