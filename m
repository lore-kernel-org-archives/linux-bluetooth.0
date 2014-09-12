Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Sep 2014 09:44:30 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] core: Fix missing channel unref on cached session watch
Message-ID: <20140912164430.GA3671@t440s>
References: <1410512047-15547-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410512047-15547-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Sep 12, 2014, Szymon Janc wrote:
> g_io_add_watch function takes own reference so local one needs to
> be dropped. Fix following Valgrind report:
> 
> 126 (120 direct, 6 indirect) bytes in 1 blocks are definitely lost in
>     loss record 146 of 158
> at 0x4C2745D: malloc (in /usr/lib64/valgrind/
>    vgpreload_memcheck-amd64-linux.so)
> by 0x4E7FE6E: g_malloc (in /usr/lib64/libglib-2.0.so.0.3800.2)
> by 0x4EBC5B7: g_io_channel_unix_new (in /usr/lib64/
>    libglib-2.0.so.0.3800.2)
> by 0x4496B4: search_completed_cb (sdp-client.c:129)
> by 0x45217B: sdp_process (sdp.c:4350)
> by 0x449814: search_process_cb (sdp-client.c:228)
> by 0x4E7A2A5: g_main_context_dispatch (in /usr/
>    lib64/libglib-2.0.so.0.3800.2)
> by 0x4E7A627: ??? (in /usr/lib64/libglib-2.0.so.0.3800.2)
> by 0x4E7AA39: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3800.2)
> by 0x404372: main (main.c:550)
> ---
>  src/sdp-client.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

Johan
