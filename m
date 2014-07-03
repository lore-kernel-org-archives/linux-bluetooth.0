Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 3/3] Bluetooth: Add support for background LE scanning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404330122-18770-3-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 3 Jul 2014 09:45:44 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E2F749DD-1515-438D-A99D-69E466172C27@holtmann.org>
References: <1404330122-18770-1-git-send-email-johan.hedberg@gmail.com> <1404330122-18770-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we have one or more devices with HCI_AUTO_CONN_REPORT we should do
> background scanning and emit mgmt_device_found events. This patch
> modifies the hci_update_background_scan() function to extend the
> conditions needed to trigger scanning, and adds the necessary code to
> process_adv_report() to emit mgmt_device_found events.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c  |  7 ++++---
> net/bluetooth/hci_event.c | 25 +++++++++++++++++++++++--
> 2 files changed, 27 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

