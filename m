Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03880C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 05:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A45320781
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 05:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgHDFxG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:53:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:56916 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgHDFxG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 01:53:06 -0400
Received: by mail-io1-f71.google.com with SMTP id q20so8011347iod.23
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Aug 2020 22:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BRdtTRPOEaQKBrhbJMVyVg8f+gg0wNhNpfaLQFbDwIc=;
        b=DRPGVNsLbV9cXXkPP+gHN9qzHCpW6CnrGA2+IZM3B9uOd77EvjB4zbLTs6YQwn/fo5
         oNICnTqvsHB4IFwMjD0ucXYW0lqoa8aSjOHW9MFBqWjD6veZmQIzqzRwfZLNglvOzYOT
         ZPeuQGNIZ1DOou20xRplnFiKJbnSNmv3/WBM+ocNssciU4MeJ684NZbzU2RJgIo2VARY
         aZmr7uetPxqjYlOGo67NqETWWizy4Xz0qWrpidJHQpOaoLuq7Bq8Ggd18dwNt2oi82i8
         LEtPL/hZBUdmNNGDzVU78FJWaUNqGUKEbkrY5lmINhg5xyBNAaQwPXLzIW5i3McHlVyz
         a1GA==
X-Gm-Message-State: AOAM530FWvQxedzcwLED4BlZ6172iBcJnmwn2Xh4NA78Dsfnkote/p3L
        UjQtV14eEtqnJKZF4bvHkBelxUFRWojJypGRRr9jo18GgNhW
X-Google-Smtp-Source: ABdhPJzEkoMCbnNdFUe97FE5HM517BQ0ax1yAE9KKbwZVWX1mKbnq4Vi7DM1AkTvDXzbANiqrkZroxhk4raf2RYgrw3J8jVZ61+P
MIME-Version: 1.0
X-Received: by 2002:a6b:e216:: with SMTP id z22mr3305588ioc.97.1596520385235;
 Mon, 03 Aug 2020 22:53:05 -0700 (PDT)
Date:   Mon, 03 Aug 2020 22:53:05 -0700
In-Reply-To: <0000000000003d6e8405abeb1da7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070529b05ac06deaa@google.com>
Subject: Re: KASAN: use-after-free Read in hci_send_acl
From:   syzbot <syzbot+98228e7407314d2d4ba2@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, mareklindner@neomailbox.ch,
        michael.chan@broadcom.com, netdev@vger.kernel.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 4ffcd582301bd020b1f9d00c55473af305ec19b5
Author: Michael Chan <michael.chan@broadcom.com>
Date:   Mon Sep 19 07:58:07 2016 +0000

    bnxt_en: Pad TX packets below 52 bytes.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167b0f04900000
start commit:   ac3a0c84 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=157b0f04900000
console output: https://syzkaller.appspot.com/x/log.txt?x=117b0f04900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0cfcf935bcc94d2
dashboard link: https://syzkaller.appspot.com/bug?extid=98228e7407314d2d4ba2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152f1904900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1482dfca900000

Reported-by: syzbot+98228e7407314d2d4ba2@syzkaller.appspotmail.com
Fixes: 4ffcd582301b ("bnxt_en: Pad TX packets below 52 bytes.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
