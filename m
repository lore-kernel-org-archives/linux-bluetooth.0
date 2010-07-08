Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Send ConfigReq after send a ConnectionRsp
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1278630498-20401-1-git-send-email-gustavo@padovan.org>
References: <1278630498-20401-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 20:12:33 -0300
Message-ID: <1278630753.10421.86.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> The extended L2CAP features requires that one should initiate a
> ConfigReq after send the ConnectionRsp. This patch changes the behaviour
> of the configuration process of our stack.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/l2cap.c |   44 +++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 41 insertions(+), 3 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


