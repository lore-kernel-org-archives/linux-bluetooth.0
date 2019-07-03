Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA8CC0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 14:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C4421871
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 14:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOkM2EM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfGCOjf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:39:35 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:40401 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCOjf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 10:39:35 -0400
Received: by mail-ot1-f44.google.com with SMTP id e8so2580662otl.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XgC1Mky5hndVHgqBcte0uiK8zj4tjTYIVvG+5eNUBCE=;
        b=GOkM2EM6PMiR8CoYYjo0bC+US0aczD1aCHEmJPp6wtNOwuSPuCNuXbiOX61tywW49l
         1/2GcXyemQ//ZS6BkjCJYcbEJ8XzMhjhQLNsgMYCsZyf99cHXZIglnr21+8ro77qIHJA
         RmD0H3Ivk1wgMl2LU2AWijh8OoTyEYJKAo06CmNm4SwlwCZ0Z8tFKMtLiSGqkVVZeHa0
         DZa7/mOHCD874UsAUmDB+P678srPmpJrnPTODIMSSWOfgi8/Jshey4mgk+b/aYnaTrZ2
         upHxx4TSWUX/pAA/xLaXw5tIZmXXrmkEsqR6TQS06AGdAU8HoASaBcAfjvDwUPtG9Iv3
         u5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XgC1Mky5hndVHgqBcte0uiK8zj4tjTYIVvG+5eNUBCE=;
        b=dA0gBRBcEqvtA2qibq2Dm8y8riFELAwsP1r8D6XkEqRN3+QA5EXHkAlh9XAQfNthvx
         N9HUkTYkCAlFMUji5FJQkCnL0ihRHQdtnD21/heMDyWuAnMJioP28lk0k2mMegRPh8YV
         ZpDchqdRvXUgiAx5wbpB7xv/f3vEWz6NjGhejnEzWaVZ3sLCkx4R6qx5gWl8VhjMHUlF
         BIsOJoJjlZDpxz85mEVx0JL+snVzepGbY8dKBDmsYZgCKRHOszJV0VzjxNUu3jwm7Ay5
         fmwXKyWo/QkXrDD9grP9HqDkIntX73XRGwxcODqnUTQzIwiljKcO+qy/eNaSZNhsvglb
         XPmQ==
X-Gm-Message-State: APjAAAU8Miutx7oFUo5CZuXUxfdd2qVJIvRmFSU7AZtD2VgrxC5NYccv
        VNOf1MpN+5edugEQjznfbo/U5tllqIG9yRUiUvyB2B0N
X-Google-Smtp-Source: APXvYqyrmXARezsBDHJd6Yo1g5ieG9zJXeaGuLa1DJ1t2VEMzokgpaVkID5WgotftLQ5rP7avp30nlYh5MUhY4IVGYc=
X-Received: by 2002:a9d:4546:: with SMTP id p6mr30400979oti.34.1562164774517;
 Wed, 03 Jul 2019 07:39:34 -0700 (PDT)
MIME-Version: 1.0
From:   Edward Fung <jjsheepman@gmail.com>
Date:   Wed, 3 Jul 2019 07:39:23 -0700
Message-ID: <CAK_dC=N+YvA1mH5XJDO-P3CV38NbK6UiLrBQe9na-AT8yraVAA@mail.gmail.com>
Subject: PTS test case (GATT/SR/UNS/BI-01-C) fails with Bluez 5.50
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello team,

I'm performing PTS testing (PTS 7.4.1 Build 2 and Bluez 5.50 stack)
for SIG certification and the test case GATT/SR/UNS/BI-01-C always
fails with the following response error codes. Can anyone shed some
light on this? Thank you!

Test case : GATT/SR/UNS/BI-01-C started
- Running test case with ATT bearer setup over BR/EDR.
- BR/EDR Connection setup successfully.
- BR Security not initiated due to TSPX_security_enabled value.
- Sending an ATT request with an unsupported opcode.
- Received data 010C-0000-04
- Invalid Error Code received. Expected=0x06 Received =0x4.
- Connection terminated successfully.
-Final Verdict: FAIL
GATT/SR/UNS/BI-01-C finished

Test case : GATT/SR/UNS/BI-01-C started
- Running test case with ATT bearer setup over BR/EDR.
- BR/EDR Connection setup successfully.
- BR Security not initiated due to TSPX_security_enabled value.
- Sending an ATT request with an unsupported opcode.
- Received data 010E-0000-01
- Invalid Error Code received. Expected=0x06 Received =0x1.
- Connection terminated successfully.
-Final Verdict: FAIL
GATT/SR/UNS/BI-01-C finished

Test case : GATT/SR/UNS/BI-01-C started
- Running test case with ATT bearer setup over BR/EDR.
- BR/EDR Connection setup successfully.
- BR Security not initiated due to TSPX_security_enabled value.
- Sending an ATT request with an unsupported opcode.
- Received data 0116-0102-01
- Invalid request handle received. Expected=0x0000 Received =0x201.
- Connection terminated successfully.
-Final Verdict: FAIL
GATT/SR/UNS/BI-01-C finished
