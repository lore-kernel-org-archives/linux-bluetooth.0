Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: btmrvl: *_err() and *_info() strings should
 end with newlines
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <4f30b7d1f1933dadaa9a9af8adc66b85b67bb573.1506324921.git.arvind.yadav.cs@gmail.com>
Date: Mon, 25 Sep 2017 15:35:48 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "bluez mailin list (linux-bluetooth@vger.kernel.org)"
        <linux-bluetooth@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <72948618-3BAB-4AE0-9AF7-B04074D89DD9@holtmann.org>
References: <4f30b7d1f1933dadaa9a9af8adc66b85b67bb573.1506324921.git.arvind.yadav.cs@gmail.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arvind,

> pr_err(), dev_err() and pr_info() messages should terminated with
> a new-line to avoid other messages being concatenated onto the end.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
