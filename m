Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Move hci_update_page_scan to hci_request.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1419023902-16725-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 19 Dec 2014 22:25:25 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <534BF951-2335-4CA2-834E-6050D8F64247@holtmann.org>
References: <1419023902-16725-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This is a left-over from the patch that created hci_request.c. The
> hci_update_page_scan functions should have been moved from hci_core.c
> there.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c    | 56 ---------------------------------------------
> net/bluetooth/hci_request.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 56 insertions(+), 56 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

