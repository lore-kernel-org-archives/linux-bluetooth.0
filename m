Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Fix mgmt error code for negative PIN response
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1389626153-25740-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 15 Jan 2014 22:01:33 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <ADCC3D2F-DC63-4569-9D41-8FAB528B6F03@holtmann.org>
References: <1389626153-25740-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The NOT_PAIRED status is only really suitable for operations where being
> paired is a pre-requisite. Using it e.g. for the mgmt_pair_device
> command seems unintuitive. In the case that either the local or the
> remote user responds with a negative PIN Code response the "PIN or Key
> Missing" HCI status will be generated. This patch changes the mapping of
> this status from the NOT_PAIRED mgmt status to the more intuitive
> AUTH_FAILED mgmt status.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> I had trouble deciding whether we should use REJECTED or AUTH_FAILED
> here, but eventually went with AUTH_FAILED. If someone thinks REJECTED
> is better and has convincing reasons for it I can change it.
> 
> net/bluetooth/mgmt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

