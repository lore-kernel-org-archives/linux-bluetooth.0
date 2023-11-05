Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AB2C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Nov 2023 17:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjKEReM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Nov 2023 12:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKEReL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Nov 2023 12:34:11 -0500
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4796C6
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Nov 2023 09:34:05 -0800 (PST)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3f4ab1238so4565413b6e.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Nov 2023 09:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699205645; x=1699810445;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4FvxRKbvCfMpMcLXPYkRNT3NM+7m0oeXuj/bJJZmv8=;
        b=D6/fzZN4CmaWlewRahp07jRc3gyCb4XVDtvHAa8ytpGrYA5XjoOaerPO+BdV0PyRxm
         1lD7IZ65olxzIQVqXKnF7QZfyHRSwXxj+CXDKBtxEsptcAksJa5JFwB/NiSiIBWK7X23
         wvxbfKeoVuKhTX7b4Qc60uo8iOseOXpFGljtaPDpsqBptkU2yCmrZGnIKxIXgNj9s9VM
         x1DGflrVUaP9ib1CXAur8bAf8nm6mpn20s6rFIEFFTmHzX9+3MVkCrAgSn22lUiLSx35
         p98WQOOP5OT+D2hCpvq96Q5VlCHt+GDPXCdG/sb3JDlQUFnJAikAdWNK7kXk7f0kIiCe
         Lg9w==
X-Gm-Message-State: AOJu0Yyee89BUdni8QqDU4/cdbkhLF7krGPtMYufcWb89JVhnGo8gZvb
        D+G3rImFNJJNANN27qyhbe3XdM/c83FQWsMKkNUcsJx1MtxX
X-Google-Smtp-Source: AGHT+IHQGKy6Mfra4sf1/Fnaf3EC/D55G0NP35y8t1SN8GFVyNI7t9d57uCYzqPBwHjaKdaF7v3yTC+yAH7PGthgD35bnMd/I7bL
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3083:b0:3ad:aeed:7eeb with SMTP id
 bl3-20020a056808308300b003adaeed7eebmr10612059oib.6.1699205645177; Sun, 05
 Nov 2023 09:34:05 -0800 (PST)
Date:   Sun, 05 Nov 2023 09:34:05 -0800
In-Reply-To: <0000000000006f759505ee84d8d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e197ef06096b2454@google.com>
Subject: Re: [syzbot] [nfc?] [net?] BUG: corrupted list in nfc_llcp_unregister_device
From:   syzbot <syzbot+81232c4a81a886e2b580@syzkaller.appspotmail.com>
To:     309386628@qq.com, davem@davemloft.net,
        dominic.coppola@gatoradeadvert.com, dvyukov@google.com,
        edumazet@google.com, hdanton@sina.com, johan.hedberg@gmail.com,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org, linma@zju.edu.cn,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, zahiabdelmalak0@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit b938790e70540bf4f2e653dcd74b232494d06c8f
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Fri Sep 15 20:24:47 2023 +0000

    Bluetooth: hci_codec: Fix leaking content of local_codecs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15cb8f17680000
start commit:   e1c04510f521 Merge tag 'pm-6.2-rc9' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe56f7d193926860
dashboard link: https://syzkaller.appspot.com/bug?extid=81232c4a81a886e2b580
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e90568c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Bluetooth: hci_codec: Fix leaking content of local_codecs

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
