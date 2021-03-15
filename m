Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0261C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 21:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A4664F56
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Mar 2021 21:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhCOVrp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhCOVrQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Mar 2021 17:47:16 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40013C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 14:47:16 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so5870537otn.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Mar 2021 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91OuV8kJeZuxupS72EvCTsYuqm/rc0g5ZNtB6uln4lk=;
        b=g0jAGaLysIx3lChwAorCPOOeWl6VSAycDuSAKvkCaTE0Z2clQyh607AfnZUMpOP2tu
         thB8Fh+B1ZzUn0123nWRqT/s4i+KyoLEImjMyD7MNSJZGG2RKFt7geLyP/ya/iVNUWIQ
         KpBuNA5p5cxN4WlQPitVSgZDj+bqKz63ccNN5dUXDryXBrw83U4PS9pXymrCfBFk/G66
         R8bQIrmSnjkrzFBn1PqkNGKPFW9+kw/UtK7XI7jZjKkWED4NNFXCtuZlqym16tqqlpWQ
         TAIKbkeUTXaTuZ8/bg6AFiBDFBUSV6OXkhANbk7ROZ3ignYHl66Zzqayv+ofI2RMPKaQ
         sCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91OuV8kJeZuxupS72EvCTsYuqm/rc0g5ZNtB6uln4lk=;
        b=oG/FMmaI1dvJ6M6QdLt3/ZP177J5yaYLSr58C5r0Txelpn83h9S0iWoBQtyfMHjMYq
         A1PaNsHr/sIcTMqkJcOX7npYfEv+IWOkPlgYZCwNjvxwVaVLCL7Q0Z4/leNdkuZ2ck2c
         SloNEAZPFXPvhvsdKw5/TQHgxrgdSx7QORHAqNObiBZo2fa9IRYZnv2MaRcVdqZjXOQE
         LZyoPZjIfOf01VfHYMjihMs3UIIF9xLF6McDQ9P0jBwfKXsD4TNgmqPQLyujp0N1VtZU
         mIaG8sy8lFZWExt69Fq6LQcEcfosSuxMgKvAnzkKkTdoOMJ0YdYu4pq1IqK/qrVr/t8R
         1iMg==
X-Gm-Message-State: AOAM530yYdVGlrHxrJXnFbazOGOr9Rlon46ESKVyizNnIp2GOX8TKex0
        dojM5N6PU3VZS5GRfJViaq9IEdlYfceLNA92BNRgDapr9iU=
X-Google-Smtp-Source: ABdhPJzoZ0j7rnO64i3ptnMzoGMl/ln3yNbRDcbX07ToAw/0XMKyvSEXQVao9hVaEXC5ud8QnB6ylTQaoTexerP6Fwk=
X-Received: by 2002:a05:6830:57:: with SMTP id d23mr887110otp.44.1615844835443;
 Mon, 15 Mar 2021 14:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210307091845.13269-1-kiran.k@intel.com> <60449ed5.1c69fb81.1e850.17f8@mx.google.com>
In-Reply-To: <60449ed5.1c69fb81.1e850.17f8@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 Mar 2021 14:47:04 -0700
Message-ID: <CABBYNZLW1mRAhcTDsfg3gO5obJsU3F_YuCsVcsprx7ctBGpzqQ@mail.gmail.com>
Subject: Re: [v1] monitor: Fix decoding Read Local Supported Codec Capabilities
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Sun, Mar 7, 2021 at 1:39 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=443331
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
