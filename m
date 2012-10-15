Return-Path: <cyrus@holtmann.org>
Message-ID: <1350325584.26318.11.camel@aeonflux>
Subject: Re: [PATCH 08/19] Bluetooth: Add state to hci_chan
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Date: Mon, 15 Oct 2012 20:26:24 +0200
In-Reply-To: <1350315248-7690-9-git-send-email-mathewm@codeaurora.org>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
	 <1350315248-7690-9-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> On an AMP controller, hci_chan maps to a logical link.  When a channel
> is being moved, the logical link may or may not be connected already.
> The hci_chan->state is used to determine the existance of a useable
> logical link so the link can be either used or requested.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/hci_core.h | 1 +
>  net/bluetooth/hci_conn.c         | 1 +
>  2 files changed, 2 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


