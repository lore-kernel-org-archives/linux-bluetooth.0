Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/scpp: Fix using freed memory
Date: Mon, 22 Dec 2014 14:13:53 +0100
Message-ID: <3155639.Ajs76qMxjk@leonov>
In-Reply-To: <1419248953-31147-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1419248953-31147-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Monday 22 of December 2014 13:49:13 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Fixes use after free memory bug.
> req is assigned to user_data and then freed with destroy_gatt_req(req)
> ---
>  android/scpp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/scpp.c b/android/scpp.c
> index 77f48cd..9f60c9f 100644
> --- a/android/scpp.c
> +++ b/android/scpp.c
> @@ -301,8 +301,6 @@ static void refresh_discovered_cb(uint8_t status, GSList
> *chars, uint16_t start, end;
>  	bt_uuid_t uuid;
> 
> -	destroy_gatt_req(req);
> -
>  	if (status) {
>  		error("Scan Refresh %s", att_ecode2str(status));
>  		return;
> @@ -329,6 +327,8 @@ static void refresh_discovered_cb(uint8_t status, GSList
> *chars,
> 
>  	discover_desc(scan, scan->attrib, start, end, &uuid,
>  					discover_descriptor_cb, user_data);
> +
> +	destroy_gatt_req(req);
>  }
> 
>  static void iwin_discovered_cb(uint8_t status, GSList *chars, void
> *user_data)

This patch doesn't fix the bug (actually it introduces some memleaks).

>From what I see in code gatt_request is packing userdata passed to 
discover_desc() so I think fix should be like:

--- a/android/scpp.c
+++ b/android/scpp.c
@@ -328,7 +328,7 @@ static void refresh_discovered_cb(uint8_t status, GSList 
*chars,
        bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
 
        discover_desc(scan, scan->attrib, start, end, &uuid,
-                                       discover_descriptor_cb, user_data);
+                                       discover_descriptor_cb, scan);


Although here scan and userdata seems reluctant (since req is already holding 
sccp instance).

I'd wait for Luiz to comment on this since he wrote most of the scpp code.

-- 
BR
Szymon Janc
