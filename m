Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C080FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Apr 2022 02:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243147AbiDLCJ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Apr 2022 22:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242695AbiDLCJY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Apr 2022 22:09:24 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1F333A00
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 19:07:08 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso10700812iov.16
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 19:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=rgLhKgyYYXped5y5Egl1XGVJSyw4pIOBxrcsqBBOMPM=;
        b=SWdo930CivI29nXK8Qx7wetFcNeSoFZEXaOqVRSAWCaIW2W7CC+sDQN/tqWz1tFTM3
         yaY4AgdBYvhxHHSnRvBwbmqh3WkysQceG1vSJgNLHZqGtKdvY6bzhgEswavmqmkczeeH
         fpgmD4N0OXpwGOHQXj+fOK79cV1IVchbNUBB4xzmL60uRp4DfwgqtzYU9xD0NbGYCCdg
         rTxgRmjBfhA+y4Heyt9gLL1MsWJMYoS/Ms0OxKgjcNLNY7QyOM5q8m1l9adShIR1FBz9
         L3t1DrQp2f2l0j9qCAhBQ+Fh1Zal7gRg5WF3KBC9UK0+YNOb+hb7hd+/JaA458K6HjTH
         Zo2w==
X-Gm-Message-State: AOAM530dROejhHKacvVrG4YBMhsgRXb2LqHn//v260g1PYffQ3614KPS
        JwwxcDbThjjZl1LBsyXo2h9FHqqS47GLg6zWl8lXMPDfoM32
X-Google-Smtp-Source: ABdhPJxIQgnlTG6611QNF85mk+GE0GJsYrhE1dmIPSFt+vn4RQPBc5gWboiYalgK2FPu7DY4f5GKByS9KaJbMktyCjEYOz5HhU6T
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ba9:b0:2ca:8e77:82e1 with SMTP id
 n9-20020a056e021ba900b002ca8e7782e1mr7327019ili.311.1649729227774; Mon, 11
 Apr 2022 19:07:07 -0700 (PDT)
Date:   Mon, 11 Apr 2022 19:07:07 -0700
In-Reply-To: <20220412015446.6243-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098e01a05dc6b8433@google.com>
Subject: Re: [syzbot] possible deadlock in sco_conn_del
From:   syzbot <syzbot+b825d87fe2d043e3e652@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b825d87fe2d043e3e652@syzkaller.appspotmail.com

Tested on:

commit:         d12d7e1c Add linux-next specific files for 20220411
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=58fcaf7d8df169a6
dashboard link: https://syzkaller.appspot.com/bug?extid=b825d87fe2d043e3e652
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13879aa8f00000

Note: testing is done by a robot and is best-effort only.
