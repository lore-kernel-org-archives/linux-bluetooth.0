Return-Path: <cyrus@holtmann.org>
Message-ID: <1350326527.26318.19.camel@aeonflux>
Subject: Re: [PATCH 14/19] Bluetooth: Do not send data during channel move
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Date: Mon, 15 Oct 2012 20:42:07 +0200
In-Reply-To: <1350315248-7690-15-git-send-email-mathewm@codeaurora.org>
References: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
	 <1350315248-7690-15-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Outgoing ERTM data is queued during a channel move.  The ERTM state
> machine is partially reset at the start of a move, and must be
> resynchronized with the remote state machine at the end of the move.
> Data is not sent so that there are no state transitions between the
> partial reset and the resync.
> 
> Streaming mode frames are dropped during a move.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


