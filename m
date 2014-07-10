Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 3/4] Bluetooth: Remove unneeded mgmt_discoverable function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404983349-6105-3-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 10 Jul 2014 11:17:13 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <702A721D-3AD0-4E03-BDE1-4140CBD25191@holtmann.org>
References: <1404983349-6105-1-git-send-email-johan.hedberg@gmail.com> <1404983349-6105-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Since the HCISETSCAN ioctl is the only non-mgmt user we care about for
> setting the right discoverable state we can simply do the necessary
> updates in the ioctl handler function instead. This then allows the
> removal of the mgmt_discoverable function and should simplify that state
> handling considerably.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 +-
> net/bluetooth/hci_core.c         | 24 +++++++++++---
> net/bluetooth/hci_event.c        | 19 +++---------
> net/bluetooth/mgmt.c             | 67 ++++++++++++++--------------------------
> 4 files changed, 50 insertions(+), 62 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

