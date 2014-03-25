Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 2/4] Bluetooth: Add scan_rsp parameter to mgmt_device_found()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395736249-11450-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 25 Mar 2014 01:43:25 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C506613C-CE89-4532-B78D-E274440F2859@holtmann.org>
References: <1395736249-11450-1-git-send-email-johan.hedberg@gmail.com> <1395736249-11450-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> In preparation for being able to merge ADV_IND/ADV_SCAN_IND and SCAN_RSP
> together into a single device found event add a second parameter to the
> mgmt_device_found function. For now all callers pass NULL as this
> parameters since we don't yet have storing of the last received
> advertising report.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  5 +++--
> net/bluetooth/hci_event.c        | 10 +++++-----
> net/bluetooth/mgmt.c             | 16 +++++++++++-----
> 3 files changed, 19 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

