Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12882C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 07:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9FF2071B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 07:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGPHN4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:13:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:50343 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPHN4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 03:13:56 -0400
Received: from marcel-macbook.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 69384CECFD;
        Thu, 16 Jul 2020 09:23:52 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v4 8/8] Bluetooth: Enable controller RPA resolution using
 Experimental feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200713062213.3692-9-sathish.narasimman@intel.com>
Date:   Thu, 16 Jul 2020 09:13:53 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5CD116F7-EFB3-47A2-B8D5-0012657F10F9@holtmann.org>
References: <20200713062213.3692-1-sathish.narasimman@intel.com>
 <20200713062213.3692-9-sathish.narasimman@intel.com>
To:     Sathish Narasimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

> This patch adds support to enable the use of RPA Address resolution
> using expermental feature mgmt command.

everything looks fine, except for this patch. I just prefer to only apply the others if we can apply this one as well.

> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
> include/net/bluetooth/hci.h |  1 +
> net/bluetooth/hci_event.c   |  3 ++-
> net/bluetooth/hci_request.c |  6 +++--
> net/bluetooth/mgmt.c        | 52 +++++++++++++++++++++++++++++++++++++
> 4 files changed, 59 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 4ff2fc4498f3..cb284365b4c1 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -307,6 +307,7 @@ enum {
> 	HCI_FORCE_BREDR_SMP,
> 	HCI_FORCE_STATIC_ADDR,
> 	HCI_LL_RPA_RESOLUTION,
> +	HCI_ENABLE_RPA_RESOLUTION,

I would call this ENABLE_LL_PRIVAY. It put its more in line with use_ll_privacy and clearly distinct from the LL_RPA_RESOLUTION with is a HCI operational mode.

> 	HCI_CMD_PENDING,
> 	HCI_FORCE_NO_MITM,
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 684c68cb5c76..c8a5e1e4dba2 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5222,7 +5222,8 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
> 			     le16_to_cpu(ev->latency),
> 			     le16_to_cpu(ev->supervision_timeout));
> 
> -	if (use_ll_privacy(hdev) &&
> +	if (hci_dev_test_flag(hdev, HCI_ENABLE_RPA_RESOLUTION) &&
> +	    use_ll_privacy(hdev) &&
> 	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))

I would leave use_ll_privacy at the top and add the new one after it.

> 		hci_req_disable_address_resolution(hdev);
> }
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index c3193f7f9ff0..cb44b83539e6 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -677,7 +677,8 @@ void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
> 	}
> 
> 	/* Disable address resolution */
> -	if (use_ll_privacy(hdev) &&
> +	if (hci_dev_test_flag(hdev, HCI_ENABLE_RPA_RESOLUTION) &&
> +	    use_ll_privacy(hdev) &&

Same here.

> 	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
> 		__u8 enable = 0x00;
> 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
> @@ -870,7 +871,8 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
> 		return;
> 	}
> 
> -	if (use_ll_privacy(hdev) && addr_resolv) {
> +	if (hci_dev_test_flag(hdev, HCI_ENABLE_RPA_RESOLUTION) &&
> +	    use_ll_privacy(hdev) && addr_resolv) {

And here.

> 		u8 enable = 0x01;
> 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
> 	}
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index c292d5de4dc3..fbe02ab5fa05 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3759,6 +3759,12 @@ static const u8 simult_central_periph_uuid[16] = {
> 	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
> };
> 
> +/* 15c0a148-c273-11ea-b3de-0242ac130004 */
> +static const u8 rpa_resolution_uuid[16] = {
> +	0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
> +	0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
> +};
> +
> static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
> 				  void *data, u16 data_len)
> {
> @@ -3795,6 +3801,17 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
> 		idx++;
> 	}
> 
> +	if (hdev) {

If use_ll_privacy is not available, then we should also not expose this experimental feature.

> +		if (hci_dev_test_flag(hdev, HCI_ENABLE_RPA_RESOLUTION))
> +			flags = BIT(0);
> +		else
> +			flags = 0;
> +

And since we only support the RPA resolution for central mode at the moment, we really now need to disable advertising support. So this one needs to indicate the the supported settings will change when enabled.

> +		memcpy(rp->features[idx].uuid, rpa_resolution_uuid, 16);
> +		rp->features[idx].flags = cpu_to_le32(flags);
> +		idx++;
> +	}
> +
> 	rp->feature_count = cpu_to_le16(idx);
> 
> 	/* After reading the experimental features information, enable
> @@ -3895,6 +3912,41 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
> 	}
> #endif
> 
> +	if (!memcmp(cp->uuid, rpa_resolution_uuid, 16)) {
> +		bool val;
> +		int err;
> +
> +		/* Parameters are limited to a single octet */
> +		if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
> +			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
> +					       MGMT_OP_SET_EXP_FEATURE,
> +					       MGMT_STATUS_INVALID_PARAMS);
> +
> +		/* Only boolean on/off is supported */
> +		if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
> +			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
> +					       MGMT_OP_SET_EXP_FEATURE,
> +					       MGMT_STATUS_INVALID_PARAMS);
> +
> +		val = !!cp->param[0];
> +
> +		if (val)
> +			hci_dev_set_flag(hdev, HCI_ENABLE_RPA_RESOLUTION);
> +		else
> +			hci_dev_clear_flag(hdev, HCI_ENABLE_RPA_RESOLUTION);
> +
> +		memcpy(rp.uuid, rpa_resolution_uuid, 16);
> +		rp.flags = cpu_to_le32(val ? BIT(0) : 0);
> +
> +		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
> +
> +		err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
> +					MGMT_OP_SET_EXP_FEATURE, 0,
> +					&rp, sizeof(rp));

The exp_feature_changed event is missing. In addition you need to handle the ZERO_KEY branch which means it will reset all experimental features back to default.

> +
> +		return err;
> +	}
> +
> 	return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
> 			       MGMT_OP_SET_EXP_FEATURE,
> 			       MGMT_STATUS_NOT_SUPPORTED);

Regards

Marcel

