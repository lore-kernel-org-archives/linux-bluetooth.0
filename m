Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: use gpiod cansleep version
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1520272955-5023-1-git-send-email-loic.poulain@linaro.org>
Date: Mon, 5 Mar 2018 19:10:37 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Bluetooth mailing list
        <linux-bluetooth@vger.kernel.org>, stefan.wahren@i2se.com
Message-Id: <7C48397B-D91F-4684-9568-E23D632EFCE3@holtmann.org>
References: <1520272955-5023-1-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Some GPIO controller drivers request sleepable context and so can't
> be accessed from IRQ context. Using gpiod_set/get_value accessors
> with such controller leads to a kernel warning since they are
> reserved for atomic context (according to the documentation).
> 
> Use the postfixed _cansleep version instead, indicating that context
> is safe for sleeping if necessary. Note that this is the case here
> since we never toggle the gpio neither from IRQ nor from a spinlocked
> section.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
> drivers/bluetooth/hci_bcm.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

