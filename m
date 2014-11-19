Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Convert link keys list to use RCU
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1416403342-14715-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 19 Nov 2014 23:20:18 +0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0771A97A-9ED6-46B4-B55E-0500BA9A0F34@holtmann.org>
References: <1416403342-14715-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch converts the hdev->link_keys list to be protected through
> RCU, thereby eliminating the need to hold the hdev lock while accessing
> the list.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_core.c         | 37 ++++++++++++++++++-------------------
> net/bluetooth/hci_event.c        |  4 ++--
> 3 files changed, 21 insertions(+), 21 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

