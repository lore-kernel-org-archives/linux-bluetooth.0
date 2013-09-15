Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v4 2/8] Bluetooth: Fix double error response for l2cap_create_chan_req
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379269001-6313-3-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 15 Sep 2013 14:05:59 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6861E621-398F-4E7A-B0AA-68B5D17325B6@holtmann.org>
References: <1379269001-6313-1-git-send-email-johan.hedberg@gmail.com> <1379269001-6313-3-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When an L2CAP request handler returns non-zero the calling code will
> send a command reject response. The l2cap_create_chan_req function will
> in some cases send its own response but then still return a -EFAULT
> error which would cause two responses to be sent. This patch fixes this
> by making the function return 0 after sending its own response.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

