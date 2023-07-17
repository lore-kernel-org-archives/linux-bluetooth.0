Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0A7EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jul 2023 20:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjGQUW1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGQUW0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Jul 2023 16:22:26 -0400
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DABC1AC
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 13:22:25 -0700 (PDT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1b88edb7f46so7508571fac.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jul 2023 13:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689625344; x=1692217344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGrQ+szKoMK+EaVan75CnITnplIPv8vValzWkyBMelk=;
        b=h+klZZOZrlB7p4GlUvtpAX07t5+7PrnZwQDNxSRHZSKOGt/fP+I+g1gl4TCddN3WEW
         i5iBIV4caWxQbAUEBfu9LbUmzekswVRDQX1BTLw8NPnc0sRj5ZGamKHlqzO21MQhzE40
         n2E4D7rok6ofzJX3IRxNNPvIUqE4Gb2BaHfGHZxYAAkM2hxSrv1GTlxJe+J3lmJig9BO
         2LbXIZl60ydMMAh0msVufnBW9SPR868eRysP1fDTULkFcidkb7Ebf2z4LsHPZ45OLcaX
         ZUldFY7bnGrNCecIPC1lAcebDUo9gALSox24c9QInwl37wfyZIkEWaiOa3SsHriEw6UK
         JMgg==
X-Gm-Message-State: ABy/qLazxuP6Yny4SE6psxKqEQ0sqJJBUykrhYl2uWcQiiiBD3eCdEhU
        eE11kp0/gEt3Tm/0Psd22K3OA5R4RMeRllfaV4An24FseVOA
X-Google-Smtp-Source: APBJJlH3Timn+OhaHJ/79ZumgdgzTTzyEzblDmWTxmlZfYEFG5zG9Y/2M+u7w8vJLIufO3NBE/Ht7+La67whJbsd8/rLPvXWbJRL
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5aa5:b0:1b0:60ff:b748 with SMTP id
 dt37-20020a0568705aa500b001b060ffb748mr11252238oab.3.1689625344585; Mon, 17
 Jul 2023 13:22:24 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:22:24 -0700
In-Reply-To: <00000000000049baa505e65e3939@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077b5650600b48ed0@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in hci_uart_tty_ioctl
From:   syzbot <syzbot+c19afa60d78984711078@syzkaller.appspotmail.com>
To:     davem@davemloft.net, hdanton@sina.com, jiri@nvidia.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d772781964415c63759572b917e21c4f7ec08d9f
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Fri Jan 6 06:33:54 2023 +0000

    devlink: bump the instance index directly when iterating

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=136a0414a80000
start commit:   84368d882b96 Merge tag 'soc-fixes-6.1-3' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=24d192d47d02d9e1
dashboard link: https://syzkaller.appspot.com/bug?extid=c19afa60d78984711078
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168fc765880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1376e745880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: devlink: bump the instance index directly when iterating

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
