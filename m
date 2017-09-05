Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 2/3] Bluetooth: btqcomsmd: BD address setup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1504607164-12645-2-git-send-email-loic.poulain@linaro.org>
Date: Tue, 5 Sep 2017 14:14:15 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>, robh+dt@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org
Message-Id: <773E21D0-9E00-45B5-8454-3AFFAECCBFD7@holtmann.org>
References: <1504607164-12645-1-git-send-email-loic.poulain@linaro.org>
 <1504607164-12645-2-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> This patch implements the hdev setup function.
> wcnss-bt does not have persistent memory to store
> an allocated BD address. The device is therefore
> marked as unconfigured if no BD address has been
> previously retrieved.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
> v2: Set device as unconfigured if default address detected
>     Add warning if BD addr retrieved from DT
> v3: if no addr retrieved from DT, unconditionally set
>     the invalid BD addr flag.
>     swap and set bdaddr in the platform probe
> v4: Add dt-bindings documentation
>     split patch in two parts (setup, dt prop)
>     use local-bd-address name instead of local-mac-address
> 
> drivers/bluetooth/btqcomsmd.c | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
> index ef730c173d4b..c70fae75c4ad 100644
> --- a/drivers/bluetooth/btqcomsmd.c
> +++ b/drivers/bluetooth/btqcomsmd.c
> @@ -26,6 +26,7 @@
> struct btqcomsmd {
> 	struct hci_dev *hdev;
> 
> +	bdaddr_t bdaddr;
> 	struct rpmsg_endpoint *acl_channel;
> 	struct rpmsg_endpoint *cmd_channel;
> };
> @@ -100,6 +101,29 @@ static int btqcomsmd_close(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static int btqcomsmd_setup(struct hci_dev *hdev)
> +{
> +	struct btqcomsmd *btq = hci_get_drvdata(hdev);
> +	struct sk_buff *skb;
> +
> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +	kfree_skb(skb);
> +
> +	/* Device does not have persistent storage for BD address.
> +	 * Mark the device with invalid BD addr flag if no address
> +	 * retrieved during probe.
> +	 */
> +	if (!bacmp(&btq->bdaddr, BDADDR_ANY)) {
> +		bt_dev_info(hdev, "No BD address configured");
> +		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> +		return 0;
> +	}
> +
> +	return qca_set_bdaddr_rome(hdev, &btq->bdaddr);
> +}
> +

actually I applied a modified version of your patch that also sets invalid BD address when changing the address fails. I think there is no good reason to fail ->setup(). Let them fix that in userspace since the device is actually functional.

Regards

Marcel

