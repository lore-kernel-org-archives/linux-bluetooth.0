Return-Path: <cyrus@holtmann.org>
Date: Sun, 23 Dec 2012 11:31:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: Fix memory leak from pending UUID removal
Message-ID: <20121223093108.GA4601@x220.P-661HNU-F1>
References: <1356217161-3787-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1356217161-3787-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Sat, Dec 22, 2012, Anderson Lizardo wrote:
> When bluetoothd is shutting down, profile cleanup will usually issue
> many "Remove UUID" management commands. These may not complete before
> the process exits, resulting on this memory leak:
> 
> ==2461== 144 (8 direct, 136 indirect) bytes in 1 blocks are definitely
> lost in loss record 153 of 176
> ==2461==    at 0x402BE68: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
> ==2461==    by 0x40869AA: standard_malloc (gmem.c:85)
> ==2461==    by 0x4086E42: g_malloc (gmem.c:159)
> ==2461==    by 0x409B26D: g_slice_alloc (gslice.c:1003)
> ==2461==    by 0x409C659: g_slist_append (gslist.c:222)
> ==2461==    by 0x80B5E12: mgmt_remove_uuid (mgmt.c:1034)
> ==2461==    by 0x80A734E: adapter_service_remove (adapter.c:708)
> ==2461==    by 0x80994B4: sdp_record_remove (sdpd-database.c:272)
> ==2461==    by 0x8098CC0: remove_record_from_server (sdpd-service.c:290)
> ==2461==    by 0x8062B5B: avrcp_unregister (avrcp.c:2354)
> ==2461==    by 0x409C797: g_slist_foreach (gslist.c:840)
> ==2461==    by 0x80A7D77: adapter_remove (adapter.c:1630)
> 
> The leak seems to only happen during bluetoothd shutdown, because the
> list of pending UUIDs is cleared when controller is removed. Therefore,
> only cleanup the list on shutdown path.
> ---
>  src/mgmt.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied. Thanks.

Johan
