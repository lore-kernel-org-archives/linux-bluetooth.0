Return-Path: <cyrus@holtmann.org>
Message-ID: <1325542817.1965.397.camel@aeonflux>
Subject: Re: [PATCH 3/5] Bluetooth: Remove *_bh locks from SCO
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 02 Jan 2012 14:20:17 -0800
In-Reply-To: <1325006928-3338-3-git-send-email-padovan@profusion.mobi>
References: <1325006928-3338-1-git-send-email-padovan@profusion.mobi>
	 <1325006928-3338-2-git-send-email-padovan@profusion.mobi>
	 <1325006928-3338-3-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Those locks are not shared between interrupt and process context anymore,
> so remove the part that disable interrupts. We are still safe because
> preemption is disabled.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/sco.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Same socket list lock situation. RCU?

Regards

Marcel


