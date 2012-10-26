Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Oct 2012 14:58:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Do not call the callback on
 btd_cancel_authorization
Message-ID: <20121026115828.GA8570@x220>
References: <1351252089-19329-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351252089-19329-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Oct 26, 2012, Luiz Augusto von Dentz wrote:
> btd_cancel_authorization should work like g_source_remove and not attempt
> to reach the callback as its maybe already invalid or lead to double free
> situations such as this:
> 
> Invalid write of size 4
>    at 0x13D480: connection_lost (avdtp.c:1102)
>    by 0x13F37A: session_cb (avdtp.c:2281)
>    by 0x4C7B824: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C7BB57: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C7BF51: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x122B21: main (main.c:551)
>  Address 0x6512ac0 is 32 bytes inside a block of size 1,184 free'd
>    at 0x4A07786: free (vg_replace_malloc.c:446)
>    by 0x4C8150E: g_free (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x13D4A9: connection_lost (avdtp.c:1216)
>    by 0x13D55E: auth_cb (avdtp.c:2471)
>    by 0x17E99A: service_auth_cancel (adapter.c:1021)
>    by 0x183C67: btd_cancel_authorization (adapter.c:3358)
>    by 0x13D477: connection_lost (avdtp.c:1098)
>    by 0x13F37A: session_cb (avdtp.c:2281)
>    by 0x4C7B824: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C7BB57: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C7BF51: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x122B21: main (main.c:551)
> ---
>  src/adapter.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
