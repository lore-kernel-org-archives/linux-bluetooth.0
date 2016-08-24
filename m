Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] Bluetooth: Fix memory leak at end of hci requests
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1471931959-1027-1-git-send-email-frederic.dalleau@collabora.co.uk>
Date: Wed, 24 Aug 2016 10:57:01 -0400
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <184990AC-F3F6-47AF-AAAC-61BABCB7E2C2@holtmann.org>
References: <1471931959-1027-1-git-send-email-frederic.dalleau@collabora.co.uk>
To: =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Dalleau?=
        <frederic.dalleau@collabora.co.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> In hci_req_sync_complete the event skb is referenced in hdev->req_skb.
> It is used (via hci_req_run_skb) from either __hci_cmd_sync_ev which will
> pass the skb to the caller, or __hci_req_sync which leaks.
> 
> unreferenced object 0xffff880005339a00 (size 256):
>  comm "kworker/u3:1", pid 1011, jiffies 4294671976 (age 107.389s)
>  backtrace:
>    [<ffffffff818d89d9>] kmemleak_alloc+0x49/0xa0
>    [<ffffffff8116bba8>] kmem_cache_alloc+0x128/0x180
>    [<ffffffff8167c1df>] skb_clone+0x4f/0xa0
>    [<ffffffff817aa351>] hci_event_packet+0xc1/0x3290
>    [<ffffffff8179a57b>] hci_rx_work+0x18b/0x360
>    [<ffffffff810692ea>] process_one_work+0x14a/0x440
>    [<ffffffff81069623>] worker_thread+0x43/0x4d0
>    [<ffffffff8106ead4>] kthread+0xc4/0xe0
>    [<ffffffff818dd38f>] ret_from_fork+0x1f/0x40
>    [<ffffffffffffffff>] 0xffffffffffffffff
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@collabora.co.uk>
> ---
> net/bluetooth/hci_request.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

