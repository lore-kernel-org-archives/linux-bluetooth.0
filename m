Return-Path: <SRS0=3vvc=RY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F8BC43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 18:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2278421874
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Mar 2019 18:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfCUSWB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:22:01 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:40308 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbfCUSWB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Mar 2019 14:22:01 -0400
Received: by mail-it1-f199.google.com with SMTP id f84so3114012ita.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Mar 2019 11:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fTLO6OcuHsHb44XDt78pjCY8tSBFpFvZ5qx5QixAZZI=;
        b=rEkXKpMECvNwMMu+QOxAKhKyU24c+PpJ6lMI07nn5TBsqzJ/oOLdO1BNNLysabq23b
         ltsoH0DORfgZ5L8ta6D6LMEToL73RQgtUIJkfUH1v4WrkAo4w4L/mioXyDUm1/34QuyF
         PAtH/A2sjiU+aJ0lurXCOj0wRgOtTn2y77fa0Vhwjj9MKuJltOJK0giKDC1qmtd3rPkw
         InRzLsLe/JWxSLo7XbNPNQtxP6uQevWyNqD4tZSxRn1pLwPZJ1vZJMYeQhsLkTOZJI5n
         Yyb+7m2uaFQZTj9B6U6iTUj1pth5gWpbDArXtUhPNBykG5Sq6pHq/4wGThY2ftjxIqTZ
         yl0w==
X-Gm-Message-State: APjAAAVbyUNlo8f/NFyFauooDofbUUkmDDxZ8uVslHsoJwVgARwnFbnV
        xUVJ2zkffhqMFzZ7qYvbZta+UhoseEL4NVx+O/nuXtDsNIVu
X-Google-Smtp-Source: APXvYqwfKfcWYoLC2muoC5HxT06a0Hqy417x+/kQ/NPZelbuME0SoyhSJaSJ/ffzRHwSnLs2YB1A8wU03lJGFeDGI4rovr1XO69C
MIME-Version: 1.0
X-Received: by 2002:a5d:8358:: with SMTP id q24mr3698326ior.273.1553192520865;
 Thu, 21 Mar 2019 11:22:00 -0700 (PDT)
Date:   Thu, 21 Mar 2019 11:22:00 -0700
In-Reply-To: <00000000000017690505849d6b3c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000795f1c05849ed02b@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in hci_uart_set_flow_control
From:   syzbot <syzbot+79337b501d6aa974d0f6@syzkaller.appspotmail.com>
To:     gustavo@padovan.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@intel.com, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this bug to:

commit 162f812f23bab583f5d514ca0e4df67797ac9cdf
Author: Loic Poulain <loic.poulain@intel.com>
Date:   Mon Sep 19 14:29:27 2016 +0000

     Bluetooth: hci_uart: Add Marvell support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=112f0a3b200000
start commit:   162f812f Bluetooth: hci_uart: Add Marvell support
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=132f0a3b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=152f0a3b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9a31fb246de2a622
dashboard link: https://syzkaller.appspot.com/bug?extid=79337b501d6aa974d0f6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15397fd7200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151e9e6d200000

Reported-by: syzbot+79337b501d6aa974d0f6@syzkaller.appspotmail.com
Fixes: 162f812f23ba ("Bluetooth: hci_uart: Add Marvell support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
