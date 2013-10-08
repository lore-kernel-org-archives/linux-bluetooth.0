Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Fix changing advertising setting while LE is connected
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381240338-13436-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 8 Oct 2013 16:49:50 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1B7F6130-0400-421B-AF01-C335388AA4F0@holtmann.org>
References: <1381240338-13436-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We only (re)enable advertising when LE is disconnected. Trying to enable
> advertising using mgmt_set_advertising while connected should simply
> change the flag but not do anything else (until the connection gets
> dropped). This patch fixes this by making an LE connection lookup to
> determine whether there are any connected devices or not.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

