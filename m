Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: Add support of Toshiba Broadcom based devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1449313776-7498-1-git-send-email-hanipouspilot@gmail.com>
Date: Sat, 5 Dec 2015 08:13:19 -1000
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	stable@vger.kernel.org
Message-Id: <7275E823-1BA0-4F7E-AD0E-C9F0FB318F55@holtmann.org>
References: <1449313776-7498-1-git-send-email-hanipouspilot@gmail.com>
To: Dmitry Tunin <hanipouspilot@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitry,

> BugLink: https://bugs.launchpad.net/bugs/1522949
> 
>    T: Bus=03 Lev=02 Prnt=02 Port=05 Cnt=02 Dev#= 4 Spd=12 MxCh= 0
>    D: Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs= 1
>    P: Vendor=0930 ProdID=0225 Rev=01.12
>    S: Manufacturer=Broadcom Corp
>    S: Product=BCM43142A0
>    S: SerialNumber=4CBB58034671
>    C: #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=0mA
>    I: If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
>    I: If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=(none)
>    I: If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
>    I: If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
> 
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> drivers/bluetooth/btusb.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

