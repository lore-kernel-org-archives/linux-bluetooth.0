Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/2] Bluetooth: Reject invalid bdaddr types for sockets
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381774673-14150-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 14 Oct 2013 20:27:24 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3EEB0352-3FAC-4FD3-B962-21FF9F094DD6@holtmann.org>
References: <1381774673-14150-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We need to verify that the bdaddr type passed to connect() and bind() is
> within the set of valid values. If it is not we need to cleanly fail
> with EINVAL.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

