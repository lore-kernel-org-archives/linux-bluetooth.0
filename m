Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/3] Bluetooth: Add support for local name in scan rsp
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1473280837-4093-1-git-send-email-szymon.janc@codecoup.pl>
Date: Thu, 8 Sep 2016 06:47:43 +0100
Cc: linux-bluetooth@vger.kernel.org,
        =?utf-8?Q?Micha=C5=82_Narajowski?= <michal.narajowski@codecoup.pl>
Message-Id: <D8B8DE00-CC48-4826-B128-A74ECD9AA9E6@holtmann.org>
References: <1473280837-4093-1-git-send-email-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This patch enables appending local name to scan response data.
> 
> Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
> ---
> net/bluetooth/hci_request.c | 28 ++++++++++++++++++++--------
> net/bluetooth/mgmt.c        |  1 +
> 2 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 9968b1c..d1839d2 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -971,14 +971,14 @@ void __hci_req_enable_advertising(struct hci_request *req)
> 	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
> }
> 
> -static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
> +static u8 append_local_name(struct hci_dev *hdev, u8 *ptr, u8 ad_len)
> {
> -	u8 ad_len = 0;
> 	size_t name_len;
> +	int max_len;
> 
> +	max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
> 	name_len = strlen(hdev->dev_name);
> -	if (name_len > 0) {
> -		size_t max_len = HCI_MAX_AD_LENGTH - ad_len - 2;
> +	if (name_len > 0 && max_len > 0) {
> 
> 		if (name_len > max_len) {
> 			name_len = max_len;
> @@ -997,22 +997,34 @@ static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
> 	return ad_len;
> }
> 
> +static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
> +{
> +	return append_local_name(hdev, ptr, 0);
> +}
> +
> static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
> 					u8 *ptr)
> {
> 	struct adv_info *adv_instance;
> +	u32 instance_flags;
> +	u8 scan_rsp_len = 0;
> 
> 	adv_instance = hci_find_adv_instance(hdev, instance);
> 	if (!adv_instance)
> 		return 0;
> 
> -	/* TODO: Set the appropriate entries based on advertising instance flags
> -	 * here once flags other than 0 are supported.
> -	 */
> +	instance_flags = adv_instance->flags;
> +
> 	memcpy(ptr, adv_instance->scan_rsp_data,
> 	       adv_instance->scan_rsp_len);
> 
> -	return adv_instance->scan_rsp_len;
> +	scan_rsp_len += adv_instance->scan_rsp_len;
> +	ptr += adv_instance->scan_rsp_len;
> +
> +	if (instance_flags & MGMT_ADV_FLAG_LOCAL_NAME)
> +		scan_rsp_len = append_local_name(hdev, ptr, scan_rsp_len);
> +
> +	return scan_rsp_len;
> }
> 
> void __hci_req_update_scan_rsp_data(struct hci_request *req, u8 instance)
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 74179b9..5f6942d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5887,6 +5887,7 @@ static u32 get_supported_adv_flags(struct hci_dev *hdev)
> 	flags |= MGMT_ADV_FLAG_DISCOV;
> 	flags |= MGMT_ADV_FLAG_LIMITED_DISCOV;
> 	flags |= MGMT_ADV_FLAG_MANAGED_FLAGS;
> +	flags |= MGMT_ADV_FLAG_LOCAL_NAME;
> 
> 	if (hdev->adv_tx_power != HCI_TX_POWER_INVALID)
> 		flags |= MGMT_ADV_FLAG_TX_POWER;

the Get Advertising Size Information needs to work as well. This screams adding something into mgmt-tester to test it with different length of full and short names.

Regards

Marcel

