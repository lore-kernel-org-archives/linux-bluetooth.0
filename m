Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Don't send RFC for Basic Mode if only it is
 supported
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1280890169-8880-1-git-send-email-gustavo@padovan.org>
References: <1280890169-8880-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Aug 2010 07:27:24 -0700
Message-ID: <1280932044.12579.109.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> If the remote side doesn't support Enhanced Retransmission Mode neither
> Streaming Mode, we shall not send the RFC option.
> Some devices that only supports Basic Mode do not understanding the RFC
> option. This patch fix the regression found with that devices.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/l2cap.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


