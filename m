Return-Path: <SRS0=4il6=YE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F60C47404
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 10:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDC72190F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 10:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=noa-labs.com header.i=@noa-labs.com header.b="kFe5VYCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfJKKMX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:12:23 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:44325 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfJKKMX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Oct 2019 06:12:23 -0400
Received: by mail-io1-f50.google.com with SMTP id w12so20241840iol.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2019 03:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noa-labs.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RF9S3TRPvjh6Dkzz3q5tjDOLM65z2Nz5fShja7q9PD0=;
        b=kFe5VYCgb+n7NXuqG+yRZoldFO8U/+/kgmjTthyDaeM3eKHxfOBZYnZVPgss3wAX5z
         4SbYKDDdeIXPcfnUYtVLVO67VWyXiC++dcYgec7s4y+mR9seYYI8qcfrkRNyA1qaxrNk
         5UqcC5Zd11QWDhcjaEghd5x5M4TpoqfseRi5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RF9S3TRPvjh6Dkzz3q5tjDOLM65z2Nz5fShja7q9PD0=;
        b=qq7YdEcKovW81EDmY52GirDfKMfRnbHCxTP6xe6BX/hFqab075hn6ehZxPWUBS7/I8
         kmDI035GUKOjeMHIOTnDZvnT2RCHve2XKnfUDOCFVWeNKEcVTxJMQ9ziwrlP38fFRSOz
         PvtH0HK14DIra2uhkV3tbz5nLz3dOBENlxno13x306uLp7mLIAf9NBecg5nNtxBTNJd6
         rkW5sir6obBdPdx3ZlobMd4+opnY2oqBYaPF4v9GUGu4+p0ryOUmInlb5GBeIFd37K+P
         BvJLYtbVAsNLYMUO4CO+ZgeCCKPwbGSmHFUrX6oVVxtJSc4fzBQz5Fmicoln0eD5352U
         bacA==
X-Gm-Message-State: APjAAAXPoM8mew6RxrOdbi5IKu9XVArapr5QHSV1XyWKPjR0fh3UmL0T
        nXIUFWcpbyAYiNgiko+z5Q5fYCmPuFWaf4OO1rhd7g==
X-Google-Smtp-Source: APXvYqyJKyHguItyQ7Kzx0SBGkG0WeLCcdq+xsRio+JwLhtbJ3GWh8u2IbKaEHU1AX5M7yjaNL+yt+rrdVa2k+OPfl0=
X-Received: by 2002:a6b:c8d2:: with SMTP id y201mr1980403iof.284.1570788742422;
 Fri, 11 Oct 2019 03:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <a04053d3-6165-5dfa-932c-5a93d2bd1358@einfach.org>
 <CABBYNZLK_rzAf5aPzJHShEVvXSvndZFh5TjyjaaFzAPw_sHoTA@mail.gmail.com>
 <12b16466-3633-75ff-bf84-9cef44a2358c@einfach.org> <CABBYNZKUmctzTRxix9P-FBK=15v01tkHWMCirFefStpCS2ukBQ@mail.gmail.com>
In-Reply-To: <CABBYNZKUmctzTRxix9P-FBK=15v01tkHWMCirFefStpCS2ukBQ@mail.gmail.com>
From:   Pavel Nikulin <pavel@noa-labs.com>
Date:   Fri, 11 Oct 2019 16:12:18 +0600
Message-ID: <CAG-pW8Ev_ntv1=o0ndd_2FXTdbsvHJ=FVsB-YXUucVtyKSO0Sg@mail.gmail.com>
Subject: Re: bluetoothd: Please don't filter UUIDs
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bruno Randolf <br1@einfach.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello

On Wed, Oct 9, 2019 at 7:35 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Right, so I assume then every application interested on battery would
> then attempt to subscribe for the battery level on the own instead of
> using org.bluez.Battery1? Either way that would be done via D-Bus but
> dealing with a characteristic seem quite a bit more expensive not to
> mention is another object the daemon has to maintain.

There is an issue with org.bluez.Battery1 currently that I wrote to
linux-bluetooth about a week ago. The quickest solution other than
leaving it to client programs would be to fix the battery plugin. As
of now, it doesn't seem to support a use case where you have battery
service, but no battery attribute. Also, HFP/HSP own battery level
indication mechanism doesn't seem to be implemented at all.

I contacted the original contributor of LE code for
org.bluez.Battery1, but he said he is no longer involved with that.
