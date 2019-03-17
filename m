Return-Path: <SRS0=QJP1=RU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3CAC10F05
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410B2218D4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Mar 2019 10:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfCQKnU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:43:20 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40730 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfCQKnC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Mar 2019 06:43:02 -0400
Received: by mail-io1-f71.google.com with SMTP id e72so4920450iof.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2019 03:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8MbrwbVMz/U2xBG6e2LAHNi6Es8AzxeT9Tpv47LzQRE=;
        b=uJgxeiF5m8YhbmmNEl1Ac8evRHz4LWKJ5M3IPd8xrRwY9tVSKbLJJtbWSWAAgmVWA3
         5AYw0Llkn/3ajrfuxVTTVptjkBEICZRqkJKenHfVlZETLWbh0YMv88fm/9p6249nU5Gm
         33du26Y2KkAweGmRQJsl4jnvsYv32uINZ/D45M+OwX8TkYahq3uIZCAtrdCiwYrHnDDb
         EAkMSYDQiHajv5d4Qjtz98K/K8OmK1DiUUqkJyIL6olCOuKXmCQ0XMTgMV4ZI2S0AH8w
         KhFY8hzYXXdEoStf162XgM2YrpHzCA3w6iILjRNuiOOQ7ezi/NVw8BUcjEudqV0pYMBS
         lENg==
X-Gm-Message-State: APjAAAUBf1GrogP6EaSgGD2YjUOFEBr3oSdQmFF/zBDZ+YLfO1e0RO7m
        FmbZ1OtD8LGuUNDCvveMY5+ru3KnHZ51lRl/qJD5uy4B34ui
X-Google-Smtp-Source: APXvYqyopT+KYGY0Lg9SOPp4VT6xOVP8PZzi03QqktR8TBdWZt0BCNCbqieSY3QNJu7Vl8xSKKexSBeXTM0it0lTi3EmHaXzbFH5
MIME-Version: 1.0
X-Received: by 2002:a24:3552:: with SMTP id k79mr2932454ita.18.1552819381326;
 Sun, 17 Mar 2019 03:43:01 -0700 (PDT)
Date:   Sun, 17 Mar 2019 03:43:01 -0700
In-Reply-To: <0000000000002996510581a1487e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fd88d058447ef47@google.com>
Subject: Re: general protection fault in qca_setup
From:   syzbot <syzbot+8c0dbf8843bb75efaa05@syzkaller.appspotmail.com>
To:     gustavo@padovan.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com,
        ytkim@qca.qualcomm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has bisected this bug to:

commit 0ff252c1976da5d80db1377eb39b551931e61826
Author: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Date:   Mon Aug 10 21:24:17 2015 +0000

     Bluetooth: hciuart: Add support QCA chipset for UART

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106c36d7200000
start commit:   0ff252c1 Bluetooth: hciuart: Add support QCA chipset for U..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146c36d7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee434566c893c7b1
dashboard link: https://syzkaller.appspot.com/bug?extid=8c0dbf8843bb75efaa05
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130894af400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10799004c00000

Reported-by: syzbot+8c0dbf8843bb75efaa05@syzkaller.appspotmail.com
Fixes: 0ff252c1 ("Bluetooth: hciuart: Add support QCA chipset for UART")
