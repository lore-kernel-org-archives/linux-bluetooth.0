Return-Path: <SRS0=m/C2=4G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2E3C3403B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 13:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A064B2173E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Feb 2020 13:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBRNhE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:37:04 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:44977 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgBRNhD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 08:37:03 -0500
Received: by mail-il1-f197.google.com with SMTP id h87so17013783ild.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2020 05:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aHgHZ98+U4qABqernE/QDZiaIAcqsbiecjuclCSQv3M=;
        b=m5dRbiXvJeW6z6rz4GVs/b6jlAm4v3w5GSQC5D/E/wqTv2RXffqlhDYcIHXvMj0LZ7
         yVNBeY01tGKESMdTPafB3Be5ji9ayAg7x9eTtNlETK0UYsNGa7PW071LopK8BXm3FdgK
         VlevxdI8Bip5tGXtMT23udQuqj5mC5MHVZlfvWgL5m+4C3yFFHHlTymYgkrQ/Lw4eiSK
         2CZaeaVSWHpay5XVv39xEQpqDPjnNG1q9Uzoi1Molmf/zXbJ50JpeBZ0Sn/CoR72tBsm
         q9JSpIAsf8JMWn5wPxmyR75Qydp5idXxXCLdc9TpS5jeKl6TQgd4KHBpSV9GvGaJARqj
         Q3rA==
X-Gm-Message-State: APjAAAUUuVwkPqTrextEwnQy1acinuehcyiWA4/QP5Q3x8ONwCj0mIfQ
        o6DzaLkcikKbGXN4wGGTEGdE+NvprO95dqwt/86WR+4oGUfQ
X-Google-Smtp-Source: APXvYqyshNr6yoq5/wyQMhnfun/9MaaVUhImNxSLDXvsUcP+/UH3ULcBhS56N6d3AxYFbB6MIE376Q80hME1hctKKSSfPJJLaJ4T
MIME-Version: 1.0
X-Received: by 2002:a92:a1c5:: with SMTP id b66mr18063518ill.190.1582033022916;
 Tue, 18 Feb 2020 05:37:02 -0800 (PST)
Date:   Tue, 18 Feb 2020 05:37:02 -0800
In-Reply-To: <000000000000b7ee04059ed40af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a9ed2059ed9c426@google.com>
Subject: Re: general protection fault in sco_sock_getsockopt
From:   syzbot <syzbot+4a38d3795200fd59a9eb@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this bug to:

commit eab2404ba798a8efda2a970f44071c3406d94e57
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Fri Feb 14 18:08:57 2020 +0000

    Bluetooth: Add BT_PHY socket option

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=105f1a29e00000
start commit:   c25a951c Add linux-next specific files for 20200217
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=125f1a29e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=145f1a29e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c727d8fc485ff049
dashboard link: https://syzkaller.appspot.com/bug?extid=4a38d3795200fd59a9eb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158849e9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e3d711e00000

Reported-by: syzbot+4a38d3795200fd59a9eb@syzkaller.appspotmail.com
Fixes: eab2404ba798 ("Bluetooth: Add BT_PHY socket option")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
