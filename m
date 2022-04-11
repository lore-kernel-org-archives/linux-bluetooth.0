Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625E7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Apr 2022 21:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350239AbiDKVu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Apr 2022 17:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350205AbiDKVuZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Apr 2022 17:50:25 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AB91A80D
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 14:48:10 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id v14-20020a056e020f8e00b002caa6a5d918so4074881ilo.15
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Apr 2022 14:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Nrfu+QqSF6/ab+WasZFQXdtEXQrUlu6Oj2jlqNXgE2Y=;
        b=A9sw+1ueuNmLkiSexaEp38bHLG+6Imv67ncb5pUweayL8TEC3lgPXBp28vY05XITgQ
         5XmI7qV2uT3T9mPZwD/xY04oJ31YNuXD7Pq10WYCdi/2NJJjx9ceYOmb2psH5/70kMoT
         TMwznWxpy0BQpbTxyMb2TxjXFSlSAC+Q4Ngsbvxl6SSo4aas+mzxp5Sd9PAUCFosTiYN
         DG0lj9yAAaK34JLPcePqi0UpiE02tuK8507Oem8B9JaC9RJi6cB89FpL/1loG96Im8YL
         fqrF4547WsfZ1rxOh++7rj3QlerFyxxpNmHWigjbJGDPgNzU1PY25W5oaSCqGkgIlJ+h
         0l/w==
X-Gm-Message-State: AOAM530B9pCTcYZyL6vAKvqWKWs4W1m22yLVxBrKs2J/Vn9FNBFYYQJK
        kGrdeXxzh9EMP9JnyCjNZRkCuNF58a1YcZRaAPWxMS1qG/ZO
X-Google-Smtp-Source: ABdhPJwJO9uxDUuoSJ6AW+FyvTZ0JArsOxFYZApz2erqpsQNVtXt62RJ98yJQG2Mai75WQ1cVZbXr1dav+A3EkX+HtssNTxCCL1X
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0e:b0:2c6:18c3:9691 with SMTP id
 g14-20020a056e021e0e00b002c618c39691mr14673558ila.287.1649713689588; Mon, 11
 Apr 2022 14:48:09 -0700 (PDT)
Date:   Mon, 11 Apr 2022 14:48:09 -0700
In-Reply-To: <00000000000098289005dc17b71b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072fb2705dc67e6c0@google.com>
Subject: Re: [syzbot] possible deadlock in sco_conn_del
From:   syzbot <syzbot+b825d87fe2d043e3e652@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        josephsih@chromium.org, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        yinghsu@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 92b8aa6d18f7a9ae36a0f71d31742aeef201207a
Author: Ying Hsu <yinghsu@chromium.org>
Date:   Sat Mar 26 07:09:28 2022 +0000

    Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fada04f00000
start commit:   d12d7e1cfe38 Add linux-next specific files for 20220411
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12fada04f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14fada04f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58fcaf7d8df169a6
dashboard link: https://syzkaller.appspot.com/bug?extid=b825d87fe2d043e3e652
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a2ff0f700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149fd2df700000

Reported-by: syzbot+b825d87fe2d043e3e652@syzkaller.appspotmail.com
Fixes: 92b8aa6d18f7 ("Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
