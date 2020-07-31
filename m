Return-Path: <SRS0=UTuE=BK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179CAC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 08:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37DC2084D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Jul 2020 08:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbgGaIoJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:44:09 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:54253 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731374AbgGaIoG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Jul 2020 04:44:06 -0400
Received: by mail-il1-f197.google.com with SMTP id v13so7942992ila.20
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2020 01:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=2MiWhebPAZEwNHbE02ggeQmHTDlIjaaAtS5l21f1BPw=;
        b=iBXQaP86SCGC6SIP7sne1BNpGX6rpQj+YGVXRMfMyPgtO8oypRGgZBZkacYwqx+S7D
         o3ZRYyMwvoqWW24RlPm0Vg2P5LjjaSYc7+WRXRgkV205HG8uj59QIP8Zj1ySEpqn6xDA
         ZdaJ2OEfRnZJUenWX/p4SibmZZ7++44xuQB75NGbZSXZqIUPR3me0xnPdB3DnAFt6iDS
         I2b8ZI6i9A/9odjwBCZxbXHkD4WAHXpbO/8txkLNC/Gj6ckYluHQXhifV59kjfAeHL9U
         0BNeH4WP6AgymL63R+vr79gAPKkQyJVLXf8AOVLu+AS820BrHu4mQISdCkAPzVZl46pW
         FNtw==
X-Gm-Message-State: AOAM5308J1lqpAHrsIt5q05hDYQO2ZVDN49IoXA+TsJerr74+r74+iXR
        cOzylYQjP8e3BsSBrXDq2r1Qe5XuujRdXtiToIgK3tPnGT/Z
X-Google-Smtp-Source: ABdhPJy4Rj2LLEiAspTEtCegum11hHhIEmst76GFNZjb8ziE/nZyOIvy4zdOy45COS+BYVrIBbRSJc0ymQWmZ3YMzOpl0u7SggRq
MIME-Version: 1.0
X-Received: by 2002:a6b:7416:: with SMTP id s22mr2545374iog.160.1596185045466;
 Fri, 31 Jul 2020 01:44:05 -0700 (PDT)
Date:   Fri, 31 Jul 2020 01:44:05 -0700
In-Reply-To: <000000000000f6d80505abb42b60@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1816805abb8caa1@google.com>
Subject: Re: WARNING in cancel_delayed_work
From:   syzbot <syzbot+35e70efb794757d7e175@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        johannes.berg@intel.com, johannes@sipsolutions.net,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        luciano.coelho@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit fbd05e4a6e82fd573d3aa79e284e424b8d78c149
Author: Luca Coelho <luciano.coelho@intel.com>
Date:   Thu Sep 15 15:15:09 2016 +0000

    cfg80211: add helper to find an IE that matches a byte-array

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1790af82900000
start commit:   83bdc727 random32: remove net_rand_state from the latent e..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1050af82900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e59ee776d5aa8d55
dashboard link: https://syzkaller.appspot.com/bug?extid=35e70efb794757d7e175
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1160faa2900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11816098900000

Reported-by: syzbot+35e70efb794757d7e175@syzkaller.appspotmail.com
Fixes: fbd05e4a6e82 ("cfg80211: add helper to find an IE that matches a byte-array")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
