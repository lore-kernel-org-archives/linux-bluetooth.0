Return-Path: <cyrus@holtmann.org>
Message-ID: <1349106806.23068.9.camel@aeonflux>
Subject: Re: [PATCH v2] Bluetooth: remove unused member of hci_dev.
From: Marcel Holtmann <marcel@holtmann.org>
To: Rami Rosen <ramirose@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	johan.hedberg@gmail.com
Date: Mon, 01 Oct 2012 17:53:26 +0200
In-Reply-To: <1349113051-27803-1-git-send-email-ramirose@gmail.com>
References: <1349113051-27803-1-git-send-email-ramirose@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rami,

> This patch removes core_data member from hci_dev struct as it is unused.
> 
> Signed-off-by: Rami Rosen <ramirose@gmail.com>
> ---
>  include/net/bluetooth/hci_core.h | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


