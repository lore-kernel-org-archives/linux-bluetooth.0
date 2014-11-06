Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/gatt: Fix using wrong variable type
Date: Thu, 06 Nov 2014 16:28:21 +0100
Message-ID: <1609834.LQp6R4r1xk@uw000953>
In-Reply-To: <1415266238-12423-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1415266238-12423-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 06 of November 2014 10:30:35 Jakub Tyszkowski wrote:
> Not all bytes were set thus the following valgrind report:
> ==4748== Conditional jump or move depends on uninitialised value(s)
> ==4748==    at 0x436493: att_handler (gatt.c:5922)
> ==4748==    by 0x4448ED: received_data.part.2 (gattrib.c:432)
> ==4748==    by 0x4E7FCE4: g_main_context_dispatch (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
> ==4748==    by 0x4E80047: ??? (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
> ==4748==    by 0x4E80309: g_main_loop_run (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
> ==4748==    by 0x4045B6: main (main.c:772)
> ==4748==  Uninitialised value was created by a stack allocation
> ==4748==    at 0x432690: get_cid.isra.5 (gatt.c:2983)
> ==4748==
> ---
>  android/gatt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 7cf612f..d601cda 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -2965,7 +2965,7 @@ static void read_char_cb(guint8 status, const guint8 *pdu, guint16 len,
>  static int get_cid(struct gatt_device *dev)
>  {
>  	GIOChannel *io;
> -	int cid;
> +	uint16_t cid;
>  
>  	io = g_attrib_get_channel(dev->attrib);
>  

Patch 1-3 are now applied, thanks. 

-- 
Best regards, 
Szymon Janc
