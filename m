Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 12:14:05 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Send new missed calls count once
Message-ID: <20110614091405.GC31529@dell.ger.corp.intel.com>
References: <1308034791-3290-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308034791-3290-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Tue, Jun 14, 2011, Slawomir Bochenski wrote:
> Change introduced by commit b0619290e4128bb583268bfbfbb66de9a30ecf7c
> prevented calling count query multiple times when getting the phone book
> in parts. However value of newmissedcalls was kept between calls to
> phonebook_pull_read() resulting in adding application parameters header
> multiple times.
> ---
>  plugins/phonebook-tracker.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
> index 80dfc02..d396203 100644
> --- a/plugins/phonebook-tracker.c
> +++ b/plugins/phonebook-tracker.c
> @@ -1551,6 +1551,8 @@ int phonebook_pull_read(void *request)
>  	if (!data)
>  		return -ENOENT;
>  
> +	data->newmissedcalls = 0;
> +
>  	if (g_strcmp0(data->req_name,"/telecom/mch.vcf") == 0 &&
>  						data->tracker_index == 0) {
>  		/* new missed calls amount should be counted only once - it

Shouldn't this be added inside the first if-statement branch instead of
affecting the whole function? It seems to me that only the first branch
deals with new missed calls.

Johan
