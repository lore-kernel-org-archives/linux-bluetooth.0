Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Oct 2012 16:47:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/7] audio: Fix not freeing gateway agent data on
 exit
Message-ID: <20121001134733.GA10861@x220.ger.corp.intel.com>
References: <1349091471-17396-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349091471-17396-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 01, 2012, Luiz Augusto von Dentz wrote:
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

All patches in this set have been applied. Thanks.

Johan
