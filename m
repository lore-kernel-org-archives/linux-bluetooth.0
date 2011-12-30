Return-Path: <cyrus@holtmann.org>
Message-ID: <1325272516.1965.295.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Rename extfeatures
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <aguedespe@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, andre.guedes@openbossa.org
Date: Fri, 30 Dec 2011 11:15:16 -0800
In-Reply-To: <1325252044-21134-1-git-send-email-aguedespe@gmail.com>
References: <1325252044-21134-1-git-send-email-aguedespe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch renames hdev->extfeatures to hdev->host_features since it
> holds the extended features Page 1 (aka host features).
> 
> Signed-off-by: Andre Guedes <aguedespe@gmail.com>
> ---
>  include/net/bluetooth/hci_core.h |    4 ++--
>  net/bluetooth/hci_event.c        |    2 +-
>  net/bluetooth/mgmt.c             |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


