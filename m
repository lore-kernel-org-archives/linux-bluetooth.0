Return-Path: <cyrus@holtmann.org>
Message-ID: <1350594308.2026.15.camel@aeonflux>
Subject: Re: [PATCHv3 09/18] Bluetooth: Move channel response
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org, andrei.emeltchenko.news@gmail.com
Date: Thu, 18 Oct 2012 14:05:08 -0700
In-Reply-To: <1350583130-3241-10-git-send-email-mathewm@codeaurora.org>
References: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
	 <1350583130-3241-10-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> The move response command includes a result code indicationg
> "pending", "success", or "failure" status.  A pending result is
> received when the remote address is still setting up a physical link,
> and will be followed by success or failure.  On success, logical link
> setup will proceed.  On failure, the move is stopped.  The receiver of
> a move channel response must always follow up by sending a move
> channel confirm command.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |   2 +
>  net/bluetooth/l2cap_core.c    | 164 ++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 161 insertions(+), 5 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


