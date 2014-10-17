Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH bluetooth] Bluetooth: Fix missing channel unlock in l2cap_le_credits
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1413224685-3700-1-git-send-email-mtownsend1973@gmail.com>
Date: Fri, 17 Oct 2014 16:18:24 +0200
Cc: linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <031954F7-A072-495B-A1FA-CC8793C4601C@holtmann.org>
References: <1413224685-3700-1-git-send-email-mtownsend1973@gmail.com>
To: Martin Townsend <mtownsend1973@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

> In the error case where credits is greater than max_credits there
> is a missing l2cap_chan_unlock before returning.
> 
> Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
> ---
> net/bluetooth/l2cap_core.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

