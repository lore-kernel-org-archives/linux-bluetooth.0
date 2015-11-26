Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 2/2] Bluetooth: Remove unnecessary HCI_ADVERTISING_INSTANCE flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448532959-21912-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 26 Nov 2015 06:50:33 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <068B28B7-D096-49B5-B453-6EE965DDFD14@holtmann.org>
References: <1448532959-21912-1-git-send-email-johan.hedberg@gmail.com> <1448532959-21912-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This flag just tells us whether hdev->adv_instances is empty or not.
> We can equally well use the list_empty() function to get this
> information.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h |  1 -
> net/bluetooth/hci_request.c | 19 ++++++++-----------
> net/bluetooth/mgmt.c        |  8 +-------
> 3 files changed, 9 insertions(+), 19 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

