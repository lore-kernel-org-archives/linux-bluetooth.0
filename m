Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B8C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 18:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C73C64E4F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Feb 2021 18:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbhBBSlb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Feb 2021 13:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbhBBSk1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Feb 2021 13:40:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61027C0613ED
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Feb 2021 10:39:46 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a8so29432217lfi.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Feb 2021 10:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iKC+SjpHdf96i7OtD28cm7wxzxirDWCLYW62mNx6jsg=;
        b=KnayXvag6CMExiLBVjSjUNTD+J9XtxorPM+SslYnHmJQeHu5foNIeCfwKYVNhbMEYI
         fZRYULyttVDwul/JNOiZCBzp0BSsHooj2OUdppmH3oGYb6J98CGq9cqCrj7lLNirE3K5
         KfT3AQgIiXXw2xei1sAqa5F1pWSo3ZjoXVM3hllzKG+4H98ArIxQ9maxyipqSHRCjJ0Y
         5Uza2/S1xkJvcBCW9p+1SbSV25Vtrp8xlFVWQDrryCeHUOeSbQhgdXKmWXljMJoHK4r+
         jfU1acBTNpssp3K4SiD8KbfFbGucPx2iWMKJkRXHuSmD7ZKlz2/mJe5aIaVmVNbIw6pS
         C5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iKC+SjpHdf96i7OtD28cm7wxzxirDWCLYW62mNx6jsg=;
        b=VhyFrdltGt315qeeFiZWaqhcGbjuul20wU3rReplD980B7wFV31mXQJnNjFkLmyel+
         /YLrBGVBflOZBEdvcy/Gdwl+KEahXgK0OUpt5MyT3V5e0zIVFtO5O7s3qcnUsG27m91u
         iZFw56QMkrUEgcNEC6tsvMqggh9CmEBPbNUSrpSQ67jqzVGMfnKzQS0rhSzVBPmCnYdS
         dvHD8FhDZdsgSUblQGxC7A5ld83ymOo0KSflNwE3qEFD7Yb+k0kXa7WmbwS18cYZJNmS
         Npy7hCZezhBa8Lb59F6M1mpVGg0cxUyOITrn2SrMWyBpU7xhw/ImVLk19oEuvQU8utF7
         qd7w==
X-Gm-Message-State: AOAM531iaQDw9lPneU0j+0yRHEzkP+154xL/bSb5AMmYy1BzcY+S1Lu2
        bRXfqHnmOWzEdHIcm0wqkQMDsgJazC9985g24FWMx2rkW2E=
X-Google-Smtp-Source: ABdhPJxsZkn4kJ1T779huyW/oWRa4+tXz/fbdJF2F0og1BllxapXEqQE5t4QkcpUx5eMzVC2+30+JA+8oFgafUs4jC4=
X-Received: by 2002:a19:5056:: with SMTP id z22mr1566777lfj.226.1612291184516;
 Tue, 02 Feb 2021 10:39:44 -0800 (PST)
MIME-Version: 1.0
References: <38532f57a6446d2aebc4276fbba42c97bd214042.camel@fedoraproject.org> <CAO6ejrnXcnkhjbRE1V8xz++TiT_DxEfJ1wH4fmF+YnUUPxQmtw@mail.gmail.com>
In-Reply-To: <CAO6ejrnXcnkhjbRE1V8xz++TiT_DxEfJ1wH4fmF+YnUUPxQmtw@mail.gmail.com>
From:   murph nj <murphnj+fedora@gmail.com>
Date:   Tue, 2 Feb 2021 13:39:08 -0500
Message-ID: <CAO6ejr=bv7wOU9LEtYrodUGBPrL+zUsNkoRhw+7mZUB735OiLQ@mail.gmail.com>
Subject: Fwd: Kernel version related bluetooth issue.
To:     linux-bluetooth@vger.kernel.org, rjliao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

I've noticed a problem attaching a bluetooth mouse. (or enabling
bluetooth at all)

I have a laptop that I don't depend on, and use for testing, or
playing around.  It's a converted Chromebook, an Acer C710.
In the past, I've used bluetooth, primarily for a mouse.  Converted it
to use the Fedora rawhide branch a while ago, and everything seemed OK.
My use case for it has changed, so it has spent more time plugged into
devices, including a trackball, so I'm not sure exactly when this
change happened.

At some point, the bluetooth mouse stopped working, and I was unable
to turn on the bluetooth adapter on the laptop at all.  I figured that
it was my fault, I had done some questionable removals of packages to
get things to upgrade.  No problem, I'll wipe and reload, and get it
working.

While booting off the Fedora 33 USB drive, no problem, I was able to use the
mouse.  Installed, and booted up the system, same.

After I did a full system upgrade, it is back to not working again.

If I boot from an older kernel  (the 5.8.15 from the install image)  no problem.

If I boot from the 5.10.10 kernel, the bluetooth module does not work.

I've seen the same results with KDE, gnome, and XFCE, so I'm pretty
sure it's not the DE.

I get the following:

dmesg | grep hci0
[  11.031856 ] Bluetooth: hci0: don't support firmware rome 0x11020000

Like the following shows:  https://bugzilla.kernel.org/show_bug.cgi?id=210681


Not sure where else to go from here, wait until the fix is committed
in the kernel?

If a bug report needs to be made, if someone could point me in the
right direction.

Thanks,
  --murph
