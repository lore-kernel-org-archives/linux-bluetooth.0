Return-Path: <SRS0=BOlL=2Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B94CC3276C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 01:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1411C21734
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 01:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAU3eUfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgACBaX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 20:30:23 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:40214 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgACBaX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 20:30:23 -0500
Received: by mail-ot1-f48.google.com with SMTP id w21so51487487otj.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 17:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yyNRDEu2LPePcQPHEEhI8OAhLp91SJv/obThbUCivYM=;
        b=fAU3eUfL7FTfnmEgeCc49ubzvsbN/Xzmbp94pJH9r6rbrVSnXCzXvfKPzIMXYsPIt8
         24MkPKfJ4MzfTajjrh29oy3ewHcge8H9E0NtWgu03TX4SRRhF2lEJTGba1sL/k5VMjzh
         UHC4k9PyI9cRKx39KeppmkucKwM8D1cFKQ0qQ7+/JOJ7Dp8QNr8Hh3Ni6utVXTxouCXq
         d17itKBovn/XFwCo/fnsUPZLExo6XggmUxyFBle6Gg0sc/eYnzNG+d+umntGacjTR/aD
         q/wlIhdpZA7SFvNtNNQuubDbl97qFXu+GLqLjG6K21uJVXzun+g/D3uHtWDbaDTZf4ch
         0+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yyNRDEu2LPePcQPHEEhI8OAhLp91SJv/obThbUCivYM=;
        b=X6nnSPiJT7rK/4QZLNypHQTLTT+LsQekhtxTrf5rDRjebMmrM0VSK50KEfopq4faEg
         FL8aVEVjRXsv13CLZ9Qd+/qtHuXUfzDLqXqwqwrKXGPaqcYHlylP0KGTo7XUw2zzH0+R
         Y7XFD5wfFvsAdJ6Z+eu46S3br/CT9iEO8jKHI+50CT2Or77Sy1TT/CT20b4q36aps1wl
         mQ3HxUtmR/iWQFFZcUYAVXwnD8ITalJwatmocG7iKoQf+3BazSLXrSp+xNmEOSyTKm6a
         xTi3V1C5LyEYzDbY2l7ZZZtmRNNwYhD3nIhjyyXp7Ye9BLRu5M70fdHqEuNcidjzh9xS
         Xu4g==
X-Gm-Message-State: APjAAAVnSgk4fh3y/YmSf+WPGDNcP9AUCjXu/8fXekrNlrGJpYOn7WjD
        1q7iCuW4RTPRYekyDhee57/nZXBMILIYLlDjS/a7QVgd
X-Google-Smtp-Source: APXvYqwd4sTKj6gdxG5fMizt8mdsyaJC9ovLAicXXjtM1fBCugRRENTCiYgM7jlU98iFDDAvw/seAtO6rD9nqTe0RjA=
X-Received: by 2002:a05:6830:605:: with SMTP id w5mr95888649oti.79.1578015022514;
 Thu, 02 Jan 2020 17:30:22 -0800 (PST)
MIME-Version: 1.0
References: <CAAERL8RHaWGAg5FOwts_pdDmagSdDj-Ui3ittmop+beVj9y6dQ@mail.gmail.com>
In-Reply-To: <CAAERL8RHaWGAg5FOwts_pdDmagSdDj-Ui3ittmop+beVj9y6dQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Jan 2020 17:30:09 -0800
Message-ID: <CABBYNZLe=ZmiPXg8mrU2BxY9H0hv_WvkvigyJBAs_wnq5ct_Cg@mail.gmail.com>
Subject: Re: Problems reading characteristics with Bluez 5.52
To:     Peter Belau <pbelau1@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Peter,

On Thu, Jan 2, 2020 at 5:22 PM Peter Belau <pbelau1@gmail.com> wrote:
>
> I'm trying to get a Qardio ARM BP monitor working with Linux/Bluez but
> cannot seem to read any device characteristics with Bluez. My
> interaction through bluetoothctl looks like this:
>
> # menu gatt
> # attribute-info  00002a35-0000-1000-8000-00805f9b34fb
> Characteristic - Blood Pressure Measurement
>     UUID: 00002a35-0000-1000-8000-00805f9b34fb
>     Service: /org/bluez/hci0/dev_B0_49_5F_02_B5_61/service0400
>     Value:
>   16 7f 00 49 00 5b 00 00 00 00 00 00 00 00 35 00  ...I.[........5.
>   00 00                                            ..
>     Notifying: no
>     Flags: indicate
> # select-attribute 00002a35-0000-1000-8000-00805f9b34fb
> # read
> # Attempting to read /org/bluez/hci0/dev_B0_49_5F_02_B5_61/service0400/char0410
> Failed to read: org.bluez.Error.Failed
>
> I have bluetoothd running with debug flags but nothing appears in the
> debug logs. What am I doing wrong?

Look at the flags, it only has indicate so it doesn't support reading directly.

-- 
Luiz Augusto von Dentz
