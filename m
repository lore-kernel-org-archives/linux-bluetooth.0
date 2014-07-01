Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: Allow L2CAP getpeername() for BT_CONFIG state
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404205643-31443-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Jul 2014 11:27:10 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F5E7CD15-5A70-4E56-8533-0B822D40BAA5@holtmann.org>
References: <1404205643-31443-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We have all the necessary remote information for getpeername() when we
> are in the BT_CONFIG state so this should be allowed. This is
> particularly important for LE sockets where changing the security level
> will temporarily move the socket into BT_CONFIG state.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

