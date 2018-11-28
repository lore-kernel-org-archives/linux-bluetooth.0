Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA3AC43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254A3208E7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 15:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZko90TZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254A3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeK2CIj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:08:39 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37583 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeK2CIj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 21:08:39 -0500
Received: by mail-oi1-f193.google.com with SMTP id y23so22819946oia.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Nov 2018 07:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQ38wtxBMoylRpeENOLFrsZuwWeHQH+0ev2i5TO6dUk=;
        b=AZko90TZDu+hTnGhx/dYCi1yBA0fiEhIfQLn5nL7shj+xHb7X2SCSyN3mR+08jzdQd
         h1Mao8pyyK0Vu+pmq6Uuymp8AuWh5qxVJOYY7IDgZToJimyLmzi/rdnwJuLEPBuZz7gH
         gvMUd8YT/SE5N9zfhO89UnU5/ngm9o/sfTOwfkjIh1OXaD7phmIfZmrDNtDWpB7T/IkV
         hgql68mJ/AhhHcOUdIltutTMMQuLYRNpvkk9LTkqH1bvNqoftF+2fRN9TAJEf00HjQHQ
         l+8lbYGUnhq4vvjmb5/5ygzKW0D2r/a3nDJKLE4a4ryoegCWB+zw4B+pjlLrEcniGHnF
         Ab5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQ38wtxBMoylRpeENOLFrsZuwWeHQH+0ev2i5TO6dUk=;
        b=s8c01o1RvX194NTyNnJxDRwmFVBNOCeIq1et6HDnb6y1sjWYNcLqAjQo7jolNPAG91
         +joeA2LSfMiNxqh9KqGywTP+bS4/+R5DFhnPYGjve5WwEPAArIAofi7OrudqgjW+pJxI
         csAVKf4Z9HyN1LJOxZNn1xOk2Mp1eWjR5PV3aP8R4lJyVtN9lQWr8hFdgq5UP5+80Wmm
         lRMQS2mWuQMzIUlmHFS0QWqjUxs5dHB9aLL/gmgsqkC0s2Ey2G90X/G3u9VIkyAkUkNj
         wPd0Dt+VwTwelxgax0doBBj7g80uVs0gxH4PDnIOLkOA992GAexsKvWKz6sGHbmR4SUl
         H9uw==
X-Gm-Message-State: AA+aEWb95Foj9/xZZpiwniXrSoPp/kxDdDyBDvz4nUcHQVrY55CUJiXd
        FO40xfRE2VnQNhEYgxUp/CQtwuQmZNLcYsrIf+wjqQ==
X-Google-Smtp-Source: AFSGD/WSzdlyLDLqudW8lDIBKNKEbQizx1B93SH4NH7vKWT232k6ywJVKkJFs7G2PMUDd6beh6k2lWjQF4YItvTVdFs=
X-Received: by 2002:aca:e755:: with SMTP id e82mr3402815oih.153.1543417600739;
 Wed, 28 Nov 2018 07:06:40 -0800 (PST)
MIME-Version: 1.0
References: <CABBYNZL0jgnZTYSQ+c+54_fHudK+0fg-GwS_-LUzw7gde_aMyA@mail.gmail.com>
 <20181125092012.8001-1-jengelh@inai.de> <CABBYNZ+AY6NPO68P5WJEtL_CKumTEywsuoGC4Roe4evm5mia1w@mail.gmail.com>
 <CABBYNZKaBff5xU=9K=4D8id_dw+MNjmCRt8ugZ0k8g1x2Z=K9A@mail.gmail.com> <nycvar.YFH.7.76.1811281603540.16342@n3.vanv.qr>
In-Reply-To: <nycvar.YFH.7.76.1811281603540.16342@n3.vanv.qr>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 28 Nov 2018 17:06:28 +0200
Message-ID: <CABBYNZ+EmmyGU2_ktS237iCjrEa1d7=ODCy_nmNerXmCuX7tsg@mail.gmail.com>
Subject: Re: [PATCH bluez] build system refresh (take 3)
To:     jengelh@inai.de
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jan,
On Wed, Nov 28, 2018 at 5:04 PM Jan Engelhardt <jengelh@inai.de> wrote:
>
> On Wednesday 2018-11-28 15:38, Luiz Augusto von Dentz wrote:
>
> >Hi Jan,
> >
> >> >  6 files changed, 119 insertions(+), 104 deletions(-)
> >> Applied, thanks.
> >
> >Looks like this is breaking the build if coverage is enabled (set when
> >lcov is available).
>
> How are you specifically enabling coverage on your system?

Just install lcov and it will auto enable it.

-- 
Luiz Augusto von Dentz
