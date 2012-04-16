Return-Path: <cyrus@holtmann.org>
Message-ID: <1334569876.16897.172.camel@aeonflux>
Subject: Re: [PATCHv3 2/2] Bluetooth: Temporary keys should be retained
 during connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 16 Apr 2012 11:51:16 +0200
In-Reply-To: <1334567684-14210-1-git-send-email-vishal.agarwal@stericsson.com>
References: <1334567684-14210-1-git-send-email-vishal.agarwal@stericsson.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

> If a key is non persistent then it should not be used in future
> connections but it should be kept for current connection. And it
> should be removed when connecion is removed.
> 
> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |    6 ++----
>  net/bluetooth/hci_event.c        |    2 ++
>  3 files changed, 5 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


