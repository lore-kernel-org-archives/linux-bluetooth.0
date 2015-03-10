Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Add 'Already Paired' error for Pair Device command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426019680-28715-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 10 Mar 2015 13:43:35 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <49895F14-025B-47D3-93D5-103FB377A316@holtmann.org>
References: <1426019680-28715-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To make the behavior predictable when attempting to pair with a device
> for which we already have a Link Key or Long Term Key, this patch adds a
> new 'Already Paired' error which gets sent in such a scenario.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 ++
> include/net/bluetooth/mgmt.h     |  1 +
> net/bluetooth/hci_core.c         | 27 +++++++++++++++++++++++++++
> net/bluetooth/mgmt.c             |  7 +++++++
> 4 files changed, 37 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

