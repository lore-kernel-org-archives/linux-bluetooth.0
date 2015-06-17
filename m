Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v3 1/5] Broadcom Bluetooth UART Device Tree bindings
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434555767-18234-2-git-send-email-ifaenson@broadcom.com>
Date: Wed, 17 Jun 2015 18:55:56 +0200
Cc: linux-bluetooth@vger.kernel.org,
	Arend van Spriel <arend@broadcom.com>
Message-Id: <BCACD307-6706-414E-B5F9-24EBBE1DBDE6@holtmann.org>
References: <1434555767-18234-1-git-send-email-ifaenson@broadcom.com> <1434555767-18234-2-git-send-email-ifaenson@broadcom.com>
To: Ilya Faenson <ifaenson@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

> Device Tree bindings to configure the Broadcom Bluetooth UART device.
> 
> Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
> ---
> .../devicetree/bindings/net/bluetooth/btbcm.txt    | 82 ++++++++++++++++++++++
> 1 file changed, 82 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
> new file mode 100644
> index 0000000..c2cf93a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
> @@ -0,0 +1,82 @@
> +btbcm
> +------
> +
> +Required properties:
> +
> +	- compatible : must be "brcm,brcm-bt-uart".
> +	- tty : tty device connected to this Bluetooth device.

since I am not the DT expert, can we get a few Acks on this patch so that I can take it through the bluetooth-next tree.

Regards

Marcel

