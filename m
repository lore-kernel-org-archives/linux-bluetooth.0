Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH 1/3] Bluetooth: bcm203x: Remove redundant error message
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1450792820-15352-1-git-send-email-s.syam@samsung.com>
Date: Tue, 22 Dec 2015 15:27:52 +0100
Cc: linux-bluetooth@vger.kernel.org, syamsidhardh@gmail.com
Message-Id: <E6012E3E-109B-489D-BCFD-E8EEFEF3E35C@holtmann.org>
References: <1450792820-15352-1-git-send-email-s.syam@samsung.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

> devm_kzalloc prints its own OOM message upon failure.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
> drivers/bluetooth/bcm203x.c |    4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

