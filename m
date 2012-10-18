Return-Path: <cyrus@holtmann.org>
Date: Thu, 18 Oct 2012 10:33:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC BlueZ] adapter: Fix memory leak on discovery cleanup
Message-ID: <20121018073324.GA2031@x220>
References: <1350515709-30389-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350515709-30389-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Oct 17, 2012, Anderson Lizardo wrote:
> During discovery cleanup, it was attempted to send a DevicesFound()
> D-Bus signal for pending found devices, but adapter->discovery was set
> to NULL before calling send_devices_found(), therefore it never sent any
> signal (and there was a leak of discovery->pending list).
> 
> Fixes this memory leak when pairing two LE devices:
> 
> ==1822== 8 bytes in 1 blocks are definitely lost in loss record 42 of
> 246
> ==1822==    at 0x482BE68: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
> ==1822==    by 0x48869AA: standard_malloc (gmem.c:85)
> ==1822==    by 0x4886E42: g_malloc (gmem.c:159)
> ==1822==    by 0x489B26D: g_slice_alloc (gslice.c:1003)
> ==1822==    by 0x489C10A: g_slist_prepend (gslist.c:265)
> ==1822==    by 0x1855AE: adapter_update_found_devices (adapter.c:2846)
> ==1822==    by 0x191431: btd_event_device_found (event.c:260)
> ==1822==    by 0xBC01001A: ???
> ==1822==
> ---
>  src/adapter.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
