Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] shared/att: Fix possible crash when security is changed
Date: Wed, 20 Dec 2017 20:58:50 +0100
Message-ID: <2929752.klXrzWnKQI@ix>
In-Reply-To: <20171220162751.9276-1-luiz.dentz@gmail.com>
References: <20171220162751.9276-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wednesday, 20 December 2017 17:27:51 CET Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When resending a PDU due to secure change the timeout_id shall also be
> removed otherwise the following crash may occur:
> 
> Invalid read of size 8
>    at 0x489639: timeout_cb (att.c:405)
>    by 0x49417C: timeout_callback (timeout-glib.c:34)
>    by 0x4E84AB2: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
>    by 0x4E84049: g_main_context_dispatch (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2) by 0x4E843EF: ??? (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2) by 0x4E84711:
> g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2) by
> 0x40B51F: main (main.c:770)
>  Address 0x6ce5830 is 32 bytes inside a block of size 192 free'd
>    at 0x4C2EDEB: free (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so) by 0x48A89D:
> disconnect_cb (att.c:593)
>    by 0x493D54: watch_callback (io-glib.c:170)
>    by 0x4E84049: g_main_context_dispatch (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2) by 0x4E843EF: ??? (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2) by 0x4E84711:
> g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2) by
> 0x40B51F: main (main.c:770)
> ---
>  src/shared/att.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/src/shared/att.c b/src/shared/att.c
> index 8d58156c1..0aab246d6 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -642,6 +642,12 @@ static bool handle_error_rsp(struct bt_att *att,
> uint8_t *pdu, if (!change_security(att, rsp->ecode))
>  		return false;
> 
> +	/* Remove timeout_id if outstanding */
> +	if (op->timeout_id) {
> +		timeout_remove(op->timeout_id);
> +		op->timeout_id = 0;
> +	}
> +
>  	util_debug(att->debug_callback, att->debug_data,
>  						"Retrying operation %p", op);

Applied, thanks.

-- 
pozdrawiam
Szymon Janc
