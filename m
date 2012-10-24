Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Oct 2012 00:45:21 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, sunnyk@codeaurora.org,
	marcel@holtmann.org, andrei.emeltchenko.news@gmail.com
Subject: Re: [PATCHv5 18/18] Bluetooth: Start channel move when socket option
 is changed
Message-ID: <20121024024521.GA13884@joana>
References: <1351031063-11791-1-git-send-email-mathewm@codeaurora.org>
 <1351031063-11791-19-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351031063-11791-19-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-10-23 15:24:23 -0700]:

> Channel moves are triggered by changes to the BT_CHANNEL_POLICY
> sockopt when an ERTM or streaming-mode channel is connected.
> 
> Moves are only started if enable_hs is true.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 19 +++++++++++++++++++
>  net/bluetooth/l2cap_sock.c    |  5 +++++
>  3 files changed, 25 insertions(+)

all 18 patches have been applied upstream. Thanks.

	Gustavo
