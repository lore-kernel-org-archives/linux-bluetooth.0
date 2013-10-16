Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2] Bluetooth: Reintroduce socket restrictions for LE sockets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381932806-13506-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Oct 2013 16:37:30 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F7DC8DE5-03D2-4EE9-9FA8-58D4B30A810D@holtmann.org>
References: <1381932806-13506-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Right now we do not allow user space to use connection oriented channels
> on LE, and the only CID that can be used is the Attribute Protocol one.
> These restrictions went away together with the recent refactoring of the
> L2CAP code, but this patch puts them back to their appropriate places.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

