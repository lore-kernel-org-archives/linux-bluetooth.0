Return-Path: <cyrus@holtmann.org>
Message-ID: <1358196275.1806.108.camel@aeonflux>
Subject: Re: [PATCH 3/4] Bluetooth: Fix using system-global workqueue when
 not necessary
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 14 Jan 2013 12:44:35 -0800
In-Reply-To: <1358195633-29303-4-git-send-email-johan.hedberg@gmail.com>
References: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
	 <1358195633-29303-4-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There's a per-HCI device workqueue (hdev->workqueue) that should be used
> for general per-HCI device work (except hdev->req_workqueue that's for
> hci_request() related work). This patch fixes places using the
> system-global work queue and makes them use the hdev->workqueue instead.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c |    4 ++--
>  net/bluetooth/mgmt.c     |    3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


