Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] shared/gatt-client: Fix crash on ext prop read failure
Date: Fri, 27 Jul 2018 14:08:38 +0200
Message-ID: <7231771.OlE9voxBx1@ix>
In-Reply-To: <20180726143400.20210-1-szymon.janc@codecoup.pl>
References: <20180726143400.20210-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday, 26 July 2018 16:34:00 CEST Szymon Janc wrote:
> Program received signal SIGSEGV, Segmentation fault.
> 
> Program received signal SIGSEGV, Segmentation fault.
> ext_prop_read_cb (success=false, att_ecode=0 '\000', value=0x0,
>     length=0, user_data=0x72ad30) at src/shared/gatt-client.c:711
> 711     src/shared/gatt-client.c: No such file or directory.
> (gdb) bt
> 0  ext_prop_read_cb (success=false, att_ecode=0 '\000', value=0x0,
>                      length=0, user_data=0x72ad30)
>    at src/shared/gatt-client.c:711
> 1  0x000000000049b8cc in disc_att_send_op (data=0x7199b0)
>    at src/shared/att.c:547
> 2  0x000000000049cb44 in disconnect_cb (io=<optimized out>,
>                        user_data=0x716070) at src/shared/att.c:580
> 3  0x00000000004a6405 in watch_callback (channel=<optimized out>,
>                       cond=<optimized out>, user_data=<optimized out>)
>    at src/shared/io-glib.c:170
> 4  0x00007ffff78c704a in g_main_context_dispatch ()
>    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> 5  0x00007ffff78c73f0 in ?? ()
>    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> 6  0x00007ffff78c7712 in g_main_loop_run ()
>    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> 7  0x000000000040c620 in main (argc=1, argv=0x7fffffffe5a8)
>    at src/main.c:781
> ---
>  src/shared/gatt-client.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 2e153db5c..3c2aa293b 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -708,6 +708,9 @@ static void ext_prop_read_cb(bool success, uint8_t
> att_ecode, bool discovering;
>  	struct gatt_db_attribute *desc_attr = NULL;
> 
> +	if (!success)
> +		goto done;
> +
>  	util_debug(client->debug_callback, client->debug_data,
>  				"Ext. prop value: 0x%04x", (uint16_t)value[0]);

Applied.

-- 
pozdrawiam
Szymon Janc


