Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2671C54FCC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 18:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FEA20663
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 18:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUtJI5wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDUSMy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgDUSMy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 14:12:54 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB14CC0610D5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 11:12:52 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id z17so11978497oto.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=es6t6nxU1jGnvVJ69fouevmOFJVMXa+LfxzJCKwM/pk=;
        b=eUtJI5wnkhjljNr53E2YU3XHct4qS+fGpEEpJhX3jVgAReXoiUtZ1/lc9uWPnD/U52
         UmP1LNEk9K95uEaZYEd+XlVel2BKxaMjRPsdIKPWM/Z4UPMC90KTm0gVl2LmxhVo7pDY
         Hk8pXY4Wf4Vhbv5NK2okWm8qha25cVLdfxDdXo8REbnw/t/2Wc3Hecv7HbrxssbWn+p5
         PaQh+BZZFPUDrA/I8Pt1hh1F/TMQDrmKdgvdq1bVvrovoXwQFtBzeuut06a426I7Y5ZM
         B1b/cuWMRe6FNprY3EHXflLGOVAz2FJI/nSx3FUG5GYvfPRorXhpyOy8u0O+7gR7g5CW
         aRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=es6t6nxU1jGnvVJ69fouevmOFJVMXa+LfxzJCKwM/pk=;
        b=s3ANlkKPZePN/X1zN+93J/611FHu8ZkDPkub9m51X8Tc5PPp5WEhA4QZjJxj8gWZ9L
         EtC42K0oHMZioIIhYsf1ka04pN036yKXFQiv0lVuwoSDx4T0tZvmr4SDWXTCQUQhdTsw
         cvJYSQuoPGZAwwUnllFiLj16BJyC8q/Jvcxk7xJRlEelmOud1OLpNRjaUQFdfL4JZ63N
         zJClQ052eBwhyr2aDBL3vNmp8Y86XIik7A7vvwaLoaXtqXP1NP+cZ8zH1h3oQ4AubPp6
         ZpS4/KhNENo6SM+8DiIbB4+t8+yzehdzkDk404qRi2iJxGbttZ/qe7KDgjcZTtkI3sYJ
         bQsQ==
X-Gm-Message-State: AGi0PuZQLOrd114cXH2Mb6bisH7ZQsqMomrmjiQ1KUSEN5D+zzFAsu2g
        27jaX86vkI+yYHqdxGBhEvl0Qi9ENg2mZMU92o5aIKZr
X-Google-Smtp-Source: APiQypIVpqPzFBBCbZQCK03v5xyGHPXJBa7H0foXst+bJqR4kiz8RNFlW6YJxF2AL49FvJoMpDkbjQNjDQcfMV2zxSc=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr15242781otn.79.1587492771997;
 Tue, 21 Apr 2020 11:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAPHZWUeGeaN5jmNHv56VzSsdmCvS1WKfSnaYE+YCfd5E8+3S-Q@mail.gmail.com>
In-Reply-To: <CAPHZWUeGeaN5jmNHv56VzSsdmCvS1WKfSnaYE+YCfd5E8+3S-Q@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Apr 2020 11:12:40 -0700
Message-ID: <CABBYNZJ4MhhEWvxX+hw8fR9uOpqXd8XWQBsy2VjP_dVtL0R+7w@mail.gmail.com>
Subject: Re: Auto-connect after disconnection from user on trusted devices
To:     Yun-hao Chung <howardchung@google.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Sonny Sasaka <sonnysasaka@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Apr 20, 2020 at 9:30 PM Yun-hao Chung <howardchung@google.com> wrote:
>
> Hi linux-bluetooth,
>
> Bluez doesn't disable auto-connect for trusted devices even in
> device.Disconnect. This causes users can't disconnect from peripherals
> unless they untrust the device.
>
> The behavior seems to change into this way intentionally after this change:
> https://www.spinics.net/lists/linux-bluetooth/msg72898.html
>
> I would like to understand why this change is needed and what is the
> suggestion to disconnect a trusted device.

This has been there for a while but if I recall correctly the problem
is that we cannot really tell when the auto-connect was disabled,
besides it was not really honoring that in case the daemon is
restarted, etc, so instead of having yet another setting to persist it
was simpler to just use the trust, or block, properties to control
auto-connect which are persisted properly, that said maybe we can make
disconnect auto block the device and then connect to unblock
automatically but I think that having the application set the block
property is probably clearer that we don't want it to be reconnected.

-- 
Luiz Augusto von Dentz
