Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH 1/2] Bluetooth: Fix setting correct flags in AD
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1457682993-18470-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 11 Mar 2016 07:31:00 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D51D92C9-0D41-4A6A-8F33-05796ECC1FD9@holtmann.org>
References: <1457682993-18470-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> A recent change added MGMT_ADV_FLAG_DISCOV to the flags returned by
> get_adv_instance_flags(), however failed to take into account limited
> discoverable mode. This patch fixes the issue by setting the correct
> discoverability flag in the AD data.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_request.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

