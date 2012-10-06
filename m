Return-Path: <cyrus@holtmann.org>
Date: Sat, 6 Oct 2012 09:43:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH BlueZ 1/6] gdbus: Fix up Properties.Set() code path
Message-ID: <20121006074317.GA25765@x220.c.hospitality.swisscom.com>
References: <1349507448-9595-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349507448-9595-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Sat, Oct 06, 2012, Lucas De Marchi wrote:
> Minor fixes to make setter actually work:
> 
> 	- Add propdata in pending_property_set
> 	- Break loop when we are removing propdata from list and we
> 	  found it
> 	- in_args and out_args were swapped
> 	- interface and method name arguments were swapped
> ---
>  gdbus/object.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

All patches from this set have been applied. Thanks.

Johan
