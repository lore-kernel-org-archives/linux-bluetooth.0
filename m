Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com
References: <1418997054-16603-1-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1418997054-16603-1-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH] profiles/hog: Remove dead code
Date: Wed, 07 Jan 2015 15:25:01 +0530
Message-id: <001501d02a60$02573100$07059300$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Friday, December 19, 2014 7:21 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: d.kasatkin@samsung.com; bharat.panda@samsung.com;
> cpgs@samsung.com; Gowtham Anandha Babu
> Subject: [PATCH] profiles/hog: Remove dead code
> 
> warning: Value stored to 'attrib' is never read
> 		attrib = report->hogdev->attrib;
> 		^        ~~~~~~~~~~~~~~~~~~~~~~
> ---
>  profiles/input/hog.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c index
> fb51663..74351f3 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -221,7 +221,6 @@ static void discover_descriptor_cb(uint8_t status,
> GSList *descs,
>  		switch (desc->uuid16) {
>  		case GATT_CLIENT_CHARAC_CFG_UUID:
>  			report = user_data;
> -			attrib = report->hogdev->attrib;
>  			write_ccc(desc->handle, report);
>  			break;
>  		case GATT_REPORT_REFERENCE:
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

