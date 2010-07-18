Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Enable L2CAP Extended features by default
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1279481154-4354-1-git-send-email-gustavo@padovan.org>
References: <1279481154-4354-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 18 Jul 2010 12:48:40 -0700
Message-ID: <1279482520.4572.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Change the enable_ertm param to disable_ertm and default value to 0. That
> means that L2CAP Extended features are enabled by default now.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/l2cap.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)

patch has been applied. Thanks.

> -module_param(enable_ertm, bool, 0644);
> -MODULE_PARM_DESC(enable_ertm, "Enable enhanced retransmission mode");
> +module_param(disable_ertm, bool, 0644);
> +MODULE_PARM_DESC(disable_ertm, "Enable enhanced retransmission mode");

And I fixed this to say "Disable enhanced ..." ;)

Regards

Marcel


