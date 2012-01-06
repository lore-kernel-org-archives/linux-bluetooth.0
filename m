Return-Path: <cyrus@holtmann.org>
Message-ID: <1325829243.6454.77.camel@aeonflux>
Subject: Re: [PATCH 7/9] Bluetooth: Rename hdev->inq_cache to hdev->discovery
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 05 Jan 2012 21:54:03 -0800
In-Reply-To: <1325776582-10314-8-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
	 <1325776582-10314-8-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This struct is used for not just inquiry caching but also for general
> device discovery state tracking so it's better to rename it to something
> more appropriate.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |   16 ++++++++--------
>  net/bluetooth/hci_core.c         |   12 ++++++------
>  net/bluetooth/hci_sysfs.c        |    2 +-
>  net/bluetooth/mgmt.c             |    2 +-
>  4 files changed, 16 insertions(+), 16 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


