Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Fix enabling fast connectable on LE-only controllers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1382363513-4083-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 21 Oct 2013 16:19:06 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EFA3D3AC-7302-4DAD-9A74-6628876C9EC6@holtmann.org>
References: <1382363513-4083-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The current "fast connectable" feature is BR/EDR-only, so add a proper
> check for BR/EDR support before proceeding with the associated HCI
> commands.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

