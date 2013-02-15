Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2013 12:57:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] A2DP: Fix invalid write
Message-ID: <20130215105759.GA21844@x220>
References: <1360332728-27051-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360332728-27051-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Feb 08, 2013, Luiz Augusto von Dentz wrote:
> Invalid write of size 8
>    at 0x41F297: setconf_cfm (a2dp.c:567)
>    by 0x42526B: session_cb (avdtp.c:3176)
>    by 0x39B0847A54: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
>    by 0x39B0847D87: ??? (in /usr/lib64/libglib-2.0.so.0.3400.2)
>    by 0x39B0848181: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
>    by 0x409C3E: main (main.c:583)
>  Address 0x555fda8 is 40 bytes inside a block of size 88 free'd
>    at 0x4A077A6: free (vg_replace_malloc.c:446)
>    by 0x39B084D79E: g_free (in /usr/lib64/libglib-2.0.so.0.3400.2)
>    by 0x41E217: setup_cb_free (a2dp.c:191)
>    by 0x41E410: finalize_config (a2dp.c:234)
>    by 0x41F296: setconf_cfm (a2dp.c:566)
>    by 0x42526B: session_cb (avdtp.c:3176)
>    by 0x39B0847A54: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
>    by 0x39B0847D87: ??? (in /usr/lib64/libglib-2.0.so.0.3400.2)
>    by 0x39B0848181: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
>    by 0x409C3E: main (main.c:583)
> ---
>  profiles/audio/a2dp.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

Johan
