Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Remove unnecessary queue_monitor_skb() function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1424431584-29831-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 20 Feb 2015 09:21:48 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3AB09DD7-64A5-4ABC-A29E-DC3BC906E356@holtmann.org>
References: <1424431584-29831-1-git-send-email-johan.hedberg@gmail.com> <1424431584-29831-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Now that there's the general purpose hci_send_to_channel() API it will
> do the exact same thing as queue_monitor_skb() when passed the monitor
> HCI channel. This patch removes queue_monitor_skb() and replaces any
> users of it with calls to hci_send_to_channel().
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_sock.c | 32 ++------------------------------
> 1 file changed, 2 insertions(+), 30 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

