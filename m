Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Avoid missing rampatch failure with
 userspace fw loader
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1523860824-3392-1-git-send-email-amit.pundir@linaro.org>
Date: Wed, 18 Apr 2018 09:33:11 +0200
Cc: LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        dragonboard@lists.96boards.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Stable <stable@vger.kernel.org>
Message-Id: <1C10FB33-04EA-4409-BE56-6C8BFC28B3ED@holtmann.org>
References: <1523860824-3392-1-git-send-email-amit.pundir@linaro.org>
To: Amit Pundir <amit.pundir@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amit,

> AOSP use userspace firmware loader to load firmwares, which will
> return -EAGAIN in case qca/rampatch_00440302.bin is not found.
> Since there is no rampatch for dragonboard820c QCA controller
> revision, just make it work as is.
> 
> CC: Loic Poulain <loic.poulain@linaro.org>
> CC: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> CC: Marcel Holtmann <marcel@holtmann.org>
> CC: Johan Hedberg <johan.hedberg@gmail.com>
> CC: Stable <stable@vger.kernel.org>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> drivers/bluetooth/hci_qca.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel
