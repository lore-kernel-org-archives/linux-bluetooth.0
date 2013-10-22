Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Oct 2013 13:38:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Fix crash while processing SDP records
Message-ID: <20131022103838.GB1697@x220.p-661hnu-f1>
References: <1382432600-6101-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382432600-6101-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Oct 22, 2013, Luiz Augusto von Dentz wrote:
> This was introduced by commit 073714c3ff70379131be3e19d9ccb8b85fe3f0d9
> which attempted to treat the return of sdp_process but caused the crash
> bellow because sdp_process actually calls search_completed_cb if it
> fails:
> Invalid read of size 8
>    at 0x44FC93: search_process_cb (sdp-client.c:214)
>    by 0x3D46047E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
>    by 0x3D46048157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
>    by 0x3D46048559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
>    by 0x40A2DF: main (main.c:587)
>  Address 0x59febd0 is 16 bytes inside a block of size 72 free'd
>    at 0x4A074C4: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>    by 0x3D4604D9AE: g_free (in /usr/lib64/libglib-2.0.so.0.3600.3)
>    by 0x44FE44: search_completed_cb (sdp-client.c:192)
>    by 0x4732E7: sdp_process (sdp.c:4341)
>    by 0x44FCD8: search_process_cb (sdp-client.c:206)
>    by 0x3D46047E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
>    by 0x3D46048157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
>    by 0x3D46048559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
>    by 0x40A2DF: main (main.c:587)
> ---
>  src/sdp-client.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)

Applied. Thanks.

Johan
