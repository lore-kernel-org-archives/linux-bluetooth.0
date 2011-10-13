Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 17:10:25 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 3/6] Bluetooth: EFS: add efs option in L2CAP conf req
Message-ID: <20111013201025.GE20892@joana>
References: <1318511938-24311-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318511938-24311-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318511938-24311-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-10-13 16:18:55 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add Extended Flow Specification option when building L2CAP
> Configuration Request. EFS is added if both the local and
> remote L2CAP entities have indicated support for the
> Extended Flow Specification for BR/EDR.
> 
> ...
> < ACL data: handle 1 flags 0x00 dlen 10
>     L2CAP(s): Info req: type 2
> > ACL data: handle 1 flags 0x02 dlen 16
>     L2CAP(s): Info rsp: type 2 result 0
>       Extended feature mask 0x01f8
>         Enhanced Retransmission mode
>         Streaming mode
>         FCS Option
>         Extended Flow Specification
>         Fixed Channels
>         Extended Window Size
> ...
> < ACL data: handle 1 flags 0x00 dlen 45
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 33
>       RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 0, MTo 0, MPS 498)
>       EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime 0xffffffff,
>           AccLat 0xffffffff, FlushTO 0x0000ffff)
> ...
> 
> Based upon haijun.liu <haijun.liu@atheros.com> series of patches
> (sent Sun, 22 Aug 2010)
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 45 insertions(+), 0 deletions(-)

Patches 1 to 3 have been applied. Thanks.

	Gustavo
