Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B444EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Jun 2023 15:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjFPPKZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Jun 2023 11:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345900AbjFPPJp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Jun 2023 11:09:45 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0FF3AB5
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jun 2023 08:09:30 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-77ad4f28a23so63728239f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jun 2023 08:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686928169; x=1689520169;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Imb23EaY07Gm7MJa4Np4kGVuIs1+xNQBFZQNfFls+gM=;
        b=fyzXVsUGZFC1gFiLspb3wS0m9qPO/0OlazEOUw9fTVrlg+df0JA3slwPTroZ/SGyqg
         5/X1Aw/6NyawF71StfmJkQgDLrRleuCKchl5uVqMV1AIrzUqdLIy2Q5o5WxqTcXJRC4L
         i//FnV+vqCeKBYMDIQTKgUnVb33QdBZX64Ai5zsEfBPjEsNw32vesCMbOsA35rpaRWYU
         oRG7SjD/2jFMIrRi1XhRqY/yYlgsRJWJcLqWRPwMHZ6Oao7ZNXtOg1FY4ENa9RY8MIjg
         x3z8rOoBQDZnW/Rw6YuU8fxSSNdzyp33ML17BkUV1G3xSchsWz71vaYq2yrq75xQOzeT
         y48Q==
X-Gm-Message-State: AC+VfDwL+22jtBJPRylWgT0vkx6I5DAL5XZing8uYPIY7ZdOcbFa+AvU
        IQdTraD3CBR1F8FusE5UDbT+bEnMxWaCl1MSRVk6HJ4gGj4J
X-Google-Smtp-Source: ACHHUZ74+dXyvXDTGc+FFJWwCq4aB7E4QHdfr+P5b8tR/ce1Zt3HbjyX4nIZUMIKXW6jGatIamaZTBC88weu2rXjtpNJxD+nybqE
MIME-Version: 1.0
X-Received: by 2002:a02:a119:0:b0:423:13e1:8092 with SMTP id
 f25-20020a02a119000000b0042313e18092mr696867jag.5.1686928169697; Fri, 16 Jun
 2023 08:09:29 -0700 (PDT)
Date:   Fri, 16 Jun 2023 08:09:29 -0700
In-Reply-To: <00000000000098289005dc17b71b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051087405fe4092cc@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in sco_conn_del
From:   syzbot <syzbot+b825d87fe2d043e3e652@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, fgheet255t@gmail.com,
        hdanton@sina.com, johan.hedberg@gmail.com, josephsih@chromium.org,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, lrh2000@pku.edu.cn,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, yinghsu@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a2ac591cb4d83e1f2d4b4adb3c14b2c79764650a
Author: Ruihan Li <lrh2000@pku.edu.cn>
Date:   Wed May 3 13:39:36 2023 +0000

    Bluetooth: Fix UAF in hci_conn_hash_flush again

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13755717280000
start commit:   e4cf7c25bae5 Merge tag 'kbuild-fixes-v6.2' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=555d27e379d75ff1
dashboard link: https://syzkaller.appspot.com/bug?extid=b825d87fe2d043e3e652
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10052058480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1190687c480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: Fix UAF in hci_conn_hash_flush again

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
