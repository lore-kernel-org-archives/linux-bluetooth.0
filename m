Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3540C04FF3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 23:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8585F610A6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 May 2021 23:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhEUXzI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 May 2021 19:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhEUXzI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 May 2021 19:55:08 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DEAC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 16:53:44 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id y36so13092584ybi.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 May 2021 16:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X21lC6duFE6XmesAKBhjy+0/LXAjmg1nRPnCK2t9czk=;
        b=ahcHh7f6RiHHvDOrJgfvH699LYnGYDCy3COHbQbb0MXO0tziYR9KAVBHPJafhCfEY/
         O6rzOJRIJ1BT4KE5VdySxyiHUdHC0PlX9/tj3McTzlTfEklyEwY0j5V29v3dGqJ7K7xz
         cvPxZDte9K2ZdlWWEKsb4+8qX0x7Dzu/kslCrhKJnkx1UH3x1cpueOyqPrfbDV/0nYK4
         X2+s+7Wk390RY5iLwiUauxY2vKwyszaRYFPvCBtQsFh9gY0BsYihWcU1xdUVFjiakZsQ
         RNonEFumHXb61tit9bQgigYhlHx+rjf9q2uAaVkCZ94e8wz166jNkv+oRpIShJQvMQ4y
         OJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X21lC6duFE6XmesAKBhjy+0/LXAjmg1nRPnCK2t9czk=;
        b=SmrKphgzMt7BBu8Vvtr858M4e8LXjkFtY0/lWDvW6/BF+8+4ay/xR4AzTbTEDLdONV
         Ke/rJPD8a7oYrSaXC8kWvjiiTyfmImcijRDRii3L1s8TBwmWmVdu1RQWj8PWBdWy8HPO
         owK1ZLzVs+8nq4hMEDvhEx33DMFE+1APafKjo2IaDVEOQEofnLi7eiWciBZyjxfM3vai
         IZ4HBiBppDBOSdhfBIv3D+nnqQw/on38LbuEbGi2Hx+g5cJVjdARcnJlSuV1R2jqRcTw
         5q+sOoL+qeiF/fG0TMBXwjJhvQwvZ2fLyOsVuBapnOA3sbIFpk9ua9WWkrOvJWcXDeyz
         QEWQ==
X-Gm-Message-State: AOAM530v1tfJNGUuQwQkjW0F9KWvRZ9l7/8Ee2VXTowVFDaj0hCAYz+J
        cyM4zZKhb5F/0dnU0LSJ1YnuOqVdryM53x/zaPKUNTY3
X-Google-Smtp-Source: ABdhPJxZAE3TcHauWLck+Yw2l8uOmWgay88pwIcpkfv2apC49kuGkcnaD5ZCWgMsfcVPrxKPVGyQPbkuhfRzt/gb89Y=
X-Received: by 2002:a25:b80e:: with SMTP id v14mr20195443ybj.408.1621641223367;
 Fri, 21 May 2021 16:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210521062441.155117-1-hj.tedd.an@gmail.com> <60a7581c.1c69fb81.b194f.b789@mx.google.com>
In-Reply-To: <60a7581c.1c69fb81.b194f.b789@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 May 2021 16:53:32 -0700
Message-ID: <CABBYNZKGqOrHEq8XC=5tEPO2pAfAu=0h3HiPG0arUo+RaowDdQ@mail.gmail.com>
Subject: Re: [BlueZ,1/2] tools/mgmt-tester: Add test cases for set device id command
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Fri, May 21, 2021 at 11:26 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=486249
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.98 seconds
> GitLint                       PASS      0.20 seconds
> Prep - Setup ELL              PASS      40.17 seconds
> Build - Prep                  PASS      0.10 seconds
> Build - Configure             PASS      7.08 seconds
> Build - Make                  PASS      172.77 seconds
> Make Check                    PASS      9.30 seconds
> Make Distcheck                PASS      203.34 seconds
> Build w/ext ELL - Configure   PASS      7.13 seconds
> Build w/ext ELL - Make        PASS      162.09 seconds
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

Applied, thanks.

-- 
Luiz Augusto von Dentz
