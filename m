Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Remove __exit from rfcomm_cleanup_ttys()
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1280617025-4001-1-git-send-email-gustavo@padovan.org>
References: <alpine.DEB.2.00.1007301330030.5809@linux-sea-02>
	 <1280617025-4001-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 31 Jul 2010 16:10:06 -0700
Message-ID: <1280617806.12579.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> rfcomm_cleanup_ttys() is also called from rfcomm_init(), so it can't have
> __exit.
> 
> Reported-by: Mat Martineau <mathewm@codeaurora.org>
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/rfcomm/tty.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


