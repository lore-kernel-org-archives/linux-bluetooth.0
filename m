Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Aug 2014 12:19:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 4/5] monitor: Handle default switch case
Message-ID: <20140813091913.GA19215@t440s.lan>
References: <20140812090449.GA18519@t440s.ger.corp.intel.com>
 <1407847596-14781-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1407847596-14781-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407847596-14781-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Aug 12, 2014, Andrei Emeltchenko wrote:
> Fixes issues with junk packets.
> ---
>  monitor/analyze.c | 3 +++
>  1 file changed, 3 insertions(+)

I've applied the four other patches, but there's a small fix needed for
this one:

> +		default:
> +			fprintf(stderr, "Wrong opcode %u", opcode);
> +			goto done;

Seems like you've forgotten a \n at the end of the string.

Johan
