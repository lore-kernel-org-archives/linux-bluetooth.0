Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH] Bluetooth: btwilink: Fix probe return value
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20161020070509.24042-1-jacob@teenage.engineering>
Date: Thu, 20 Oct 2016 10:17:38 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <3B378E7D-08D6-4795-BE09-7D6561A41F4E@holtmann.org>
References: <20161020070509.24042-1-jacob@teenage.engineering>
To: Jacob Siverskog <jacob@teenage.engineering>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jacob,

> Probe functions should return 0 on success. This driver's probe
> returns the value returned by hci_register_dev(), which is the hci
> index. This works for systems with only one hci device (id = 0) but
> for systems where the btwilink device ends up with an id larger than
> 0, things will start to fall apart.
> 
> Make the probe function return 0 on success.
> 
> Signed-off-by: Jacob Siverskog <jacob@teenage.engineering>
> ---
> drivers/bluetooth/btwilink.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

