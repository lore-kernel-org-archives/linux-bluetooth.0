Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Sep 2010 20:45:31 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 3/3] Bluetooth: check L2CAP length in first ACL
 fragment
Message-ID: <20100928234531.GA8518@vigoh>
References: <1284550124-31201-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1284550124-31201-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284550124-31201-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-09-15 14:28:44 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Current Bluetooth code assembles fragments of big L2CAP packets
> in l2cap_recv_acldata and then checks allowed L2CAP size in
> assemled L2CAP packet (pi->imtu < skb->len).
> 
> The patch moves allowed L2CAP size check to the early stage when
> we receive the first fragment of L2CAP packet. We do not need to
> reserve and keep L2CAP fragments for bad packets.
> 
> Updated version after comments from Mat Martineau <mathewm@codeaurora.org>
> and Gustavo Padovan <padovan@profusion.mobi>.
> 
> Trace below is received when using stress tools sending big
> fragmented L2CAP packets.
> ...
> [ 1712.798492] swapper: page allocation failure. order:4, mode:0x4020
> [ 1712.804809] [<c0031870>] (unwind_backtrace+0x0/0xdc) from [<c00a1f70>]
> (__alloc_pages_nodemask+0x4)
> [ 1712.814666] [<c00a1f70>] (__alloc_pages_nodemask+0x47c/0x4d4) from
> [<c00a1fd8>] (__get_free_pages+)
> [ 1712.824645] [<c00a1fd8>] (__get_free_pages+0x10/0x3c) from [<c026eb5c>]
> (__alloc_skb+0x4c/0xfc)
> [ 1712.833465] [<c026eb5c>] (__alloc_skb+0x4c/0xfc) from [<bf28c738>]
> (l2cap_recv_acldata+0xf0/0x1f8 )
> [ 1712.843322] [<bf28c738>] (l2cap_recv_acldata+0xf0/0x1f8 [l2cap]) from
> [<bf0094ac>] (hci_rx_task+0x)
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/l2cap.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

Patch 1/3 was applied to my bluetooth-2.6 tree and 2/3 and 3/3 to
bluetooth-next-2.6. Thanks.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
