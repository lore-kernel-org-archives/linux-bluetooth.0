Return-Path: <SRS0=9PGa=ZY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44842C43141
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 04:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEF12146E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 04:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfLBEHC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Dec 2019 23:07:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:45189 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfLBEHC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Dec 2019 23:07:02 -0500
Received: by mail-il1-f198.google.com with SMTP id w6so9671059ill.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Dec 2019 20:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=oWsENjm7d/+QABjuPHBYSJPPMCuN6XI9dZYPsoGDEJo=;
        b=Kg47Ke4PtF5B8KTw90UrUXneqbc5wGx8rFdnqhY2xkc820QhEyDFz3U4VGiHbx5rOj
         88ZKZX6GmbF7PvNDjN5b0npHpeszpaaR+hKkD3vRaYPF5Ue3EdzvEZL8zVHZ5pXw5nJb
         VkJae8ciLFGbEDAU9rDaUsihLKIwUUQcwb9YAwWSDe5DRMtIMnUzdelhuRStJ+ii3wqt
         EwOxRzfNwtr+3LpEpCFki0X8RDtRTqHYQO3eU75CWFC0DpzFXzL8Pjpeb87/3lxMYd+j
         xzyt0lSOiEm0FC+dF1tpzOeZsW9HQvc7t3fCSQI7mZ6OxeYKFM9qCSV7uszCmoHV0gzV
         uOHw==
X-Gm-Message-State: APjAAAUqZUOFS14U41tPDZmdU6zlUykK1WS8UYaEWlCam7kmUWqBSvrs
        e3j7uN1VqEuO8/FRs86B6k9DOIKoEZy4336Amg1eTeDGi0FE
X-Google-Smtp-Source: APXvYqwbNau2iLq/cBIAuQInsyrPMPEuwnt2BDzeyB8yqBtnk0ZK4FLDDa7c3GeQTvUxRw7rZ0iE6vluQVplMVvE3Si4+oaVnUb7
MIME-Version: 1.0
X-Received: by 2002:a5d:8184:: with SMTP id u4mr50614802ion.155.1575259621372;
 Sun, 01 Dec 2019 20:07:01 -0800 (PST)
Date:   Sun, 01 Dec 2019 20:07:01 -0800
In-Reply-To: <000000000000c280ba05988b6242@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000293e9f0598b0b69d@google.com>
Subject: Re: BUG: sleeping function called from invalid context in __alloc_pages_nodemask
From:   syzbot <syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com>
To:     a@unstable.cc, akpm@linux-foundation.org, alex.aring@gmail.com,
        allison@lohutok.net, andrew@lunn.ch, andy@greyhouse.net,
        ap420073@gmail.com, aryabinin@virtuozzo.com, ast@domdv.de,
        b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org,
        christophe.leroy@c-s.fr, cleech@redhat.com, daniel@iogearbox.net,
        davem@davemloft.net, dja@axtens.net, dsa@cumulusnetworks.com,
        dvyukov@google.com, edumazet@google.com, f.fainelli@gmail.com,
        fw@strlen.de, glider@google.com, gor@linux.ibm.com,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        gvaradar@cisco.com, haiyangz@microsoft.com, hdanton@sina.com,
        idosch@mellanox.com, info@metux.net, j.vosburgh@gmail.com, j@w1.fi,
        jakub.kicinski@netronome.com, jhs@mojatatu.com, jiri@resnulli.us,
        johan.hedberg@gmail.com, johannes.berg@intel.com,
        jwi@linux.ibm.com, kasan-dev@googlegroups.com,
        kstewart@linuxfoundation.org, kvalo@codeaurora.org,
        kys@microsoft.com, lariel@mellanox.com, linmiaohe@huawei.com,
        linux-bluetooth@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-ppp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this bug to:

commit ab92d68fc22f9afab480153bd82a20f6e2533769
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Mon Oct 21 18:47:51 2019 +0000

     net: core: add generic lockdep keys

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15769712e00000
start commit:   419593da Add linux-next specific files for 20191129
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17769712e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13769712e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c04b0959e75c206
dashboard link: https://syzkaller.appspot.com/bug?extid=4925d60532bf4c399608
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16148e9ce00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a1f786e00000

Reported-by: syzbot+4925d60532bf4c399608@syzkaller.appspotmail.com
Fixes: ab92d68fc22f ("net: core: add generic lockdep keys")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
