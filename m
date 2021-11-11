Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD84EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 00:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B4C6124D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 00:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhKKA3L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 19:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhKKA3K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 19:29:10 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415EFC061766
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 16:26:22 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id b125so2343072vkb.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Nov 2021 16:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GnQZu8/mCVC8YOPTYFngCXPybM8+AnREaKgDouCkJMg=;
        b=JeXd3pId404rGc0fDJrkEVQBU9yrCtA2BSaMVbBGraIcQstSq6eMJh0SD+o4Z8/EMp
         6jUNMjVN7xkmYEry/dL9GrXQDwI+Uzhu/PeDoiHGC7f0bHOmApomeXIn5BnLi5aHm6yw
         DR2I4MtpGVmGSNtuuxxCtLvskVNCgSnf93dtJ7Ie2vEFhIAlW5hfCvPrSEzv4xW4q52r
         9s5V9KJkMGheuN19QLWsbejaMLJtiMlskrgA+irkg7NTuo7F6LLaLerzZDhlbXCqdS4X
         IEYhU3bJGsKDIjDWiKFIN+LQen59HzfcImiUG/EzsnaBkRv7jzcEZUjITI7To+OqLSb/
         +kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GnQZu8/mCVC8YOPTYFngCXPybM8+AnREaKgDouCkJMg=;
        b=1C7hDbFAWpINCvt7ZMxA9Rd2MoeFJKIDuC8RgP/ETlgUUwHhIBxUeI+wLOBpgUivri
         Z5iz7jkNOozeMOf98+HP7TAJ24KmarniZIG/iPwMmLCJ+p2VDzH1gOlpq29mD16OxxQE
         AzDMRjLXKTpzkEru7s0YAuh/rE35VMLBkhaR3kMtDt8cuk9PLpohW2FAYpFyv4e06308
         RGHBwnhdQtB5HeGlYSalcUaF+Dw1azr84jzBmXPozdAT96oJ6AG+wvIvA3YGK0q5S2Ag
         GFcED5tc1mmwHBKQ7H8kk7VtvlgQs57WVv6sb6xWGutQnjsgDVCVWx03yOSrmizxvttC
         6FQg==
X-Gm-Message-State: AOAM531XYggkQvIEencrx75n8u07ZRBH/l9ETprbGE8i0XW6MXi6QMcR
        wpmawiTzKPDU7r2M1ddAOsncz6s6YFquYlqCwr+mPIJq
X-Google-Smtp-Source: ABdhPJw4mHKS3jo7RRfgmyaA38ySEbSDhcVu3q0p+cU4TixvfYhfSWZgHZemtaHAojldxwJPr2OcZ3bZfnW8rRliaeU=
X-Received: by 2002:a1f:9803:: with SMTP id a3mr4402099vke.6.1636590380754;
 Wed, 10 Nov 2021 16:26:20 -0800 (PST)
MIME-Version: 1.0
References: <20211105211245.424024-1-luiz.dentz@gmail.com> <618c1200.1c69fb81.c5125.18bf@mx.google.com>
In-Reply-To: <618c1200.1c69fb81.c5125.18bf@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 10 Nov 2021 16:26:10 -0800
Message-ID: <CABBYNZLX_j+379jNZps5goorCV6U6NrUTPN3WfgooS1s6jWoWw@mail.gmail.com>
Subject: Re: [BlueZ,1/6] btdev: Add support for LE Set Privacy mode
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Nov 10, 2021 at 10:40 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=576261
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      3.26 seconds
> GitLint                       PASS      1.89 seconds
> Prep - Setup ELL              PASS      52.41 seconds
> Build - Prep                  PASS      0.26 seconds
> Build - Configure             PASS      9.43 seconds
> Build - Make                  PASS      224.72 seconds
> Make Check                    PASS      9.45 seconds
> Make Distcheck                PASS      261.29 seconds
> Build w/ext ELL - Configure   PASS      9.39 seconds
> Build w/ext ELL - Make        PASS      210.38 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Pushed.


-- 
Luiz Augusto von Dentz
