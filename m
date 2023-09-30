Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095F1E77371
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Sep 2023 13:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjI3N2a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Sep 2023 09:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjI3N23 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Sep 2023 09:28:29 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D97F1
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Sep 2023 06:28:26 -0700 (PDT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3ae4cefe17dso21013358b6e.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Sep 2023 06:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696080505; x=1696685305;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clptT4o9piPtlOVuSvMOu72Wg75C4LpmwxVKqyK6DCk=;
        b=LYDUZnUu8reoRbdVk/U7G074zzSbH3lWMrN7TAsml6lIrTJECGKIACYR5Bv0ptRiRo
         d/em0kd9Y7iuDmV5FSAXZ+k8buw1XdXPNI06z8Yv3WHUboVImJGNpwf/+Des11+kYiIc
         33/7jiKtN6aRnkVVkJNjis4d2F/mEN7H/9XfiX1yKm7o3oogBjkHNfd6NMsannGLtpP0
         lmB3DQPbmDBes8Ihu1ua0SXL11lFNze+cA5AG5xjkWukfQLcfg7NknkIdsB/D60YbKgO
         j/fBkrOvHvH6b3RkpScWxAqq5jJ1xRfN1W0BPPrntI2GmY5UlZmz4X3byORe3fb2U+KK
         Z1jA==
X-Gm-Message-State: AOJu0YwhFMWa//KDLFVCQIGGM363u1mT8HdU3oglC19DGhUmLUB9R5/m
        TXO14IAz1W1NugZCq5Ut6BELkQe+kMMnAjf87SNyWmFTIAwzlpE=
X-Google-Smtp-Source: AGHT+IFB8dLCDFedgeXOOxut4pjWysOjOJNad++TVTP+6enYNYbiZGq+Aq7M/MBWq5Pgck2FzhCnKTu5qweHRQSohmAek5kLwPJl
MIME-Version: 1.0
X-Received: by 2002:a05:6808:151f:b0:3ae:1799:9a50 with SMTP id
 u31-20020a056808151f00b003ae17999a50mr3193147oiw.11.1696080505024; Sat, 30
 Sep 2023 06:28:25 -0700 (PDT)
Date:   Sat, 30 Sep 2023 06:28:24 -0700
In-Reply-To: <fd9c0f0eddb8a7d73e9797568dc3cf2bc9b8ad62.1696077070.git.pav@iki.fi>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000033a0106069384af@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl
From:   syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com

Tested on:

commit:         62dc2425 Bluetooth: ISO: Fix invalid context error
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12897062680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d83e69abefedb6e
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a7711a680000

Note: testing is done by a robot and is best-effort only.
