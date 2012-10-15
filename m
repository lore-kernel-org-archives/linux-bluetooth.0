Return-Path: <cyrus@holtmann.org>
Message-ID: <1350326868.26318.23.camel@aeonflux>
Subject: Re: [PATCH 19/19] Bluetooth: Start channel move when socket option
 is changed
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Date: Mon, 15 Oct 2012 20:47:48 +0200
In-Reply-To: <1350315248-7690-20-git-send-email-mathewm@codeaurora.org>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
	 <1350315248-7690-20-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Channel moves are triggered by changes to the BT_CHANNEL_POLICY
> sockopt when an ERTM or streaming-mode channel is connected.
> 
> Moves are only started if enable_hs is true.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 20 ++++++++++++++++++++
>  net/bluetooth/l2cap_sock.c    |  5 +++++
>  3 files changed, 26 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


