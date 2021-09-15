Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9DCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 09:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9493961251
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 09:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbhIOJw2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 05:52:28 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:46634 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbhIOJwY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 05:52:24 -0400
Received: by mail-io1-f72.google.com with SMTP id s6-20020a5ec646000000b005b7f88ffdd3so1360303ioo.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 02:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OaUs54KYE2dDB55GtbB/YxbBBPa+RBaXGRBRYMoLDKU=;
        b=FViuY4K7iw9mOfq28B1oJEzADl8tyIk3aKky7oDJsaoV2QicChPhnuGUygL/o45iBd
         MiPbC0ZV1yVJkoJRfxkUWsjBMEIUcGdPvCTuiCW+A9wCImIV48dCRB7C5t71lKvE4Zml
         68IFvgBZFzepkG+hlrTtyxrCWsn/XEWPOqT5yJhF7fY24eQPAcLBtFzms6p41B001MuG
         B4qH1nBrsEO1ABKLH9Vd9WtpIu090iIXhpiIOE94ce1EzQt2oSF5zkRIwIraxzik2Oa+
         sKw3bGdGpGStmBauDGtW75eI3/0zXcwMdzzH/pMdmSC6nf03B4YDhz+uPxlI1TuoF+2Q
         oG6g==
X-Gm-Message-State: AOAM533B5fv9+jDSzpyJ5lnR3Fw8wCNdMWMd7txB7wvNZHxF8Yuv28kK
        7G2OYeTPRUvo5KQrszYvvKJjG+fmNTcx6VPKGEZPONewye6I
X-Google-Smtp-Source: ABdhPJxjyFHohDbIEXYdADd0QU860qw30kCuDJ3L5SMpqY/Ye8pmCqxqNT1+TDyRuqO1aqUby62HwN40PgfqFyKNbZdzfBLlMBT7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dce:: with SMTP id l14mr10147510ilj.272.1631699466084;
 Wed, 15 Sep 2021 02:51:06 -0700 (PDT)
Date:   Wed, 15 Sep 2021 02:51:06 -0700
In-Reply-To: <000000000000a5339205c9e53883@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e753105cc05a31d@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in h4_recv_buf
From:   syzbot <syzbot+a06c3db558cbb33d7ff9@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org,
        stephen.s.brennan@oracle.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 0766ec82e5fb26fc5dc6d592bc61865608bdc651
Author: Stephen Brennan <stephen.s.brennan@oracle.com>
Date:   Wed Sep 1 17:51:41 2021 +0000

    namei: Fix use after free in kern_path_locked

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b29973300000
start commit:   7c60610d4767 Linux 5.14-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f61012d0b1cd846f
dashboard link: https://syzkaller.appspot.com/bug?extid=a06c3db558cbb33d7ff9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147f96ee300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112b3629300000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: namei: Fix use after free in kern_path_locked

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
