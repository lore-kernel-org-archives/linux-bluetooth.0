Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Remove useless l2cap_seq_list_remove function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390073579-19074-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 18 Jan 2014 12:13:26 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <F60FFB1D-EFB2-491E-A996-0740FEF97542@holtmann.org>
References: <1390073579-19074-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The only user of l2cap_seq_list_remove() was l2cap_seq_list_pop() which
> only removes the head, meaning only the "else if (seq_list->head ==
> seq)" branch was ever being used. This patch moves the code from this
> branch straight into l2cap_seq_list_pop() and removes the (now useless)
> l2cap_seq_list_remove().
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 40 ++++++++--------------------------------
> 1 file changed, 8 insertions(+), 32 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

