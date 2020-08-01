Return-Path: <SRS0=3CUk=BL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61365C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Aug 2020 22:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BED206F6
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Aug 2020 22:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgHAW4L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 1 Aug 2020 18:56:11 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:53629 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgHAW4K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 1 Aug 2020 18:56:10 -0400
Received: by mail-io1-f71.google.com with SMTP id f22so15759584iof.20
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2020 15:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dOzePy5yJodn3MAztJ8MjMszFxBpzjO8+9+k54Plw7U=;
        b=YeFLHyWpCWNCRunyZoFFIOguyNC7DawplTpC40pHOSNglgNZAZzPk/CfE/Op4q6KgL
         k79EoTLYzV/2cPyMOGju6nnovj3xHo/lRXx222nVxWzeag32B4mrzwJATehVdUv8eVuN
         kakGXPzvjzrUaGn6sQFnojH8fhBxmy7YHyFIiFoOZ+7HQKcKNtFD/XLR1odc3oTwAc6P
         z52PRm+gZ+GQPRlDYBqBt8WiCJmz1avMSUsFDN4CMkE6+9/2wgb4BShHjfiq5G4MQDVd
         +FUWmkyds7UnWmo3k2Qyq/Dn7EznlAYLD+Bqhz+8MdJ/Cx/3NxlU4Utmy0i3Rd5wmvbF
         z7VQ==
X-Gm-Message-State: AOAM532ksvmEZV5V8fSmOxA7FqwdapgD9RGaagPDM+DnbxNWWakk1Rw2
        duNc//lOcfaAcHjhw+9aWWYubG+ApZNH9V3OivQ5fEFs/K5C
X-Google-Smtp-Source: ABdhPJzoFyfIZQhNRPiFzD4/WN4vVmjC3jcEN/n2QVLjineSWA8YL2dCDfS0uwVot1kHmJxuiejHJRIs+6Vlg9DaPmCCBtbeQtI1
MIME-Version: 1.0
X-Received: by 2002:a92:79c4:: with SMTP id u187mr10446904ilc.194.1596322569603;
 Sat, 01 Aug 2020 15:56:09 -0700 (PDT)
Date:   Sat, 01 Aug 2020 15:56:09 -0700
In-Reply-To: <0000000000007450a405abd572a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b54f9f05abd8cfbb@google.com>
Subject: Re: WARNING in hci_conn_timeout
From:   syzbot <syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com>
To:     coreteam@netfilter.org, davem@davemloft.net,
        devel@driverdev.osuosl.org, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org, johan.hedberg@gmail.com,
        kaber@trash.net, kadlec@blackhole.kfki.hu, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        rvarsha016@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 3d30311c0e4d834c94e6a27d6242a942d6a76b85
Author: Varsha Rao <rvarsha016@gmail.com>
Date:   Sun Oct 9 11:13:56 2016 +0000

    staging: vt6655: Removes unnecessary blank lines.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17023a14900000
start commit:   7dc6fd0f Merge branch 'i2c/for-current' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14823a14900000
console output: https://syzkaller.appspot.com/x/log.txt?x=10823a14900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e59ee776d5aa8d55
dashboard link: https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f781d4900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116a0c14900000

Reported-by: syzbot+2446dd3cb07277388db6@syzkaller.appspotmail.com
Fixes: 3d30311c0e4d ("staging: vt6655: Removes unnecessary blank lines.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
