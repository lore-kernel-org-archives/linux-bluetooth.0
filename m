Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 1/2] Bluetooth: Fix trying to disable scanning twice
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393611973-3183-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 28 Feb 2014 10:39:10 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FA08990A-3699-4EA2-A593-C62D02D6D1F8@holtmann.org>
References: <1393611973-3183-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The discovery process has a timer for disabling scanning, however
> scanning might be disabled through other means too like the auto-connect
> process.  We should therefore ensure that the timer is never active
> after sending a HCI command to disable scanning.
> 
> There was some existing code in stop_scan_complete trying to avoid the
> timer when a connect request interrupts a discovery procedure, but the
> other way around was not covered. This patch covers both scenarios by
> canceling the timer as soon as we get a successful command complete for
> the disabling HCI command.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c  | 1 -
> net/bluetooth/hci_event.c | 5 +++++
> 2 files changed, 5 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

