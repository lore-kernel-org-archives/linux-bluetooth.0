Return-Path: <cyrus@holtmann.org>
Message-ID: <1358196147.1806.106.camel@aeonflux>
Subject: Re: [PATCH 1/4] Bluetooth: Add a new workqueue for hci_request
 operations
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 14 Jan 2013 12:42:27 -0800
In-Reply-To: <1358195633-29303-2-git-send-email-johan.hedberg@gmail.com>
References: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
	 <1358195633-29303-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The hci_request function is blocking and cannot be called through the
> usual per-HCI device workqueue (hdev->workqueue). While hci_request is
> in progress any other work from que queue, including sending HCI

no idea what a que queue is ;)

> commands to the controller would be blocked and eventually cause the
> hci_request call to time out.
> 
> This patch adds a second workqueue to be used by operations needing
> hci_request and thereby avoiding issues with blocking other workqueue
> users.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |   11 +++++++++++
>  2 files changed, 12 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


