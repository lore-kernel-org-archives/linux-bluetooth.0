Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C13C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Nov 2021 23:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhKVXDG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhKVXDG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Nov 2021 18:03:06 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB79C061746
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 14:59:59 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id p37so39829198uae.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Nov 2021 14:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XF+t8VJEfWAtGaMPz3T9ya0h9RhlZ0aeJP+HnlND22Y=;
        b=ipBShYsyNkqEpikdBkFynnWRConDxnsQEOKQ2uIUTtr+v/A6JR2dhZoS//hw2GqtLc
         7L7Fx58az/D+VToaiVGveW3exJxOajNb6NPAM6M1MBrwYdWZ7NoVRnmjzYCbYRQ2CIar
         aHUrc4+o0Q4125N+erBLHZW4x+FTfjqIJsVxf3/98MjYvBzeK4gskc/uoT86FNHWj/bs
         YbSZ8CU3tWDWzylAn8UsyrWsomvGHCAy7v6cpBO/Cx4mhw+mDkk9e6SYMUidZLFEuN3n
         +tDRTz0Ea4TTN/IUM7GLJYIcvNV0naQOTQAXDQVn/DC4mDF5aMdYo/W76ygn9kxlxS6t
         /CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XF+t8VJEfWAtGaMPz3T9ya0h9RhlZ0aeJP+HnlND22Y=;
        b=L9RoyXKNQyrWJfoT+j3DrU51uOjBSYomXc/9beljgCgLUKKmp/Na4S/swWXtjJeiGA
         pFeYA7qLUunHYnHCab80EtC5ZiqqDpaBWHwIlSC577HvmiuyQHEeV8JRffiJxjcCwiX/
         01ovmYMcSc93e34E/CMCeFiwE1TVLGzlaJdKoJB2DvFUHIxDTvPvqzqtDHol3XxNzXIU
         UQ9Ll69nWhqSiANt6hxI2IcV4TDbw4ESGzMKZItcivfjEyvMK1DPsKIjySGFcH1PYaRJ
         U60xaFMG/Upq5nHEGjN7yhGfAiimYoxHCDgP/nZe+x6/7LDi+Ypuvy8/Mg+dE7ldbH6W
         5gtQ==
X-Gm-Message-State: AOAM532zCDn9xETtjcF2yy7haHEEadKCq6iUa/4lCBSUGxl2EdwbcIDE
        HwtBiaHbaxkl5iFDzg79mGbjewWeYwS2binksfFRx0KT
X-Google-Smtp-Source: ABdhPJyAWtwnGAO6K+bDaAP2N1G6rebVYDiLWvJiVBIELbzAzHyN2qFm1oukgVhbpGInzpYVbBOuGd0i1qmeIsAoQps=
X-Received: by 2002:a05:6102:c06:: with SMTP id x6mr1536629vss.23.1637621998143;
 Mon, 22 Nov 2021 14:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20211120072449.BlueZ.v6.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
 <61991bae.1c69fb81.58706.8e87@mx.google.com>
In-Reply-To: <61991bae.1c69fb81.58706.8e87@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Nov 2021 14:59:47 -0800
Message-ID: <CABBYNZ+8g5eXGqsFta++rss0yxqv5=XrVHDft-VOfRm6gBw9Sg@mail.gmail.com>
Subject: Re: [BlueZ,v6,1/6] doc: Introduce the Adv Monitor Device Found/Lost events
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Sat, Nov 20, 2021 at 8:01 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=583423
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      8.80 seconds
> GitLint                       PASS      5.68 seconds
> Prep - Setup ELL              PASS      49.12 seconds
> Build - Prep                  PASS      0.54 seconds
> Build - Configure             PASS      9.13 seconds
> Build - Make                  PASS      205.71 seconds
> Make Check                    PASS      9.38 seconds
> Make Distcheck                PASS      240.14 seconds
> Build w/ext ELL - Configure   PASS      8.69 seconds
> Build w/ext ELL - Make        PASS      202.00 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
