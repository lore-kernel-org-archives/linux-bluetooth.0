Return-Path: <SRS0=UcDi=S3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F9CC10F03
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 12:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126F12084B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 12:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfDYMD0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:03:26 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54928 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfDYMD0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Apr 2019 08:03:26 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id E0D05CEE14;
        Thu, 25 Apr 2019 14:11:34 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] v6 Add support for LE ping feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1556180337-21898-1-git-send-email-spoorthix.k@intel.com>
Date:   Thu, 25 Apr 2019 14:03:23 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <531CC196-CA08-4F84-BF39-99762282D19C@holtmann.org>
References: <1556180337-21898-1-git-send-email-spoorthix.k@intel.com>
To:     SpoorthiX K <spoorthix.k@intel.com>
X-Mailer: Apple Mail (2.3445.104.8)
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
> include/net/bluetooth/hci.h      | 11 +++++++++
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_core.c         |  1 +
> net/bluetooth/hci_debugfs.c      | 31 ++++++++++++++++++++++++
> net/bluetooth/hci_event.c        | 51 ++++++++++++++++++++++++++++++++++++++++
> 5 files changed, 96 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index c36dc1e..6340e9f 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -284,6 +284,7 @@ enum {
> #define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
> #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
> #define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
> +#define HCI_AUTH_PAYLOAD_TIMEOUT msecs_to_jiffies(30000)/* 30 seconds */
> 
> /* HCI data types */
> #define HCI_COMMAND_PKT		0x01
> @@ -1130,6 +1131,16 @@ struct hci_cp_write_sc_support {
> 	__u8	support;
> } __packed;
> 
> +#define HCI_OP_WRITE_AUTH_PAYLOAD_TO    0x0c7c
> +struct hci_cp_write_auth_payload_to {
> +	__le16  handle;
> +	__le16  timeout;
> +} __packed;
> +struct hci_rp_write_auth_payload_to {
> +	__u8    status;
> +	__le16  handle;
> +} __packed;
> +
> #define HCI_OP_READ_LOCAL_OOB_EXT_DATA	0x0c7d
> struct hci_rp_read_local_oob_ext_data {
> 	__u8     status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e5ea633..72f3b31 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -421,6 +421,7 @@ struct hci_dev {
> 	__u32			rpa_timeout;
> 	struct delayed_work	rpa_expired;
> 	bdaddr_t		rpa;
> +	__u16			auth_payload_timeout;

Move it after conn_info_max_page.

> 
> #if IS_ENABLED(CONFIG_BT_LEDS)
> 	struct led_trigger	*power_led;
> @@ -499,6 +500,7 @@ struct hci_conn {
> 	__u8		remote_id;
> 
> 	unsigned int	sent;
> +	__u16		auth_payload_timeout;

Move it after setting.

> 
> 	struct sk_buff_head data_q;
> 	struct list_head chan_list;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 7352fe8..402bbf9 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3147,6 +3147,7 @@ struct hci_dev *hci_alloc_dev(void)
> 	hdev->le_max_tx_time = 0x0148;
> 	hdev->le_max_rx_len = 0x001b;
> 	hdev->le_max_rx_time = 0x0148;
> +	hdev->auth_payload_timeout = 0x0bb8;
> 	hdev->le_max_key_size = SMP_MAX_ENC_KEY_SIZE;
> 	hdev->le_min_key_size = SMP_MIN_ENC_KEY_SIZE;
> 	hdev->le_tx_def_phys = HCI_LE_SET_PHY_1M;

Move this after hdev->conn_info_max_page. And as mentioned before, define DEFAULT_AUTH_PAYLOAD_TIMEOUT constant.

> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 51f5b1e..bb67f4a 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -941,6 +941,35 @@ static int adv_max_interval_get(void *data, u64 *val)
> DEFINE_SIMPLE_ATTRIBUTE(adv_max_interval_fops, adv_max_interval_get,
> 			adv_max_interval_set, "%llu\n");
> 
> +static int auth_payload_timeout_set(void *data, u64 val)
> +{
> +	struct hci_dev *hdev = data;
> +
> +	if (val < 0x0001 || val > 0xffff)
> +		return -EINVAL;
> +
> +	hci_dev_lock(hdev);
> +	hdev->auth_payload_timeout = val;
> +	hci_dev_unlock(hdev);
> +
> +	return 0;
> +}
> +
> +static int auth_payload_timeout_get(void *data, u64 *val)
> +{
> +	struct hci_dev *hdev = data;
> +
> +	hci_dev_lock(hdev);
> +	*val = hdev->auth_payload_timeout;
> +	hci_dev_unlock(hdev);
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(auth_payload_timeout_fops,
> +			auth_payload_timeout_get,
> +			auth_payload_timeout_set, "%llu\n");
> +
> DEFINE_QUIRK_ATTRIBUTE(quirk_strict_duplicate_filter,
> 		       HCI_QUIRK_STRICT_DUPLICATE_FILTER);
> DEFINE_QUIRK_ATTRIBUTE(quirk_simultaneous_discovery,
> @@ -994,6 +1023,8 @@ void hci_debugfs_create_le(struct hci_dev *hdev)
> 			    &adv_max_interval_fops);
> 	debugfs_create_u16("discov_interleaved_timeout", 0644, hdev->debugfs,
> 			   &hdev->discov_interleaved_timeout);
> +	debugfs_create_file("auth_payload_timeout", 0644, hdev->debugfs, hdev,
> +			    &auth_payload_timeout_fops);
> 
> 	debugfs_create_file("quirk_strict_duplicate_filter", 0644,
> 			    hdev->debugfs, hdev,
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index ac2826c..065528e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -579,6 +579,33 @@ static void hci_cc_read_local_commands(struct hci_dev *hdev,
> 		memcpy(hdev->commands, rp->commands, sizeof(hdev->commands));
> }
> 
> +static void hci_cc_write_auth_payload_timeout(struct hci_dev *hdev,
> +					      struct sk_buff *skb)
> +{
> +	struct hci_rp_write_auth_payload_to *rp = (void *)skb->data;
> +	struct hci_conn *conn;
> +
> +	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
> +
> +	if (rp->status)
> +		return;
> +
> +	hci_dev_lock(hdev);
> +
> +	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
> +
> +	if (!conn)
> +		goto unlock;
> +
> +	if (conn->state == BT_CONNECTED) {
> +		hci_conn_hold(conn);
> +		conn->auth_payload_timeout = HCI_AUTH_PAYLOAD_TIMEOUT;
> +		hci_conn_drop(conn);
> +	}

So I have no idea what this is doing. It is clearly not tested code. Unless you are BT_CONNECTED, you will never be encrypted and never reach this state. And then you are setting the value to HCI_AUTH_PAYLOAD_TIMEOUT. How is that even remotely correct. You suppose to set the value that was actually chosen by the write command which can obviously differ based on what you set via debugfs.

> +unlock:
> +	hci_dev_unlock(hdev);

	if (rp->status)
		return;

	sent = hci_sent_cmd_data(hdev, HCI_OP_WRITE_AUTH_PAYLOAD_TO);
	if (!sent)
		return;

	hci_dev_lock(hdev);

	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
	if (!conn)
		conn->auth_payload_timeout = get_unaligned_le16(sent + 2);
		
	hci_dev_unlock(hdev);

> +}
> +
> static void hci_cc_read_local_features(struct hci_dev *hdev,
> 				       struct sk_buff *skb)
> {
> @@ -2975,6 +3002,26 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 		goto unlock;
> 	}
> 
> +	/* Set the default Authenticated Payload Timeout after
> +	 * an LE Link is established. As per Core Spec v5.0, Vol 2, Part B
> +	 * Section 3.3, the HCI command WRITE_AUTH_PAYLOAD_TIMEOUT should be
> +	 * sent when the link is active and Encryption is enabled, the conn
> +	 * type can be either LE or ACL and controller must support LMP Ping.
> +	 * Ensure for AES-CCM encryption as well.
> +	 */
> +
> +	if ((conn->type == LE_LINK || conn->type == ACL_LINK) &&
> +	    (hdev->le_features[0] & HCI_LE_PING) &&
> +	     lmp_ping_capable(hdev) &&
> +		test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
> +		test_bit(HCI_CONN_AES_CCM, &conn->flags)) {

I have said multiple times now that the indentation is wrong here. Please read CodingStyle and the network subsystem specific rules when it comes to indentation.

This statement is also wrong !!!

> +		struct hci_cp_write_auth_payload_to cp;
> +
> +		cp.handle = cpu_to_le16(conn->handle);
> +		cp.timeout = cpu_to_le16(hdev->auth_payload_timeout);
> +		hci_send_cmd(conn->hdev, HCI_OP_WRITE_AUTH_PAYLOAD_TO,
> +			     sizeof(cp), &cp);
> +	}

	if (test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
	    test_bit(HCI_CONN_AES_CCM, &conn->flags) &&
	    ((conn->type == ACL_LINK && lmp_ping_capable(hdev)) ||
	     (conn->type == LE_LINK && (hdev->le_features[0] & HCI_LE_PING))) {
		..
	}
		

> notify:
> 	if (conn->state == BT_CONFIG) {
> 		if (!ev->status)
> @@ -3178,6 +3225,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> 		hci_cc_read_local_commands(hdev, skb);
> 		break;
> 

I would also handle the READ_AUTH_PAYLOAD_TO since it clearly will update the value of the connection correctly.

> +	case HCI_OP_WRITE_AUTH_PAYLOAD_TO:
> +		hci_cc_write_auth_payload_timeout(hdev, skb);
> +		break;
> +
> 	case HCI_OP_READ_LOCAL_FEATURES:
> 		hci_cc_read_local_features(hdev, skb);
> 		break;

Regards

Marcel

