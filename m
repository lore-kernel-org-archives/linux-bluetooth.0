Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D28AC4363D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 15:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F413D21741
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 15:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAjfsCsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgIYPxc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 11:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgIYPxc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 11:53:32 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB88C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 08:53:32 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id o8so2752069otl.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCknuGYJWuxnT1wYQ+2nO1s2cU7CuDyTwOBzv9jhRo8=;
        b=fAjfsCsE75WE69WsWKqHzPojqhZ0Z/4IT0bFHkSTzGEMBOffjsMJs0THqRgUebNPjI
         gnntYGsMyCEP2OJPXI2Vkhv5nB9gdyEakine6Sy/0+lWAUZVGio80CofEVYheFMvuuWV
         +lYVfntkEcbkAlIFlVf2LodQVTiaO88OPmVDeKWDGwlrDkKxK4/9bbU9oAmjorlOdl83
         jzTtDAKr5HwTXzaCSIrZlwbmUWDMaAt7r1siJDzgVr+W0JZfmMEB1KbjXKwWkmcWIQyX
         WibxpIUI3xIpJYAFyWRjzbwZTlW4D2CeNHcVTpGxHIVoj+vMi35kR5VfzEfhqszWj2A5
         z7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCknuGYJWuxnT1wYQ+2nO1s2cU7CuDyTwOBzv9jhRo8=;
        b=Bu4zhSACB0kMcfX3+Ns5soFIyrdHiBsjgkIaipLy5MNfJYQHgWt1C9wWMr418jYUCk
         CGqzRY2bNdegVr2gWgp7nJhB+PU0+CvaOhWoL/96uWvMnkpVAqcaPmYFxCuPZ1U/VIVJ
         KeRYGw4ACXB1s+9DQVPjpXNlxdgr7TeCCpYpowEHpuNdMfrtBIa9+u6kLj1zPX9jFj1E
         q4hXHKnON3ckeMyQFYb9I+w6RskXNuKtX7DAgAmWDDGlUJd9o8p/OzCl2w/kv6UPAZsd
         jmKshlzAeJ6oRrU28pxuQJGORDYt8QbV35SQGgMqmzs8TMDwHGlCd46e+n5ajDj+RUlc
         1vDw==
X-Gm-Message-State: AOAM530YtYPTuH/x0HsebO/R5YUg9eV/0xWW/zIWQh0+wulovrH898ct
        LkDl9YTP9kLSiHeloYtSmMLTetegxmmhyRHzfN/sJ9IkHHw=
X-Google-Smtp-Source: ABdhPJwG3CskydShgbr99ZCcU7lDM8fzg1QPGOItvXfayD0ssIAbtUJnUGff3G0XbcAXTx1llmMg6LDFDdiYFZznWjM=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr724672otd.362.1601049211357;
 Fri, 25 Sep 2020 08:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <CANozA0gGok3nJgVJehz6tS3iEXDGzd9Rj1QFN=w_xBA5OS-2LA@mail.gmail.com>
In-Reply-To: <CANozA0gGok3nJgVJehz6tS3iEXDGzd9Rj1QFN=w_xBA5OS-2LA@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 25 Sep 2020 08:53:18 -0700
Message-ID: <CABBYNZ+R45LcY6eN-Ep6vEMCXC4qhyKHHd+UtMJQGDJJn2Z1oQ@mail.gmail.com>
Subject: Re: Submitting patches to user land components
To:     Aravind Machiry <machiry@cs.ucsb.edu>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Aravind,

On Fri, Sep 25, 2020 at 7:27 AM Aravind Machiry <machiry@cs.ucsb.edu> wrote:
>
> Hello,
>
> Is this the right mailing list to submit patches to bluez user-space components?
>
> Thanks in advance.
>
> -Best,
> Aravind

Yes it is, please check the HACKING document before submitting:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/HACKING

-- 
Luiz Augusto von Dentz
