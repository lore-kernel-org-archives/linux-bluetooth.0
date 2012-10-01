Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349091471-17396-1-git-send-email-luiz.dentz@gmail.com>
References: <1349091471-17396-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 1 Oct 2012 14:31:50 +0200
Message-ID: <CANT-zCWzU6-8S58g1XPwfCTT3JNGMwEArjspJsWt91f9MZHwLg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/7] audio: Fix not freeing gateway agent data on exit
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 1, 2012 at 1:37 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> 434 (168 direct, 266 indirect) bytes in 7 blocks are definitely lost in loss record 322 of 338
>    at 0x4A06F18: calloc (vg_replace_malloc.c:566)
>    by 0x4C802C6: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x126C0C: register_agent (gateway.c:673)
>    by 0x122960: process_message.isra.0 (object.c:197)
>    by 0x4F70684: ??? (in /usr/lib64/libdbus-1.so.3.5.6)
>    by 0x4F6290C: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.5.6)
>    by 0x120FA7: message_dispatch (mainloop.c:76)
>    by 0x4C7B22A: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C7A694: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C7A9C7: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C7ADC1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x120671: main (main.c:551)
> ---
>  audio/gateway.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index 45b25a1..3e606c9 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -741,6 +741,9 @@ static void path_unregister(void *data)
>
>         gateway_close(dev);
>
> +       if (dev->gateway->agent)
> +               agent_free(dev->gateway->agent);
> +
>         g_free(dev->gateway);
>         dev->gateway = NULL;
>  }
> --

I also had this in my pipeline so ack from my side.

Cheers,
Mikel
