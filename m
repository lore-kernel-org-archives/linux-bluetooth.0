Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Nov 2012 13:03:32 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/7] event: Store link key infos in new keys file
Message-ID: <20121127110332.GA23883@x220>
References: <1354006193-7199-1-git-send-email-frederic.danis@linux.intel.com>
 <1354006193-7199-7-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1354006193-7199-7-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Tue, Nov 27, 2012, Frédéric Danis wrote:
> ---
>  src/event.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 47 insertions(+), 12 deletions(-)

After these patches there's the following leak:

==23252== 32,808 bytes in 1 blocks are definitely lost in loss record 210 of 210
==23252==    at 0x4A0883C: malloc (vg_replace_malloc.c:270)
==23252==    by 0x565E25F: __alloc_dir (opendir.c:199)
==23252==    by 0x175382: load_devices (adapter.c:2005)
==23252==    by 0x178E50: adapter_init (adapter.c:2896)
==23252==    by 0x17391E: btd_manager_register_adapter (manager.c:334)
==23252==    by 0x1883E1: mgmt_event.part.36 (mgmt.c:1081)
==23252==    by 0x4C78A74: g_main_context_dispatch (gmain.c:2715)
==23252==    by 0x4C78DA7: g_main_context_iterate.isra.24 (gmain.c:3290)
==23252==    by 0x4C791A1: g_main_loop_run (gmain.c:3484)
==23252==    by 0x121640: main (main.c:544)

That seems to be simple missing closedir() call. Didn't I already tell
you to always use valgrind?

Another problem with these is that I'm getting over a hundred unexpected
device objects which I didn't have before. It seems that this is because
you convert the classes file into the device storage instead of the
cache. It might be due to some other info as well though.

Johan
