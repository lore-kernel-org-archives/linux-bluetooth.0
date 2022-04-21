Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B511C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 12:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384766AbiDUMcD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384697AbiDUMcB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 08:32:01 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA1C3136F
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 05:29:11 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id h28-20020a056e021d9c00b002cc403e851aso2536740ila.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 05:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2LH/TUAXgyjFg87lmutVH/Zh/Ig4GTObkpnNk61xg+4=;
        b=i8C6mZi7qsJXX4Ygku4RBpqaW4o5Am9iUITgEfwu3WOy1Ies/tS1fwwp7J39zDql/E
         YTm3+TNXIUP7Uyse+KG5SpWR2OgLLEt0zNh3DnfwZupMufoJHP173/EbZOfJCz09V4+K
         hMa/FZEU0Pjkl9ufvnW0OqpLnkmTHnLWAzHON2GnYhjNudS+Emaw89FxcJ6tz4lwwevp
         h+rHoJpyOi54W9ciIs4h520kNLRZEOU8EgPaoUFD3Sas9aovtE+oHxp39CZCBOtggiAR
         sax1FoSvRWxdm0VKt67smD3RZjFuFlsFOuU+03fuJqqZO1l+EB+zxz3oQMyz88ZNn3RZ
         COGg==
X-Gm-Message-State: AOAM533jbCplBCsw89Z6V08RpKKJ9W0LvIqSccpCM9g5DHS3A5+s+phH
        89+l6uA4d5/YPSYVIeC9Zhy+jbYj7mVwGCC2sRcxDyKLPEDV
X-Google-Smtp-Source: ABdhPJw9cDZEQPn7qRg5XxIXfP++kvVm4Mw1mTgznR6D5YpBs5CrAp8bCEiEqG9rWSv0a5q9ra/l7nk55Ugc5U+QM+RiN92OCC+2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cab:b0:2ca:b397:a2e0 with SMTP id
 x11-20020a056e021cab00b002cab397a2e0mr10720692ill.104.1650544150570; Thu, 21
 Apr 2022 05:29:10 -0700 (PDT)
Date:   Thu, 21 Apr 2022 05:29:10 -0700
In-Reply-To: <000000000000f8b5ef05dd25b963@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7ede805dd2941b2@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in ntfs_fill_super
From:   syzbot <syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, chao@kernel.org,
        davem@davemloft.net, jaegeuk@kernel.org, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        luiz.dentz@gmail.com, marcel@holtmann.org, nathan@kernel.org,
        ndesaulniers@google.com, netdev@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit adf9ea89c719c1d23794e363f631e376b3ff8cbc
Author: Chao Yu <chao@kernel.org>
Date:   Thu Aug 26 02:03:15 2021 +0000

    f2fs: fix unexpected ENOENT comes from f2fs_map_blocks()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101dd0fcf00000
start commit:   b253435746d9 Merge tag 'xtensa-20220416' of https://github..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121dd0fcf00000
console output: https://syzkaller.appspot.com/x/log.txt?x=141dd0fcf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff9f8140cbb3af7
dashboard link: https://syzkaller.appspot.com/bug?extid=1631f09646bc214d2e76
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e13cfcf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135e3008f00000

Reported-by: syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com
Fixes: adf9ea89c719 ("f2fs: fix unexpected ENOENT comes from f2fs_map_blocks()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
