Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: add WCNSS dependency for HCI driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160829123630.3314682-1-arnd@arndb.de>
Date: Mon, 29 Aug 2016 07:07:00 -0700
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <53D1E31A-3EA8-49C2-B843-C2A89CF24C7A@holtmann.org>
References: <20160829123630.3314682-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arnd,

> The newly added bluetooth driver is based on the soc-specific support,
> but lacks the obvious compile-time dependency on that:
> 
> drivers/bluetooth/btqcomsmd.o: In function `btqcomsmd_probe':
> btqcomsmd.c:(.text.btqcomsmd_probe+0x40): undefined reference to `qcom_wcnss_open_channel'
> btqcomsmd.c:(.text.btqcomsmd_probe+0x5c): undefined reference to `qcom_wcnss_open_channel'
> Makefile:969: recipe for target 'vmlinux' failed
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 90c107dc8b2c ("Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver")
> ---
> drivers/bluetooth/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
