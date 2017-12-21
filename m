Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared/gatt-client: Fix memory leak of ready callback
Date: Thu, 21 Dec 2017 09:31:23 +0100
Message-ID: <3395977.ZSQskvrf2M@ix>
In-Reply-To: <20171220204415.17278-1-szymon.janc@codecoup.pl>
References: <20171220204415.17278-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday, 20 December 2017 21:44:15 CET Szymon Janc wrote:
> 72 bytes in 3 blocks are definitely lost in loss record 161 of 244
>    at 0x4C2FB6B: malloc (vg_replace_malloc.c:299)
>    by 0x48D07D: btd_malloc (util.c:45)
>    by 0x493992: bt_gatt_client_ready_register (gatt-client.c:1924)
>    by 0x472BD7: gatt_client_init (device.c:4785)
>    by 0x472BD7: device_attach_att (device.c:4919)
>    by 0x4740A2: att_connect_cb (device.c:4963)
>    by 0x445024: connect_cb (btio.c:232)
>    by 0x50CEBB6: g_main_context_dispatch (in
> /usr/lib64/libglib-2.0.so.0.5400.2) by 0x50CEF5F: ??? (in
> /usr/lib64/libglib-2.0.so.0.5400.2)
>    by 0x50CF271: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5400.2)
>    by 0x40BDE8: main (main.c:770)
> ---
>  src/shared/gatt-client.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 4b3f553f1..8083ff719 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -1934,7 +1934,14 @@ unsigned int bt_gatt_client_ready_register(struct
> bt_gatt_client *client, bool bt_gatt_client_ready_unregister(struct
> bt_gatt_client *client, unsigned int id)
>  {
> -	return queue_remove(client->ready_cbs, UINT_TO_PTR(id));
> +	struct ready_cb *ready = UINT_TO_PTR(id);
> +
> +	if (queue_remove(client->ready_cbs, ready)) {
> +		ready_destroy(ready);
> +		return true;
> +	}
> +
> +	return false;
>  }
> 
>  bool bt_gatt_client_set_service_changed(struct bt_gatt_client *client,

Applied.

-- 
pozdrawiam
Szymon Janc
