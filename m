Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: use __packed in drivers/bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1279558445-9910-1-git-send-email-gustavo@padovan.org>
References: <1279558445-9910-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Jul 2010 10:03:18 -0700
Message-ID: <1279558998.4572.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Use the __packed annotation instead of the __attribute__((packed)).
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  drivers/bluetooth/bpa10x.c     |    2 +-
>  drivers/bluetooth/btmrvl_drv.h |    4 ++--
>  drivers/bluetooth/dtl1_cs.c    |    2 +-
>  drivers/bluetooth/hci_ll.c     |    2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)

patch has been applied. Thanks.

Regards

Marcel


