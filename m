Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Nov 2011 14:07:37 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv4 3/3] Bluetooth: EFS: implement L2CAP config pending
 state
Message-ID: <20111101160737.GB2580@joana>
References: <1318851332-23700-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1318851332-23700-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318851332-23700-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-10-17 14:35:32 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add L2CAP Config Pending state for EFS. Currently after receiving
> Config Response Pending respond with Config Response Success.
> 
> ...
> > ACL data: handle 1 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
>       Connection successful
> > ACL data: handle 1 flags 0x02 dlen 45
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 33
>       RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 0, MTo 0, MPS 1009)
>       EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime 0xffffffff,
>           AccLat 0xffffffff, FlushTO 0x0000ffff)
> < ACL data: handle 1 flags 0x00 dlen 45
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 33
>       RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 0, MTo 0, MPS 498)
>       EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime 0xffffffff,
>           AccLat 0xffffffff, FlushTO 0x0000ffff)
> < ACL data: handle 1 flags 0x00 dlen 47
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 4 clen 33
>       Pending
>       MTU 672
>       RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 2000, MTo 12000, MPS 498)
>       EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime 0xffffffff,
>           AccLat 0xffffffff, FlushTO 0x0000ffff)
> > ACL data: handle 1 flags 0x02 dlen 47
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 4 clen 33
>       Pending
>       MTU 672
>       RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 2000, MTo 12000, MPS 498)
>       EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime 0xffffffff,
>           AccLat 0xffffffff, FlushTO 0x0000ffff)
> > ACL data: handle 1 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 1 flags 0x00 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
>       Success
> < ACL data: handle 1 flags 0x00 dlen 510
>     L2CAP(d): cid 0x0040 len 506 ext_ctrl 0x00010000 fcs 0xebe0 [psm 4113]
>       I-frame: Start (len 672) TxSeq 0 ReqSeq 0
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |    3 ++
>  net/bluetooth/l2cap_core.c    |   47 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 49 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo
