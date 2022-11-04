Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3406C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Nov 2022 17:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiKDR4Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiKDR4X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Nov 2022 13:56:23 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7F84AF02
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Nov 2022 10:56:21 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id d19-20020a056e020c1300b00300b5a12c44so4289115ile.15
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Nov 2022 10:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HFLDZrSmrKf3eaUSPUfU/z0D34JmXW5qNTObPr5a3dE=;
        b=cTWroYLrkuMlgdrZGLi6K+DkUk623nK/S9y2DRSTv+j8hrT6hoR3d3L58J4lUITuC/
         bOPsHJGyVRH5sRi9ztgvxalXkMOB6o2aDQZtxfbs/HPQ+CWIpwx8LCShoBdqjwun6ng/
         ZfaSgBrry2XgsZJgG2SmsmfBDWxUstM9kRj4RSlZftGD8Yu/C+oDdwmlreiIRMhnETQc
         yBX4ZOPn2VpX3THS6grTt52w+R8/8yBmFezLLDR+7xYrgZcCIYKdKecS7s4P6m/N44BL
         QBMNklWSW2ugNcovpVGaO81mcdtKSMaDTI4GXywlWnEU/EKWYH3fegAnWwXiDKyaOnkQ
         8rEA==
X-Gm-Message-State: ACrzQf3/AMVH7N/0zz2nFmPXRWAI1Est+EPvz/ZM1W3pmtYIb4ptzouX
        BIiT7/rqv7O4SoG0V4l4UZ8+nWtf9YkLgKSKNX5duihPlDyv
X-Google-Smtp-Source: AMsMyM5jISVm+ThnehVRlGr4SGLsiESwHWORrPJaHVN2Gla1RS8HH7b06ZPnW17OhSwF1wbMM8K1f2L1F/XbPusoit6A69WxSHeM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1210:b0:375:4aa6:ff85 with SMTP id
 n16-20020a056638121000b003754aa6ff85mr19651201jas.227.1667584580937; Fri, 04
 Nov 2022 10:56:20 -0700 (PDT)
Date:   Fri, 04 Nov 2022 10:56:20 -0700
In-Reply-To: <0000000000000bab2c05e95a81a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000946f3005eca8cafe@google.com>
Subject: Re: [syzbot] BUG: corrupted list in hci_conn_add_sysfs
From:   syzbot <syzbot+b30ccad4684cce846cef@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        gregkh@linuxfoundation.org, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, pabeni@redhat.com, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, yin31149@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 448a496f760664d3e2e79466aa1787e6abc922b5
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Sep 19 17:56:59 2022 +0000

    Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1052f8fe880000
start commit:   dc164f4fb00a Merge tag 'for-linus-6.0-rc7' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=b30ccad4684cce846cef
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1110db8c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e58aef080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
