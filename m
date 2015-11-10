Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 10 Nov 2015 20:47:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] shared/mgmt: Fix crash when removing index
Message-ID: <20151110184716.GA17113@t440s.P-661HNU-F1>
References: <1447147958-23378-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447147958-23378-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Nov 10, 2015, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Because queue entries are no longer protected by a reference it is
> necessary to return the use of in_notify flag, etc, otherwise the
> following crash can happen when removing an index:
> 
> Invalid read of size 8
>    at 0x41AD6F: queue_foreach (queue.c:219)
>    by 0x41CA6C: process_notify (mgmt.c:280)
>    by 0x41CA6C: can_read_data (mgmt.c:338)
>    by 0x422DCA: watch_callback (io-glib.c:170)
>    by 0x4E7EA89: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4400.1)
>    by 0x4E7EE1F: ??? (in /usr/lib64/libglib-2.0.so.0.4400.1)
>    by 0x4E7F141: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4400.1)
>    by 0x422A31: tester_run (tester.c:830)
>    by 0x403013: main (l2cap-tester.c:1489)
>  Address 0x5754b38 is 8 bytes inside a block of size 16 free'd
>    at 0x4C29D6A: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
>    by 0x41AFCF: queue_remove_if (queue.c:302)
>    by 0x41B0BA: queue_remove_all (queue.c:331)
>    by 0x41C6A2: mgmt_unregister_index (mgmt.c:737)
>    by 0x405033: index_removed_callback (l2cap-tester.c:162)
>    by 0x41B751: notify_handler (mgmt.c:270)
>    by 0x41AD83: queue_foreach (queue.c:220)
>    by 0x41CA6C: process_notify (mgmt.c:280)
>    by 0x41CA6C: can_read_data (mgmt.c:338)
>    by 0x422DCA: watch_callback (io-glib.c:170)
>    by 0x4E7EA89: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4400.1)
>    by 0x4E7EE1F: ??? (in /usr/lib64/libglib-2.0.so.0.4400.1)
>    by 0x4E7F141: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4400.1)
> ---
>  src/shared/mgmt.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 58 insertions(+), 8 deletions(-)

Applied. Thanks.

Johan
