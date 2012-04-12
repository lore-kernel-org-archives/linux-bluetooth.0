Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 14:37:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio: Fix memory leak when headset server probe()
 fails
Message-ID: <20120412113738.GA18837@x220.ger.corp.intel.com>
References: <1334089368-6920-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334089368-6920-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Apr 10, 2012, Anderson Lizardo wrote:
> If RFCOMM is disabled on the kernel, headset_server_probe() fails.
> Relevant log messages:
> 
>  audio/manager.c:headset_server_probe() path /org/bluez/499/hci0
>  src/adapter.c:btd_adapter_ref() 0x4bb4f78: ref=6
>  audio/manager.c:audio_adapter_ref() 0x4ca3010: ref=1
>  socket(STREAM, RFCOMM): Protocol not supported (93)
>  audio/manager.c:audio_adapter_unref() 0x4ca3010: ref=0
>  src/adapter.c:btd_adapter_unref() 0x4bb4f78: ref=5
>  audio-headset: Operation not permitted (1)
> 
> The powered callback should only be registered if adapter driver probe
> was successful. The callback unregister was moved to the beginning of
> headset_server_remove() for consistency.
> 
> This fixes this memory leak:
> 
> ==499== 8 bytes in 1 blocks are definitely lost in loss record 44 of 182
> ==499==    at 0x4826444: malloc (vg_replace_malloc.c:263)
> ==499==    by 0x4877243: g_malloc (gmem.c:132)
> ==499==    by 0x488D088: g_slice_alloc (gslice.c:836)
> ==499==    by 0x488E8A5: g_slist_append (gslist.c:230)
> ==499==    by 0x18AEEE: btd_adapter_register_powered_callback
> (adapter.c:3416)
> ==499==    by 0x11AF61: headset_server_probe (manager.c:919)
> ==499==    by 0x18B67B: probe_driver (adapter.c:2033)
> ==499==    by 0x1908F5: adapter_init (adapter.c:2048)
> ==499==    by 0x189D20: btd_manager_register_adapter (manager.c:397)
> ==499==    by 0x1649AF: mgmt_cmd_complete (mgmtops.c:1075)
> ==499==    by 0x16665E: mgmt_event (mgmtops.c:1780)
> ==499==    by 0x48B2EFA: g_io_unix_dispatch (giounix.c:162)
> ---
>  audio/manager.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
