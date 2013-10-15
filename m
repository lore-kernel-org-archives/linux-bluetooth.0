Return-Path: <cyrus@holtmann.org>
Date: Tue, 15 Oct 2013 09:57:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] audio/AVDTP: Fix crash after disconnecting
Message-ID: <20131015065720.GA21914@x220.p-661hnu-f1>
References: <1381745687-5677-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381745687-5677-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 14, 2013, Luiz Augusto von Dentz wrote:
> If the session is disconnected while process_discover is pending the
> source id is not removed causing the following crash:
>       at 0x414C08: finalize_discovery (avdtp.c:1050)
>       by 0x414C5A: process_discover (avdtp.c:3346)
>       by 0x3D46047E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
>       by 0x3D46048157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
>       by 0x3D46048559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
>       by 0x40A3B6: main (main.c:595)
>     Address 0x5e25de8 is 1,144 bytes inside a block of size 1,176 free'd
>     at 0x4A074C4: free (in
>     /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>       by 0x3D4604D9AE: g_free (in /usr/lib64/libglib-2.0.so.0.3600.3)
>       by 0x4152F2: connection_lost (avdtp.c:1206)
>       by 0x4162C4: cancel_request (avdtp.c:2662)
>       by 0x4164BD: request_timeout (avdtp.c:2672)
>       by 0x3D46048962: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
>       by 0x3D46047E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
>       by 0x3D46048157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
>       by 0x3D46048559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
>       by 0x40A3B6: main (main.c:595)
> ---
>  profiles/audio/avdtp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

All three patches have been applied. Thanks.

Johan
