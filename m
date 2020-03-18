Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A504EC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 09:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C9D20674
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 09:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="wrw85z6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgCRJaC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:30:02 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47036 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgCRJaB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 05:30:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id d23so26142445ljg.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 02:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:organization:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuN/8GOSi8AnIhbjoZiJkBDnY1+7U7fNl1KzOyOXfdE=;
        b=wrw85z6lwciHvvEEfP1U9SQkkS6X7+nXnY6tNmQwiPPIz54cJxeCz/WMRt4YlymtkL
         l3wcVtOUATIG3ObN7w4Te6ZpP/A/ZtH27ohe7GkBsnzQEVefQ+m2hMMd3PaNk/tPBjtV
         1jts0MrvYmEO8OJIyZLiF3rNg94Vi6T1DiwqzBSEkzfaYJf0WmwKs8xRxmyzXdlcdD3w
         kD61Q1ick/jDiNy0C6sDO8OkVNmgRv36EEq4lTc4kLqfRzL9f4WBWrnBJOdhCRlCEOIr
         B9IP6OzUv+PjL+8rl5k3pFrwNi6aajyAq7E5FkSimnk79q15PlTO2YHRZ2HUOOFeDvWB
         jzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yuN/8GOSi8AnIhbjoZiJkBDnY1+7U7fNl1KzOyOXfdE=;
        b=oJ67cNXevfEUjhsMGw+QUbNm8SB6g1NBhedCPtFCV9z0p2ciV8IV2UvTA0Zoyk4qkK
         Cl1qxqDVUN75iLxEWCtqNHQToqzgxa5OSWstrK9t0hm2tCEGE/fDe+4qUKHBiWcXEK/m
         Qgd5CkSEI0Vn4Z4BcMTZ8GWdbDM+NkvYyYrYVpMFN/BbTSssG1KKBAFSa0ikdp2sx+7W
         7YBKhRoHG0w/dpOqcPx4iYinc2IOI0V7HFy0kthcH1wRs4AWPe14aB9dWZLiv/FA0qju
         1lxziFZm3ub6CtJViRVw5pe3tYtb/ExmVNc7K7orxwM/HEjY5mthVondsfCJbJOHvykx
         j5pg==
X-Gm-Message-State: ANhLgQ1PLEmlMNnve8qxRGhQNFX1fEKhVx86NZpZjwaqOlL5jf9xSbcS
        vb36t8x3cJPfn5e7Fm5SxWiO9Q==
X-Google-Smtp-Source: ADFU+vt/V0jHsvkGPrsNwIdR8+HXi12ytj5mKzQyBJNt856xxNC5iuFT3gIB2gh77PfqGE0qU9Yclw==
X-Received: by 2002:a2e:240e:: with SMTP id k14mr1833268ljk.228.1584523799259;
        Wed, 18 Mar 2020 02:29:59 -0700 (PDT)
Received: from ix.localnet (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id q6sm4138153ljp.21.2020.03.18.02.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 02:29:58 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     Sathish Narsimman <nsathish41@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
        Sathish Narsimman <sathish.narasimman@intel.com>,
        Joy Shermin <shermin.joy@intel.com>
Subject: Re: [PATCH 2/7] Bluetooth: Add device to Resolving List
Date:   Wed, 18 Mar 2020 10:29:57 +0100
Message-ID: <3330738.rHcyvYZEMk@ix>
Organization: CODECOUP
In-Reply-To: <20200312100754.3445-3-sathish.narasimman@intel.com>
References: <20200312100754.3445-1-sathish.narasimman@intel.com> <20200312100754.3445-3-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thursday, 12 March 2020 11:07:49 CET Sathish Narsimman wrote:
> The Patch is used to add the device to resolving list. The patch
> will look for the local IRK list and if the device is present in
> the local resolving list it will be updated and the same updated
> w.r.t to BT controller by first deleting the existing and adding
> the new IRK w.r.t bd_addr.
> 
> Signed-off-by: Sathish Narsimman <sathish.narasimman@intel.com>
> Signed-off-by: Joy Shermin <shermin.joy@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |  2 +
>  net/bluetooth/hci_request.c      | 80 ++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h
> b/include/net/bluetooth/hci_core.h index 5f04ef88da35..e5e09d530ce7 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1657,6 +1657,8 @@ void hci_le_start_enc(struct hci_conn *conn, __le16
> ediv, __le64 rand,
> 
>  void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  			       u8 *bdaddr_type);
> +int hci_req_update_resolving_list(struct hci_dev *hdev,  u8 addr_type,
> +				  bdaddr_t *bdaddr, u8 irk[16]);
>  void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
>  				     bdaddr_t *bdaddr);
> 
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index f4bbd3b79210..88225a9ca1f8 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -885,6 +885,86 @@ static void hci_req_start_scan(struct hci_request *req,
> u8 type, u16 interval, }
>  }
> 
> +int hci_req_update_resolving_list(struct hci_dev *hdev, u8 type, bdaddr_t
> *bdaddr, +				  u8 irk_val[16])
> +{
> +	struct hci_request req;
> +	struct hci_cp_le_add_to_resolv_list cp;
> +	struct bdaddr_list_with_irk *irk;
> +	u8 entries;
> +
> +	BT_DBG("");
> +
> +	/* Nothing to be done if LL privacy is not supported */
> +	if ( !(hdev->le_features[0] & HCI_LE_LL_PRIVACY) )
> +		return -EPROTONOSUPPORT;
> +
> +	/* Resolving List cannot be updated if address resolution
> +	 * in the controller is enabled and advertisement or scanning
> +	 * or create connection command is ongoing.
> +	 */
> +	if ( !hci_dev_test_flag(hdev, HCI_LL_RPA_RESOLUTION) &&
> +	    ( hci_dev_test_flag(hdev, HCI_LE_ADV) ||
> +	      hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
> +	      hci_lookup_le_connect(hdev) ) )
> +		return -EINVAL;
> +
> +	hci_req_init(&req, hdev);
> +
> +	irk = hci_bdaddr_list_lookup_with_irk(&hdev->le_resolv_list, bdaddr,
> type); +	if (irk) {
> +		/* Device is present in resolving list.*/
> +		if (memcmp(irk->peer_irk, irk_val, 16) == 0) {
> +			/* Device present in resolving list with same 
IRK.
> +			 * No HCI communication is required.Sort the
> +			 * Kernel list.
> +			 */
> +			hci_bdaddr_list_add_with_irk(&irk->list, bdaddr, 
type, irk_val, NULL);
> +			return 0;
> +
> +		}
> +		/* IRK has changed for the device in resolving list
> +		 * Queue up commands to delete the existing entry and
> +		 * add new one. Sorting will be done when command complete
> +		 * for add command is receieved.
> +		 */
> +		goto remote;
> +	}
> +	/* Device is not present in resolving list.If resolving list
> +	 * is not full add the device to resolving list.
> +	 */
> +	entries = 0;
> +	list_for_each_entry(irk, &hdev->le_resolv_list, list) {
> +		entries++;
> +	}
> +
> +	if (entries < hdev->le_resolv_list_size)
> +		goto add;
> +
> +	/* If the resolving list is full, queue up HCI command to delete
> +	 * the entry that was used least recently to make space for the
> +	 * new device. Kernel list will be updated when command complete
> +	 * is received.
> +	 */
> +	irk = list_first_entry_or_null(&hdev->le_resolv_list, struct
> bdaddr_list_with_irk, list); +
> +	if (!irk)
> +		return -1;

I'm not sure about this... we should have some fallback mechanism when HW RL 
is full. Maybe some rotation of devies on list or simply disable address 
resolution in controller? Otherwise we won't be able to connect to some of 
paired devices.

> +
> +remote:
> +	hci_req_del_from_resolving_list(hdev, irk->bdaddr_type, &irk-
>bdaddr);
> +
> +add:
> +	cp.bdaddr_type = type;
> +	bacpy(&cp.bdaddr, bdaddr);
> +	memcpy(cp.peer_irk, irk_val, 16);
> +	memcpy(cp.local_irk, hdev->irk, 16);
> +
> +	hci_req_add(&req, HCI_OP_LE_ADD_TO_RESOLV_LIST, sizeof(cp), &cp);
> +	hci_req_run(&req, NULL);
> +	return 0;
> +}
> +
>  void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
> bdaddr_t *bdaddr) {
>  	struct hci_cp_le_del_from_resolv_list cp;


-- 
pozdrawiam
Szymon Janc


