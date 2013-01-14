Return-Path: <cyrus@holtmann.org>
Message-ID: <1358196231.1806.107.camel@aeonflux>
Subject: Re: [PATCH 2/4] Bluetooth: Use req_workqueue for hci_request
 operations
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 14 Jan 2013 12:43:51 -0800
In-Reply-To: <1358195633-29303-3-git-send-email-johan.hedberg@gmail.com>
References: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
	 <1358195633-29303-3-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch converts work assignment relying on hci_request() from the
> system-global work queue to the per-HCI device specific work queue
> (hdev->req_workqueue) intended for hci_request() related tasks.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c |    5 +++--
>  net/bluetooth/mgmt.c     |    4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


