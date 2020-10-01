Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7BDC4727C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 07:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9712620739
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 07:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf/O/eFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgJAHPr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 03:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgJAHPq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 03:15:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6535C0613D0;
        Thu,  1 Oct 2020 00:15:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u3so1405789pjr.3;
        Thu, 01 Oct 2020 00:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0N5ZbXBtnwntldT0m2lp5CvoYnPX3c9VsysiYC8gncA=;
        b=Wf/O/eFHld0m4dgAc2lBd4g94nABMzXLttE5nglWfZbSY1Bwn2xPmmDSj+8yBd6R86
         ctzx37NZ+io9ght7axHtT5wOHUtDJk6HuUiJnWBfkw+Q6XQzCTtjknfkRBp8X4CgLugs
         jPoBSyH8EUISkGEeGJ33hniI7PO/HCjBSoxN/93azr7ITT32eJ1Y4PZxoSuTtFMxv/Lu
         zHfGdTaJmSCr8BMtKFPS4NGy6hymKvRiLQXmA9d00pRLdctpi4UyitZGLHaSmQ5mZLKx
         KS9/HrsYNwc9tylLznrUpeNRwPBsB89r/k2sisjOxU40kLgMClHgta0VuyOqPaq2EXFq
         Be1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0N5ZbXBtnwntldT0m2lp5CvoYnPX3c9VsysiYC8gncA=;
        b=c28M/Vorr0KoxyGSUwxUhONWZjYSGXewSSxnuTlpfMzPem2yPzlMlWpDwwKJ/TaDJx
         I2oD5ea+nU8BCNFZulmD3qLfgZ7jgulq0r0UO3QNYeN6/Fi9ImAIXp4O1bX38zvLpk/N
         dOqXjzBjfKWHfm3qy4zaHbkHT6lJVJDQaSsUvhBSha5aELAYkW3ci5s9lo56ARgVUMJy
         S+9lfQls1P1y6arYFR8gaOJL9o9kQJWYp8JoUB4yj/t5e2ptrJqOuDw8szgVSUAvLom5
         kg5U3Cg8vpr67c2VZomSL/r4CK0p5LmwRnPwtyDsw71jPdexwIjUECn5ZwD/YwUtWzdZ
         QvNw==
X-Gm-Message-State: AOAM530KvU5e+K7EqpC/AtsItWsbjJBoAlsp8En/Etd+pYZPvkbklLFm
        TbaguS5Tkp5QwjSreyVcm6Mf/508z7JRHTkoPFM=
X-Google-Smtp-Source: ABdhPJwCYIwkoRDM9VXxsFghIyxXpu3/Ulz3jhy7lk28eW/IrSpPAGt6H0gokLJ0ycahG//eg8jOjg==
X-Received: by 2002:a17:90a:71cb:: with SMTP id m11mr79030pjs.14.1601536545822;
        Thu, 01 Oct 2020 00:15:45 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.212.76])
        by smtp.gmail.com with ESMTPSA id y29sm5372565pfq.207.2020.10.01.00.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 00:15:45 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees][PATCH] bluetooth: hci_h5: close serdev
 device and free hu in h5_close
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200929185815.12879-1-anant.thazhemadam@gmail.com>
 <9D145813-A4B8-46AB-A55F-54C4AF82FD19@holtmann.org>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <40cdb070-a170-e979-6564-8abb0113570b@gmail.com>
Date:   Thu, 1 Oct 2020 12:45:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9D145813-A4B8-46AB-A55F-54C4AF82FD19@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 01/10/20 12:38 pm, Marcel Holtmann wrote:
> Hi Anant,
>
>> When h5_close() gets called, the memory allocated for the hu gets 
>> freed only if hu->serdev doesn't exist. This leads to a memory leak.
>> So when h5_close() is requested, close the serdev device instance and
>> free the memory allocated to the hu entirely instead.
>>
>> Fixes: https://syzkaller.appspot.com/bug?extid=6ce141c55b2f7aafd1c4
>> Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
>> Tested-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com
>> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
>> ---
>> drivers/bluetooth/hci_h5.c | 8 ++++++--
>> 1 file changed, 6 insertions(+), 2 deletions(-)
> patch has been applied to bluetooth-next tree.
>
> Regards
>
> Marcel

Great! Thanks :)

Thanks,
Anant
