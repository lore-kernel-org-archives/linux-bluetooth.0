Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] Bluetooth: hci_qca: Avoid setup failure on missing
 rampatch
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1509967016-24224-1-git-send-email-loic.poulain@linaro.org>
Date: Mon, 6 Nov 2017 14:51:19 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <748062E7-C760-429A-BAD7-01F5AA12BE86@holtmann.org>
References: <1509967016-24224-1-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Assuming that the original code idea was to enable in-band sleeping
> only if the setup_rome method returns succes and run in 'standard'
> mode otherwise, we should not return setup_rome return value which
> makes qca_setup fail if no rampatch/nvm file found.
> 
> This fixes BT issue on the dragonboard-820C p4 which includes the
> following QCA controller:
> hci0: Product:0x00000008
> hci0: Patch  :0x00000111
> hci0: ROM    :0x00000302
> hci0: SOC    :0x00000044
> 
> Since there is no rampatch for this controller revision, just make
> it work as is.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
> drivers/bluetooth/hci_qca.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

