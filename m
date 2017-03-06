Return-Path: <javier@osg.samsung.com>
Subject: Re: [PATCH] Bluetooth: btqcomsmd: fix compile-test dependency
To: Arnd Bergmann <arnd@arndb.de>, Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
References: <20170301224907.1263804-1-arnd@arndb.de>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>,
 Loic Poulain <loic.poulain@intel.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <9a54c8a2-f0e4-d2fb-de66-18346056f368@osg.samsung.com>
Date: Mon, 6 Mar 2017 12:35:43 -0300
MIME-Version: 1.0
In-Reply-To: <20170301224907.1263804-1-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Arnd,

On 03/01/2017 07:48 PM, Arnd Bergmann wrote:
> compile-testing fails when QCOM_SMD is a loadable module:
> 
> drivers/bluetooth/built-in.o: In function `btqcomsmd_send':
> btqca.c:(.text+0xa8): undefined reference to `qcom_smd_send'
> drivers/bluetooth/built-in.o: In function `btqcomsmd_probe':
> btqca.c:(.text+0x3ec): undefined reference to `qcom_wcnss_open_channel'
> btqca.c:(.text+0x46c): undefined reference to `qcom_smd_set_drvdata'
> 
> This clarifies the dependency to allow compile-testing only when
> SMD is completely disabled, otherwise the dependency on QCOM_SMD
> will make sure we can link against it.
> 
> Fixes: e27ee2b16bad ("Bluetooth: btqcomsmd: Allow driver to build if COMPILE_TEST is enabled")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks for the fix. The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
