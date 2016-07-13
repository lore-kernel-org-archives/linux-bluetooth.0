Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/2] Bluetooth: Add LED triggers for HCI frames tx and rx
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1466657923-5776-1-git-send-email-guodong.xu@linaro.org>
Date: Wed, 13 Jul 2016 09:07:58 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, xuwei5@hisilicon.com,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, catalin.marinas@arm.com,
	will.deacon@arm.com, haojian.zhuang@linaro.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Tony Lindgren <tony@atomide.com>,
	"open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-Id: <D2545F6D-7100-4B59-A19D-7CF878902BAA@holtmann.org>
References: <1466657923-5776-1-git-send-email-guodong.xu@linaro.org>
To: Guodong Xu <guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Guodong,

> Two LED triggers are defined: tx_led and rx_led. Upon frames
> available in HCI core layer, for tx or for rx, the combined LED
> can blink.
> 
> Verified on HiKey, 96boards. It uses hi6220 SoC and TI WL1835 combo
> chip.
> 
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_core.c         |  3 +++
> net/bluetooth/leds.c             | 15 +++++++++++++++
> net/bluetooth/leds.h             |  2 ++
> 4 files changed, 21 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index dc71473..37b8dd9 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -398,6 +398,7 @@ struct hci_dev {
> 	bdaddr_t		rpa;
> 
> 	struct led_trigger	*power_led;
> +	struct led_trigger	*tx_led, *rx_led;
> 
> 	int (*open)(struct hci_dev *hdev);
> 	int (*close)(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 45a9fc6..c6e1210 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3248,6 +3248,7 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 	skb_queue_tail(&hdev->rx_q, skb);
> 	queue_work(hdev->workqueue, &hdev->rx_work);
> 
> +	hci_leds_blink_oneshot(hdev->rx_led);
> 	return 0;
> }
> EXPORT_SYMBOL(hci_recv_frame);
> @@ -3325,6 +3326,8 @@ static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
> 		BT_ERR("%s sending frame failed (%d)", hdev->name, err);
> 		kfree_skb(skb);
> 	}
> +
> +	hci_leds_blink_oneshot(hdev->tx_led);
> }

so I am not convinced that this is the right way of doing TX/RX activity leds. This would have them purely based on HCI traffic and this would include control frames. I think that we want activity leds for actual radio activity. Meaning that when we have an active connection and ACL packets are exchanged or when we are scanning.

Regards

Marcel
