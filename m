Return-Path: <SRS0=EfKn=BJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4577CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 09:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280DD2083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jul 2020 09:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgG3JMy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:12:54 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:53207 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgG3JMx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jul 2020 05:12:53 -0400
Received: from marcel-macbook.fritz.box (p4ff9f430.dip0.t-ipconnect.de [79.249.244.48])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3FD16CECF2;
        Thu, 30 Jul 2020 11:22:53 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v5 8/8] Bluetooth: Enable controller RPA resolution using
 Experimental feature
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200723123903.29337-8-sathish.narasimman@intel.com>
Date:   Thu, 30 Jul 2020 11:12:50 +0200
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <1F0277AF-FC7E-4200-8274-A13B590154AA@holtmann.org>
References: <20200723123903.29337-1-sathish.narasimman@intel.com>
 <20200723123903.29337-8-sathish.narasimman@intel.com>
To:     Sathish Narasimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

> This patch adds support to enable the use of RPA Address resolution
> using expermental feature mgmt command.
> 
> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
> include/net/bluetooth/hci.h |   1 +
> net/bluetooth/hci_event.c   |   1 +
> net/bluetooth/hci_request.c |   7 ++-
> net/bluetooth/mgmt.c        | 112 ++++++++++++++++++++++++++++++++++++
> 4 files changed, 120 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 4ff2fc4498f3..55205d805c22 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -307,6 +307,7 @@ enum {
> 	HCI_FORCE_BREDR_SMP,
> 	HCI_FORCE_STATIC_ADDR,
> 	HCI_LL_RPA_RESOLUTION,
> +	HCI_ENABLE_LL_PRIVACY,
> 	HCI_CMD_PENDING,
> 	HCI_FORCE_NO_MITM,
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 628831b15c0a..33d8458fdd4a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5230,6 +5230,7 @@ static void hci_le_enh_conn_complete_evt(struct hci_dev *hdev,
> 			     le16_to_cpu(ev->supervision_timeout));
> 
> 	if (use_ll_privacy(hdev) &&
> +	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
> 	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION))
> 		hci_req_disable_address_resolution(hdev);
> }
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 70e077cc7dfa..435400a43a78 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -678,8 +678,10 @@ void hci_req_add_le_scan_disable(struct hci_request *req, bool rpa_le_conn)
> 
> 	/* Disable address resolution */
> 	if (use_ll_privacy(hdev) &&
> +	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
> 	    hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) && !rpa_le_conn) {
> 		__u8 enable = 0x00;
> +
> 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
> 	}
> }
> @@ -870,8 +872,11 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
> 		return;
> 	}
> 
> -	if (use_ll_privacy(hdev) && addr_resolv) {
> +	if (use_ll_privacy(hdev) &&
> +	    hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY) &&
> +	    addr_resolv) {
> 		u8 enable = 0x01;
> +
> 		hci_req_add(req, HCI_OP_LE_SET_ADDR_RESOLV_ENABLE, 1, &enable);
> 	}
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 47bcfe2fb14c..adde92cf015d 100644
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
> @@ -3795,6 +3801,21 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
> 		idx++;
> 	}
> 
> +	if (use_ll_privacy(hdev)) {

this function can be called with hdev and !hdev and you need to handle this correctly.

	if (hdev && use_ll_privacy(hdev)) {

> +		if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY)) {
> +			flags = BIT(0);
> +			if (!hci_dev_test_flag(hdev, HCI_ADVERTISING))
> +				flags |= BIT(1);
> +		} else
> +			flags = 0;

I think that I should have explained this in a bit more detail. The BIT(1) needs to be always set when the feature can change settings. It means that bluetoothd needs to re-read controller information to get the new settings.

> +
> +		memcpy(rp->features[idx].uuid, rpa_resolution_uuid, 16);
> +		rp->features[idx].flags = cpu_to_le32(flags);
> +		idx++;
> +
> +		new_settings(hdev, sk);
> +	}
> +
> 	rp->feature_count = cpu_to_le16(idx);

I prefer also to extend the buffer to 62 bytes so that it can potentially fit 3 options.

> 
> 	/* After reading the experimental features information, enable
> @@ -3807,6 +3828,27 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
> 				 0, rp, sizeof(*rp) + (20 * idx));
> }
> 
> +static int exp_ll_privacy_feature_changed(bool enabled, struct sock *skip)
> +{
> +	struct mgmt_ev_exp_feature_changed ev;
> +	u32 flags;
> +
> +	memset(&ev, 0, sizeof(ev));
> +	memcpy(ev.uuid, rpa_resolution_uuid, 16);
> +
> +	if (enabled)
> +		flags = 0x03;
> +	else
> +		flags = 0;
> +
> +	ev.flags = cpu_to_le32(flags);
> +
> +	return mgmt_limited_event(MGMT_EV_EXP_FEATURE_CHANGED, NULL,
> +				  &ev, sizeof(ev),
> +				  HCI_MGMT_EXP_FEATURE_EVENTS, skip);

This needs to be send to hdev and not NULL.

> +
> +}
> +
> #ifdef CONFIG_BT_FEATURE_DEBUG
> static int exp_debug_feature_changed(bool enabled, struct sock *skip)
> {
> @@ -3845,6 +3887,18 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
> 		}
> #endif
> 
> +		if (use_ll_privacy(hdev)) {

The experimental setting mgmt might not always be used with a hdev. In addition this feature change must be limited to controller that are powered off.

	if (hdev && use_ll_privacy(hdev) && !hdev_is_powered(hdev)) {

> +			bool changed;
> +
> +			changed = hci_dev_test_flag(hdev,
> +						    HCI_ENABLE_LL_PRIVACY);
> +
> +			hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
> +
> +			if (changed)
> +				exp_ll_privacy_feature_changed(false, sk);
> +		}
> +


> 		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
> 
> 		return mgmt_cmd_complete(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
> @@ -3895,6 +3949,64 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
> 	}
> #endif
> 
> +	if (!memcmp(cp->uuid, rpa_resolution_uuid, 16)) {
> +		bool val, changed;
> +		int err;
> +		u32 flags;
> +

                /* Command requires to use the controller index */               
                if (!hdev)                                                       
                        return mgmt_cmd_status(sk, MGMT_INDEX_NONE,              
                                               MGMT_OP_SET_EXP_FEATURE,          
                                               MGMT_STATUS_INVALID_INDEX);       
                                                                                 
                /* Changes can only be made when controller is powered down */   
                if (hdev_is_powered(hdev))                                       
                        return mgmt_cmd_status(sk, hdev->id,                     
                                               MGMT_OP_SET_EXP_FEATURE,          
                                               MGMT_STATUS_NOT_POWERED); 

> +		/* Parameters are limited to a single octet */
> +		if (data_len != MGMT_SET_EXP_FEATURE_SIZE + 1)
> +			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,

Need to be hdev->id instead of MGMT_INDEX_NONE.

> +					       MGMT_OP_SET_EXP_FEATURE,
> +					       MGMT_STATUS_INVALID_PARAMS);
> +
> +		/* Only boolean on/off is supported */
> +		if (cp->param[0] != 0x00 && cp->param[0] != 0x01)
> +			return mgmt_cmd_status(sk, MGMT_INDEX_NONE,

Same as above.

> +					       MGMT_OP_SET_EXP_FEATURE,
> +					       MGMT_STATUS_INVALID_PARAMS);
> +
> +		val = !!cp->param[0];
> +
> +		if (val) {
> +			changed = !hci_dev_test_flag(hdev,
> +						     HCI_ENABLE_LL_PRIVACY);
> +
> +			hci_dev_set_flag(hdev, HCI_ENABLE_LL_PRIVACY);
> +
> +			/* Enable LL privacy */
> +			flags = BIT(0);
> +			/* Disable HCI_ADVERTISING flag */
> +			flags |= BIT(1);
> +
> +			hci_dev_clear_flag(hdev, HCI_ADVERTISING);
> +
> +		} else {
> +			changed = hci_dev_test_flag(hdev,
> +						    HCI_ENABLE_LL_PRIVACY);
> +			hci_dev_clear_flag(hdev, HCI_ENABLE_LL_PRIVACY);
> +
> +			flags = 0;

BIT(1) needs to be set all the time to indicate that supported settings changed.

> +		}
> +
> +		memcpy(rp.uuid, rpa_resolution_uuid, 16);
> +
> +		rp.flags = cpu_to_le32(flags);
> +
> +		hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
> +
> +		err = mgmt_cmd_complete(sk, MGMT_INDEX_NONE,

Here also we have to use hdev->id and not MGMT_INDEX_NONE.

> +					MGMT_OP_SET_EXP_FEATURE, 0,
> +					&rp, sizeof(rp));
> +
> +		if (changed) {
> +			exp_ll_privacy_feature_changed(val, sk);
> +			new_settings(hdev, sk);

The new_settings is not helpful. The BIT(1) will already indicate that bluetoothd has to re-read the controller info to get the actual supported settings.

> +		}
> +
> +		return err;
> +	}
> +
> 	return mgmt_cmd_status(sk, hdev ? hdev->id : MGMT_INDEX_NONE,
> 			       MGMT_OP_SET_EXP_FEATURE,
> 			       MGMT_STATUS_NOT_SUPPORTED);

So I fixed these all up and hopefully didn’t make a mistake. I am re-sending the whole series with the fixes. Please review.

Regards

Marcel

