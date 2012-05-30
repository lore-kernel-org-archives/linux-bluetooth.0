Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 May 2012 10:48:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: joohi.rastogi@stericsson.com
Cc: User Name <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Sets the information attribute for the service
Message-ID: <20120530074813.GG6539@x220>
References: <1338273973-28767-1-git-send-email-joohi.rastogi@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338273973-28767-1-git-send-email-joohi.rastogi@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joohi,

On Tue, May 29, 2012, joohi.rastogi@stericsson.com wrote:
> From: Joohi Rastogi <joohi.rastogi@stericsson.com>
> 
> This patch adds the service name for
> Device Identification Profile
> ---
>  src/sdpd-service.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/src/sdpd-service.c b/src/sdpd-service.c
> index 39e05ab..1fa82a6 100644
> --- a/src/sdpd-service.c
> +++ b/src/sdpd-service.c
> @@ -228,6 +228,8 @@ void register_device_id(void)
>  	source_data = sdp_data_alloc(SDP_UINT16, &main_opts.did_source);
>  	sdp_attr_add(record, 0x0205, source_data);
>  
> +	sdp_set_info_attr(record, "Device Identification", 0, 0);
> +
>  	update_db_timestamp();

0 is an integer, NULL is a pointer. The function call you're adding
doesn't take any integer arguments so you should be passing NULL and not
0.

That said, I can't find any mention of the service name attribute in the
Device ID specification (version 1.3). In fact the table (8.1 on page
17) that lists all mandatory and optional attributes doesn't even have
this attribute mentioned as an optional one. So why do you need to have
it added? Is there some client that breaks if it's not present?

Johan
