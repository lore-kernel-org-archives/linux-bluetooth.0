Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 May 2012 17:57:25 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	pkrystad@codeaurora.org, ulisses@profusion.mobi,
	andrei.emeltchenko.news@gmail.com
Subject: Re: [PATCH 4/4] Bluetooth: Refactor L2CAP ERTM and streaming
 transmit segmentation
Message-ID: <20120504205725.GA23728@joana>
References: <1335976922-19456-1-git-send-email-mathewm@codeaurora.org>
 <1335976922-19456-5-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335976922-19456-5-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-05-02 09:42:02 -0700]:

> Use more common code for ERTM and streaming mode segmentation and
> transmission, and begin using skb control block data for delaying
> extended or enhanced header generation until just before the packet is
> transmitted.  This code is also better suited for resegmentation,
> which is needed when L2CAP links are reconfigured after an AMP channel
> move.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  net/bluetooth/l2cap_core.c    |  154 ++++++++++++++++++++++++-----------------
>  2 files changed, 92 insertions(+), 63 deletions(-)

Patch looks good to me. Applied to bluetooth-next. Thanks.

	Gustavo
