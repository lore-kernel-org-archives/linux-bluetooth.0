Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37415C5DF9D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3067247EA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma9Xx16N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgJ1Vvy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgJ1Vvx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 17:51:53 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E7C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:51:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 141so721331lfn.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=NeBKMsyaOhwbafDqgThroGDniBUy61UYUZ4SjDBmGjQ=;
        b=Ma9Xx16Njw7LE73BhulmNWnJNV4g+JmZ7qAqjklqhR0kd5PcngwaviHu/KG9wTQmn5
         XXR8Dg25DMFPq2R7bzBDYDCxzqF4jYvPslOWiDcgsfmZxWiMI8i/t9fqkbJFmzG1Pqpz
         LhcRZqmqomMr+oKTeLtj0eyiZCYAHI9tHa5pM2XdLhtbWcfivTNiSrzpuPIIaFU3zmof
         iM4EpjGwDIU3TzNEfsuiNt3ZSnOPz24ISj6Wth5qHVyCXDiRCGzwuxuoXUSoIDoEojLA
         vh8cSCgxJFE5+Ae1zeiIa6mw3e9GfcwCHH6ZonPLTyVzHeIhrjejN0km3Cj+cr15wYYU
         wL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NeBKMsyaOhwbafDqgThroGDniBUy61UYUZ4SjDBmGjQ=;
        b=VpRKIsDyLec0hO+bu853syulzVyddfNLpg4ZbXrOrNucVbeeKzhNzxtgwRJA+MrVTx
         Y6QXh03VRnbC7BBjNB+oLMCtwtqOv+JeXj1NEeUe2+ni7/Dh0/zJL8ov+dJrjf5Nyf1d
         1UXS4Kv0U5+8276nK2v4IheADwVpKnTj9auZDyPXoM+a4nkJ3lVU+6lFT7I15dwWXSHw
         ycBn0qoWsvS38v5Ax4T2oxboJH8mQj0xaoMRIQqqDXxFd4y3frXSarW3K4K3HypZzljr
         suz+EOnYlQEvnZv+jeD8IRhFx8MWc1NtXO0BCVA0Virt/ykL4IpJkqTAVpR1PPqCN/rL
         SPPQ==
X-Gm-Message-State: AOAM530mBqe0+ydN/buGUtuMtU162+mYOE+bP/Sm5PQU+9W2mPvDxS6q
        IZrHqzrfwS1rA0JIMspEHwYZbTc0L1yaTQ==
X-Google-Smtp-Source: ABdhPJwsWSQWDsofmkU1mUrgPZ4eFDpcEtyYnBNn8uUNqRWXFkp8of4spcVo81+RIxq76KayukVMog==
X-Received: by 2002:aa7:d28c:: with SMTP id w12mr726107edq.282.1603916734413;
        Wed, 28 Oct 2020 13:25:34 -0700 (PDT)
Received: from jurupari (firewall.seitwerk.net. [80.155.46.66])
        by smtp.gmail.com with ESMTPSA id b17sm359735edx.89.2020.10.28.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 13:25:33 -0700 (PDT)
Message-ID: <847879c75cceebee9f2d414089b527cb5dcdcece.camel@gmail.com>
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
From:   Joschi 127 <127.joschi@gmail.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Date:   Wed, 28 Oct 2020 21:25:32 +0100
In-Reply-To: <f40ad39dad23c813441a3082550ad44f85671f2d.camel@gmail.com>
References: <177c5794-1cd7-8f76-b66f-e9473ed37a31@redhat.com>
         <CAB5wbS97WQTduY9sKgiLjAnpsmka+9hGQOBDdbAEHgkcwnze1w@mail.gmail.com>
         <CABBYNZ+TQ+oSYgL1wGsC0rs9faecd0RtQkFE9fbnV89D1r=LOg@mail.gmail.com>
         <20200516075340.3z37ejs3fuhctunl@pali>
         <CABBYNZLWsYHeOo3_+hcq4r+gY_0sLBQhftW7My7Y4D1n9o5jxg@mail.gmail.com>
         <20200518165011.jfarrp5mtqoy3mqz@pali>
         <6da08b42-34d5-9d20-bfc1-161cc8d0f2ea@igalia.com>
         <CABBYNZ+myxfFmobLuzGeYfP_G5tM_ptKgCQCmpQCiUkPZYemuQ@mail.gmail.com>
         <aff611bb-4b38-7614-ce61-fc3e7c012615@igalia.com>
         <20200604204343.eor47oe3fbzf6rbv@pali>
         <20200929210452.bus2qqbikvu2xtwy@pali>
         <f40ad39dad23c813441a3082550ad44f85671f2d.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Am Mittwoch, den 28.10.2020, 11:29 -0500 schrieb Paul Stejskal:
> What can we do to get this published?
> 

As far as I understand Pali is waiting for feedback for his updated
suggestion from this email 
https://lore.kernel.org/linux-bluetooth/20191121224455.orhslaa6zdmlwe43@pali/
 with this patch attached 
https://lore.kernel.org/linux-bluetooth/20191121224455.orhslaa6zdmlwe43@pali/1.2-sco.patch

And as soon as this approach is confirmed I guess he could provide a
new updated patch in the required format and updated to the latest
mainline kernel version?

@Pali: Not sure if I got it right. Maybe you can check yourself and
confirm or correct me if I'm wrong.

Thanks to all!

