Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC77C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Mar 2022 07:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiCHHyJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Mar 2022 02:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiCHHyI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Mar 2022 02:54:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A21003CFD7
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Mar 2022 23:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646725990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J8hHnYsGpvC5TU7EphxVfoEfIwjP9uGo0yZ9ClotWYE=;
        b=Fr29qJLubbAaTSXJ/9oc70fzPsfiu9//bkwo0XQbMu0+crGrlWGkFUW4y3+lz/GF3Aag3T
        aoWtDNlRsUyc8dZaJP7sn3c1SnnsCenuEzGyPi7XBsRYh/LwVlPdAh0mjjmVIX1MQE9Iw+
        c6MxZ3ZJi6qoApdXGjw4bASxdQUy9XM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-ekt90sXaNbSv_vcXlMaAPw-1; Tue, 08 Mar 2022 02:53:09 -0500
X-MC-Unique: ekt90sXaNbSv_vcXlMaAPw-1
Received: by mail-ed1-f72.google.com with SMTP id h17-20020a05640250d100b004133863d836so10129344edb.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Mar 2022 23:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J8hHnYsGpvC5TU7EphxVfoEfIwjP9uGo0yZ9ClotWYE=;
        b=aJ41euRiLvewngSQyh5r28OcFMhtIJv4e/qieVGV09XQnmOdf3ZmFMKLbaqDGGicLf
         GsImymcVpc0MO1gx33D3n4MdbgYcgxN4ZvPyDJpIGeYZhOu91gemLB1vbN+52S3qKRKU
         /aj5j2wkQuQfiaTIrnO9D5NlfUnRzA9/oLeXli3NH2q61gKjV3GDX7/ntbzzpgFSvJtk
         Adz0gLySTCtpgxsraRO0W1U3pqRlyOQ0PC6dqdNT+BQKkG91ulcs3fcOmI03Fq15aCTG
         B198gIMc7ofHginZpVBOiHRU8FgTHFtSrYcUSiGvX3QP8xA037LMQAoxc4hLP3wvMvhn
         lh9Q==
X-Gm-Message-State: AOAM5321soq0Gt8x3ouc8Wgq4GhuTOXvG9lKulDcdOMRe5IM+wyujyIu
        6i3z8DXNOY0erp6+lSBf+vJwJb+gowwjkAfGYxKqHbO9GRSom2Tcza35zhepZZUqZyEjV9PjTBr
        TkRWMODenX9BvwVkwcS1VdbkHS0nl
X-Received: by 2002:a17:907:1ca4:b0:6da:86a4:1ec7 with SMTP id nb36-20020a1709071ca400b006da86a41ec7mr11880754ejc.556.1646725988197;
        Mon, 07 Mar 2022 23:53:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwY5icmhkUl1KViWJFlGUe2BLp5rHGY7H6vVoZqspPDkWJ9Umbdb2nJVmq0BKwPkK7hLambhw==
X-Received: by 2002:a17:907:1ca4:b0:6da:86a4:1ec7 with SMTP id nb36-20020a1709071ca400b006da86a41ec7mr11880742ejc.556.1646725988033;
        Mon, 07 Mar 2022 23:53:08 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm7291072edm.90.2022.03.07.23.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 23:53:07 -0800 (PST)
Message-ID: <72d66def-e23e-0029-6d52-3fbf3cf22849@redhat.com>
Date:   Tue, 8 Mar 2022 08:53:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 1/2] Bluetooth: hci_sync: Add a new quirk to skip
 HCI_FLT_CLEAR_ALL
Content-Language: en-US
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmenzel@molgen.mpg.de
References: <20220307200445.5554-1-swyterzone@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220307200445.5554-1-swyterzone@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On 3/7/22 21:04, Ismael Ferreras Morezuelas wrote:
> Some controllers have problems with being sent a command to clear
> all filtering. While the HCI code does not unconditionally
> send a clear-all anymore at BR/EDR setup (after the state machine
> refactor), there might be more ways of hitting these codepaths
> in the future as the kernel develops.
> 
> Cc: stable@vger.kernel.org
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>

Thanks, the series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for both patches.

Regards,

Hans

> ---
>  include/net/bluetooth/hci.h | 10 ++++++++++
>  net/bluetooth/hci_sync.c    | 16 ++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 35c073d44ec5..5cb095b09a94 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -255,6 +255,16 @@ enum {
>  	 * during the hdev->setup vendor callback.
>  	 */
>  	HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER,
> +
> +	/* When this quirk is set, HCI_OP_SET_EVENT_FLT requests with
> +	 * HCI_FLT_CLEAR_ALL are ignored and event filtering is
> +	 * completely avoided. A subset of the CSR controller
> +	 * clones struggle with this and instantly lock up.
> +	 *
> +	 * Note that devices using this must (separately) disable
> +	 * runtime suspend, because event filtering takes place there.
> +	 */
> +	HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
>  };
>  
>  /* HCI device flags */
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index e31d1150dc71..c3bdaf2de511 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -2812,6 +2812,9 @@ static int hci_set_event_filter_sync(struct hci_dev *hdev, u8 flt_type,
>  	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
>  		return 0;
>  
> +	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
> +		return 0;
> +
>  	memset(&cp, 0, sizeof(cp));
>  	cp.flt_type = flt_type;
>  
> @@ -2832,6 +2835,13 @@ static int hci_clear_event_filter_sync(struct hci_dev *hdev)
>  	if (!hci_dev_test_flag(hdev, HCI_EVENT_FILTER_CONFIGURED))
>  		return 0;
>  
> +	/* In theory the state machine should not reach here unless
> +	 * a hci_set_event_filter_sync() call succeeds, but we do
> +	 * the check both for parity and as a future reminder.
> +	 */
> +	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
> +		return 0;
> +
>  	return hci_set_event_filter_sync(hdev, HCI_FLT_CLEAR_ALL, 0x00,
>  					 BDADDR_ANY, 0x00);
>  }
> @@ -4831,6 +4841,12 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
>  	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
>  		return 0;
>  
> +	/* Some fake CSR controllers lock up after setting this type of
> +	 * filter, so avoid sending the request altogether.
> +	 */
> +	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
> +		return 0;
> +
>  	/* Always clear event filter when starting */
>  	hci_clear_event_filter_sync(hdev);
>  

