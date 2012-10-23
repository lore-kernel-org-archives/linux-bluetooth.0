Return-Path: <cyrus@holtmann.org>
Message-ID: <1351031786.1785.63.camel@aeonflux>
Subject: Re: [PATCHv5 10/18] Bluetooth: Add logical link confirm
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org, andrei.emeltchenko.news@gmail.com
Date: Tue, 23 Oct 2012 15:36:26 -0700
In-Reply-To: <1351031063-11791-11-git-send-email-mathewm@codeaurora.org>
References: <1351031063-11791-1-git-send-email-mathewm@codeaurora.org>
	 <1351031063-11791-11-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> The logical link confirm callback is executed when the AMP controller
> completes its logical link setup.  During a channel move, a newly
> formed logical link allows a move responder to send a move channel
> response.  A move initiator will send a move channel confirm.  A
> failed logical link will end the channel move and send an appropriate
> response or confirm command indicating a failure.
> 
> If the channel is being created on an AMP controller, L2CAP
> configuration is completed after the logical link is set up.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c | 134 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 123 insertions(+), 11 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


