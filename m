Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: btintel: fix warning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441314525-12080-1-git-send-email-vincent.stehle@laposte.net>
Date: Fri, 4 Sep 2015 08:26:16 -0700
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel@vger.kernel.org, trivial@kernel.org
Message-Id: <D24A2F94-7167-49D4-9BF2-E5DD5539F2C9@holtmann.org>
References: <1441314525-12080-1-git-send-email-vincent.stehle@laposte.net>
To: =?utf-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vincent,

> Fix compilation the following compilation warning, which happens when
> CONFIG_BT_INTEL is not set:
> 
>  drivers/bluetooth/btintel.h:98:13: warning: ‘btintel_version_info’
>  defined but not used [-Wunused-function]
>   static void btintel_version_info(struct hci_dev *hdev,
>                                    struct intel_version *ver)
>               ^
> 
> Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: trivial@kernel.org
> ---
> 
> 
> Hi,
> 
> This warning can be seen with e.g. ARM imx_v6_v7_defconfig.
> 
> Best regards,
> 
> V. 
> 
> 
> drivers/bluetooth/btintel.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

