Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] Bluetooth: btqcomsmd: Allow driver to build if
 COMPILE_TEST is enabled
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1483363403-25934-1-git-send-email-javier@osg.samsung.com>
Date: Thu, 16 Feb 2017 17:38:30 +0100
Cc: linux-kernel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        linux-bluetooth@vger.kernel.org
Message-Id: <8E87450E-BE99-49AA-8946-EB84400C9665@holtmann.org>
References: <1483363403-25934-1-git-send-email-javier@osg.samsung.com>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Javier,

> The driver only has runtime but no build time dependency with QCOM_SMD &&
> QCOM_WCNSS_CTRL. So it can be built for testing purposes if COMPILE_TEST
> option is enabled.
> 
> This is useful to have more build coverage and make sure that the driver
> is not affected by changes that could cause build regressions.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
> drivers/bluetooth/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
