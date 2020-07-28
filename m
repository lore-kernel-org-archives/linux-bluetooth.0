Return-Path: <SRS0=dFGF=BH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15163C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 07:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E903D20829
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jul 2020 07:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgG1HEA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:04:00 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:60583 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgG1HEA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jul 2020 03:04:00 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9E87ACECCC;
        Tue, 28 Jul 2020 09:13:59 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: adding configurable eir_max_name_len
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200727174641.1.Ic2cb84fb029a345c9e3901378717d1ab4e9246ab@changeid>
Date:   Tue, 28 Jul 2020 09:03:57 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A475AABF-D0C9-4D22-9FCC-5D1DD346247E@holtmann.org>
References: <20200727174641.1.Ic2cb84fb029a345c9e3901378717d1ab4e9246ab@changeid>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> This change adds support for a configurable eir_max_name_len for
> platforms which requires a larger than 48 bytes complete name in EIR.
> 
> From bluetoothctl:
> [bluetooth]# system-alias
> 012345678901234567890123456789012345678901234567890123456789
> Changing 012345678901234567890123456789012345678901234567890123456789
> succeeded
> [CHG] Controller DC:71:96:69:02:89 Alias:
> 012345678901234567890123456789012345678901234567890123456789
> 
> From btmon:
> < HCI Command: Write Local Name (0x03|0x0013) plen 248     #109
> [hci0] 88.567990
>         Name:
> 012345678901234567890123456789012345678901234567890123456789
>> HCI Event: Command Complete (0x0e) plen 4  #110 [hci0] 88.663854
>       Write Local Name (0x03|0x0013) ncmd 1
>         Status: Success (0x00)
> @ MGMT Event: Local Name Changed (0x0008) plen 260               
> {0x0004} [hci0] 88.663948
>         Name:
> 012345678901234567890123456789012345678901234567890123456789
>         Short name:
> < HCI Command: Write Extended Inquiry Response (0x03|0x0052) plen 241
> #111 [hci0] 88.663977
>         FEC: Not required (0x00)
>         Name (complete):
> 012345678901234567890123456789012345678901234567890123456789
>         TX power: 12 dBm
>         Device ID: Bluetooth SIG assigned (0x0001)
>           Vendor: Google (224)
>           Product: 0xc405
>           Version: 0.5.6 (0x0056)
>         16-bit Service UUIDs (complete): 7 entries
>           Generic Access Profile (0x1800)
>           Generic Attribute Profile (0x1801)
>           Device Information (0x180a)
>           A/V Remote Control (0x110e)
>           A/V Remote Control Target (0x110c)
>           Handsfree Audio Gateway (0x111f)
>           Audio Source (0x110a)
>> HCI Event: Command Complete (0x0e) plen 4    #112 [hci0] 88.664874
>       Write Extended Inquiry Response (0x03|0x0052) ncmd 1
>         Status: Success (0x00)
> 
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Alain Michaud <alainm@chromium.org>
> 
> ---
> 
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_core.c         |  1 +
> net/bluetooth/hci_request.c      | 29 +++++++++++++++++++++--------
> net/bluetooth/mgmt_config.c      |  5 +++++
> 4 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index bee1b4778ccc..e08f92e7a9ca 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -298,6 +298,7 @@ struct hci_dev {
> 	__u8		dev_name[HCI_MAX_NAME_LENGTH];
> 	__u8		short_name[HCI_MAX_SHORT_NAME_LENGTH];
> 	__u8		eir[HCI_MAX_EIR_LENGTH];
> +	__u16		eir_max_name_len;
> 	__u16		appearance;
> 	__u8		dev_class[3];
> 	__u8		major_class;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 6509f785dd14..b2507bd6613a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3536,6 +3536,7 @@ struct hci_dev *hci_alloc_dev(void)
> 	hdev->adv_instance_cnt = 0;
> 	hdev->cur_adv_instance = 0x00;
> 	hdev->adv_instance_timeout = 0;
> +	hdev->eir_max_name_len = 48;
> 
> 	hdev->sniff_max_interval = 800;
> 	hdev->sniff_min_interval = 80;
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 7c0c2fda04ad..f4714370b7e7 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -578,17 +578,21 @@ static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
> static void create_eir(struct hci_dev *hdev, u8 *data)
> {
> 	u8 *ptr = data;
> +	u8 size_remaining = HCI_MAX_EIR_LENGTH;
> 	size_t name_len;
> 
> 	name_len = strlen(hdev->dev_name);
> 
> 	if (name_len > 0) {
> 		/* EIR Data type */
> -		if (name_len > 48) {
> -			name_len = 48;
> +		if (name_len > min_t(u16, (HCI_MAX_EIR_LENGTH - 2),
> +				     hdev->eir_max_name_len)) {
> +			name_len = min_t(u16, (HCI_MAX_EIR_LENGTH - 2),
> +					 hdev->eir_max_name_len);

if we have proper input validation we could just skip this hard to read code.

> 			ptr[1] = EIR_NAME_SHORT;
> -		} else
> +		} else {
> 			ptr[1] = EIR_NAME_COMPLETE;
> +		}
> 
> 		/* EIR Data length */
> 		ptr[0] = name_len + 1;
> @@ -596,17 +600,21 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
> 		memcpy(ptr + 2, hdev->dev_name, name_len);
> 
> 		ptr += (name_len + 2);
> +		size_remaining -= (name_len + 2);
> 	}
> 
> -	if (hdev->inq_tx_power != HCI_TX_POWER_INVALID) {
> +	if (hdev->inq_tx_power != HCI_TX_POWER_INVALID &&
> +	    size_remaining >= 3) {
> 		ptr[0] = 2;
> 		ptr[1] = EIR_TX_POWER;
> 		ptr[2] = (u8) hdev->inq_tx_power;
> 
> 		ptr += 3;
> +		size_remaining -= 3;
> 	}
> 
> -	if (hdev->devid_source > 0) {
> +	if (hdev->devid_source > 0 &&
> +	    size_remaining >= 10) {
> 		ptr[0] = 9;
> 		ptr[1] = EIR_DEVICE_ID;
> 
> @@ -616,11 +624,16 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
> 		put_unaligned_le16(hdev->devid_version, ptr + 8);
> 
> 		ptr += 10;
> +		size_remaining -= 10;
> 	}
> 
> -	ptr = create_uuid16_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
> -	ptr = create_uuid32_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
> -	ptr = create_uuid128_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
> +	ptr = create_uuid16_list(hdev, ptr, size_remaining);
> +	size_remaining = HCI_MAX_EIR_LENGTH - (ptr - data);
> +
> +	ptr = create_uuid32_list(hdev, ptr, size_remaining);
> +	size_remaining = HCI_MAX_EIR_LENGTH - (ptr - data);
> +
> +	ptr = create_uuid128_list(hdev, ptr, size_remaining);
> }
> 
> void __hci_req_update_eir(struct hci_request *req)
> diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
> index b30b571f8caf..420ea322a5b7 100644
> --- a/net/bluetooth/mgmt_config.c
> +++ b/net/bluetooth/mgmt_config.c
> @@ -67,6 +67,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
> 		HDEV_PARAM_U16(0x001a, le_supv_timeout),
> 		HDEV_PARAM_U16_JIFFIES_TO_MSECS(0x001b,
> 						def_le_autoconnect_timeout),
> +		HDEV_PARAM_U16(0x001c, eir_max_name_len),

We should really have range validation for these parameters. And we should document ranges in mgmt-api.txt as well.

> 	};
> 	struct mgmt_rp_read_def_system_config *rp = (void *)params;
> 
> @@ -138,6 +139,7 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
> 		case 0x0019:
> 		case 0x001a:
> 		case 0x001b:
> +		case 0x001c:
> 			if (len != sizeof(u16)) {
> 				bt_dev_warn(hdev, "invalid length %d, exp %zu for type %d",
> 					    len, sizeof(u16), type);
> @@ -251,6 +253,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
> 			hdev->def_le_autoconnect_timeout =
> 					msecs_to_jiffies(TLV_GET_LE16(buffer));
> 			break;
> +		case 0x0001c:
> +			hdev->eir_max_name_len = TLV_GET_LE16(buffer);
> +			break;
> 		default:
> 			bt_dev_warn(hdev, "unsupported parameter %u", type);
> 			break;

Regards

Marcel

