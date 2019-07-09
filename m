Return-Path: <SRS0=Cqm8=VG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3D4C73C50
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 14:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE84214AF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 14:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kJQaPdBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfGIOw3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:52:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32773 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIOw3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jul 2019 10:52:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so4630350pfq.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2019 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bOo5FIdECv8Dk1vdDxbdUDP2ytSbYy3HpCn39a/nI1k=;
        b=kJQaPdBPe6uBds+wMPLAlAq5MTB/OwElJ+xLcT72OmqhYnRuOQpKFDauzlKzCNTH/o
         Ab2W9s8Hl8l3WQo4KCWreQ6Fe/7COl70EYhwAYBBnwb3wbGV2Mr//c+c3dGHDV3zAc71
         Iod2Yn8Vuo56S91zQ4wNLIB3q/UAZZkHE6IGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bOo5FIdECv8Dk1vdDxbdUDP2ytSbYy3HpCn39a/nI1k=;
        b=kfbczYLJb2myIaDOh6b06RFcMdIz7hXg46sXVrcR1X1WymjseY/7N6J8jzWbKpqMDZ
         Nb/xsh7wmOYb7XvhC1eB8Rb/AVCd8PxBY2u5tIn2us5E9Fdki3iAyod9SQnuozpziK+z
         iWm7HtHFUnC+OxjOfWC9nZh273qHM8uLThrNZPf9yzyEF09kzUvFDJnoWiFXnw0W8K69
         h4sOcvbjZmP9GAXlmMyhB3CkJ9oGIMEvHiullA37bWkvkjBU3r13CyS1oj1ZFHtxUHos
         oBplj6gfIAnCU9Qyx/RdVNCItxlZKxfjyGv5LCyBis6v6eVuLwVClsF/GGl8AO7K7D+e
         u+Qw==
X-Gm-Message-State: APjAAAWfsve0UqQFkU/A4y+sIG7u3LKt5Y2ESwFN680LGgk14dBlNm2k
        y5fMyNZbarI7gbZ/05XnuUcOPzJoOBs=
X-Google-Smtp-Source: APXvYqwyZy2W00cKZ0x6dz1QCQ2SgqR3O+dVRvJoge+fK1hcKgny3UXngSqShbK6ZpcrsQ87pfiLRw==
X-Received: by 2002:a63:4e60:: with SMTP id o32mr2076697pgl.68.1562683948679;
        Tue, 09 Jul 2019 07:52:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id t9sm3022920pji.18.2019.07.09.07.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 07:52:28 -0700 (PDT)
Date:   Tue, 9 Jul 2019 07:52:24 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] Bluetooth: hci_qca: Use kfree_skb() instead of
 kfree()
Message-ID: <20190709145224.GO250418@google.com>
References: <20190709013530.11865-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190709013530.11865-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue, Jul 09, 2019 at 01:35:30AM +0000, Wei Yongjun wrote:
> Use kfree_skb() instead of kfree() to free sk_buff.
> 
> Fixes: 2faa3f15fa2f ("Bluetooth: hci_qca: wcn3990: Drop baudrate change vendor event")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/bluetooth/hci_qca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 9a5c9c1f9484..cbae86e55aed 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -909,7 +909,7 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>  		if (hdr->evt == HCI_EV_VENDOR)
>  			complete(&qca->drop_ev_comp);
>  
> -		kfree(skb);
> +		kfree_skb(skb);
>  
>  		return 0;
>  	}

Good catch, thanks!

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
