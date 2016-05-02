Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 2/2] btmrvl: add platform specific wakeup interrupt support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1461679047-22631-2-git-send-email-akarwar@marvell.com>
Date: Mon, 2 May 2016 10:28:38 -0700
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Wei-Ning Huang <wnhuang@chromium.org>,
	Xinming Hu <huxm@marvell.com>
Message-Id: <A90EA9D9-9C3E-43EB-A52A-342DE4881B97@holtmann.org>
References: <1461679047-22631-1-git-send-email-akarwar@marvell.com> <1461679047-22631-2-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> On some arm-based platforms, we need to configure platform specific
> parameters by device tree node and also define our node as a child
> node of parent SDIO host controller.
> This patch parses these parameters from device tree. It includes
> calibration data download to firmware, wakeup pin configured to firmware,
> and soc specific wake up gpio, which will be set as wakeup interrupt pin.
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_drv.h  | 11 ++++++
> drivers/bluetooth/btmrvl_main.c | 35 ++++++++++--------
> drivers/bluetooth/btmrvl_sdio.c | 79 +++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btmrvl_sdio.h |  6 ++++
> 4 files changed, 116 insertions(+), 15 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

