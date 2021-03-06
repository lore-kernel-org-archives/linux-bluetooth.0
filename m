Return-Path: <SRS0=qbbT=IE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8092C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Mar 2021 01:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC4C64FE2
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Mar 2021 01:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCFBSb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 20:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCFBSV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 20:18:21 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822CDC06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 17:18:20 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id h22so3627040otr.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 17:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=MPYixuksf0SauDaIRW4ydtYYZzk7+UmZtKoZPZHV1hE=;
        b=J7hETE+RUyF0bfrcUlsLGn9TslLDoCeMHWpWzJlEsGtFm11ueVtjlSR5p1qnMaz5vJ
         IA5ABuTm6Rh4FLaDiFkLevBijEKgRFCQmSoXujdwFj4osAeU4e8ZlKP3xbJo3nM0mejC
         E9xxHcDm5JDBoYi5tYBqjtl0TxWIYlO/OZPYF/md+9EBR2Di3xsX8obE3k1C2fwiU0qU
         PVInqp6LYG7Kj3BGiVQjMMVFViMm0lYjXnhNnXwCgo+ahGcl6j/zwIr+rY/uVnuTSnYx
         WlboY0vPMirjWKTRaJiW2MwmccDtHQcNZNPeWZvd9OfFAF7jbMoF2UzVYf02Bmm1V9q2
         I4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MPYixuksf0SauDaIRW4ydtYYZzk7+UmZtKoZPZHV1hE=;
        b=kpHejGNeJl9BZrD61aJptm6ev95fawbOXatMQykv99rYV7o+RtcqkuQz/03eAJnlRo
         emmM7og/V+Wt93Qb05LEMySU6W09xNVdetgpP5Bqq8qiATWqNrcDGQLsSY6tbwOLJJaW
         9Olc0vSWcXUIpm0wL/WYtexZEbWcxNAISPCBGiB8fH0A2/J6FYGXKWs0L9qzAhGuk7Zx
         i+8H7i9uV8h1qSyTFW4CVlPFOw6GEkUHZMIPcRwowIJBAPdarAt2LTnfhBrxGY3rjMqI
         wgegWMpEdRvNb1hHpalPmCDDM6xNuuF3jAscGzLc9aiY4a8pkhJM9JMZDwYSyxtbGxQD
         ir+Q==
X-Gm-Message-State: AOAM530SBgeLlmGsc/9uLUFuP43hZVS63dLamAX2oEEBIvCMv/8xVKWn
        R99xoOx1Aj3vqSGX5XkB3tEAK2mImyo48CDa7uxr80uqWSE=
X-Google-Smtp-Source: ABdhPJw5XYMhBAnMlLlzI2GN/H0akxaPHyPp5huxGj/oo5YZIMGjCkUxctV0RMBZjhCrvwVltBhL6UzWPdP8G+HD5xQ=
X-Received: by 2002:a9d:335:: with SMTP id 50mr9970052otv.44.1614993499797;
 Fri, 05 Mar 2021 17:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20210305230004.4010887-1-luiz.dentz@gmail.com> <6042c0de.1c69fb81.b4075.4f10@mx.google.com>
In-Reply-To: <6042c0de.1c69fb81.b4075.4f10@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 5 Mar 2021 17:18:08 -0800
Message-ID: <CABBYNZLCXxRVkPtDrVSAxaCn+OgwxzgFyC+7C=A9G_d7vHz6Ag@mail.gmail.com>
Subject: Re: [BlueZ,1/2] main.conf: Enable passing false to DeviceID
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Mar 5, 2021 at 3:38 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=443019
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

Pushed.

-- 
Luiz Augusto von Dentz
