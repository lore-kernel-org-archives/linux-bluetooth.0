Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 2/4] Bluetooth: Refuse peer L2CAP address reading when not connected
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390951011-30576-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 28 Jan 2014 15:29:14 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <108434F7-C985-4FC7-98EF-87A15CEBEF5A@holtmann.org>
References: <1390951011-30576-1-git-send-email-johan.hedberg@gmail.com> <1390951011-30576-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we're not connected the peer address information is undefined. This
> patch fixes the remote address getting to return a proper error in case
> the state is anything else than BT_CONNECTED.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

