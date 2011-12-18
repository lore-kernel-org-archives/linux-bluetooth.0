Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Sun, 18 Dec 2011 21:57:39 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org,
	marcel@holtmann.org, jaikumar@google.com,
	andrei.emeltchenko@intel.com
Subject: Re: [PATCH] Bluetooth: Incoming ACL packets do not force active mode
Message-ID: <20111218235739.GL2621@joana>
References: <1323817562-26262-1-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323817562-26262-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Mat Martineau <mathewm@codeaurora.org> [2011-12-13 15:06:02 -0800]:

> Incoming sk_buffs always have bt_cb(skb)->force_active set to 0, so
> it's misleading to use that value from the control block when calling
> hci_conn_enter_active_mode() for incoming data. The destination socket
> is not known in the HCI layer, so the force_active setting for each
> socket isn't known either. Hard-coding the force_active parameter does
> not change any behavior, but makes it obvious that incoming ACL data
> never exits sniff mode.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/hci_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo
