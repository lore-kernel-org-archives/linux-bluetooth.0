Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CCBCD4934
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 22:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjITWyx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Sep 2023 18:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjITWyw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Sep 2023 18:54:52 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA6E4
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 15:54:46 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3adfeefb924so211611b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 15:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695250485; x=1695855285;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2g79bcICkCCHdQM90cMC4akmu6VrqB/gBv3hd+fNQRM=;
        b=dnzhM1DNphFIhLiwcIOC3usOCj0P/XNNFYuc2J4Kf6wdrQC4OXxrLOZeY9jkf+i1X2
         DYhjEJcyU1BaxJQk8jndeeaGo97JNhfsD7yi0i2WTPprKOcTDUMueLxmwaAG9t+Y0sgx
         cFePEwMp5P1iMS0VnmkN7nvCdymF4QosGNjdbd6oaObOU0KbkUvdUlZ97XkMQNTQHNEA
         Rq+iqE23BfKBE2EwMyx2l6hoiwqCtIrn3fEejg/vkH1PSg/VDVoNRBxupq3os30SHk89
         6ZG71cO4cd5LIT9CM66KWBhU2hxjPX443fTZXqLEp80qCKsD2eq3/DWxglx60rOgDblB
         U2zg==
X-Gm-Message-State: AOJu0Yx2L2cIQu4GdIyCoWnC6r8pkJuRkJ05IJ/+vWLfq13548cKUZzJ
        jIANL4+F4WhRWPS6eiDPT8Bn31Y3qyGvMrsXcYyCUeJ2LmjW
X-Google-Smtp-Source: AGHT+IEikjJmvx8UO8IMdN6a+9RMgVvnMxyC7pr1mrFDzf2WyUEBC1kduMH0LqlxWiVKOiNJ+Pk+swZS+bvkmRPzA6YhkYbkeqDB
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a1e:b0:3a7:9a19:332b with SMTP id
 bk30-20020a0568081a1e00b003a79a19332bmr1845061oib.7.1695250485411; Wed, 20
 Sep 2023 15:54:45 -0700 (PDT)
Date:   Wed, 20 Sep 2023 15:54:45 -0700
In-Reply-To: <000000000000a91cfe05fe5161f2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd0b980605d242ed@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in __hci_cmd_sync_sk
From:   syzbot <syzbot+c715e1bd8dfbcb1ab176@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        iulia.tanasescu@nxp.com, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 2e846cd83f6285f4fee49389954b1b1215f5e504
Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Date:   Tue May 30 14:21:59 2023 +0000

    Bluetooth: ISO: Add support for connecting multiple BISes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15636364680000
start commit:   1f6ce8392d6f Add linux-next specific files for 20230613
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17636364680000
console output: https://syzkaller.appspot.com/x/log.txt?x=13636364680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d103d5f9125e9fe9
dashboard link: https://syzkaller.appspot.com/bug?extid=c715e1bd8dfbcb1ab176
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11287563280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14395963280000

Reported-by: syzbot+c715e1bd8dfbcb1ab176@syzkaller.appspotmail.com
Fixes: 2e846cd83f62 ("Bluetooth: ISO: Add support for connecting multiple BISes")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
