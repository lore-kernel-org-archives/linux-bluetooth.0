Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 3/3] Bluetooth: Fix trying to initiate connections when acting as LE slave
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405500969-17578-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Jul 2014 12:01:19 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C2A482A9-2693-4313-AAC5-A7B4FB6D29A2@holtmann.org>
References: <1405500969-17578-1-git-send-email-johan.hedberg@gmail.com> <1405500969-17578-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we have at least one LE slave connection most (probably all)
> controllers will refuse to initiate any new connections. To avoid
> unnecessary failures simply check for this situation up-front and skip
> the connection attempt.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

