Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BBEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jan 2022 21:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381041AbiAaV2H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240178AbiAaV2G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jan 2022 16:28:06 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59C2C061714
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jan 2022 13:28:05 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c6so44712615ybk.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jan 2022 13:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaishome.de; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=injGKBnT7tO8fADGfs4rEBmFAbO+OqDdJAgAndDkFN4=;
        b=GRzs0rC5mSHsooh9FvY7eG2YuUwLoz8ckvayrEMd1CkIZ5n9Bf85YsQoBWrDRfYCtT
         SlfHZ/2n5eZDBHms7AKp+heR8ketvKUE6XbzVBLBE0p7FCCGLsyHlP5ML31gDkPuYDN5
         vCgciboBT5wyAHs1uWefTng6nx63fb3O45e3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=injGKBnT7tO8fADGfs4rEBmFAbO+OqDdJAgAndDkFN4=;
        b=Ykz4VdK4mlDJePOILqWrGTF+9hsqef1MoYMf0LTnVqFbc07RGBrqOhE6ovKTtGrhDN
         Psww4qHlAY6GkSN94ykJ7HwvtdHMY7EEHAfbsmlrDK30Lcxp6lEmV0ThrkZ6sMu48pRw
         zFOLeqBAl7bF+eBFBKXd/u8KYhOmCqI3cs6bsgkSZQYO6tXhXAbc8uVU38iVOG5sxMTE
         8H4Oy8lThkFTcU9EsVAK4KWwv9cE4n00Qy2LYZ2vLGmXvM3qXprTTxkHTOBVRRwI45Ru
         bYWCdz3WLOy/TIh067XcfIBiU7KYNGmIjU0RBB6Qys/1thHsGDBq/MOgYQtGM1jFuCSk
         kd3A==
X-Gm-Message-State: AOAM531cFzsp+k5wic7p5XzZFJDUBNWu8SASHALyLuFJsNBruK7G9rVn
        lCRwgIvditUJ/Qh8H11hyAttrnclwvDFH/2Bfvvd/1EHSO0=
X-Google-Smtp-Source: ABdhPJxglNpt2A5cis0fLayN6xyXuTK7yClzkHs+DapD0wAD0nTkbahjHJUiY3KLNVYQIWdf7Y5quklHg2bCxskAGHs=
X-Received: by 2002:a25:7454:: with SMTP id p81mr30254071ybc.725.1643664485171;
 Mon, 31 Jan 2022 13:28:05 -0800 (PST)
MIME-Version: 1.0
References: <CAC2ZOYu4zy0CPTW40qy3vJJDFuWEUvqqPJdMgtKL9=7Xh-YVEA@mail.gmail.com>
 <ec9ac627-e49b-f668-a434-c1a5173c04db@gmail.com>
In-Reply-To: <ec9ac627-e49b-f668-a434-c1a5173c04db@gmail.com>
From:   Kai Krakow <kai@kaishome.de>
Date:   Mon, 31 Jan 2022 22:27:54 +0100
Message-ID: <CAC2ZOYuXg4btk9PaE3whmP7JnntsixEvDuBNvv7GL1pvU1nepQ@mail.gmail.com>
Subject: Re: kernel 5.15.17: Spamming dmesg with "Malicious advertising data"
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hey Pavel!

Am Mo., 31. Jan. 2022 um 15:59 Uhr schrieb Pavel Skripkin
<paskripkin@gmail.com>:
>
> Hi Kai,
>
> On 1/30/22 18:02, Kai Krakow wrote:
> > Hello!
> >
> > Since kernel 5.15.17, dmesg is spammed with the following log,
> > sometimes multiple times per second:
> >
> >> Bluetooth: hci0: Malicious advertising data. Stopping processing
>
> Thanks for the report.
>
> It's caused by one of my patches. Can you, please, try [1] and see if it
> works for you. It looks like we just need to backport that patch to fix
> the problem in stable kernels.

I can confirm it's fixing the issue for 5.15.18, thanks. You can add
my Tested-by.


> I am sorry for these false-positive messages :(

NP


> [1]
> https://lore.kernel.org/linux-bluetooth/20211124201628.405647-1-brian.gix@intel.com/

Regards,
Kai
