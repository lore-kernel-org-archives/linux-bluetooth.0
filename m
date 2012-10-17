Return-Path: <cyrus@holtmann.org>
Message-ID: <1350494016.26318.117.camel@aeonflux>
Subject: Re: [PATCHv2 06/19] Bluetooth: Add new ERTM receive states for
 channel move
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org
Date: Wed, 17 Oct 2012 10:13:36 -0700
In-Reply-To: <1350430593-23565-7-git-send-email-mathewm@codeaurora.org>
References: <1350430593-23565-1-git-send-email-mathewm@codeaurora.org>
	 <1350430593-23565-7-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Two new states are required to implement channel moves with the ERTM
> receive state machine.
> 
> The "WAIT_P" state is used by a move responder to wait for a "poll"
> flag after a move is completed (success or failure).  "WAIT_F" is
> similarly used by a move initiator to wait for a "final" flag when the
> move is completing.  In either state, the reqseq value in the
> poll/final frame tells the state machine exactly which frame should be
> expected next.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 104 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


