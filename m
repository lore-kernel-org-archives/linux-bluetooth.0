Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Change the for loop to read blutooth clock in MCAP CSP
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <1284709950-5302-1-git-send-email-sancane@gmail.com>
Date: Fri, 17 Sep 2010 08:56:50 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F43E63DF-F78C-403B-B960-F302339BF7C3@signove.com>
References: <1284709950-5302-1-git-send-email-sancane@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sep 17, 2010, at 4:52 AM, Santiago Carot-Nemesio wrote:

> This is only a cosmetic change. Using a do..while loop
> we avoid direct manipulation of counter loop variable
> when error happens reading the BT clock.
> ---
> health/mcap_sync.c |   10 +++++-----
> 1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/health/mcap_sync.c b/health/mcap_sync.c
> index bc1ffcd..78cb163 100644
> --- a/health/mcap_sync.c
> +++ b/health/mcap_sync.c
> @@ -406,18 +406,18 @@ static void initialize_caps(struct mcap_mcl *mcl)
> 
> 	/* Do clock read a number of times and measure latency */
> 	avg = 0;
> -	for (i = 0; i < 20; ++i) {
> +	i = 0;
> +	do {
> 		clock_gettime(CLK, &t1);
> -		if (!read_btclock(mcl, &btclock, &btaccuracy)) {
> -			--i;
> +		if (!read_btclock(mcl, &btclock, &btaccuracy))
> 			continue;
> -		}
> 		clock_gettime(CLK, &t2);
> 
> 		latency = time_us(&t2) - time_us(&t1);
> 		latencies[i] = latency;
> 		avg += latency;
> -	}
> +		i++;
> +	} while (i < 20);
> 	avg /= 20;
> 
> 	/* Calculate deviation */
> -- 
> 1.7.2.3

Looking again now, this (the logic, not the patch) may lead to an infinite loop, if for some reason the clock simply can't be read. One more thing to be fixed.