Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A881C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 21:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7066160EE5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Aug 2021 21:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhHPVBm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:01:42 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:41640 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbhHPVBm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Aug 2021 17:01:42 -0400
Received: by mail-il1-f199.google.com with SMTP id l4-20020a92d8c40000b02902242b6ea4b3so10403577ilo.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Aug 2021 14:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QdxFVZxxVpsbxj2o+V3LRFIQHQQnZrQkJLl5OL4ggRM=;
        b=rPD1yue2qYhKbtYPcdbYR6CuprAmWU3WLrTL3/x4WckqsjSXgidHyJsm+IHjNehW4S
         fr38bkfVfNLGHeChaF3wLcrBodn6i2/nfRsZZ5h43Fjr3Cgt3hyPvA8Yp2LYiHzQnLLF
         coIWBOFvG9zNKDGB/ginWJknURZkNesIh0QOPlw9+6W5xRGt4hKJiOaklrARZm/2v6GK
         TkmiFeNC2RhEN6OkCBFKW6jWOUggo3w+QyHgx4NeLzhuD0VswcDj6wze+d+YNlpsdNSH
         Oq1klpUNNmANFWVP5wr+dISMxV8vMLCVjTK8ZrVtfzQtnhJFACk2ofcMl6i/NfTw25zp
         ntaA==
X-Gm-Message-State: AOAM531lYMgKm4anx07E0/ct1PUfQCEBk3u/1WZW3G9xXDnMB5lENR8x
        s9FgkxlHTsxg6nCocbWKNru6HIkiB1rsQ9yIZkVMkCXqeGaW
X-Google-Smtp-Source: ABdhPJwbLG6x/Nim7U+ZAhIBCiDjR+IfP2PInnWonRdz7ac8GlsIVYJT2H3mkthaKYjCFEL1injmoeKZyfkmc6VcPTKerPKls3PN
MIME-Version: 1.0
X-Received: by 2002:a05:6638:33a2:: with SMTP id h34mr513258jav.43.1629147669921;
 Mon, 16 Aug 2021 14:01:09 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:01:09 -0700
In-Reply-To: <568c354b-6e4b-d15a-613e-3389c99a93a1@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027061b05c9b38026@google.com>
Subject: Re: [syzbot] INFO: task hung in hci_req_sync
From:   syzbot <syzbot+be2baed593ea56c6a84c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/bluetooth/hci_core.c:1346:18: error: 'HCI_MAX_TIMEOUT' undeclared (first use in this function); did you mean 'HCI_CMD_TIMEOUT'?


Tested on:

commit:         a2824f19 Merge tag 'mtd/fixes-for-5.14-rc7' of git://g..
git tree:       upstream
dashboard link: https://syzkaller.appspot.com/bug?extid=be2baed593ea56c6a84c
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145874a6300000

