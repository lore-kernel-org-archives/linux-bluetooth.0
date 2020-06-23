Return-Path: <SRS0=Gzv7=AE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EA7C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jun 2020 22:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC422089D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jun 2020 22:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuxg5dLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbgFWWSJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387609AbgFWWSJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Jun 2020 18:18:09 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60EDC061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2020 15:18:08 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 64so25003oti.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jun 2020 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VWMU0JmkzxjeHfLUjYAbyb1K6Lf6Cos95UBztwli1Xk=;
        b=kuxg5dLH6lN6M80/BgF131KI1dGW77LWvxz2sslIAKSIUzpvuu9R/zH1+iajgcIxrv
         FCCsrYgP58wk+E4LtZCFHMXqO0MKjGNPUKoRDpVewxScma08YSSPdVrWniFisO0SgWU8
         9RassrubuZw60RxxD5Vkld1ciPntvhznuZR54oiZqB7Cumu7dCs3wjCiwIe0xtM6QDDt
         4lfXKISuXLR2DCq0MEYVZyM/WAjruoqtpmmTJadzHNhMfYe1MxJ6QnzmhzhaP/8HcDGb
         bUYUxcrVcfZW7gGok7CUiPgKUGOdpqObUs2hcES74TlnqhUU6Qnzsbtaq2ljrd7bS9rS
         GXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VWMU0JmkzxjeHfLUjYAbyb1K6Lf6Cos95UBztwli1Xk=;
        b=eByatv9ABEq41Ppwa8d50LIiF7rZL9EOfgep/R2+wnTg29tCO0sH6wbT+avhIbrocN
         11dOtsPlYbonTqPwELuquXDT3AJOMF698Djz4ftrIL5V9Kxsipc2qZ0WeI3DGgA7xbgz
         qH5zwBuwxmKWuvDH+ww5O57O8JC7KrIHe3ORik4ZzFJg3t39YPiSuN/Es8GJcmPjZBeH
         IptZvTNNE1XCCatYYcwuqubUpuRYrAA89LxPFTKEREmLsxY8uLALxZ9ZfMUmUwOBTvZ8
         9CWCA3UfHDGUEWe/ZoN1vyzHIhdcn2gDgfiMNs9PgKQV8UxALwue6g7J0KvsnZ/9zeN5
         RKZw==
X-Gm-Message-State: AOAM530GSdNRGky0Anlz3qGDpoP6r61l6cIbCWGjmpfU/R6cbuPPotJG
        LLZEDfuk6dcUy0jjZMhuUFja+rJBHoeTADPAUzQ=
X-Google-Smtp-Source: ABdhPJxR6d6u0DkD+JZFSUAX0+LcrTNIoO/KXyErGH/uFkSgZGeaEVrEM8gOMrfLp93FwSiHoRFi0EAcSaC/tXs9SZg=
X-Received: by 2002:a05:6830:8d:: with SMTP id a13mr20122285oto.91.1592950688202;
 Tue, 23 Jun 2020 15:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAB+bgRbZ+40TsjrjPnA2UDQLyeVvwqBcQ6nmQfvfvu2xNE547g@mail.gmail.com>
In-Reply-To: <CAB+bgRbZ+40TsjrjPnA2UDQLyeVvwqBcQ6nmQfvfvu2xNE547g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 23 Jun 2020 15:17:56 -0700
Message-ID: <CABBYNZLDNq0pQsFnAtBnX3XKnZFB6maLdjT2v2+-cCc=E1BAgA@mail.gmail.com>
Subject: Re: avoid speaker (br/edr) reconnect
To:     Ordit Gross <ordit.gross@orcam.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ordit,

On Tue, Jun 23, 2020 at 3:01 AM Ordit Gross <ordit.gross@orcam.com> wrote:
>
> hi all,
>
> our device (audio source) has the capability to connect to audio
> speakers (using code that is based on bluetoothctl bluez v5.47).
> I understand that the first connection to the speaker is initiated
> from our device,
> whereas further connections are initiated by the speaker. (still
> looking for documentation for that behavior, but have observed it in
> hci dump).
>
> When user removes credentials of the speaker on our device, the audio
> speaker still connects to us, pair, but mediaControl connects and
> disconnects immediately, so we can't open pcm device.

That would mean that a new device object would be created, paired,
etc, but in such case you will need to authorize the profiles
connections if the device is not marked as trusted.

> 1. What is the recommended way for canceling the auto reconnect of a
> speaker to a known device? (is the only way reset speaker? or can
> source device do something?)

If the device was removed locally and the adapter is not marked as
discoverable then the device will not be able to connect, so I suspect
the reconnection happens because the adapter is left discoverable all
the time.

> 2. Considering we have removed credentials on the source side, why
> does flow get stuck?

Will need debug logs in order to determine what is going on, my first
impressions given the description of the problem is that the agent is
not authorizing the profile connection since it appears as a new
device.

> any help would be appreciated



-- 
Luiz Augusto von Dentz
