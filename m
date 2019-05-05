Return-Path: <SRS0=kkCe=TF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F66CC004C9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 May 2019 17:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C09205F4
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 May 2019 17:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfEERZz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 May 2019 13:25:55 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51269 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfEERZz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 May 2019 13:25:55 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 84565CEE02;
        Sun,  5 May 2019 19:34:07 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] v7 Add support for LE ping feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1556597465-21783-1-git-send-email-spoorthix.k@intel.com>
Date:   Sun, 5 May 2019 19:25:53 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E76A1D30-87DF-4A83-B9AD-C7DCC193EB6C@holtmann.org>
References: <1556597465-21783-1-git-send-email-spoorthix.k@intel.com>
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
> include/net/bluetooth/hci.h      | 20 +++++++++++
> include/net/bluetooth/hci_core.h |  5 +++
> net/bluetooth/hci_core.c         |  1 +
> net/bluetooth/hci_debugfs.c      | 31 ++++++++++++++++
> net/bluetooth/hci_event.c        | 76 ++++++++++++++++++++++++++++++++++++++++
> 5 files changed, 133 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index c36dc1e..56d5236 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1130,6 +1130,26 @@ struct hci_cp_write_sc_support {
> 	__u8	support;
> } __packed;
> 
> +#define HCI_OP_READ_AUTH_PAYLOAD_TO    0x0c7b
> +struct hci_cp_read_auth_payload_to {
> +	__le16  handle;
> +} __packed;
> +struct hci_rp_read_auth_payload_to {
> +	__u8    status;
> +	__le16  handle;
> +	__le16  timeout;
> +} __packed;
> +
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
> index e5ea633..e8990fe 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -197,6 +197,9 @@ struct adv_info {
> #define DEFAULT_CONN_INFO_MIN_AGE	1000
> #define DEFAULT_CONN_INFO_MAX_AGE	3000
> 
> +/* Default authenticated payload timeout 30000ms/30s */
> +#define DEFAULT_AUTH_PAYLOAD_TIMEOUT	0x0bb8
> +

is this the default value from the specification? And scarp 3000ms/30s conversion. Just say 30s.

> struct amp_assoc {
> 	__u16	len;
> 	__u16	offset;
> @@ -272,6 +275,7 @@ struct hci_dev {
> 	__u16		discov_interleaved_timeout;
> 	__u16		conn_info_min_age;
> 	__u16		conn_info_max_age;
> +	__u16		auth_payload_timeout;
> 	__u8		ssp_debug_mode;
> 	__u8		hw_error_code;
> 	__u32		clock;
> @@ -477,6 +481,7 @@ struct hci_conn {
> 	__u16		disc_timeout;
> 	__u16		conn_timeout;
> 	__u16		setting;
> +	__u16		auth_payload_timeout;
> 	__u16		le_conn_min_interval;
> 	__u16		le_conn_max_interval;
> 	__u16		le_conn_interval;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 7352fe8..7959ee7 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3156,6 +3156,7 @@ struct hci_dev *hci_alloc_dev(void)
> 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
> 	hdev->conn_info_min_age = DEFAULT_CONN_INFO_MIN_AGE;
> 	hdev->conn_info_max_age = DEFAULT_CONN_INFO_MAX_AGE;
> +	hdev->auth_payload_timeout = DEFAULT_AUTH_PAYLOAD_TIMEOUT;
> 
> 	mutex_init(&hdev->lock);
> 	mutex_init(&hdev->req_lock);
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
> index ac2826c..2593b4b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -545,6 +545,54 @@ static void hci_cc_write_sc_support(struct hci_dev *hdev, struct sk_buff *skb)
> 	hci_dev_unlock(hdev);
> }
> 

On hci_conn creation the hcon->auth_payload_time needs to be set to DEFAULT_AUTH_PAYLOAD_TIMEOUT as well.

> +static void hci_cc_read_auth_payload_timeout(struct hci_dev *hdev,
> +					     struct sk_buff *skb)
> +{
> +	struct hci_rp_read_auth_payload_to *rp = (void *)skb->data;
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

Remove this empty line.

> +	if (conn)
> +		conn->auth_payload_timeout = __le16_to_cpu(rp->timeout);
> +
> +	hci_dev_unlock(hdev);
> +}
> +
> +static void hci_cc_write_auth_payload_timeout(struct hci_dev *hdev,
> +					      struct sk_buff *skb)
> +{
> +	struct hci_rp_write_auth_payload_to *rp = (void *)skb->data;
> +	struct hci_conn *conn;
> +	void *sent;
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
> +	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(rp->handle));
> +

Remove this empty line.

> +	if (conn)
> +		conn->auth_payload_timeout = get_unaligned_le16(sent + 2);
> +
> +	hci_dev_unlock(hdev);
> +}
> +
> static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
> {
> 	struct hci_rp_read_local_version *rp = (void *) skb->data;
> @@ -2975,6 +3023,26 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
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

Remove this empty line.

> +	if (test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
> +	    test_bit(HCI_CONN_AES_CCM, &conn->flags) &&
> +	    ((conn->type == ACL_LINK && lmp_ping_capable(hdev)) ||
> +	     (conn->type == LE_LINK && (hdev->le_features[0] & HCI_LE_PING)))) {
> +		struct hci_cp_write_auth_payload_to cp;
> +
> +		cp.handle = cpu_to_le16(conn->handle);
> +		cp.timeout = cpu_to_le16(hdev->auth_payload_timeout);
> +		hci_send_cmd(conn->hdev, HCI_OP_WRITE_AUTH_PAYLOAD_TO,
> +			     sizeof(cp), &cp);
> +	}
> +
> notify:
> 	if (conn->state == BT_CONFIG) {
> 		if (!ev->status)
> @@ -3170,6 +3238,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> 		hci_cc_write_sc_support(hdev, skb);
> 		break;
> 
> +	case HCI_OP_READ_AUTH_PAYLOAD_TO:
> +		hci_cc_read_auth_payload_timeout(hdev, skb);
> +		break;
> +
> +	case HCI_OP_WRITE_AUTH_PAYLOAD_TO:
> +		hci_cc_write_auth_payload_timeout(hdev, skb);
> +		break;
> +
> 	case HCI_OP_READ_LOCAL_VERSION:
> 		hci_cc_read_local_version(hdev, skb);
> 		break;

Regards

Marcel

