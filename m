Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH] monitor: Add option to disable SCO packets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180618165739.13126-1-jprvita@endlessm.com>
Date: Mon, 18 Jun 2018 19:50:19 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        =?utf-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Message-Id: <259476D2-706B-4FA2-86DE-3A6BDCC6B7EC@holtmann.org>
References: <20180618165739.13126-1-jprvita@endlessm.com>
To: =?utf-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao Paulo,

> It is difficult to follow anything else happening when a SCO connection
> is active, as the log gets floded with SCO packets. This adds an option
> to disable dumping SCO packets.
> ---
> monitor/main.c   | 9 +++++++--
> monitor/packet.c | 6 ++++--
> monitor/packet.h | 1 +
> 3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/monitor/main.c b/monitor/main.c
> index 5fa87ea3f..6a8618c41 100644
> --- a/monitor/main.c
> +++ b/monitor/main.c
> @@ -70,7 +70,8 @@ static void usage(void)
> 		"\t-V, --vendor <compid>  Set default company identifier\n"
> 		"\t-t, --time             Show time instead of time offset\n"
> 		"\t-T, --date             Show time and date information\n"
> -		"\t-S, --sco              Dump SCO traffic\n"
> +		"\t-N, --no-sco-packets   Do not dump SCO packets\n"
> +		"\t-S, --sco              Dump SCO traffic (without -N)\n”

I am confused. I assumed I made SCO off by default.

Anyhow, I don’t want to see tons of independent options. Since next thing is you tell me that AVDTP media channel is also something you want to filter out. So then we better find a generic way to apply filters and also notifications about “dropped x packets due to filter” kinda hints.

Regards

Marcel

