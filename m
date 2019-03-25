Return-Path: <SRS0=CZwu=R4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8716C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 12:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A058220850
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 12:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbfCYMBk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:01:40 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54053 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbfCYMBj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Mar 2019 08:01:39 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id 19DB1CF35C;
        Mon, 25 Mar 2019 13:09:40 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] Add Support for LE Ping feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1553511171-3362-1-git-send-email-spoorthix.k@intel.com>
Date:   Mon, 25 Mar 2019 13:01:37 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5317062E-C259-4DC8-B425-4AA37AC36E02@holtmann.org>
References: <1553511171-3362-1-git-send-email-spoorthix.k@intel.com>
To:     SpoorthiX K <spoorthix.k@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Spoorthi,

> Changes made to add HCI Write Authenticated Payload timeout
> command for LE Ping feature.
> As per the Core Specification 5.0 Volume 2 Part E Section 7.3.94,
> the following code changes implements
> HCI Write Authenticated Payload timeout command for LE Ping feature.
> 
> Signed-off-by: Spoorthi Ravishankar Koppad <spoorthix.k@intel.com>
> ---
> include/net/bluetooth/hci.h      | 10 +++++++++
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_core.c         |  1 +
> net/bluetooth/hci_debugfs.c      | 31 +++++++++++++++++++++++++++
> net/bluetooth/hci_event.c        | 46 ++++++++++++++++++++++++++++++++++++++++
> 5 files changed, 89 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index fbba43e..a9e7470d9 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1142,6 +1142,16 @@ struct hci_cp_write_sc_support {
> 	__u8	support;
> } __packed;
> 
> +#define HCI_OP_WRITE_AUTH_PAYLOAD_TO    0x0c7c
> +struct hci_cp_write_auth_payload_to {
> +	__le16   conn_handle;
> +	__u16    timeout;
> +} __packed;
> +struct hci_rp_write_auth_payload_to {
> +	__u8     status;
> +	__le16   conn_handle;
> +} __packed;
> +

we never use conn_handle. It has always been handle. And HCI is a little-endian API. So you can not have __u16 in it.

> #define HCI_OP_READ_LOCAL_OOB_EXT_DATA	0x0c7d
> struct hci_rp_read_local_oob_ext_data {
> 	__u8     status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 094e61e..f957bb0 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -421,6 +421,7 @@ struct hci_dev {
> 	__u32			rpa_timeout;
> 	struct delayed_work	rpa_expired;
> 	bdaddr_t		rpa;
> +	__u16			le_auth_payload_timeout;

It is not just LE specific. The BR/EDR Secure Connections also have a payload timeout.

> #if IS_ENABLED(CONFIG_BT_LEDS)
> 	struct led_trigger	*power_led;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d6b2540..a00358b 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3193,6 +3193,7 @@ struct hci_dev *hci_alloc_dev(void)
> 	hdev->le_max_tx_time = 0x0148;
> 	hdev->le_max_rx_len = 0x001b;
> 	hdev->le_max_rx_time = 0x0148;
> +	hdev->le_auth_payload_timeout = 0xbb8;
> 	hdev->le_max_key_size = SMP_MAX_ENC_KEY_SIZE;
> 	hdev->le_min_key_size = SMP_MIN_ENC_KEY_SIZE;
> 	hdev->le_tx_def_phys = HCI_LE_SET_PHY_1M;
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 51f5b1e..2776708 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -941,6 +941,35 @@ static int adv_max_interval_get(void *data, u64 *val)
> DEFINE_SIMPLE_ATTRIBUTE(adv_max_interval_fops, adv_max_interval_get,
> 			adv_max_interval_set, "%llu\n");
> 
> +static int authenticated_payload_timeout_set(void *data, u64 val)
> +{

Use auth_payload_timeout_set as name.

> +	struct hci_dev *hdev = data;
> +
> +	if (val < 0x0001 || val > 0xffff)
> +		return -EINVAL;
> +
> +	hci_dev_lock(hdev);
> +	hdev->le_auth_payload_timeout = val;
> +	hci_dev_unlock(hdev);
> +
> +	return 0;
> +}
> +
> +static int authenticated_payload_timeout_get(void *data, u64 *val)
> +{
> +	struct hci_dev *hdev = data;
> +
> +	hci_dev_lock(hdev);
> +	*val = hdev->le_auth_payload_timeout;
> +	hci_dev_unlock(hdev);
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(authenticated_payload_timeout_fops,
> +			authenticated_payload_timeout_get,
> +			authenticated_payload_timeout_set, "%llu\n");
> +
> DEFINE_QUIRK_ATTRIBUTE(quirk_strict_duplicate_filter,
> 		       HCI_QUIRK_STRICT_DUPLICATE_FILTER);
> DEFINE_QUIRK_ATTRIBUTE(quirk_simultaneous_discovery,
> @@ -992,6 +1021,8 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
> 			    &adv_min_interval_fops);
> 	debugfs_create_file("adv_max_interval", 0644, hdev->debugfs, hdev,
> 			    &adv_max_interval_fops);
> +	debugfs_create_file("authenticated_payload_timeout",
> +			    0644, hdev->debugfs, hdev,
> +			    &authenticated_payload_timeout_fops);
> 	debugfs_create_u16("discov_interleaved_timeout", 0644, hdev->debugfs,
> 			   &hdev->discov_interleaved_timeout);
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 609fd68..001ece2 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -564,6 +564,31 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
> 	}
> }
> 
> +static void hci_cc_write_auth_payload_timeout(struct hci_dev *hdev,
> +					      struct sk_buff *skb)
> +{
> +	struct hci_rp_write_auth_payload_to *rp = (void *)skb->data;
> +	struct hci_cp_write_auth_payload_to *sent;
> +
> +	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
> +
> +	if (rp->status)
> +		return;
> +
> +	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_AUTH_PAYLOAD_TO);
> +	if (!sent)
> +		return;
> +
> +	hci_dev_lock(hdev);
> +
> +	if (!rp->status)
> +		hdev->features[1][0] |= LMP_PING;
> +	else
> +		hdev->features[1][0] &= ~LMP_PING;

This part I do not get all. Why disable LMP_PING. And more importantly why disable the BR/EDR feature?

> +
> +	hci_dev_unlock(hdev);
> +}
> +
> static void hci_cc_read_local_commands(struct hci_dev *hdev,
> 				       struct sk_buff *skb)
> {
> @@ -3170,6 +3195,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> 		hci_cc_write_sc_support(hdev, skb);
> 		break;
> 
> +	case HCI_OP_WRITE_AUTH_PAYLOAD_TO:
> +		hci_cc_write_auth_payload_timeout(hdev, skb);
> +		break;
> +
> 	case HCI_OP_READ_LOCAL_VERSION:
> 		hci_cc_read_local_version(hdev, skb);
> 		break;
> @@ -4971,7 +5000,24 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
> 			params->conn = NULL;
> 		}
> 	}
> +	/* Set the default Authenticated Payload Timeout after
> +	 * an LE Link is established. As per Core Spec v5.0, Vol 2, Part B
> +	 * Section 3.3, the HCI command WRITE_AUTH_PAYLOAD_TIMEOUT should be
> +	 * sent when the link is active and Encryption is enabled, the conn
> +	 * type must be LE and controller must support LE Ping.
> +	 */
> +	if (conn->type == LE_LINK && lmp_ping_capable(hdev) &&
> +	    test_bit(HCI_ENCRYPT, &hdev->flags)) {
> +		struct hci_cp_write_auth_payload_to cp;
> 
> +		cp.conn_handle = cpu_to_le16(conn->handle);
> +		cp.timeout = cpu_to_le16(hdev->le_auth_payload_timeout);
> +		hci_send_cmd(conn->hdev, HCI_OP_WRITE_AUTH_PAYLOAD_TO,
> +			     sizeof(cp), &cp);
> +	} else {
> +		conn->state = BT_CONNECTED;
> +		hci_connect_cfm(conn, status);
> +	}

Reading the comment above, I do not understand why are sending the command here. Have you ever tested that this works? The Connection Complete event will never result in an encrypted connection (except for BR/EDR Security Mode 3). Meaning this should be sent when the encryption state changes to enabled.

In addition, there are a bunch of requirements for the timeout value noted in the specification that we better take care of instead of sending an invalid parameter.

Regards

Marcel

