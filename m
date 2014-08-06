Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/3] Bluetooth: Add convenience function to check for pending power off
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406880812-19731-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 6 Aug 2014 13:00:52 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <243E3BCA-5FCD-41D1-946B-3C805C0FB99B@holtmann.org>
References: <1406880812-19731-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There are several situations where we're interested in knowing whether
> we're currently in the process of powering off an adapter. This patch
> adds a convenience function for the purpose and makes it public since
> we'll soon need to access it from hci_event.c as well.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/mgmt.c             | 52 +++++++++++++++++++++-------------------
> 2 files changed, 29 insertions(+), 24 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

