Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v2 1/4] Bluetooth: Refactor advertising report processing into its own function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395650883-25577-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 24 Mar 2014 13:05:29 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <32429D54-ACE8-4620-B2A9-8E5B3504FD62@holtmann.org>
References: <1395650883-25577-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> As preparation for merging ADV_IND/ADV_SCAN_IND and SCAN_RSP together
> into a single mgmt Device Found event refactor individual advertising
> report handling into a separate function. This will help keep the code
> more readable as more logic gets added.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 21 +++++++++++++--------
> 1 file changed, 13 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

