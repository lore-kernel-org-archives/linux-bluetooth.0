Return-Path: <SRS0=nDLV=Y7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9790EC5DF61
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7DE2077C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Nov 2019 13:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbfKGNmu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:42:50 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:49430 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389142AbfKGNmJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Nov 2019 08:42:09 -0500
Received: by mail-io1-f70.google.com with SMTP id x1so1844053ior.16
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Nov 2019 05:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lTBwmsnLCzbX/olH5Mwl+G5iNSg0YQFvLfdGOpbbv6E=;
        b=i1kz2OX3pKTEQJgrj/Q0cxxyR3xajN4I/TNc35EPAWbpEiMQyHf04iJZ+OJXP11cB/
         8Z87DCCtgAawR9/ENrsUTPFrg6WxSq8lqvRzmoLHJHAYnQMXoleneOg4MwpZET5scfUG
         xlexcrdS6rQkgig/bw1ZzSR9bb+NlqIuGUDyVgOE2Afdn6n/6WZMvmwDyQeKG0+bZs6I
         88ZjOA12amhTOdgTSEaqD0SO+mnvGgnKF/Wt5PDZ2sDQvYyRCYxl33IieZWmlUlt1AY1
         L8mDrl7U5I1dGhsjSCDKQPJ7wyyNfd0PKKSWvCr3njlfTOMeCxSSXCBR5dwdKDujGeTP
         +3Dg==
X-Gm-Message-State: APjAAAVapBSiRZryoAfbAMHmfQXzSiZeo+qDgDkQmfST2hqy3gtssZjW
        Hww5WmqiDPPmTFDSKyC5LqmsLf1wLH4luAtXWyVocy0n8d2g
X-Google-Smtp-Source: APXvYqz6ZViFFcstbOLQh1BYSSIMXfKvEDzmUndoSodku49jzXKlimDRlia/G2rBwC2BghwEl5PykfBqcmfIdbePjHfamdgABMJ4
MIME-Version: 1.0
X-Received: by 2002:a02:1c41:: with SMTP id c62mr1425jac.132.1573134128561;
 Thu, 07 Nov 2019 05:42:08 -0800 (PST)
Date:   Thu, 07 Nov 2019 05:42:08 -0800
In-Reply-To: <0000000000002996510581a1487e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eac5200596c1d46b@google.com>
Subject: Re: general protection fault in qca_setup
From:   syzbot <syzbot+8c0dbf8843bb75efaa05@syzkaller.appspotmail.com>
To:     gustavo@padovan.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, vdronov@redhat.com,
        ytkim@qca.qualcomm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit b36a1552d7319bbfd5cf7f08726c23c5c66d4f73
Author: Vladis Dronov <vdronov@redhat.com>
Date:   Tue Jul 30 09:33:45 2019 +0000

     Bluetooth: hci_uart: check for missing tty operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1436b32c600000
start commit:   d1393711 Linux 5.0-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=8c0dbf8843bb75efaa05
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130894af400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10799004c00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: Bluetooth: hci_uart: check for missing tty operations

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
