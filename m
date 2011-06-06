Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Jun 2011 14:37:32 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] Bluetooth: Restore accidentally-deleted line
Message-ID: <20110606173732.GB30641@joana>
References: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Mat Martineau <mathewm@codeaurora.org> [2011-06-03 16:21:07 -0700]:

> When code was moved from l2cap_core.c to l2cap_sock.c in commit
> 6de0702b5b93da0ef097aa092b4597fbc024ebba, one line was dropped
> from the old __l2cap_sock_close() implementation. This sk_state
> change should still be in l2cap_chan_close().
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Applied, thanks.

	Gustavo
