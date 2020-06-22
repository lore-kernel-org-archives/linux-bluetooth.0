Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E45DC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 16:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387ED20707
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 16:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyhjtE8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgFVQ5U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbgFVQ5Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 12:57:16 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95B4C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 09:57:15 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id k36so1244922ooi.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtjWypn2S8b9ynhvtV26w5eTGZ8MD4aIvoCwAB14uuU=;
        b=EyhjtE8zdBZ5wCBIadSGwcQN0M+HNownAgO77rkHkJbXgStqI905ihGEdOt7SA4Q7X
         MEdqJuy4rYHFylDCIv1MQ2DeMX6+ra5DzhsaN/RSS30nlEuGYLLK9msJgPDvkGCxT6pN
         OdK4MG7b+8MfsN/n4z79X2dcz1RKllHZT8Ta0GTCwYNKDnvt8iUwAe6lCls0wBrnVN3q
         Zj0hTwQ7aniEsPjHu3jESM0CJjtokrfl/lAGdOK/Y9Ms72faMrZ/c+R78GLsq2to5Fz7
         r9bvu3nrT+XbqyoTnXDTB4JKfrCUeY2MXPn06cetmpP7EF7ButMSEZ/fAJHzjvBs6trV
         wEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtjWypn2S8b9ynhvtV26w5eTGZ8MD4aIvoCwAB14uuU=;
        b=lT3X/lwafBPHzlaNj08Ng7ymmSNQ7oyYqXSjaBAlHhdWcDrvXM44FG8l+wWSJB5PeP
         kiM4JVFeHjH18M/j+wP5+VNEz5f7E9EjyAJRS31Wumr0UG/DC2ewY06QvY9ZS1VAaBvk
         vUgUV3Bw5du99PeWaX5G9DsYu2Nhxv7Hgo89k47X8FrNxWd3S9L4oyAfDJXYiwpO5YhL
         QAMlnt72gnRZUMoGOAFUE2+e05qpEHHf6L4cL6tKSiYqvIRy3840HvsLj/WWloe3n5bx
         1I0vwA4hP31IwKH9/J/Wy7dU6on0QxEPKHDkVQCMj4p0PpuvrFgQh9RjupXegtc539ru
         eQxA==
X-Gm-Message-State: AOAM530Bz+jfmCImBw5IK8XQ6ZVPmG/U2aKE0YexP4AIJVVtz9YbZqpd
        R6B3NEnh53EMqL08CcyHFagl/2rEPKkGn0vV+VQFSg==
X-Google-Smtp-Source: ABdhPJz2Nzg9F0AFQHJqQiTJt4dJL+lcvELfTVckxr0iio4lsE4gJnnu9Ift8zoZ6XxUZTPiuhwIqsyNdWACI3uTbMg=
X-Received: by 2002:a4a:ddd7:: with SMTP id i23mr15219652oov.9.1592845035055;
 Mon, 22 Jun 2020 09:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200619155612.bluez.v4.2.Ib8ae2d78936aa9f16a318aca14cf8c7198449bac@changeid>
 <5eed44b6.1c69fb81.44ef1.7e06@mx.google.com>
In-Reply-To: <5eed44b6.1c69fb81.44ef1.7e06@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Jun 2020 09:57:03 -0700
Message-ID: <CABBYNZKWN5G0qfnpirOZddEuHJtdYpzPDMJGJKpns3gXD3G9EQ@mail.gmail.com>
Subject: Re: [bluez,v4,2/3] btmgmt: Add command "remove" into "monitor" btmgmt submenu
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Michael Sun <michaelfsun@google.com>,
        Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, Jun 19, 2020 at 9:57 PM <bluez.test.bot@gmail.com> wrote:
>
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While we are preparing for reviewing the patches, we found the following
> issue/warning.
>
> Test Result:
> checkpatch Failed
>
> Outputs:
> WARNING:SSCANF_TO_KSTRTO: Prefer kstrto<type> to single variable sscanf
> #78: FILE: tools/btmgmt.c:4686:
> +       if (sscanf(argv[1], "%hx", &monitor_handle) != 1) {
> +               error("Wrong formatted handle argument");
> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +       }

We might want to turn off this warning since it doesn't apply to
userspace where kstrto is not available.

> - total: 0 errors, 1 warnings, 80 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> Your patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
>
> ---
> Regards,
> Linux Bluetooth



-- 
Luiz Augusto von Dentz
