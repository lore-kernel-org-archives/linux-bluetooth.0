Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Nov 2011 13:58:53 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH-v4 3/9] Bluetooth: Differentiate LE User Pairing Responses
Message-ID: <20111121155853.GF2552@joana>
References: <1321480400-17397-1-git-send-email-bgix@codeaurora.org>
 <1321480400-17397-4-git-send-email-bgix@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321480400-17397-4-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

* Brian Gix <bgix@codeaurora.org> [2011-11-16 13:53:14 -0800]:

> Low Energy (LE) pairing responses must be recognized and handled
> differently from BR/EDR pairing responses. BR/EDR responses are
> handled via HCI commands by the LMP layer, and LE responses are
> handled by the Host.
> 
> Signed-off-by: Brian Gix <bgix@codeaurora.org>
> ---
>  net/bluetooth/mgmt.c |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)

Applied, thanks.

	Gustavo
