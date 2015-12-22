Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH 3/3] Bluetooth: bfusb: Fix the return error code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1450792820-15352-3-git-send-email-s.syam@samsung.com>
Date: Tue, 22 Dec 2015 15:27:45 +0100
Cc: linux-bluetooth@vger.kernel.org, syamsidhardh@gmail.com
Message-Id: <61E2D355-D0A7-436C-8032-01D19FC68509@holtmann.org>
References: <1450792820-15352-1-git-send-email-s.syam@samsung.com> <1450792820-15352-3-git-send-email-s.syam@samsung.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

> -ENOMEM is the appropriate error code instead of -EIO.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
> drivers/bluetooth/bfusb.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

