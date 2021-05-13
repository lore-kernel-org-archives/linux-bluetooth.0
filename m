Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182D5C43460
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 16:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA946143B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 16:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbhEMQ2Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 May 2021 12:28:16 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:46713 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhEMQ2O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 May 2021 12:28:14 -0400
Received: by mail-io1-f71.google.com with SMTP id z8-20020a6be0080000b0290438c7ace07dso15002225iog.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 May 2021 09:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=YKYMJN0wOTOdIhbhWJ09zW38cF2+wNMxDEkbWJQv620=;
        b=N3eFwgqdZu9BOci1DFalLlEFRhD5Fl5aO+R0LIkpSLSw100lA0hK+sIu46g/F4AwEs
         ADVR4VQmSM1+/bMCJZc1dp8sNFLsPfJHP8rXdqZJ+Dj97JsxoXuliKX5srG2eKjP0jWO
         1cVRDR3U9mxIoIxqfUR6U4otg7H8/KaOOpGlwJSXSE0MX0rzDqSZ4S4jb8OK9ajwxKHs
         zGPeK4O5ZzRUoNrZDnB1GPjmMTs2zgjBK/n1I0nvnjouC58HzuOF/ZJg4zpNpTN0TwUx
         HLQsKvCYnqls7egX8yEbd7+TozOMeE9DDTmmcGu8TdLG3I7IqUHoxSg8KSu55uTvMhEG
         qKyA==
X-Gm-Message-State: AOAM530eA3KmZyPFH54G+R+WgtmH5anwgymZiuwqDZRAb6Rhi/p0w4n+
        Etglo8jmg07NOYzCB6psQTBjwqH5rl8CuPwtynbHywhvehFW
X-Google-Smtp-Source: ABdhPJyDfQsqI4Kf8+DTE946kH5/MEOSEHJVBdeLXA8kLQzSGICDYM4ZCGvRpL5XacZosrDhcc4hXoWum6QCXdcpQ6jqvPq3mm23
MIME-Version: 1.0
X-Received: by 2002:a02:b717:: with SMTP id g23mr39955248jam.109.1620923224227;
 Thu, 13 May 2021 09:27:04 -0700 (PDT)
Date:   Thu, 13 May 2021 09:27:04 -0700
In-Reply-To: <000000000000aaa4a905ac646223@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd05a005c2389844@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __queue_work (3)
From:   syzbot <syzbot+77e5e02c6c81136cdaff@syzkaller.appspotmail.com>
To:     Markus.Elfring@web.de, anant.thazhemadam@gmail.com,
        davem@davemloft.net, gregkh@linuxfoundation.org, hdanton@sina.com,
        johan.hedberg@gmail.com, kuba@kernel.org, linma@zju.edu.cn,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit e2cb6b891ad2b8caa9131e3be70f45243df82a80
Author: Lin Ma <linma@zju.edu.cn>
Date:   Mon Apr 12 11:17:57 2021 +0000

    bluetooth: eliminate the potential race condition when removing the HCI controller

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=127b3593d00000
start commit:   c0842fbc random32: move the pseudo-random 32-bit definitio..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf567e8c7428377e
dashboard link: https://syzkaller.appspot.com/bug?extid=77e5e02c6c81136cdaff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e36a4900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bluetooth: eliminate the potential race condition when removing the HCI controller

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
