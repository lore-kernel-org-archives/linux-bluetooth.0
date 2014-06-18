Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/gatt: Fix not freeing discover_srvc_data
Date: Wed, 18 Jun 2014 15:40:24 +0200
Message-ID: <1788801.NPzh0SoE2F@uw000953>
In-Reply-To: <1403096334-23297-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403096334-23297-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 18 of June 2014 14:58:53 Jakub Tyszkowski wrote:
> This fixes the following issue:
> 
> 32 bytes in 1 blocks are definitely lost in loss record 92 of 142
> ==19365==    at 0x4C29DB4: calloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==19365==    by 0x43275A: search_dev_for_srvc (gatt.c:1302)
> ==19365==    by 0x4354C9: connect_cb (gatt.c:1424)
> ==19365==    by 0x448AD3: accept_cb (btio.c:203)
> ==19365==    by 0x4E79D12: g_main_context_dispatch (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
> ==19365==    by 0x4E7A05F: ??? (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
> ==19365==    by 0x4E7A459: g_main_loop_run (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
> ==19365==    by 0x40459D: main (main.c:538)
> ---
>  android/gatt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index b256077..7dd37ab 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1245,11 +1245,15 @@ static void discover_primary_cb(uint8_t status, GSList *services,
>  	if (status) {
>  		error("gatt: Discover all primary services failed: %s",
>  							att_ecode2str(status));
> +		free(cb_data);
> +
>  		return;
>  	}
>  
>  	if (!services) {
>  		info("gatt: No primary services found");
> +		free(cb_data);
> +
>  		return;
>  	}
>  
> 

Both patches applied. Thanks.

-- 
Best regards, 
Szymon Janc
