Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v5 3/8] Bluetooth: Fix L2CAP error return used for failed channel lookups
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379325919-19003-4-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 16 Sep 2013 09:12:03 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E3F98756-278B-4F43-9DE9-11604217BA71@holtmann.org>
References: <1379325919-19003-1-git-send-email-johan.hedberg@gmail.com> <1379325919-19003-4-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The EFAULT error should only be used for memory address related errors
> and ENOENT might be needed for other purposes than invalid CID errors.
> This patch fixes the l2cap_config_req, l2cap_connect_create_rsp and
> l2cap_create_channel_req handlers to use the unique EBADSLT error to
> indicate failed lookups on a given CID.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

