Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Jul 2015 10:22:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anupam Roy <anupam.r@samsung.com>
Cc: vinicius.gomes@intel.com, linux-bluetooth@vger.kernel.org,
	sachin.dev@samsung.com
Subject: Re: [PATCH RESEND] tools/obex-client-tool.c: Fix memory leak in
 obex-client-tool
Message-ID: <20150727072238.GB29130@t440s>
References: <1437750106-16261-1-git-send-email-anupam.r@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437750106-16261-1-git-send-email-anupam.r@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anupam,

On Fri, Jul 24, 2015, Anupam Roy wrote:
> GOptionContext object should be freed in case socket connection
> fails and program execution is terminated.
> 
> ==12968== HEAP SUMMARY:
> ==12968==     in use at exit: 2,895 bytes in 14 blocks
> ==12968==   total heap usage: 23 allocs, 9 frees, 36,669 bytes allocated
> ==12968==
> ==12968== 624 (88 direct, 536 indirect) bytes in 1 blocks are definitely lost in loss record 13 of 14
> ==12968==    at 0x4C2CC70: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==12968==    by 0x4E85668: g_malloc0 (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
> ==12968==    by 0x4E89D22: g_option_context_new (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
> ==12968==    by 0x402BAB: main (obex-client-tool.c:428)
> ==12968==
> ==12968== LEAK SUMMARY:
> ==12968==    definitely lost: 88 bytes in 1 blocks
> ==12968==    indirectly lost: 536 bytes in 2 blocks
> ==12968==      possibly lost: 0 bytes in 0 blocks
> ==12968==    still reachable: 2,271 bytes in 11 blocks
> ==12968==         suppressed: 0 bytes in 0 blocks
> ---
>  tools/obex-client-tool.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
