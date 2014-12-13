Return-Path: <cyrus@holtmann.org>
Date: Sat, 13 Dec 2014 20:35:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Toshi Kikuchi <toshik@chromium.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btusb: support public address
 configuration for ath3012
Message-ID: <20141213183518.GA17141@t440s.P-661HNU-F1>
References: <1418410685-29882-1-git-send-email-toshik@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418410685-29882-1-git-send-email-toshik@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Toshi,

On Fri, Dec 12, 2014, Toshi Kikuchi wrote:
> +	skb = __hci_cmd_sync(hdev, 0xfc0b, sizeof(buf), buf, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb)) {
> +		ret = PTR_ERR(skb);
> +		BT_ERR("%s: Change address command failed (%ld)",
> +		       hdev->name, ret);
> +		return ret;
> +	}
> +	kfree_skb(skb);

Don't you need to peek into the received skb to get the command status
as well? Or this command can never fail?

Johan
