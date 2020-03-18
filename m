Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B5DC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 10:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD092076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 10:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgCRKms convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:42:48 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40432 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgCRKms (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 06:42:48 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0B77ACECF2;
        Wed, 18 Mar 2020 11:52:17 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH 1/7] Bluetooth: LL Privacy Delete Store Resolving list
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200312100754.3445-2-sathish.narasimman@intel.com>
Date:   Wed, 18 Mar 2020 11:42:46 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sathish Narsimman <sathish.narasimman@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <AD87C0E6-8A18-4016-9A4C-CE2934B6F862@holtmann.org>
References: <20200312100754.3445-1-sathish.narasimman@intel.com>
 <20200312100754.3445-2-sathish.narasimman@intel.com>
To:     Sathish Narsimman <nsathish41@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

> This patch help to delte the resolving list stored in the BT
> Controller w.r.t BD_ADDR.
> 
> Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> ---
> include/net/bluetooth/hci.h      |  1 +
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_request.c      | 33 ++++++++++++++++++++++++++++++++
> 3 files changed, 36 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 5f60e135aeb6..352bc43940ff 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -457,6 +457,7 @@ enum {
> #define HCI_LE_DATA_LEN_EXT		0x20
> #define HCI_LE_PHY_2M			0x01
> #define HCI_LE_PHY_CODED		0x08
> +#define HCI_LE_LL_PRIVACY		0x40
> #define HCI_LE_EXT_ADV			0x10
> #define HCI_LE_EXT_SCAN_POLICY		0x80
> #define HCI_LE_PHY_2M			0x01
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index d4e28773d378..5f04ef88da35 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1657,6 +1657,8 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
> 
> void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 			       u8 *bdaddr_type);
> +void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
> +				     bdaddr_t *bdaddr);
> 
> #define SCO_AIRMODE_MASK       0x0003
> #define SCO_AIRMODE_CVSD       0x0000
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index bf83179ab9d1..f4bbd3b79210 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -885,6 +885,39 @@ static void hci_req_start_scan(struct hci_request *req, u8 type, u16 interval,
> 	}
> }
> 
> +void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type, bdaddr_t *bdaddr)
> +{
> +	struct hci_cp_le_del_from_resolv_list cp;
> +	struct hci_request req;
> +	struct bdaddr_list_with_irk *irk;
> +
> +	BT_DBG("");
> +
> +	/* Nothing to be done if LL privacy is not supported */
> +	if ( !(hdev->le_features[0] & HCI_LE_LL_PRIVACY) )
> +		return;
> +
> +	if ( !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
> +	    ( hci_dev_test_flag(hdev, HCI_LE_ADV) ||
> +	      hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
> +	      hci_lookup_le_connect(hdev) ) )
> +		return;

please don’t invent your own coding style. Follow the netdev convention.

Regards

Marcel

