Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85491C04AAB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Sep 2023 12:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjIVMBh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Sep 2023 08:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjIVMBf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Sep 2023 08:01:35 -0400
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D80E19C
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 05:01:29 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-57abf1ee779so2704139eaf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Sep 2023 05:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695384088; x=1695988888;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jj2QWvmiK+0WWAcmrF4T0yz3RCgK8HWXoA++/rR1IPw=;
        b=f/SANEywMCnPr/HTlUJKS6qoTSk+O507QQsh3SlIEqbf2iUyq39L3YmM1gCiTjzR1A
         UyaKtW2iJLZZmKN3PwY/Hrri6Klkj+pRbDTray2bjw9+qndaBjiDs+IO+6o3oLrI4vi7
         hXsxCz8IZBPZMFwLsdDmPv55ZBuMawxC2BXRRZlFsrQAiGe54ewZiy2CbYq6LAwL99Se
         HwH0M1lCMryLOm6IpRcpl/y0NeyXfAlExYibUb3v8vMUpGYSOrmP/Y5/jTo61bCLfUJG
         c80qdXjvq+9WVyB2QhlunCgs8+N81dKlGnEtuPl91yPBzR/mMGtJO+PAmhnTwrW0K1Yu
         k0WA==
X-Gm-Message-State: AOJu0YwWbMt90gXKcNI8oVVaeY7mETm8qUCT4wJLau1UQEnvFlKWWWKh
        z8jof1BLK/QoVOWYlT+9YPB5liwmI/Yi2Z1EHPujyX7lFdzk
X-Google-Smtp-Source: AGHT+IGQtOov5rgUCSHUmJaUiEHw6Xxzi7sjyCjTogbyObjGLfUVrtFsovgvSWXfW6nmE42beN87+I5IFZm0BLhP45xFVBRc0qio
MIME-Version: 1.0
X-Received: by 2002:a05:6870:954d:b0:1d6:41c0:c9bf with SMTP id
 v13-20020a056870954d00b001d641c0c9bfmr3173482oal.5.1695384088583; Fri, 22 Sep
 2023 05:01:28 -0700 (PDT)
Date:   Fri, 22 Sep 2023 05:01:28 -0700
In-Reply-To: <000000000000140b1405fce42c66@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005be6710605f15e50@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in sco_conn_del
From:   syzbot <syzbot+6b9277cad941daf126a2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 9a8ec9e8ebb5a7c0cfbce2d6b4a6b67b2b78e8f3
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Thu Mar 30 21:15:50 2023 +0000

    Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b66646680000
start commit:   bd6c11bc43c4 Merge tag 'net-next-6.6' of git://git.kernel...
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b66646680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b66646680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f06d04680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107fdcd0680000

Reported-by: syzbot+6b9277cad941daf126a2@syzkaller.appspotmail.com
Fixes: 9a8ec9e8ebb5 ("Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
