Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 May 2012 17:37:51 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	pkrystad@codeaurora.org, ulisses@profusion.mobi,
	andrei.emeltchenko.news@gmail.com
Subject: Re: [PATCH 1/4] Bluetooth: Fix a redundant and problematic incoming
 MTU check
Message-ID: <20120504203751.GC11510@joana>
References: <1335976922-19456-1-git-send-email-mathewm@codeaurora.org>
 <1335976922-19456-2-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335976922-19456-2-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-05-02 09:41:59 -0700]:

> The L2CAP MTU for incoming data is verified differently depending on
> the L2CAP mode, so the check is best performed in a mode-specific
> context.  Checking the incoming MTU before HCI fragment reassembly is
> a layer violation and assumes all bytes after the standard L2CAP
> header are L2CAP data.
> 
> This approach causes issues with unsegmented ERTM or streaming mode
> frames, where there are additional enhanced or extended headers before
> the data payload and possible FCS bytes after the data payload.  A
> valid frame could be as many as 10 bytes larger than the MTU.
> 
> Removing this code is the best fix, because the MTU is checked later
> on for all L2CAP data frames (connectionless, basic, ERTM, and
> streaming).  This also gets rid of outdated locking (socket instead of
> l2cap_chan) and an extra lookup of the channel ID.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |   20 --------------------
>  1 file changed, 20 deletions(-)

Patch has been applied to the bluetooth tree. Thanks.

	Gustavo
