Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v2] Bluetooth: btqcomsmd: fix compile-test dependency
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170320223110.30431-1-bjorn.andersson@linaro.org>
Date: Tue, 21 Mar 2017 09:23:48 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <16B97F19-379E-43BB-80B7-F2CA58235165@holtmann.org>
References: <20170320223110.30431-1-bjorn.andersson@linaro.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bjorn,

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
> [bjorn: Restructure and clarify dependency to QCOM_WCNSS_CTRL]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> drivers/bluetooth/Kconfig | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Dave, please take this one as well if you decide to take Bjorn’s 3 patches for rpmsg transition.

Regards

Marcel
