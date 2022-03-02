Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B61C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 23:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiCBX70 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 18:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiCBX7Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 18:59:24 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C4AB8B5D
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 15:58:39 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id u61so6738872ybi.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 15:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Z9g6+j3hWaSSl/8rQsC5jQNaPqHt3DHAq6OTGFpeHz0=;
        b=RdzwKuD2/UlMOo1olO3BtAiJ0haWE4dkC2U5uqMsKAN2XSgg+h3Oe6MCV6qIOiy4dl
         Rx7RJdaDjRraOPaQowsjlRiX8+Gwz4jLA8oATbv7JXR3s9Sox1CAmIfjSOVxdZrwsfjW
         03cuXdmu7EC/qnnFdm2JonklhwU7ma+d52LxCeSUsopGi5ffWhwWY2eYPTIt+IfVFutQ
         2vwAJ8XOwZ0SVCWzhtRGSpcRa05WQQlYVfTX4Wt8USPKDMeVH6jjh76ALROCeloL8Ss3
         IeeFAU4JH7JoCeJ+jqNymP1JB1u4taPmZL03OqKoIx2MWXLFkNHrOdPPvuCk3K0gvyLv
         BScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Z9g6+j3hWaSSl/8rQsC5jQNaPqHt3DHAq6OTGFpeHz0=;
        b=dKpPAq3yyLnEOpBLrQQApydCa8O8pvxX+wHIJscOTVVq9AiaYXc2uhkEmt2/7+eyir
         A9zODlUj3XoJOktkNu9xT3kha+OIjlQ/0QF/bndryz70gDnt1fuRR4uo1NuMXGEpNL8d
         IDgtvmu2PALZYNKMuyRPp8GnQm7MtNohKHu5iri3L57bWjYG0CYuhLGACqMzxZEwYK7D
         qxoG9L536wX9uh7qtkRfbeqgykXoHGVml4VFwN0qUduN7iv23rf/HoHABHWiIH4SfPxQ
         AGV6YXmBj9NMBIs+7DlAAKT9zcW95F5cBev4tAgM8c1aYwEJdcWJLC5F3mpRIKySFGOb
         9PLg==
X-Gm-Message-State: AOAM531oQqZi9Zy42jqRIjiGlJ7FBEoeJL67XieQbZPGgkNe8pLuPnIH
        hXDAWUOUie8zClt12oO55hR0Jcz3LP8YJ/tRuiIaDs+k
X-Google-Smtp-Source: ABdhPJwI5YSWLbvFALbth5cMzs3bK9Tn6BfCjj/QzpwCS1GMCxjMGgDtDocR6IQUNPUsjQBBfr90+cBh6drbZiuFxJA=
X-Received: by 2002:a25:8546:0:b0:61e:1d34:ec71 with SMTP id
 f6-20020a258546000000b0061e1d34ec71mr30199640ybn.259.1646263335730; Wed, 02
 Mar 2022 15:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20220301233045.109794-1-luiz.dentz@gmail.com> <621ebde3.1c69fb81.4f0e1.a85e@mx.google.com>
In-Reply-To: <621ebde3.1c69fb81.4f0e1.a85e@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 2 Mar 2022 15:22:04 -0800
Message-ID: <CABBYNZKkgrTruTapU1V4wHd3fAx2Udh8xvT+7wttR4T8n4V64A@mail.gmail.com>
Subject: Re: [BlueZ] shared/shell: Introduce bt_shell_exec
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Tue, Mar 1, 2022 at 4:44 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619349
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.51 seconds
> GitLint                       PASS      1.07 seconds
> Prep - Setup ELL              PASS      51.80 seconds
> Build - Prep                  PASS      0.83 seconds
> Build - Configure             PASS      10.43 seconds
> Build - Make                  PASS      1500.30 seconds
> Make Check                    PASS      12.38 seconds
> Make Check w/Valgrind         PASS      533.05 seconds
> Make Distcheck                PASS      278.20 seconds
> Build w/ext ELL - Configure   PASS      10.45 seconds
> Build w/ext ELL - Make        PASS      1473.77 seconds
> Incremental Build with patchesPASS      0.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Pushed
-- 
Luiz Augusto von Dentz
