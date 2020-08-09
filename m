Return-Path: <SRS0=zjTV=BT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBDFC433E0
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Aug 2020 05:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D62320709
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Aug 2020 05:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgHIFPK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Aug 2020 01:15:10 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:40889 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHIFPK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Aug 2020 01:15:10 -0400
Received: by mail-il1-f198.google.com with SMTP id z16so5194194ill.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Aug 2020 22:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+7GquL5yQSGcFGMZlACJ2Y2BFlEpHb0ViyNa4GHMUYI=;
        b=rMKqoFXSgY4F1MrcXxUWWLOI1YxA02DIucJqt6GA/qnHq0Lqy1rdIzoaFX36EM6uk1
         H3QItdZ0+08Av+qyXWN3LQ4+OrRnWodNafFoWs1QrhruU7bIrDbX0oflBSQR2raDSLZE
         YhFGFsMEJkAAWWDrxqojK36VM8PYIm9xachapP9AVSwgSLEs1RiCmRYlvXPmbZ4B07o4
         g6Zge+9zIfViO0HZDcSJG7mECiSD0iVVzR1cq4dmvQWsCPNp7hloss6zdojhnOYrR8gq
         Om27rNxzUQtyq+loq5anRYzoOUXV97zqnkQesAR2NBcoFLpOFhlZK1YLPFxObYvlA1TS
         FFKg==
X-Gm-Message-State: AOAM533yueFchy2l0DgS6YPmeqHgzmEUHmS0sN3sBfOdCd506mTIOTQb
        JM6IOpkLG4Ti0g/vDj4MIbl46Yg7wS+x5KiCR+/eruSohhcx
X-Google-Smtp-Source: ABdhPJwnoROO8orXk27MbZoY6LmPmQEmrUZnYlYAjH2J4bAGvlMJDDzVwIZ0hH60TV5qaTtB7u2wVG/qNSiGwWh/MNVTaKiDIsBk
MIME-Version: 1.0
X-Received: by 2002:a92:918b:: with SMTP id e11mr12138160ill.201.1596950109419;
 Sat, 08 Aug 2020 22:15:09 -0700 (PDT)
Date:   Sat, 08 Aug 2020 22:15:09 -0700
In-Reply-To: <000000000000cde53e05ac446157@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fefd5e05ac6aeb99@google.com>
Subject: Re: WARNING: ODEBUG bug in put_device
From:   syzbot <syzbot+a9290936c6e87b3dc3c2@syzkaller.appspotmail.com>
To:     bgolaszewski@baylibre.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, jdelvare@suse.com,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, marcel@holtmann.org, netdev@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this issue to:

commit 6f8c8f3c31015808100ee54fc471ff5dffdf1734
Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu Aug 8 08:01:44 2019 +0000

    hwmon: pmbus: ucd9000: remove unneeded include

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1550298a900000
start commit:   47ec5303 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1750298a900000
console output: https://syzkaller.appspot.com/x/log.txt?x=1350298a900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bb894f55faf8242
dashboard link: https://syzkaller.appspot.com/bug?extid=a9290936c6e87b3dc3c2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b69a52900000

Reported-by: syzbot+a9290936c6e87b3dc3c2@syzkaller.appspotmail.com
Fixes: 6f8c8f3c3101 ("hwmon: pmbus: ucd9000: remove unneeded include")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
