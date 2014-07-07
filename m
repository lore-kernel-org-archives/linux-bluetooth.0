Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Enable passive scanning whenever we're connectable
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404733222-28820-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 7 Jul 2014 15:16:12 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C2650D8B-BB68-4787-9EA9-3DA964E13082@holtmann.org>
References: <1404733222-28820-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Enabling passive scanning always when we're connectable aligns us with
> the BR/EDR page scanning. This is also consistent with the fact that the
> code dealing with passive scanning results will actively try to connect
> any direct advertising event when we're connectable.
> 
> This patch implements the feature by adding the connectable condition to
> hci_update_background_scan() checks for starting scanning and by calling
> hci_update_background_scan() whenever the connectable state changes.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 3 ++-
> net/bluetooth/mgmt.c     | 4 +++-
> 2 files changed, 5 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

