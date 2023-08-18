Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D958C71136
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 04:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357866AbjHREkO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Aug 2023 00:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357859AbjHREjh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Aug 2023 00:39:37 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6093AAB
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 21:39:36 -0700 (PDT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1bc49d0cb4aso7100755ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 21:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692333576; x=1692938376;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvFwXjLMYeqdlXwre0HE3uWwxv+R86ki6i68P3Vs0+0=;
        b=BnRjZPpg3h9KBNAJs7krvhcuMgb8M4AZlQFnjQwwNaJ8XnN4/E1ji/2G0Ptt+UO8RJ
         xQphr1DiFD8gVD+7BOwmq9nZcTIZAlQ1i1Aza6qHBslvx4rZ/dG+PDcAQoLx7Hl0m8vh
         TDz8aEIE/BiIEYL9qzy1a70jilFP6JyGEWB4P3HUlGC5E74gnYrjeZKsuo39cC/iDOk2
         jULJJkxtLQyeUN31HTFYK23nqwCHwS0YDBn5BXxjee2Org47fHf8JvyfNtwy/HNY6TKk
         tWr4q+/oOwKVPa1nHTCdeyCReXEH5gBqTjiq4pgMpI1q0yjZEyRF/xtl0HUhi/1U88j1
         V+Zw==
X-Gm-Message-State: AOJu0YwRPlanfrpeC0q1yF0Uc1kX7M/lU3PboLiSjqtKIDSvMH6OXIqt
        sPrOwjtFTkO/p8ilK60HlNLd2R3HDkumdR/dAhxyyL0sDJig
X-Google-Smtp-Source: AGHT+IEOWZ9TR7uxnnrr5o2vN1zMwhChrSWkI3uvdoJ384ju6Mbmly2riQQtj6/6k2K4DgTVbAMNubudY8qv1xdOJsYBGe16jePd
MIME-Version: 1.0
X-Received: by 2002:a17:902:da92:b0:1b9:e8e5:b0a4 with SMTP id
 j18-20020a170902da9200b001b9e8e5b0a4mr573998plx.8.1692333576338; Thu, 17 Aug
 2023 21:39:36 -0700 (PDT)
Date:   Thu, 17 Aug 2023 21:39:36 -0700
In-Reply-To: <00000000000013b93805fbbadc50@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8c57a06032b1dd2@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_chan_del
From:   syzbot <syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, lrh2000@pku.edu.cn,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        pav@iki.fi, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 45c37c4e9c9aab5bb1cf5778d8e5ebd9f9ad820a
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Wed Aug 9 23:49:33 2023 +0000

    Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1331e265a80000
start commit:   47762f086974 Add linux-next specific files for 20230817
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10b1e265a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1731e265a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed03cf326b3ef94c
dashboard link: https://syzkaller.appspot.com/bug?extid=cf54c1da6574b6c1b049
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1125bc65a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ce8f03a80000

Reported-by: syzbot+cf54c1da6574b6c1b049@syzkaller.appspotmail.com
Fixes: 45c37c4e9c9a ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
