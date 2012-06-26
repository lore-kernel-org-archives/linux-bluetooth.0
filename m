Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jun 2012 08:33:19 -0700
From: Gustavo Padovan <gustavo@padovan.org>
To: Anton Weber <ant@antweb.me>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] monitor: Fix optstring to parse -b parameter
Message-ID: <20120626153319.GB4206@joana>
References: <1339760580-8219-1-git-send-email-ant@antweb.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339760580-8219-1-git-send-email-ant@antweb.me>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anton,

* Anton Weber <ant@antweb.me> [2012-06-15 13:43:00 +0200]:

> Without the colon getopt ignores the parameter and optarg is always NULL.
> ---
>  monitor/main.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/monitor/main.c b/monitor/main.c
> index 90e32c5..0b8ae30 100644
> --- a/monitor/main.c
> +++ b/monitor/main.c
> @@ -73,7 +73,7 @@ int main(int argc, char *argv[])
>  	for (;;) {
>  		int opt;
>  
> -		opt = getopt_long(argc, argv, "bvh", main_options, NULL);
> +		opt = getopt_long(argc, argv, "b:vh", main_options, NULL);
>  		if (opt < 0)
>  			break;

Ack.

	Gustavo
