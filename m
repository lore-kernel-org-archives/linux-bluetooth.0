Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25885C64E7A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 22:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C889320758
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Dec 2020 22:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgLAWyV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgLAWyU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Dec 2020 17:54:20 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61238C0613D4
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Dec 2020 14:53:40 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id l4so2161357pgu.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Dec 2020 14:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:cc:subject:from:to:date:message-id
         :in-reply-to;
        bh=z43phSBmGCup61kiFENZ8nzfAjjSNVitBH28qNimq34=;
        b=PdZ7WoHo31ndAbY2UqnkKEur6Pp6PBn0anJ9hIeInvmj+7Qn8CkpSM09jeNcgrNzXP
         O07AWvHAfRMf8C02kZ4LVljvcxP3T/g/llPAwAr9vCeIUMEIffyKTIoWyMuLH5pnqHj0
         rAoUNDwXty1NUZ995EztwPipVzE1HrpsR33TxALn5jmIPzBltrNzBbezAtLFCatMEq0m
         NO7AwOsDRFQpGzsm2ADL9EhdU+Julytj96oDU4/i/WNrboY2jkRS6kWJFW/1McAa5rjb
         xljcnehP7oYvnettqJzi+VSY7c/gdM3vqO2dERCihiTQ1UeYxPU1/eHV3gj/wBamODEV
         xw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:cc:subject:from:to
         :date:message-id:in-reply-to;
        bh=z43phSBmGCup61kiFENZ8nzfAjjSNVitBH28qNimq34=;
        b=BklaZ2qR42JVUbEydIfXaKyrapckKv0//lDbuf75PT046MwC+vW/LYAcW+ASsed4YZ
         3D26yAPCWOHgzNky2EE3H/ghIKk7ZCmrcCSsZpwd/uCzUmSBa9OLyhyi/RjJDJCOS+Hq
         hE/Ss6sPKkaDOMnKJgwskzvHlthq0C7cuFju/0/ewqbPULBrOLg4bTwbw+sx46gBOFw2
         GooKgn/c1nRH6v7IplPqpqIy3cXb1b8liK/JOi+rasbjGamKzcohvy4EchptGpW1P+uB
         agG3RtMPQL/kjJZ8MW5+Ex2dfmp8G6zFYbF95LtfouZ0BhYPI+HrgTzuJknTFqKPwdsY
         RyiA==
X-Gm-Message-State: AOAM5300/9zIB/B6Rbi7eKR15yKDwReCh0pWZYEECXsn3j1gGSPXUYZu
        OGwGoZGY3U6Fww9kRcFfQg==
X-Google-Smtp-Source: ABdhPJxpZl+tor8T5MBKGzDJ7gmgigJRXf296gy819JbsHsGch3XaekoF9hzLi15BL6faPz/F0tGnA==
X-Received: by 2002:aa7:824d:0:b029:18b:ad77:1a2b with SMTP id e13-20020aa7824d0000b029018bad771a2bmr4696041pfn.25.1606863219952;
        Tue, 01 Dec 2020 14:53:39 -0800 (PST)
Received: from localhost ([2600:8800:1680:2610:7708:5a76:7058:e08])
        by smtp.gmail.com with ESMTPSA id i3sm673283pjs.34.2020.12.01.14.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 14:53:39 -0800 (PST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Ronan Pigott" <rpigott314@gmail.com>
Subject: Re: [BlueZ] main.conf: use correct key for BREDR configuration
From:   "Ronan Pigott" <rpigott314@gmail.com>
To:     "Alain Michaud" <alainmichaud@google.com>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Date:   Tue, 01 Dec 2020 15:51:09 -0700
Message-Id: <C7HTF3EX487A.12XRHXZKFSF76@rxps>
In-Reply-To: <CALWDO_Ug-VzXmrTOUmMKgQSqqVx-b_L5rekwnv53d4ynjzyfYg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tue Dec 1, 2020 at 8:33 AM MST, Alain Michaud wrote:
> Hi Luiz/Ronan,
>
> This appears to have been an incorrect fix since
> parse_mode_config(config, "BREDR", params, ARRAY_SIZE(params)); will
> attempt to read from the BREDR section. My suggestion would be to
> update the group table entry instead:

Oh, that's right. Whoops.

Updating the group table sounds good to me.
