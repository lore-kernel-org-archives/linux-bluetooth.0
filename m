Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E1FECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 16:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiH2QI6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 12:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2QI5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 12:08:57 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1E686B5F
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 09:08:56 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id x10-20020a4a410a000000b004456a27110fso1528728ooa.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 09:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=YjOjxX2KX+IQB5W93zDagwQtedsxmtji9kMu+DTc+5A=;
        b=iPK07KyX7/7OlJ4wDDgZ0PYFWGY6Cn9hf+W9Y4FxCbk0FuBNXhzc8krD3/7xBE7QAS
         mjvgGeyXjsw5XfTPkQIkwZbKiMEkKZB2fxz7INqKKc0MlT4BcMlnEUJ2hdkPU6Twa2UJ
         dqqP+63xwRVjG1sH8sODGEXYs/zqQZQDKPJou0mEiMjWoOqDR8Rot5H6kTXFVwRmwfMl
         VxLhv1bGfyQhMBRuVN6hkVZnLRrjpEaeQv/aw6tr5lPgdhmRU9xUSO6aw1TWCPhH0Fdd
         n1UP/Bp6heQM064YOZD9iTH0Y2HeId1Tx9davTAjWqc01KXZT0HQfccHF2MnUbLNzXOy
         KAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=YjOjxX2KX+IQB5W93zDagwQtedsxmtji9kMu+DTc+5A=;
        b=Wcqbhoc0plRTNuh3e7IhxXLLWMt5V2kA3GH3i+cacOkD2NNwZkdHTUzqtTz1LLIJC2
         Afv2IFRuHTjKrwP3nFWErvisQgjy7C32uDdutg1ObmumTW1LmJxXeRI7d0J6/xy01GFZ
         aawZ0unb9RNdsrruPisz+mH13E01OjAb6MNCNyrs0nXgXtd0cmkywexaHMRHiSfT/LTF
         B+P8AQ3tQF/jtIFXYR8mHUDdpf4B8rNY/flTpYseVZ4ZOFfxWsTM04bVXKBcW9EM86Ur
         igM9Bz9btk5bN8vUq6jLDvXzEkr0kmXM2bknJkR+e/8k1M+ahln5m8T5PHlfW0D8Eva9
         Pk6A==
X-Gm-Message-State: ACgBeo1xmlECLpg2LrJzXQHZUiRLb28VjfaLeXLbl0CWraISYh6iRl51
        eOG7VDZZHnG/b4l/lU4pEPv3iNvYDCc=
X-Google-Smtp-Source: AA6agR6Z8JFt3U+D11BPqs+LggZ1tzty4V3IugE9kdh7Y8UiTBHf2gC1bCQ7JDnDyZHljrR7Y4zrLA==
X-Received: by 2002:a4a:ded0:0:b0:448:97fa:9604 with SMTP id w16-20020a4aded0000000b0044897fa9604mr5807927oou.83.1661789335781;
        Mon, 29 Aug 2022 09:08:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.185.73])
        by smtp.gmail.com with ESMTPSA id er42-20020a056870c8aa00b00118281a1227sm5996263oab.39.2022.08.29.09.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 09:08:55 -0700 (PDT)
Message-ID: <630ce497.050a0220.b4335.f3a5@mx.google.com>
Date:   Mon, 29 Aug 2022 09:08:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5245691532269076726=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
Subject: RE: Bluetooth: hci_{ldisc,serdev}: check percpu_init_rwsem() failure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <376d3dd4-725a-a212-2701-09a80b7d3915@I-love.SAKURA.ne.jp>
References: <376d3dd4-725a-a212-2701-09a80b7d3915@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5245691532269076726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672057

---Test result---

Test Summary:
CheckPatch                    PASS      1.50 seconds
GitLint                       PASS      0.78 seconds
SubjectPrefix                 PASS      0.61 seconds
BuildKernel                   PASS      41.89 seconds
BuildKernel32                 PASS      36.63 seconds
Incremental Build with patchesPASS      53.05 seconds
TestRunner: Setup             PASS      605.00 seconds
TestRunner: l2cap-tester      PASS      20.78 seconds
TestRunner: bnep-tester       PASS      8.29 seconds
TestRunner: mgmt-tester       PASS      126.49 seconds
TestRunner: rfcomm-tester     PASS      12.08 seconds
TestRunner: sco-tester        PASS      11.95 seconds
TestRunner: smp-tester        PASS      11.84 seconds
TestRunner: userchan-tester   PASS      8.58 seconds



---
Regards,
Linux Bluetooth


--===============5245691532269076726==--
