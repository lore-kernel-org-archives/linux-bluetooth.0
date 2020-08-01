Return-Path: <SRS0=3CUk=BL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A5FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Aug 2020 16:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64BC2071E
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Aug 2020 16:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgHAQdH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Aug 2020 12:33:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48561 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgHAQdG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Aug 2020 12:33:06 -0400
Received: by mail-io1-f69.google.com with SMTP id r9so23382100ioa.15
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2020 09:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SIdCK8Q+4LKw+jmzrptYCoQd/JoF3mumY50X9Ph/hTE=;
        b=Yp5CxSqrfh5++OZ58NE4K92opZrfKm6sWxb3Sh29nkbmZefsyHQpOvzEiTfT20mvWL
         Ylhe3sPibXiwVfUgvZrdkbqz8Zr1Nu+xJbQeqDb9tUBAyfKEMNhx3SQ7Ex3WQW8cUk44
         AQGRxWyP3MGm2V/bGpTA3E/T+l8l1QxEkZ9RzoF6AKlIzIrq6NX/JnoydDnhBLBhtFY6
         aLiQRCcXxhnDNcvQqGJy6c+TCi/wXwqHqqiXx7r3Z7E2IhDBKu80KjBogAesWguaxiqs
         vc529Ruw6D747421twHXyXQ71iD9yCYDGdNc8L5j2nyNXTZhIpF+cRGFKdRguHm/xs1h
         ++hg==
X-Gm-Message-State: AOAM531ikU1A02RHKRDrBaHjOnF1W2UZte/i+cXMW3XYOgS3zRXjJnaC
        gApwWs2OzCRPbJGjlF3q4qIBruDp26F8JRzrAYdcorTD0LDg
X-Google-Smtp-Source: ABdhPJxr/wL4FBG9BjuUQiXlSC8n5B0989oGaJ3+8JI4slsvtNxiaGVvvNeo1Fc/qvwpgTWkAaur6QYbJbGO5vawji+M3kZenXYs
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1343:: with SMTP id i3mr8889517iov.134.1596299585453;
 Sat, 01 Aug 2020 09:33:05 -0700 (PDT)
Date:   Sat, 01 Aug 2020 09:33:05 -0700
In-Reply-To: <000000000000f298fc05abb42b70@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf03f305abd37535@google.com>
Subject: Re: WARNING: ODEBUG bug in cancel_delayed_work
From:   syzbot <syzbot+338f014a98367a08a114@syzkaller.appspotmail.com>
To:     bhumirks@gmail.com, coreteam@netfilter.org, davem@davemloft.net,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        johan.hedberg@gmail.com, kaber@trash.net, kadlec@blackhole.kfki.hu,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 43ff7f53de2294a83dcf84b35de6ffa1ffafae9d
Author: Bhumika Goyal <bhumirks@gmail.com>
Date:   Thu Oct 6 18:10:01 2016 +0000

    Staging: vc04_services: vchiq_arm: Remove unused function remote_event_destroy

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=107c810c900000
start commit:   d8b9faec Merge tag 'drm-fixes-2020-07-31' of git://anongit..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=127c810c900000
console output: https://syzkaller.appspot.com/x/log.txt?x=147c810c900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0cfcf935bcc94d2
dashboard link: https://syzkaller.appspot.com/bug?extid=338f014a98367a08a114
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1111ad5c900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16565d5c900000

Reported-by: syzbot+338f014a98367a08a114@syzkaller.appspotmail.com
Fixes: 43ff7f53de22 ("Staging: vc04_services: vchiq_arm: Remove unused function remote_event_destroy")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
