Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53F1C432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 17:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88FF2068D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 17:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scewo-ch.20150623.gappssmtp.com header.i=@scewo-ch.20150623.gappssmtp.com header.b="ehq8Ft1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfKURhZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:37:25 -0500
Received: from mail-il1-f175.google.com ([209.85.166.175]:46728 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfKURhY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 12:37:24 -0500
Received: by mail-il1-f175.google.com with SMTP id q1so4054554ile.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2019 09:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scewo-ch.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YuPb893pPBUFmDLwbPwwEMuJ8rXEXS/E7QeQksJ3bk=;
        b=ehq8Ft1wEYjwxfkc5B7fnoJ1lo7vUZiGj0DPv4S7uMVEItGcMSdlfWxCNjwMIISId8
         RweYcXRWdEskde360OEraWQY/mD4lkHdQWeabQIZ4pU3H/vcaznicUsHtw0sf/5mGphS
         y8pwHImJRobrK7loW8sMufIN/LbWotlinb0fveASnb9YxMzYZupf3KhehhpkUGpweZLm
         NSGVqZQFMiowcn6xj1pbej75GPURUONZDo4aCMXz/pYpQIgX8SbZ4fD6DSHkyajuh22A
         tyg5BlyjBg+eoHlfUZQ9SsL2EL6+iYby0+CfcjyjgLYYBPl7I3TvZnFaQQG1VlaSvUXh
         e9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YuPb893pPBUFmDLwbPwwEMuJ8rXEXS/E7QeQksJ3bk=;
        b=RYVi2J0XOp7KOTzV0riKTY00uQ/PVKBLjvvB7Fd+y87hnpf7UG21lYpXDHKEeg6Ic6
         8e4JaED+oCaXmiM3b6dVuXQyQHewsgCajFpFUgYPUWNb35AZ8flH8HtoyBXBs6QlNJwC
         d0dahCZ1QW1Vkq/OizU6sdq43gFvcH7UOW5U52AWN5ptwhqDAY8uih5z07lbQlBuujaA
         Vm9vUYmogugGIX/I9SlFgw7gzUWhW1hKdLE5chfdKrhKrPrVpuaT9FJzlAc7NyivoVjy
         TZnwo7laKTMOni0r2b9QjuE6eapbJvNOP3asj8sE/enCFqDaUo4hsBguIHpZxnt3nXzu
         +m9Q==
X-Gm-Message-State: APjAAAXFSC3B+aQvdCkwqzAxrcT8efjHhnkMqsXsrC9tfwswV9pLyAD2
        TY13myqB7H11q8+zZnxjhcE16ryCUB1krqBuSBtEN3XY8J7GUg==
X-Google-Smtp-Source: APXvYqxEBgXCtPhu12QpwAs/5aXRtVZuVpu3wXzPBXbqk2CPjA4hD8NFrkiTIhhpKUNMeh62l9GfC5cJ3AEURjbsQR8=
X-Received: by 2002:a05:6e02:789:: with SMTP id q9mr10491802ils.96.1574357841930;
 Thu, 21 Nov 2019 09:37:21 -0800 (PST)
MIME-Version: 1.0
References: <CAGssATiS=dpA=WOSfLek385o2g=C5sb0z+z=V7CDswn9_5Eu-g@mail.gmail.com>
 <CABBYNZ+VfyOeWjfdE64bVQM0eAJE789NRBjy+wgKa_Dka2ZZJg@mail.gmail.com>
 <F827D8AB-4404-4C81-9368-A18AB87D9292@holtmann.org> <CAGssATiZsC28X06aVQDTO=8va-0dtoe-1a2Mi6JZv4P9UMdGqg@mail.gmail.com>
In-Reply-To: <CAGssATiZsC28X06aVQDTO=8va-0dtoe-1a2Mi6JZv4P9UMdGqg@mail.gmail.com>
From:   Guy Morand <g.morand@scewo.ch>
Date:   Thu, 21 Nov 2019 18:37:11 +0100
Message-ID: <CAGssAThL-EYEDLm8+aGqV_+sM0m8Gu7NdZ-jJOCMh3YgxJdq6A@mail.gmail.com>
Subject: Re: Bluetooth disconnect event / Link layer monitoring
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I found out that the hcitool lst command was working perfectly fine on
my desktop and is doing what I expect!

Unfortunately, on my device it only works after pairing, then I always
get the "Command Disallowed" error. This is weird as I'm  using the same
USB dongle and bluez version (5.50). The only thing that changes is the
kernel version that is why I think there is something weird here:
* 4.9 (Yocto) -> Doesn't work
* 4.14 (Yocto) -> Doesn't work
* 4.19 (Debian) -> works!
* 5.0.0 (Ubuntu) -> works!

I know it's  boring but updating the kernel is not straightforward, we
use the kernel provided  but our silicium vendor (embedded).

I was just wondering if one of you remember a similar bug (and fix?) or
this was just automagically solved without someone noticing it? Or maybe
I'm just missing something else important...

All the best!

Guy
