Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 24 Jul 2017 21:58:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_nokia: select BT_BCM for
 btbcm_set_bdaddr()
Message-ID: <20170724185839.GA15843@x1c>
References: <20170722095747.101069-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170722095747.101069-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sat, Jul 22, 2017, Marcel Holtmann wrote:
> The Nokia devices require the setup of its Public Bluetooth Device
> Address and for that it is required to depend on vendor specific
> commands. For Broadcom based Nokia devices, that is part of btbcm
> module and can be selected via BT_BCM config option.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to bluetooth-next. Thanks.

Johan
