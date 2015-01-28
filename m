Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 1/3] Bluetooth: Fix notifying discovery state upon reset
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422450799-18548-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 28 Jan 2015 13:55:00 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DD71F632-F381-48AF-B452-6F5DE5BC257E@holtmann.org>
References: <1422450799-18548-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When HCI_Reset is issued the discovery state is assumed to be stopped.
> The hci_cc_reset() handler was trying to set the state but it was doing
> it without using the hci_discovery_set_state() function. Because of this
> e.g. the mgmt Discovering event could go without being sent. This patch
> fixes the code to use the hci_discovery_set_state() function instead of
> just blindly setting the state value.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

