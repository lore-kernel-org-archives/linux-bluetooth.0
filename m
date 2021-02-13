Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C0FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 08:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5046E60C41
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Feb 2021 08:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBMI0Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Feb 2021 03:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhBMI0W (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Feb 2021 03:26:22 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E40C061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Feb 2021 00:25:41 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lg21so3161855ejb.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Feb 2021 00:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xOHOjB2P8V+xAfGV1iz/KcML1lOhAqUNYcY689P6FFk=;
        b=egv2QuoO1Dd0i2Zn6g6mx+/6U9Z4KJr3xB8KJo25A4HA1UfaUtN/QV+txHi6Kt5fJP
         0WV9D4tVmazdDB5y/Ncc/V4jL56eZXgRAT8jsKLdy8Di8yqrHw6nW40pjQbxxETxoaNy
         CCBG0hdqfnqkSQpYnov5AVmtePq7rRepAu0sWXJlT/slB3Qkw6TxqxFL5YCxlaqsg6oy
         4iJlzkuZlSTmWrjzQs3wiDS8elGdOshNzQVkiEV3OrzJfrgNzNZDQpasqlJbtHN70GmT
         Iy0F0RJLTclx/ozdlBuBNRjts55HYUiN3f+F5uHqOZSnMEVKvB/uovzyQDNkndOMour2
         x03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xOHOjB2P8V+xAfGV1iz/KcML1lOhAqUNYcY689P6FFk=;
        b=QSYMI7NdkdsKy6n63U1krZfOdGASBqfTqqXji6R1x1VBDVJs2AaNiQL2S+C3tC7rac
         Jm6HbfO4werL4VBj9OhJsoh5nutWLrHgrQ5PrTD6x9VVuQIdoDPPFx2dwd/N464KfXna
         ZXk1JmnGNHoMAK0O/BrDM7yvXWg2yzcfsfURjOIPG86BCysk31t3FxEkKTmxHFAgg8Vc
         p1NGYtTvDbB6hzCdFiaoCUGw7uhBlzXEtdhn4dNVKTYXXCICGWr0xFrCNXracRsgygQx
         xdqtXwnymaxcpsQQZk11v8W5rKHJ1VRBmNt/zHX3sxcOnAJ5cDi8Vxw2O5Ge+Zfes4uD
         ninQ==
X-Gm-Message-State: AOAM533ePDBjlN04oA/MbfQJg2MYAprNsN8qc9eq31197BHKtwEuLeH5
        lY897PRlaijjh7GzOGYpXe9dt7JGbbpbeA==
X-Google-Smtp-Source: ABdhPJwDBKSGpgVmJ20/fn3d3tHnCPeayFBYu1KCE/k8b17gHSf8SOXcoI0tOjhTAOCiDYZZokkAiw==
X-Received: by 2002:a17:906:9b4f:: with SMTP id ep15mr6585232ejc.423.1613204740721;
        Sat, 13 Feb 2021 00:25:40 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id t9sm7117617ejc.51.2021.02.13.00.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 00:25:39 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Sat, 13 Feb 2021 09:25:38 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Bluetooth: Fix not checking advertisement
 bondaries
Message-ID: <YCeNAv7W2JCezoOB@eldamar.lan>
References: <20201024002251.1389267-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024002251.1389267-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Fri, Oct 23, 2020 at 05:22:50PM -0700, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When receiving advertisements check if the length is actually within
> the skb, this also make use of skb_pull to advance on the skb->data
> instead of a custom ptr that way skb->len shall always indicates how
> much data is remaining and can be used to perform checks if there is
> enough data to parse.
> 
> Fixes: a2ec905d1e160a33b2e210e45ad30445ef26ce0e ("Bluetooth: fix kernel oops in store_pending_adv_report")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_event.c | 73 ++++++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 17 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index a4c3703f2e94..6925c090a9e0 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5599,24 +5599,41 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
>  static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>  	u8 num_reports = skb->data[0];
> -	void *ptr = &skb->data[1];
>  
>  	hci_dev_lock(hdev);
>  
> +	skb_pull(skb, sizeof(num_reports));
> +
>  	while (num_reports--) {
> -		struct hci_ev_le_advertising_info *ev = ptr;
> +		struct hci_ev_le_advertising_info *ev;
>  		s8 rssi;
>  
> -		if (ev->length <= HCI_MAX_AD_LENGTH) {
> -			rssi = ev->data[ev->length];
> -			process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
> -					   ev->bdaddr_type, NULL, 0, rssi,
> -					   ev->data, ev->length, false);
> -		} else {
> -			bt_dev_err(hdev, "Dropping invalid advertising data");
> +		if (skb->len < sizeof(*ev)) {
> +			bt_dev_err(hdev, "Malformed advertising report");
> +			break;
> +		}
> +
> +		ev = (void *) skb->data;
> +		skb_pull(skb, sizeof(*ev));
> +
> +		if (skb->len < ev->length || ev->length > HCI_MAX_AD_LENGTH) {
> +			bt_dev_err(hdev, "Malformed advertising data");
> +			break;
>  		}
>  
> -		ptr += sizeof(*ev) + ev->length + 1;
> +		skb_pull(skb, ev->length);
> +
> +		if (skb->len < sizeof(rssi)) {
> +			bt_dev_err(hdev, "Malformed advertising rssi");
> +			break;
> +		}
> +
> +		rssi = skb->data[0];
> +		skb_pull(skb, sizeof(rssi));
> +
> +		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
> +				   ev->bdaddr_type, NULL, 0, rssi,
> +				   ev->data, ev->length, false);
>  	}
>  
>  	hci_dev_unlock(hdev);
> @@ -5669,15 +5686,31 @@ static u8 ext_evt_type_to_legacy(struct hci_dev *hdev, u16 evt_type)
>  static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>  	u8 num_reports = skb->data[0];
> -	void *ptr = &skb->data[1];
>  
>  	hci_dev_lock(hdev);
>  
> +	skb_pull(skb, sizeof(num_reports));
> +
>  	while (num_reports--) {
> -		struct hci_ev_le_ext_adv_report *ev = ptr;
> +		struct hci_ev_le_ext_adv_report *ev;
>  		u8 legacy_evt_type;
>  		u16 evt_type;
>  
> +		if (skb->len < sizeof(*ev)) {
> +			bt_dev_err(hdev, "Malformed ext advertising report");
> +			break;
> +		}
> +
> +		ev = (void *) skb->data;
> +		skb_pull(skb, sizeof(*ev));
> +
> +		if (skb->len < ev->length || ev->length > HCI_MAX_AD_LENGTH) {
> +			bt_dev_err(hdev, "Malformed ext advertising data");
> +			break;
> +		}
> +
> +		skb_pull(skb, ev->length);
> +
>  		evt_type = __le16_to_cpu(ev->evt_type);
>  		legacy_evt_type = ext_evt_type_to_legacy(hdev, evt_type);
>  		if (legacy_evt_type != LE_ADV_INVALID) {
> @@ -5687,7 +5720,6 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
>  					   !(evt_type & LE_EXT_ADV_LEGACY_PDU));
>  		}
>  
> -		ptr += sizeof(*ev) + ev->length;
>  	}
>  
>  	hci_dev_unlock(hdev);
> @@ -5873,19 +5905,26 @@ static void hci_le_direct_adv_report_evt(struct hci_dev *hdev,
>  					 struct sk_buff *skb)
>  {
>  	u8 num_reports = skb->data[0];
> -	void *ptr = &skb->data[1];
>  
>  	hci_dev_lock(hdev);
>  
> +	skb_pull(skb, sizeof(num_reports));
> +
>  	while (num_reports--) {
> -		struct hci_ev_le_direct_adv_info *ev = ptr;
> +		struct hci_ev_le_direct_adv_info *ev;
> +
> +		if (skb->len < sizeof(*ev)) {
> +			bt_dev_err(hdev, "Malformed direct advertising");
> +			break;
> +		}
> +
> +		ev = (void *) skb->data;
> +		skb_pull(skb, sizeof(*ev));
>  
>  		process_adv_report(hdev, ev->evt_type, &ev->bdaddr,
>  				   ev->bdaddr_type, &ev->direct_addr,
>  				   ev->direct_addr_type, ev->rssi, NULL, 0,
>  				   false);
> -
> -		ptr += sizeof(*ev);
>  	}
>  
>  	hci_dev_unlock(hdev);
> -- 
> 2.26.2

Are both these two patches in the series still something which needs
to be applied as fixes, or has it been solved in other ways?

If so can you shorten the Fixes tags to the first 12 characters of the
SHA-1 ID, cf.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
.

Regards,
Salvatore
