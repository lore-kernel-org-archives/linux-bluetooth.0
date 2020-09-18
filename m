Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085D1C43463
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94E821734
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5yyVV10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgIRWMY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRWMX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 18:12:23 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF577C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:12:23 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id x14so8840930oic.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nZKXAmQXOCYqMZ4lcdAaR9zafR1QMAlp0o9MGm/Juk=;
        b=Y5yyVV10zFxt7f0jQANZ2WHjs4d+K8ewhV4sY31a0fhwF1SAfvyHbnUse3CcLd412D
         PgBPs1pyNWhzcErZ8msrRiYjEOlCRX9X/CTKH4r5iBjMk9DaDTd0tzIgr3n8jJRNhH9x
         Mbkgtt7vLrxwzT/+VFuQRpWolCXF1/IZXYyzIJwOsLBDRheQqCdVsWt8gJ8L4HvtujSI
         E+0RhWvlY1lAlNPhQtS2MQJTg68XffCuyZUVB1rXWvETESOi1yqNDw4qo3VbzvGYZnTF
         MbJvW0ee49hIVTaqK/a7T5U4SrJarq/YUdv/8bdjhdDYlMKRXEFrzxETefoN2zWgiFwQ
         F4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nZKXAmQXOCYqMZ4lcdAaR9zafR1QMAlp0o9MGm/Juk=;
        b=VhgbpZqz4xpJz3BHBHS4Km2ctaPwFjeW02zJuI/T3vaxEFQZCRu7rMxowcm37eWfgH
         zqCf+qK2Vbb9wVb+42Dq94ZXJUAUGZhqOVVPDtLxVvzWsuXBxytKGaUvuYPgJOhunDyb
         7Q187+Zdp5O22L1ScZxRpBQyGA97MAENkDadPw7EG7Ai0y1CBBuv8AOJMdaIx8A3FR4r
         TAWDDav9m0H1Bv9tgwgNAA1AGtBvljN7mvUGMyVrEtpXUP4Yw5CF8vB6VrvoWqkAEZ2/
         MHlhp7680Vg0roEhgORMC3i1I5oRTL49+UYUcd2AmRuQtMrGPBesKZXCGa8i+1UZwX3Z
         SYZw==
X-Gm-Message-State: AOAM533uPInjVYM8Ud5QTRWD2l/UGG+Ha+NcPnlr8CUzM3DQUkhOmYZM
        uA47WQpxRqyc5hh9qZUMXQM+LEt6UqkjQfoi83Y=
X-Google-Smtp-Source: ABdhPJwJxaCqWVCDehe9yaMucVj5bGqUlPTlr2BruuG4fUfzvCw84GEsIyfpu93Q3QTyyV2XHVMIN8UpHDy44fb4lWQ=
X-Received: by 2002:aca:3e08:: with SMTP id l8mr10147892oia.152.1600467143139;
 Fri, 18 Sep 2020 15:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <CABmPvSHYi7WeWqgqxSe60omSyVXj_EezMhGi1GMXBBWM-TWeBw@mail.gmail.com>
In-Reply-To: <CABmPvSHYi7WeWqgqxSe60omSyVXj_EezMhGi1GMXBBWM-TWeBw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Sep 2020 15:12:12 -0700
Message-ID: <CABBYNZJDbPd83cx0KWLGMpE_KaA9xUbuMCDsuQVTNxV7xrowiw@mail.gmail.com>
Subject: Re: Modifying Makefile.am to facilitate test-adv-monitor and future
 unit tests.
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Fri, Sep 18, 2020 at 12:44 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> Hi Luiz and Marcel,
>
> Unlike the rest of the existing unit tests in BlueZ, the logic blocks
> tested in test-adv-monitor require dependencies of not only
> src/adv_monitor.c but also all the dependency tree of
> src/adv_monitor.c. The current convention in Makefile.am is to add all
> the extra dependencies one by one. However, the maintenance cost is
> high and not suitable in the case of test-adv-monitor. Therefore, we'd
> like to propose changes in Makefile.am to make the source of
> bluetoothd as a static library and link it for bluetoothd target and
> the unit test target. It would be great if you can provide feedback on
> this idea before the implementation. Thanks in advance!

Then we should have had the code move to src/shared for unit testing,
but how exactly are you planning to do that? For testing the kernel
interface it normally done via a dedicated tester, but that again can
be done with shared library.

> Regards,
> Miao



-- 
Luiz Augusto von Dentz
