Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/2] Bluetooth: Don't let background scanning interfering with discovery
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404728699-11268-2-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 7 Jul 2014 12:37:41 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <848B65F3-02E4-48D4-921B-4B8B5CC8A6B5@holtmann.org>
References: <1404728699-11268-1-git-send-email-johan.hedberg@gmail.com> <1404728699-11268-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we have an active discovery going on we shouldn't do any changes to
> LE scanning when hci_update_background_scan() is called (a call which
> can happen for many different reasons). This patch fixes the issue by
> returning from the function if the discovery state is anything else
> except DISCOVERY_STOPPED.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

