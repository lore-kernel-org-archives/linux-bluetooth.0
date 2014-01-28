Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 1/4] Bluetooth: Free up l2cap_chan->sport when initiating a connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1390951011-30576-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 28 Jan 2014 15:28:53 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <D3F37431-2DE2-45C3-A3F0-AF1ED256943B@holtmann.org>
References: <1390951011-30576-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The sport variable is used to track the allocation of the local PSM
> database to ensure no two sockets take the same local PSM. It is
> acquired upon bind() but needs to be freed up if the socket ends up
> becoming a client one. This patch adds the clearing of the value when
> l2cap_chan_connect is called.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 7 +++++++
> 1 file changed, 7 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

