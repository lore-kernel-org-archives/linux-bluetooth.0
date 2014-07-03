Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 2/3] Bluetooth: Allow mgmt_device_found events for kernel-side scanning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404330122-18770-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 3 Jul 2014 09:45:42 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <99066572-1F10-4ABE-89B4-4AC5C286244F@holtmann.org>
References: <1404330122-18770-1-git-send-email-johan.hedberg@gmail.com> <1404330122-18770-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When the kernel is doing LE scanning because of one or more devices
> added with action 0x00 through the Add Device command we do want to let
> mgmt_device_found() to proceed with sending an event. This kind of
> devices are tracked with hdev->pend_le_reports, so check this value
> before bailing out from the function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

