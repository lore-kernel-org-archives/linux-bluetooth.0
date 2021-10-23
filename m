Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550F4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Oct 2021 13:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C6A60ED3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Oct 2021 13:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhJWNtd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 23 Oct 2021 09:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhJWNtc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 23 Oct 2021 09:49:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CBBC061764;
        Sat, 23 Oct 2021 06:47:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e19so7092040edy.0;
        Sat, 23 Oct 2021 06:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CHTTiz/vvwyGyiU0edgyMzPDNqvYsXTPAInXA2oaKyQ=;
        b=a5fKR7cIcb2HP0ioumDIZYSg5xxKlVdv2QMfXMk087u1tXLTPty1SPg+P7cyFVkRJH
         qhSacNj0aFxa25NlBdl2Qs936C6jzs1CjsUDQ/LpzG1Oo3gfpSyycS3BrGooMjjv8zS+
         X16UzbmVNWKA7yGvgTouN9KDWiaR98HhALl4T27uRQDrgLxVE2L4YsTGeV2TjccPXVcg
         BYp77Tv/1+/YfU5sq3cYPAg9AwBr4yzZaZJJcX0PItNHLCSWTiAUNZUpbHjb2u0td81E
         GUIuTOj3soaqKVioacP+4jCZjphMcFbr4yH7mB5nxBaSNZ6LDl4obkVlXVNzyA95awGJ
         OnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CHTTiz/vvwyGyiU0edgyMzPDNqvYsXTPAInXA2oaKyQ=;
        b=wqr07hVpjeaygQzBrpraj8iRW3rl66+OCiKg/aJMiSQEKQFoY0foLEjb9ELCLjjc70
         rqMF8vfZ/CsiCkVkhyEaeOy9Q8qPqTZ3jpN7yJoVOHqacUhyqJFab90IbAsesScVZJ5n
         u6Fz6JX+3UeuOonC1hYAFifWkvqMMDXKoRMV1z1WHFXOgU0pVix1816LTP0+9EjjtIkE
         sOtyUxsLp3LOKwOYilrjxHu9/u+z/unH3au8DnLkf8bW3F5WCrVEMTd31YPQefusQBIa
         4iSswMU3azU0sgwqZAz6a/yooytlfcZKjS8DQziVmqdh9l/VZSAWuLoXa/wI85yPZw6m
         007g==
X-Gm-Message-State: AOAM531i5LPW0eYBLcpKz2xV/N1OxwttsPX6m9yl4C1rpaEZNR3idAjH
        u3yjWxSB0MkN7d8oHEp4x1eYYq8xXeU=
X-Google-Smtp-Source: ABdhPJxhvYIDQbk3B6Fy5Z3B40cv2EqYLLWaTIpgkYgdSor6wbA3dyOz/q6O0iPBPdBJnAap+ALDCg==
X-Received: by 2002:a05:6402:5ca:: with SMTP id n10mr9087295edx.216.1634996831905;
        Sat, 23 Oct 2021 06:47:11 -0700 (PDT)
Received: from localhost.localdomain (host-80-181-148-119.pool80181.interbusiness.it. [80.181.148.119])
        by smtp.gmail.com with ESMTPSA id ck9sm4954401ejb.56.2021.10.23.06.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 06:47:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Cc:     syzbot <syzbot+f2725165900304ec97b6@syzkaller.appspotmail.com>
Subject: Re: [syzbot] INFO: trying to register non-static key in hci_uart_tty_receive (3)
Date:   Sat, 23 Oct 2021 15:47:10 +0200
Message-ID: <4202176.J8ZBFPDcmx@localhost.localdomain>
In-Reply-To: <000000000000162f5005cef9bbf7@google.com>
References: <000000000000162f5005cef9bbf7@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart10165136.KMSVk7YZYO"
Content-Transfer-Encoding: 7Bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart10165136.KMSVk7YZYO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Saturday, October 23, 2021 1:54:24 AM CEST syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    519d81956ee2 Linux 5.15-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16787178b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1f7f46d98a0da80e
> dashboard link: https://syzkaller.appspot.com/bug?
extid=f2725165900304ec97b6
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils 
for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the 
commit:
> Reported-by: syzbot+f2725165900304ec97b6@syzkaller.appspotmail.com
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.

Let's try the solution attached.

Fabio

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
--nextPart10165136.KMSVk7YZYO
Content-Disposition: attachment; filename="hci_ldisc.c.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="hci_ldisc.c.diff"

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 5ed2cfa7da1d..18b039c2f3cf 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -499,11 +499,11 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	hu->alignment = 1;
 	hu->padding = 0;
 
+	percpu_init_rwsem(&hu->proto_lock);
+
 	INIT_WORK(&hu->init_ready, hci_uart_init_work);
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
 
-	percpu_init_rwsem(&hu->proto_lock);
-
 	/* Flush any pending characters in the driver */
 	tty_driver_flush_buffer(tty);
 

--nextPart10165136.KMSVk7YZYO--



