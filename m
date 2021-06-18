Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D25C48BDF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 18:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A276112D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jun 2021 18:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhFRSmz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhFRSmy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jun 2021 14:42:54 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46603C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 11:40:44 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g4so12006365qkl.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jun 2021 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEIKKRhdoFvI/es7R9MCzlBB8oI4L698p4c9wTlFK+o=;
        b=e0AGSRLinX/lXmgdS5DPfC4BlXuP54VOIJkaGs7ejKtGLIaPM6D6cmUnowflF4Tcia
         9duYkpVcZ1J97ncOJ0+tTDFD4QZmnB3ecQSLlnZyN1rdzfM3iJbuZvwOg1We96QUJTFF
         Nbgk/UNllpbQ9GdFc2pIoVySzNGS83KzDFZoxiDFhb8sCuOgPqLuviHSqti/qSxctd2x
         OYzzwE5wlfJ24YyiqYJ4mlyXFZzasmRuAdW4XFEf0R+eEIx7aksi5OyX9HuqB6NPImnT
         mIUPNdwdK4DotGPGnFZW3kuyn/CboI8pDvEA6j6ujnWhJrXBy/WfEIbtHJPk6V8A7oOY
         Klyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEIKKRhdoFvI/es7R9MCzlBB8oI4L698p4c9wTlFK+o=;
        b=sY3S9FyuBAB1nlxyE+f9ZJ4/lK25r75hWRcF7U87q2q3+F4tY2+gwom9KlpjUfh0WM
         qkHgnjKtVShdtDuw8tRIyaaQAMJDWKifjEF2m1mty2b9Wa/U6bB2NohkuHDF12PzM3nC
         HqKumrLZE5xkwtf91EAiNhpzHBBH2C708M1B5/0h8NES12U0OyabeOqzj1QONUzhYylt
         wuADpO5mbgZazWfs8wMt8kH16SfYCOdY98nlmubYunbgEhRcMCBYuekyC2wrMBDdSngT
         B/FCxwkdvtNPX7lGLVgMPiTfRNLEicbwdMsMSPpgZAnVPTlhMfVUdqBS9oK/21a5XE6v
         HECA==
X-Gm-Message-State: AOAM533I+NkOVbb9UR6C+YJzyzJYQMG48xNQAIJVNL15O49tdpt6vVga
        pj8twia8ShpeMOv7M3cOvO6TIk5Dr0QYlNKLDn8=
X-Google-Smtp-Source: ABdhPJz3UderGodPKNgRYf9aQ5SbB4PBQs63hDCkrdJeiWEf7NQgU2W9ecTUOYr5DGzBaAeBWbJr1vQDeBbJbsg6HS0=
X-Received: by 2002:a05:6902:102d:: with SMTP id x13mr16641143ybt.408.1624041643452;
 Fri, 18 Jun 2021 11:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210618001559.1284204-1-mcchou@chromium.org>
In-Reply-To: <20210618001559.1284204-1-mcchou@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Jun 2021 11:40:32 -0700
Message-ID: <CABBYNZJ9pVRcx8eduu0DCWdu+e5F_UXW9Kzb5GgmNEz20ayBxw@mail.gmail.com>
Subject: Re: [BlueZ PATCH v1 0/3] Detailed error code
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Thu, Jun 17, 2021 at 8:08 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> Hi BlueZ maintainers,
>
> Chromium OS has been working closely with Linux Bluetooth community to
> improve BlueZ stack, and there are increasing needs from applications
> building their features around Bluetooth. One of the major feedback
> from these application is the lack of the detailed failure reasons as
> return for D-Bus method call, and these failure reasons can be used in
> metrics, optimizing retry mechanism, hinting the reproduce scenario to
> improve BlueZ stack. The current org.bluez.Error.* are serving the
> generic errors well. However,g given org.bluez.Error.* errors are used
> across different interface context which does not serve the detailed
> failure reasons well. (See https://github.com/bluez/bluez/issues/131)

I would suggest adding some documentation on the errors e.g.
doc/error-code.txt, so we can document what are the errors and how
they are included on the reply (encoded within the error message as
string using hexadecimal values as in 0x04X, etc.), also we we want to
be crystal clear it would probably be a good idea to inform what
errors codes can appear on each Method like we do for the error
interface.

>
>
> Miao-chen Chou (3):
>   BR/EDR and LE connection failure reasons
>   Include BtdError code in Connect() return
>   Print error code for connect methods
>
>  client/main.c |   3 +-
>  src/device.c  |  52 +++++++++------
>  src/error.c   | 124 ++++++++++++++++++++++++++++++++++++
>  src/error.h   | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 331 insertions(+), 19 deletions(-)
>
> --
> 2.32.0.288.g62a8d224e6-goog
>


-- 
Luiz Augusto von Dentz
