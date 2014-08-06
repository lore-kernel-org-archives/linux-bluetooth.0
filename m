Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/3] Bluetooth: Create unified helper function for updating page scan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1406880812-19731-2-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 6 Aug 2014 13:00:36 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <739D9424-D12F-4846-8529-2DFE42EB8671@holtmann.org>
References: <1406880812-19731-1-git-send-email-johan.hedberg@gmail.com> <1406880812-19731-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Similar to our hci_update_background_scan() function we can simplify a
> lot of code by creating a unified helper function for doing page scan
> updates. This patch adds such a function to hci_core.c and updates all
> the relevant places to use it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  5 +++
> net/bluetooth/hci_core.c         | 31 +++++++++++++++++
> net/bluetooth/mgmt.c             | 72 +++++++---------------------------------
> 3 files changed, 48 insertions(+), 60 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

