Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4F5C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 14:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9AF6109F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 14:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239558AbhG3OW1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:22:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59674 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239448AbhG3OWI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jul 2021 10:22:08 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id F20A7CED30;
        Fri, 30 Jul 2021 16:22:02 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v11 10/10] Bluetooth: Add offload feature under
 experimental flag
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210727084713.23038-10-kiran.k@intel.com>
Date:   Fri, 30 Jul 2021 16:22:02 +0200
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <E940626A-E8CA-4AB2-AE1F-B3F1CCE07D4B@holtmann.org>
References: <20210727084713.23038-1-kiran.k@intel.com>
 <20210727084713.23038-10-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

> Allow user level process to enable / disable codec offload
> feature through mgmt interface. By default offload codec feature
> is disabled.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> changes in v11:
> - Remove Kconfig
> 
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/mgmt.c        | 98 ++++++++++++++++++++++++++++++++++++-
> net/bluetooth/sco.c         | 10 ++++
> 3 files changed, 108 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 8af8892e18bc..dbbbb974ade6 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -330,6 +330,7 @@ enum {
> 	HCI_ENABLE_LL_PRIVACY,
> 	HCI_CMD_PENDING,
> 	HCI_FORCE_NO_MITM,
> +	HCI_OFFLOAD_CODECS_ENABLED,
> 
> 	__HCI_NUM_FLAGS,
> };
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 3663f880df11..eb10f9597837 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3791,6 +3791,12 @@ static const u8 debug_uuid[16] = {
> };
> #endif
> 
> +/* a6695ace-ee7f-4fb9-881a-5fac66c629af */
> +static const u8 offload_codecs_uuid[16] = {
> +	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f, 0x1a, 0x88,
> +	0xb9, 0x4f, 0x7f, 0xee, 0xce, 0x5a, 0x69, 0xa6,
> +};
> +
> /* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
> static const u8 simult_central_periph_uuid[16] = {
> 	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
> @@ -3806,7 +3812,7 @@ static const u8 rpa_resolution_uuid[16] = {
> static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
> 				  void *data, u16 data_len)
> {
> -	char buf[62];	/* Enough space for 3 features */
> +	char buf[82];   /* Enough space for 4 features: 2 + 20 * 4 */
> 	struct mgmt_rp_read_exp_features_info *rp = (void *)buf;
> 	u16 idx = 0;
> 	u32 flags;
> @@ -3850,6 +3856,26 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
> 		idx++;
> 	}
> 
> +	if (hdev) {
> +		if (hdev->get_data_path_id) {
> +			/* BIT(0): indicating if offload codecs are
> +			 * supported by controller.
> +			 */
> +			flags = BIT(0);
> +
> +			/* BIT(1): indicating if codec offload feature
> +			 * is enabled.
> +			 */
> +			if (hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED))
> +				flags |= BIT(1);
> +		} else {
> +			flags = 0;
> +		}
> +		memcpy(rp->features[idx].uuid, offload_codecs_uuid, 16);
> +		rp->features[idx].flags = cpu_to_le32(flags);
> +		idx++;
> +	}
> +
> 	rp->feature_count = cpu_to_le16(idx);
> 
> 	/* After reading the experimental features information, enable
> @@ -3892,6 +3918,21 @@ static int exp_debug_feature_changed(bool enabled, struct sock *skip)
> }
> #endif
> 
> +static int exp_offload_codec_feature_changed(bool enabled, struct sock *skip)
> +{
> +	struct mgmt_ev_exp_feature_changed ev;
> +
> +	BT_INFO("enabled %d", enabled);
> +
> +	memset(&ev, 0, sizeof(ev));
> +	memcpy(ev.uuid, offload_codecs_uuid, 16);
> +	ev.flags = cpu_to_le32(enabled ? BIT(0) : 0);
> +
> +	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, NULL,
> +				  &ev, sizeof(ev),
> +				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);
> +}
> +
> static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
> 			   void *data, u16 data_len)
> {
> @@ -4038,6 +4079,61 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
> 		return err;
> 	}
> 
> +	if (!memcmp(cp->uuid, offload_codecs_uuid, 16)) {
> +		bool val, changed;
> +		int err;
> +
> +		/* Command requires to use a valid controller index */
> +		if (!hdev)
> +			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
> +					       MGMT_OP_SET_EXP_FEATURE,
> +					       MGMT_STATUS_INVALID_INDEX);
> +
> +		/* Parameters are limited to a single octet */
> +		if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
> +			return mgmt_cmd_status(sk, hdev->id,
> +					       MGMT_OP_SET_EXP_FEATURE,
> +					       MGMT_STATUS_INVALID_PARAMS);
> +
> +		/* Only boolean on/off is supported */
> +		if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
> +			return mgmt_cmd_status(sk, hdev->id,
> +					       MGMT_OP_SET_EXP_FEATURE,
> +					       MGMT_STATUS_INVALID_PARAMS);
> +
> +		val = !!cp->param[0];
> +		changed = (val != hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED));
> +
> +		if (!hdev->get_data_path_id) {
> +			bt_dev_info(hdev, "offload codecs not supported");
> +			return mgmt_cmd_status(sk, hdev->id,
> +					       MGMT_OP_SET_EXP_FEATURE,
> +					       MGMT_STATUS_NOT_SUPPORTED);
> +		}
> +
> +		if (changed) {
> +			if (val)
> +				hci_dev_set_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED);
> +			else
> +				hci_dev_clear_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED);
> +		}
> +
> +		bt_dev_info(hdev, "offload codecs enable %d changed %d",
> +			    val, changed);
> +
> +		memcpy(rp.uuid, offload_codecs_uuid, 16);
> +		rp.flags = cpu_to_le32(val ? BIT(0) : 0);
> +		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
> +		err = mgmt_cmd_complete(sk, hdev->id,
> +					MGMT_OP_SET_EXP_FEATURE, 0,
> +					&rp, sizeof(rp));
> +
> +		if (changed)
> +			exp_offload_codec_feature_changed(val, sk);
> +
> +		return err;
> +	}
> +
> 	return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
> 			       MGMT_OP_SET_EXP_FEATURE,
> 			       MGMT_STATUS_NOT_SUPPORTED);
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 5ff06ac05fef..ba66e082ba9e 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -964,6 +964,11 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
> 			break;
> 		}
> 
> +		if (!hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED)) {
> +			err = -EOPNOTSUPP;
> +			break;
> +		}
> +
> 		if (!hdev->get_codec_config_data) {
> 			err = -EOPNOTSUPP;
> 			break;
> @@ -1160,6 +1165,11 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> 			break;
> 		}
> 
> +		if (!hci_dev_test_flag(hdev, HCI_OFFLOAD_CODECS_ENABLED)) {
> +			err = -EOPNOTSUPP;
> +			break;
> +		}
> +
> 		if (!hdev->get_data_path_id) {
> 			err = -EOPNOTSUPP;
> 			break;

these two and the flag definition itself need to be a lot earlier in the series.

Regards

Marcel

