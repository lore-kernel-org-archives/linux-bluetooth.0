Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 2/2] Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1471046488-14860-2-git-send-email-bjorn.andersson@linaro.org>
Date: Sun, 14 Aug 2016 22:09:59 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
Message-Id: <65B4737D-BE49-4197-A06B-36CF9BCE96BD@holtmann.org>
References: <1471046488-14860-1-git-send-email-bjorn.andersson@linaro.org> <1471046488-14860-2-git-send-email-bjorn.andersson@linaro.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bjorn,

> The Qualcomm WCNSS chip provides two SMD channels to the BT core; one
> for command and one for event packets. This driver exposes the two
> channels as a hci device.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Due to timing issues with the combo chip firmware boot process I had to move
> things around slighly. So this driver is now probed by the wcnss_ctrl driver,
> once the firmware have signaled that boot is completed.
> 
> The wcnss_ctrl changes are merged in v4.8, as is the devicetree binding for
> this part (soc/qcom/qcom,wcnss.txt)
> 
> Changes since v2:
> - This is now a child of wcnss_ctrl
> - Added missing kfree_skb() in btqcomsmd_send()
> 
> drivers/bluetooth/Kconfig     |  12 +++
> drivers/bluetooth/Makefile    |   1 +
> drivers/bluetooth/btqcomsmd.c | 183 ++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 196 insertions(+)
> create mode 100644 drivers/bluetooth/btqcomsmd.c

patch has been applied to bluetooth-next tree.

Regards

Marcel

