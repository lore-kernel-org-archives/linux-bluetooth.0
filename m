Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/gatt: Fix memory leak
Date: Mon, 14 Apr 2014 11:36:16 +0200
Message-ID: <3951410.3Mdp0NIN3A@uw000953>
In-Reply-To: <1397465714-12257-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397465714-12257-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 14 of April 2014 10:55:14 Lukasz Rymanowski wrote:
> It happens on daemon exit when connection is up.
> 
> 295 (104 direct, 191 indirect) bytes in 1 blocks are definitely lost in
> loss record 140 of 148
> ==25132==    at 0x4C2B6CD: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==25132==    by 0x4E7FBBD: g_try_malloc0 (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
> ==25132==    by 0x437BF9: g_attrib_new (gattrib.c:495)
> ==25132==    by 0x42F45F: connect_cb (gatt.c:845)
> ==25132==    by 0x439DBA: connect_cb (btio.c:232)
> ==25132==    by 0x4E79D12: g_main_context_dispatch (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
> ==25132==    by 0x4E7A05F: ??? (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
> ==25132==    by 0x4E7A459: g_main_loop_run (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.3200.4)
> ==25132==    by 0x4044FD: main (main.c:531)
> 
> This patch moves function connection_cleanup up in the file as this is
> needed by destroy_device
> ---
>  android/gatt.c | 45 ++++++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 21 deletions(-)

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
