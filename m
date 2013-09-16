Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v5 4/8] Bluetooth: Fix L2CAP Disconnect response for unknown CID
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379325919-19003-5-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 16 Sep 2013 09:10:10 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0C089188-44BC-4B7D-A1EA-C44321B6F671@holtmann.org>
References: <1379325919-19003-1-git-send-email-johan.hedberg@gmail.com> <1379325919-19003-5-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we receive an L2CAP Disconnect Request for an unknown CID we should
> not just silently drop it but reply with a proper Command Reject
> response. This patch fixes this by ensuring that the disconnect handler
> returns a proper error instead of 0 and will cause the function caller
> to send the right response.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

