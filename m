Return-Path: <cyrus@holtmann.org>
Message-ID: <1350326429.26318.17.camel@aeonflux>
Subject: Re: [PATCH 12/19] Bluetooth: Handle physical link completion
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Date: Mon, 15 Oct 2012 20:40:29 +0200
In-Reply-To: <1350315248-7690-13-git-send-email-mathewm@codeaurora.org>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
	 <1350315248-7690-13-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Several different actions may be taken when an AMP physical link
> becomes available.  A channel being created on an AMP controller must
> continue the connection process.  A channel being moved needs to
> either send a move request or a move response.  A failed physical link
> will revert to using a BR/EDR controller if possible.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 166 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 166 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


