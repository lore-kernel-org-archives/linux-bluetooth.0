Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2529FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 23:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbiDFX3O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 19:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbiDFX3N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 19:29:13 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2B86D957
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 16:27:15 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l36so6683945ybj.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Apr 2022 16:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oCLcpMdfpjHiizued0S4rgKD0K8M/d1CLTQvNj5WFT8=;
        b=DT5s5DOHPEWby/MT3rlrgCVM7hbO7iYYyS1R/JZ8e6csoFPiir3WnQM1heYQj4XiZf
         2CVIHl2POZLe20oGQ9zklPHbCxI8bxrf3AQONtfiy4/eFpZDDnpgew15e4CGmDGQTucQ
         se2BxXwFIFioJ40qfLoAGD0aPuUIE9ZrAiQVy5nQTfVbrESlrMLPA8CYtiMnbWwjcFuC
         c1/Sh0ez/4+Sc3Y2Yf6kqejJ/Dg6TDyHuu0bCqYghjDyRJcIOiFpk28CDglb8fJGUhBr
         iMKvmq7zKULBRZzKeAlHzwrs1D7Fiudx3mJBSs9aLfTqRQEv/t2wKSiOQfOmqXVkxUWp
         jNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oCLcpMdfpjHiizued0S4rgKD0K8M/d1CLTQvNj5WFT8=;
        b=zlChPyzLmRScBfO5eUyv6WeMYLGHO1twKYYhFHXVh3uhcE0WvIcgILxY/mxwSIxPoV
         qETHvpyb8wzmFOCNpo+847x+dfZuxJD/r7IWUKSG3W1N4jbsj3YsrRT3GCQI329fALSS
         wUxiS4sIvy0vKBzzJwvUq/whRnS9P/DHgc65ikOlsOdvYMrEohOgjdt3DxEoQr5nBPFw
         CmA2xPNeepM2tC671mi+B24yH9g42SRFNd09JMxaTsDGFQADdJ/k/+vE+nX/jyayQn/E
         pGByX4IZ55oc35Yj4BPu8RxagOkPax++SLuS5YSQE8OKOBonVs9QvW1ekd7bzxvsa8pP
         joqQ==
X-Gm-Message-State: AOAM533use7q1Y/81zSSgk7XirXeKNQlw4WfiaKgCFjRfCrskCrh1vq3
        XfD7mqPk0IDzYQxVqEWe6uOTwqLXzrTbgnZ++7/yorXk
X-Google-Smtp-Source: ABdhPJzDRTWX7K9OeY1BhXc5O4Hrbloe9J1aILMOfw6yopVez4vOmX0oXCppm51uXll8dHTNJggB9SiRW5zMIrGjQ1w=
X-Received: by 2002:a05:6902:1009:b0:634:674f:ef16 with SMTP id
 w9-20020a056902100900b00634674fef16mr8704067ybt.459.1649287634438; Wed, 06
 Apr 2022 16:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220406084357.iai4k6jvg6gnnbyi@pelzflorian.localdomain>
 <624da59d.1c69fb81.2e0bd.0aa2@mx.google.com> <20220406160832.y5mw64ey45donzew@pelzflorian.localdomain>
In-Reply-To: <20220406160832.y5mw64ey45donzew@pelzflorian.localdomain>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 6 Apr 2022 16:27:03 -0700
Message-ID: <CABBYNZK7YtxDkf_SPqYsrnc_xNaSOa0MyhEhKSQ1jOJboDuf=g@mail.gmail.com>
Subject: Re: [v2] main: Remove unused main.conf option NameResolving
To:     "pelzflorian (Florian Pelz)" <pelzflorian@pelzflorian.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Florian,

On Wed, Apr 6, 2022 at 11:08 AM pelzflorian (Florian Pelz)
<pelzflorian@pelzflorian.de> wrote:
>
> On Wed, Apr 06, 2022 at 07:37:17AM -0700, bluez.test.bot@gmail.com wrote:
> > WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '826023de5689', maybe rebased or not pulled?
> > #49:
> > Commit 826023de5689 ("core: Create devices dynamically during
>
> This patch is for BlueZ, not Linux.

You should prefix the patch with BlueZ, though the CI was able to
apply and test it and the above error is probably CI specific.
Regarding the use of the name resolving afaik we should make use of it
for legacy devices perhaps that was not taken into account when
changing the code lately but we should probably use it to make the
kernel skip asking for the device name.

-- 
Luiz Augusto von Dentz
