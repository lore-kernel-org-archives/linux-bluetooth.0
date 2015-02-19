Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Feb 2015 18:27:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] monitor: Add PSM tracking support for LE CoC
Message-ID: <20150219162754.GA5857@t440s.P-661HNU-F1>
References: <1424362834-12706-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424362834-12706-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Feb 19, 2015, Szymon Janc wrote:
> This uses identifier to match simultaneous L2CAP connect requests
> and responses.
> 
> < ACL Data TX: Handle 3585 flags 0x00 dlen 18
>     LE L2CAP: LE Connection Request (0x14) ident 2 len 10
>       PSM: 131 (0x0083)
>       Source CID: 65
>       MTU: 672
>       MPS: 672
>       Credits: 10
> > ACL Data RX: Handle 3585 flags 0x02 dlen 18
>     LE L2CAP: LE Connection Response (0x15) ident 2 len 10
>       Destination CID: 65
>       MTU: 23
>       MPS: 23
>       Credits: 5
>       Result: Connection successful (0x0000)
> < ACL Data TX: Handle 3585 flags 0x00 dlen 27
>     Channel: 65 len 23 [PSM 131 mode 0] {chan 1}
>       17 00 00 00 00 00 17 00 7f 7f 7f 7f 7f 7f 7f 7f  ................
>       7f 7f 7f 7f 7f 7f 7f                             .......
> < ACL Data TX: Handle 3585 flags 0x00 dlen 6
>     Channel: 65 len 2 [PSM 131 mode 0] {chan 1}
>       7f 7f                                            ..
> ---
> V2: pass ident in struct l2cap_frame as suggested by Johan
> 
>  monitor/l2cap.c | 57 +++++++++++++++++++++++++++++++++++++++------------------
>  monitor/l2cap.h |  2 ++
>  2 files changed, 41 insertions(+), 18 deletions(-)

Applied. Thanks.

Johan
