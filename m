Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 2/2] Bluetooth: Clean up current advertising instance tracking
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448875305-1347-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Dec 2015 21:44:58 -1000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F95870A8-1981-4E50-8726-AB19005B5184@holtmann.org>
References: <1448875305-1347-1-git-send-email-johan.hedberg@gmail.com> <1448875305-1347-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We can simplify a lot of code by making sure hdev->cur_adv_instance is
> always up-to-date. This allows e.g. the removal of the
> get_current_adv_instance() helper function and the special
> HCI_ADV_CURRENT value. This patch also makes selecting instance 0x00
> explicit in the various calls where advertising instances aren't
> enabled, e.g. when HCI_ADVERTISING is set or we've just finished
> enabling LE.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c    | 12 +++++---
> net/bluetooth/hci_request.c | 68 ++++++++++-----------------------------------
> net/bluetooth/hci_request.h |  8 ++----
> net/bluetooth/mgmt.c        | 10 ++++---
> 4 files changed, 32 insertions(+), 66 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

