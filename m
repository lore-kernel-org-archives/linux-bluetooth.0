Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFDBC19F2A
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Aug 2022 19:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiHGTn3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Aug 2022 15:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiHGTn0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Aug 2022 15:43:26 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310DB6595
        for <linux-bluetooth@vger.kernel.org>; Sun,  7 Aug 2022 12:43:26 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id u8so5153903qvv.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Aug 2022 12:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc;
        bh=nBt2kKr8G1b8ZCw+u45lxxp5XAPH6dyAsnD7kRDtYz0=;
        b=AjagOwrbLn5Vi0wIlBAwIj08eD+U90RrCOIyRFwyWDwEYJpH6xquQk2YhMzi3nEK18
         R0R1Bm+O47fYSRoJGDsOlWL0q3qQY78lIat8DAeDXH9afkfLrNQcVavHgZQSE/sYI2iM
         2fgTCU2Q1F6mF4cOqyIbSB+b9Bv6UMQL1Ikw42nzwpZ+iPDYOXJiee9dOpi+dLoHptjl
         JbWA2JWVT/NHzfSu+YEK1AMokszECe7yiCqxEz/jct4xULtaPoA0cWWlrmGs7ESsFkHQ
         9XjHthGvAke4oevi1o8vKfkUT2+DxHKNi3LGat7/Iou/eKLiBrWfPCKLGWyOYKl/C2pB
         rYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=nBt2kKr8G1b8ZCw+u45lxxp5XAPH6dyAsnD7kRDtYz0=;
        b=xzM007UcNj2IwfTrGEZk7f9zuaI1bKnChJpBtaUjVjhE365ZxwHTYX2oKewPD1rWt9
         yL32oKeIhPp8J3NtdiPNPDcZO8xHTWvXE4jGzS5ZbgdH3by7fmqXgR9CKthBWCklnH38
         EwQh0QB7nmqUjCzJkZFkSnn1J3JetLLMBs9u1tXGcUfidzZu4h9bzS3hOLyA8uOHaWmG
         b/Z9fYqO20cfPYSkq72V1pcBq9/uiRGwjRpcwHJb1q4W+O/nsKBXCwUdcHQ/QmQwPZUR
         kNttI45jgn4DRPIra9Xf51q6cAAURfJ4W4hj8RAzsNvrAeCTVvc6OCQoe+NsTU5xcPfC
         /xXQ==
X-Gm-Message-State: ACgBeo1wT1kpgiY+3qMTlot8xZapvGtk+yyxTeHdm4rXO8LQl5JxLdCs
        mKBcQjn2jrR81Cgo8CX24BM2REqruJI=
X-Google-Smtp-Source: AA6agR7vB5ialgryWUCkLIwE1JLPYLPrrrG0i4bXMqoQ2bU/yb17R+/sB1gHeUTO4rDjL6rLekdLBg==
X-Received: by 2002:ad4:5b8d:0:b0:47b:2c2c:96f with SMTP id 13-20020ad45b8d000000b0047b2c2c096fmr5381027qvp.80.1659901404997;
        Sun, 07 Aug 2022 12:43:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.124.2.43])
        by smtp.gmail.com with ESMTPSA id bs27-20020ac86f1b000000b00342f58fffe0sm2167686qtb.9.2022.08.07.12.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 12:43:24 -0700 (PDT)
Message-ID: <62f015dc.c80a0220.23a6d.3331@mx.google.com>
Date:   Sun, 07 Aug 2022 12:43:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1405101608213167899=="
MIME-Version: 1.0
Subject: RE: [BlueZ] client: Fix uninitialized read in attribute handle
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ntrrgc@gmail.com
In-Reply-To: <20220807192013.74195-1-ntrrgc@gmail.com>
References: <20220807192013.74195-1-ntrrgc@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1405101608213167899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: client/gatt.c:259
error: client/gatt.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1405101608213167899==--
