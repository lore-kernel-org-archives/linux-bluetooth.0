Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH 1/2] Bluetooth: btmrvl: max out host sleep parameter 'gap'
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1452090878-19586-1-git-send-email-akarwar@marvell.com>
Date: Wed, 6 Jan 2016 07:24:08 -0800
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chin-Ran Lo <crlo@marvell.com>
Message-Id: <F723F721-CF7F-4417-BF6F-5D6A260BC7F6@holtmann.org>
References: <1452090878-19586-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> For gpio=0xff (wake up host through SDIO interface) case,
> gap=0xff means no delay (same as gap=0) for incoming data packet
> to be sent to host after host sleep is activated.
> Change it to the maximum delay to reduce the chance that RX
> interrupt could be delivered while host controller suspends.
> 
> Signed-off-by: Chin-Ran Lo <crlo@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

