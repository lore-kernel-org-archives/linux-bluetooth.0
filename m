Return-Path: <cyrus@holtmann.org>
Message-ID: <4ABEAB27.9010806@dtsp.co.nz>
Date: Sun, 27 Sep 2009 13:00:39 +1300
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] init and extra checking fixups
References: <200909261237.58379.sgrubb@redhat.com>
In-Reply-To: <200909261237.58379.sgrubb@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Steve Grubb wrote:
> In tools/hcitool.c, around line 687, handle could conceivably be used without
> being initialized. I set it to 0.
>
>   

Modern gcc is great at telling you when uninitialised variables might be 
used. But it can't do that job if you just initialise the variable at 
the start. The error code patch probably falls into the same category.

At the very least for this specific case, handle should be reset at the 
start of the loop it's used in, not just at the start of the function.

But it probably makes sense to tidy the code up a bit instead. cc is a 
boolean that is true iff handle is valid, so maybe some of those (handle 
 > 0) tests should go away and be replaced by (cc).

Though this code would be a bit simpler if it didn't try to survive and 
continue after malloc() failures, which seems a bit excessive. An error 
and exit seems more reasonable from hcitool.

> diff -urp bluez-4.54.orig/tools/hcitool.c bluez-4.54/tools/hcitool.c
> --- bluez-4.54.orig/tools/hcitool.c	2009-09-26 08:43:56.000000000 -0400
> +++ bluez-4.54/tools/hcitool.c	2009-09-26 12:31:28.000000000 -0400
> @@ -505,7 +505,7 @@ static void cmd_scan(int dev_id, int arg
>  	uint8_t lap[3] = { 0x33, 0x8b, 0x9e };
>  	int num_rsp, length, flags;
>  	uint8_t cls[3], features[8];
> -	uint16_t handle;
> +	uint16_t handle = 0;
>  	char addr[18], name[249], oui[9], *comp, *tmp;
>  	struct hci_version version;
>  	struct hci_dev_info di;
>   

