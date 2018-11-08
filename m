Return-Path: <SRS0=LpJm=NT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF33ECDE47
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Nov 2018 14:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641B92081D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Nov 2018 14:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvOfba0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641B92081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeKIAVG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:21:06 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:37265 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKIAVG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Nov 2018 19:21:06 -0500
Received: by mail-ot1-f43.google.com with SMTP id 40so18095296oth.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Nov 2018 06:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YyHkLpkMlU6kdjgeG51nfUmyx9zZ/ue8ilva/mnN60M=;
        b=UvOfba0q+jsUaDtU57CNZThlltpdJ0NHvdg0zRT53RjBYNuHwUS1jX7EhvAbqCWLhs
         pGoEFYc/a/Ap2qa9kUbwUGf1+T1IRgsiVzwlOEJPvrGujUrxfbYZq2HmJgGF8KThYROp
         JhlZPUEj9SdrXl3rcGgUON9VLE1cJ8NZHrjwwJ/4Ho/zCSmFyoB4Yz2V1rkQSZu4S/32
         B62VtQn6p014GjIcULmeLpLPGq4oEPZrlbAzggWF3+XiKOzSu8GcwoVKJulKyvyQgEYD
         CHQlCFYpjgC5YB0XQ3GMbk8x2vvK//vfUSAczRASpiQVtttl1Lcf6ABJb0Nw/vjIPquO
         +e4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YyHkLpkMlU6kdjgeG51nfUmyx9zZ/ue8ilva/mnN60M=;
        b=MDWXFVQEwXVVamvmTrGpVckyzlQM5JvCpK1poDfit7J+An1Hku0C666BGwOkjppF27
         MKfIfI170ueYdoxge6fTtoNXf1EA0DrSuV9zyyA8gPkFqSqhCZHodRctShCkhKjdw/ul
         mAe+3UGiE0FBrG2CvP/qd8GIkGXSpzSj5yDsB0o2WAbEmmO7yS9O9P+w9j4y9fQmc5L7
         fsA1TgN1WYrYw7E2dCV3FR41wFQ+YobIfkLxyNG6dEvhTdUNFXCIUaHA5kTBhqqhBqrU
         1DXsdIYNKoSnLVxLbN92Tzt+UP+qwnWLQzBNP3r8AdrBu3+ipoo1jk/UjuDoAbAn9ynw
         BFdA==
X-Gm-Message-State: AGRZ1gKdMvM2owTZ3E7awefrOiqr3bTzNB20uSsGrYUfMkxyC9cz60X1
        hZ/9+LWKVgjcVaLWkqFco+oIFoXSABIVRLLU5UIG1ScP
X-Google-Smtp-Source: AJdET5dposXotaeBgtWutqc+YfUOvKScxcjmon3V6y2Iukv5rpW8PmIjjBsZ8CaXJEKhJVlbwp+SaIim+DhNsZVg/HI=
X-Received: by 2002:a9d:4a22:: with SMTP id h31mr2754856otf.254.1541688316522;
 Thu, 08 Nov 2018 06:45:16 -0800 (PST)
MIME-Version: 1.0
References: <CADZhEUBeTf0-muEdXg0f_-nq3udgj2ZiSzRgg68Yp8GRywmZeQ@mail.gmail.com>
In-Reply-To: <CADZhEUBeTf0-muEdXg0f_-nq3udgj2ZiSzRgg68Yp8GRywmZeQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 8 Nov 2018 16:45:04 +0200
Message-ID: <CABBYNZKS_MCwdC1T+PChPEe8Qfswxoc3qocPZsfMVarEYF7nag@mail.gmail.com>
Subject: Re: Improving error messages in BlueZ
To:     hofman.robbert@gmail.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Robbert,
On Thu, Nov 8, 2018 at 3:34 PM Robbert Hofman <hofman.robbert@gmail.com> wrote:
>
> Hi,
>
> I am not familiar with the way pull requests work on git.kernel.org,
> so I'm trying to make my proposal via email. Excuse me if I'm doing
> something wrong here.

Did you check the HACKING documentation:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/HACKING#n95

> I wanted to improve the error messages that gatttool prints, a.o. when
> not specifying a value to write to a certain characteristic. See
> https://github.com/pauloborges/bluez/pull/8/commits/745e8308bacb0e60e39237c821b08960cf0aba55
> where I made a commit that would do so.

gatttool is a deprecated tool, you should be able to do the same using
bluetoothctl nowadays.

> When following the tutorial on how to make a pull request
> (https://www.kernel.org/doc/html/v4.17/maintainer/pull-requests.html),
> upon trying to push my commit to a new branch, I got an "access
> denied" error message from git. So I guess not everyone can just make
> a pull request? Can I get any help on how to make this work?
>
> Kind regards,
> Robbert



-- 
Luiz Augusto von Dentz
