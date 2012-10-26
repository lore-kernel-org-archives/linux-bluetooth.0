Return-Path: <cyrus@holtmann.org>
Date: Fri, 26 Oct 2012 11:01:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Fix memory leak
Message-ID: <20121026080142.GB20213@x220>
References: <1351238216-7583-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351238216-7583-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Oct 26, 2012, Luiz Augusto von Dentz wrote:
> 1,262 (64 direct, 1,198 indirect) bytes in 1 blocks are definitely lost in loss record 280 of 290
>    at 0x4A0881C: malloc (vg_replace_malloc.c:270)
>    by 0x4C813FE: g_malloc (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C95801: g_slice_alloc (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C95D55: g_slice_alloc0 (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C746AA: g_key_file_new (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x18136C: load_config (adapter.c:2620)
>    by 0x18353B: adapter_init (adapter.c:2708)
>    by 0x17E62E: btd_manager_register_adapter (manager.c:337)
>    by 0x191171: mgmt_event.part.36 (mgmt.c:1081)
>    by 0x4C7B824: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C7BB57: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
>    by 0x4C7BF51: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3200.4)
> ---
>  src/adapter.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

Johan
