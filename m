Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: hci_serdev: make hci_serdev_client_ops static
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170623083738.8836-1-colin.king@canonical.com>
Date: Fri, 23 Jun 2017 10:55:53 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <F2C49C06-F6D7-4598-87DE-F4BC98A546F7@holtmann.org>
References: <20170623083738.8836-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

> The structure hci_serdev_client_ops does not need to be in global scope
> and is not modified, so make it static.
> 
> Cleans up sparse warning:
> "symbol 'hci_serdev_client_ops' was not declared. Should it be static?"
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> drivers/bluetooth/hci_serdev.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
