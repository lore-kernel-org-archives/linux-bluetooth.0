Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CAEC432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 22:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC8F61076
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Aug 2021 22:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhHYWOs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Aug 2021 18:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhHYWOr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Aug 2021 18:14:47 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A829C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 15:14:01 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id i23so634761vsj.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Aug 2021 15:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=VUo6bLjoVkfaZuAtUnHlJL0mifkfRzFt0NXWtollBY4=;
        b=FqPJ8Xe33/NAszhkHRSkdJBTu2nm5aWaJrG4OIJd0hP5cb9Xd4nwbOF7Wq/Jj51LKM
         aWObabXahEjdz3ARRAOXtjjkCHA2+3jeDCqkC4G/qy2IBwB3tW//0GNaiOgJlZajiSFK
         e7aPxFTMBnj0nQiFwtyTd50eZMXCQUy2yJFEfjS4AKBt6+1njjSddDEfNwgnReLQessP
         XWMXmjf4PJZOcmEfrot9CmEo6HhAcqaIFm9TFzcF+r+3Vfjrvmi0drOTND6+nqw8s9Ta
         5sLAM1veCYrashBh+K7IoCmKetRCymK5z4RSDy74JkPZWnLCOFVrNElE9/nbWN/ImATB
         +DHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=VUo6bLjoVkfaZuAtUnHlJL0mifkfRzFt0NXWtollBY4=;
        b=BsLkm8KVg1364TKhqvCcgDFnsvyeTPsf1O1JY0OMlrrOncsxT+uZn5x2kggbwwSMGj
         f4cWZcX1haRnBXHiWoTdA7zZnLDzMvZA7h+vBfZdlx+/Vz4/WTzShMSs7zdnZrp/lv1y
         rwihmuqXnJ0vw4tMn0H/TDoEq3AIwScL97SoQRLLSvfDCc9a1NS5RXJzSlTGpVUUimn9
         VZmJveyuXAhvCWU3S4IVa1YLvjG4M08LEBXnAOgVPX6VXvsWwpbx+k4YRxAZzgb9+F6F
         5X37Fbmu6SEDLv/RIGr2d+6QvRXnLEJ6ZySrjrSyXOWWvrAiRw0U5tb+gkCYH91+3ekX
         F+IQ==
X-Gm-Message-State: AOAM530pVmfFZ1LDYvxwe9hy50jp0jyXTXl5jYALJP0ZaE2CyOCunxzV
        VEUfdHBvIatj8HI09oEcO8DsKkdmVIGjdOUFsDo/x4iA
X-Google-Smtp-Source: ABdhPJwjdGrxETRW/9MGrlRGYspYLWHnhQN69zfmO/L7ViIRhcris9Yn/6EhPDhVXay5F2iM3pxaKK+TBXkhJ0k17UI=
X-Received: by 2002:a67:f10a:: with SMTP id n10mr728238vsk.18.1629929640525;
 Wed, 25 Aug 2021 15:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210825211415.1057804-1-luiz.dentz@gmail.com> <6126b738.1c69fb81.1b41f.2a00@mx.google.com>
In-Reply-To: <6126b738.1c69fb81.1b41f.2a00@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 25 Aug 2021 15:13:49 -0700
Message-ID: <CABBYNZJQaFwqOMrPi+X9PE_9J1bNMsJ--_HFtsTFNDsoks3fZA@mail.gmail.com>
Subject: Re: [BlueZ,1/3] shared/att: Fix accepting Exchange MTU on EATT bearer
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Aug 25, 2021 at 2:33 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=537355
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.80 seconds
> GitLint                       PASS      0.32 seconds
> Prep - Setup ELL              PASS      42.62 seconds
> Build - Prep                  PASS      0.15 seconds
> Build - Configure             PASS      7.72 seconds
> Build - Make                  PASS      190.27 seconds
> Make Check                    PASS      9.03 seconds
> Make Distcheck                PASS      224.50 seconds
> Build w/ext ELL - Configure   PASS      7.65 seconds
> Build w/ext ELL - Make        PASS      178.82 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Pushed.

-- 
Luiz Augusto von Dentz
