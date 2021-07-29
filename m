Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_HELO_IP_MISMATCH,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D27C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 22:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A9C60F46
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 22:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhG2WY3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 18:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhG2WY2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 18:24:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E49C061765;
        Thu, 29 Jul 2021 15:24:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f14-20020a05600c154eb02902519e4abe10so7780874wmg.4;
        Thu, 29 Jul 2021 15:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LOX8ZHfk/Qsidg5/FWcUvCoq+KCIJaGQvGbJZ0G3asQ=;
        b=rNmMYVXBBi+3q/vHY6zyT8vUc77XieSSx21bFRJU8datswB9UwerDdwOaHF6fvu1/t
         nHbFpq4JG5ZLz1/dhww9uSu0PstRjqaCTxSoYzXxcLhVRYK31fuWnb+egboMgBc3WzfV
         IKtY1UQW1/hse/Ni7ANxq4n3MywXVmrlhGRk8iYx9YYZetXYZUY9ncfwc3eWVqiuj0kN
         i3Qrn+lDS8N9wbloNr9elJv2Mf8E0lUwF18sMvuK9s/Fi0E5XBtbijz/GbT5Db1G9YJQ
         caqsgJFfPpXtMOqD3lZ4ezjdytl7397W86F9+rivk6wRMf/K3Rxm2qFPwnkem994BPUZ
         YN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LOX8ZHfk/Qsidg5/FWcUvCoq+KCIJaGQvGbJZ0G3asQ=;
        b=hCgCBQPj5cXckjyK5OmQRcwXlLRGMWsDeNdu9grzR1TAj4WhpkawJn6z/by3WnrOlr
         1GtI7b6BGRiiwoRmjafj6A/iTKuKFyqOJj4xwwLxeMk7qpp2uUManuLrqPdFe5ns8GqF
         54z8XdlxL///YHwe4hFxCaUHuVzyE3nnujq/e0ireKNahrV5Kw6fOIlg04JzvGQph83h
         jhEKAWsRncVo2IJKdbjuhVtrtAnsddRVrppM7dVi2MK7W5pEEMttWeEKjHloHuwHGMIV
         Bfjc2foDoiKxJJSdI+NcePrLvfxj7wgEhn6NwPLmAGDHgprYWjm4GQS4+hhM2rCMYs+5
         Trsg==
X-Gm-Message-State: AOAM530gL/wgYh1KgSdyUqJzWeuhedNxi/Z7xNNmCfAaIcQdQBTbCnZK
        i9LIaAormuVA9o/OxWjZJphLZxaATOv3KGWY1sc=
X-Google-Smtp-Source: ABdhPJy0bCvdsGcG36Sc2ZlzGBRnVuewLMj2rVvhmpEB/vaSDRXeSL0Tuovo7DJjfEXdpcaZ8cm5sg==
X-Received: by 2002:a05:600c:2908:: with SMTP id i8mr6825574wmd.108.1627597462089;
        Thu, 29 Jul 2021 15:24:22 -0700 (PDT)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id x15sm4687317wrs.57.2021.07.29.15.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 15:24:21 -0700 (PDT)
Subject: Re: [PATCH] Bluetooth: btusb: Make the CSR clone chip force-suspend
 workaround more generic
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
References: <906e95ce-b0e5-239e-f544-f34d8424c8da@gmail.com>
 <D11408EE-8541-4930-A438-6338F342EFB1@holtmann.org>
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
Message-ID: <a5e94ec1-5894-3c9b-2ff3-cb1406459cfe@gmail.com>
Date:   Fri, 30 Jul 2021 00:24:18 +0200
User-Agent: nano 6.4
MIME-Version: 1.0
In-Reply-To: <D11408EE-8541-4930-A438-6338F342EFB1@holtmann.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 29/07/2021 21:55, Marcel Holtmann wrote:
> Hi Ismael,
> 
> patch has been applied to bluetooth-next tree.
> 
> Regards
> 
> Marcel
> 

Thanks a lot, Marcel! Upstreaming these changes has been very fun,
looking forward to improve the compatibility more in the future.

Every bit helps. The next step will probably entail
adding a HCI_FLT_CLEAR_ALL quirk in there. :)
