Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 May 2012 16:33:42 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Subject: Re: [PATCH] Bluetooth: Update tx_send_head when sending ERTM data
Message-ID: <20120514193342.GA23475@joana>
References: <1337019873-27017-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337019873-27017-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2012-05-14 11:24:33 -0700]:

> Commit 94122bbe9c8c4ad7ba9f02f9a30bfc95672c404e introduced a problem
> where tx_send_head was not set to point to the first skb in the ERTM
> transmit queue, which stalled data transmission.  This change sets
> that pointer when transmission is not already in progress.
> 
> Reported-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |    3 +++
>  1 file changed, 3 insertions(+)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
