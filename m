Return-Path: <SRS0=+CIn=MU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2184C00449
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Oct 2018 10:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4831F20858
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Oct 2018 10:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRYrV5DV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4831F20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=intel.corp-partner.google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeJHRpu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:45:50 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:38112 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHRpt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Oct 2018 13:45:49 -0400
Received: by mail-ua1-f47.google.com with SMTP id r20so4489136uam.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Oct 2018 03:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=78R+JaVGnYOic9ylLsWyiUF18RjXyIwOegPsMHZuucg=;
        b=mRYrV5DV1lEJge1wMLqvPuiKQKWYDlW/d9wHT5MoujlUNNUNTg0EAvfIKtfy2JVDKO
         VaC0R6pLcs7z03Yyr1r6lK5OIK7WH+bD84S6a0wp/XWdlZi908ifxECCqadDZv1C2QXG
         9mMdAOtmeaeNTbedM4v4CaPQu2PsN+NZ8wkmARA19cZgpPkQJqSAFafJsJS+5OMJZUko
         AttxCYNb46/KSWCRqZEUoNM0AcNbNyGNDWdXQbXo8IRVnlOqE/hsrRAP6FwWBCCqUz/9
         ADn0yLtdC+96r7MY26NG6zdXRjLOi4rLjzBTdaCaX5ZK+wtgkL2N2zHRclOzchetL+j0
         H8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=78R+JaVGnYOic9ylLsWyiUF18RjXyIwOegPsMHZuucg=;
        b=NP9xuJisUdAwsgwuU8Kju2KZk1UhppikHp3M1rIGe9i7wgv2CtbpX6zBWugdUAsmhZ
         FEwTPg9jSZwgcWMgwKGbk35OXq1Hs7b/v5kUZHCztWwmAWcHRz8gjy5ELian4F6eIJRN
         hy6RDOyQZwK9ZhsDJ+nlih90jreaFEFnK+oKnWEj/5wCnz0jpV4kaXMbHD4Miqd22svv
         uM8oPLRikJZEotLJYRUQp2tt3XFJpFpOFAJdtafbiQnUF0Agok0ykcLzRRZbOyR7tQtd
         g9Kl9H45rfDf3rIGgJqArksj48ItQL26r96pQZrbKGtoM4KG9bR5QVfff4HaJkUaCt7j
         fj8g==
X-Gm-Message-State: ABuFfoh3kAXF7VqWYbPQQ6ut1qNnx9NI9b16AUFSoyc29+kyDCs3fJ1j
        aVtdQhuUzqF5mKzxD6uxbRgXB7t31rG6Ut6HBGnF07G7rOM=
X-Google-Smtp-Source: ACcGV63ZWnYKI/Dwm3ByiNHX+lJ0TI5OHGR+/W6w9G6SETM3iXxWn873YeV16TausQ5ITHvmfegUNGUoa/NQB5JNIB0=
X-Received: by 2002:ab0:2444:: with SMTP id g4mr9189552uan.67.1538994886700;
 Mon, 08 Oct 2018 03:34:46 -0700 (PDT)
MIME-Version: 1.0
From:   Amit K Bag <amit.k.bag@intel.corp-partner.google.com>
Date:   Mon, 8 Oct 2018 16:04:35 +0530
Message-ID: <CAANRJtyETNy2GMYfRtFDFm6TJs94W+oXGmY_zdR9RRx_1tFpNA@mail.gmail.com>
Subject: scan stopped after log hours of stress test
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

 Scan_Stop.7z
Hello all,

I am running some stress test on chromebook with 5.44 bluez version
and 4.4 kernel version.
In this test it will scan for device connect to device do some data
transfer enable disable advertisement and repeat this in a loop. But
after hours of test scan request never sent to controller. From the
log I can see last time kernel sent the scan stop request to
controller and the scan stooped from controller side.

In this log  mgmt discovering stop callback event  at some point is
not received at Bluez adapter .So that
Kernel and bluez host lost the sync on the discovery state .And
further Discovery_start() request has been ignored .

In previous success case I can see the below 2 logs
Line 79243: 2018-09-11T11:50:41.724644+05:30 DEBUG kernel: [
105.371680] mgmt.c:mgmt_discovering() hci0 discovering 0
Line 79284: 2018-09-11T11:50:41.725959+05:30 DEBUG bluetoothd[2265]:
src/adapter.c:discovering_callback() hci0 type 6 discovering 0 method
0

But in issue case only kernel debug message is seen in messag log as
below but bluez log is not seen.
Line 4048575: 2018-09-11T12:03:59.350884+05:30 DEBUG kernel: [
634.306257] mgmt.c:mgmt_discovering() hci0 discovering 0

Further when bluez try to start scanning in kernel its always called
stop_discovery().

please suggest how to fix this issue.

Thanks & Regards,
Amit Bag
