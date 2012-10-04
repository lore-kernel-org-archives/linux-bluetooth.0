Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Oct 2012 21:22:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Fix leaking connection list nodes
Message-ID: <20121004182241.GB22857@x220.P-661HNU-F1>
References: <1349372393-8110-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349372393-8110-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Oct 04, 2012, Lucas De Marchi wrote:
> ==480== HEAP SUMMARY:
> ==480==     in use at exit: 62,418 bytes in 355 blocks
> ==480==   total heap usage: 11,134 allocs, 10,779 frees, 5,254,068 bytes allocated
> ==480==
> ==480== 16 bytes in 1 blocks are definitely lost in loss record 70 of 250
> ==480==    at 0x4C2C04B: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==480==    by 0x4E80050: g_malloc (in /usr/lib/libglib-2.0.so.0.3200.4)
> ==480==    by 0x4E94442: g_slice_alloc (in /usr/lib/libglib-2.0.so.0.3200.4)
> ==480==    by 0x4E95792: g_slist_append (in /usr/lib/libglib-2.0.so.0.3200.4)
> ==480==    by 0x17E483: adapter_add_connection (adapter.c:3245)
> ==480==    by 0x187FDF: btd_event_conn_complete (event.c:470)
> ==480==    by 0x18B72D: mgmt_event.part.36 (mgmt.c:515)
> ==480==    by 0x4E7A474: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.3200.4)
> ==480==    by 0x4E7A7A7: ??? (in /usr/lib/libglib-2.0.so.0.3200.4)
> ==480==    by 0x4E7ABA1: g_main_loop_run (in /usr/lib/libglib-2.0.so.0.3200.4)
> ==480==    by 0x1216B1: main (main.c:551)
> ---
>  src/adapter.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

Johan
