Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06457C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 18:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbiFMSmi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343491AbiFMSmT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 14:42:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055BA1180C
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 08:01:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so4422972pjl.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MbxCebj4QvQ/wsPQfSSWhp2gdTAHx3IHDG+PH/2j1qc=;
        b=G9G32IzfVRKAwAHHNm73DAPRw8O5LPL+tDBVmEAyBQO0t27fmA5Trz/6h23abHezvS
         TYOGjgQORrzNIhc4Etp65ddxWRlykv02A1BjDnG6sIpiMiE7ePXiMy8ymJeoNyUYNJzF
         dDWGvzl3NswyDdH7r5UXW9Vi6d0kVqjdbr+z13ad7p7usbEf07ItxUaXot3PeMomY26D
         XAVBNX+xpVyAZVUuD49avQG/kUeJv9c69iHZIvBc5P2PGUCeGZx9rClz2GudQOk8FSiU
         NglaPDFtbiDafizRv+WXLW1RUfIo/X04IuKWhEDFkaUR8XH2OtWP38j/57fXMv4QiLvs
         Nxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MbxCebj4QvQ/wsPQfSSWhp2gdTAHx3IHDG+PH/2j1qc=;
        b=LLLjmZTaXzV4PtuS7Y/Y6cKSjidjsuw7xoeASjcZyClrsxoVdf+U2hsHy2R0o8LmAS
         XL17xyf0TjF5tkdiLzKFVMy2Cqm3UDgrEjpKoNG/Sj2gzHs70Ox7Vai5S7uHueYcN+7h
         I8FYys9kYVvp776R0qfYbudHwfE4U6Tu3FfhysAuPfBtX25tiOuZJ/8BtrhTxHnu4x3S
         zNtW0fQMTPJDHATCz/ZoU32dBoKC3GyaEJyRDqisxYBobUczgGVbUaizMbxsl5A3buTS
         I8NrSIG7bAOU259dBcSVweaT1uNLFg4zecbe7+YXmA1flZD96yGK8+HimMo24TSkE+lv
         c5Nw==
X-Gm-Message-State: AJIora+BHs2Ut2bfbZptiPbEv1cLZUPC5cuGnnrqSd5JHd0DDBHUNeGN
        6kemmuwNxuar5tT4lS/H5hbf5uduA6I=
X-Google-Smtp-Source: AGRyM1speL/Rxdw0Qw3gqTrdjdmglN5Rc0rMQeJ5akbtqXvIpVrRmPd4ccirGAkwcIt8573DSDIqDw==
X-Received: by 2002:a17:902:bc84:b0:167:80c6:aedd with SMTP id bb4-20020a170902bc8400b0016780c6aeddmr82074plb.97.1655132500234;
        Mon, 13 Jun 2022 08:01:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.186.142])
        by smtp.gmail.com with ESMTPSA id n23-20020aa78a57000000b0051c01aa7d31sm5524289pfa.46.2022.06.13.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 08:01:39 -0700 (PDT)
Message-ID: <62a75153.1c69fb81.75bf2.6148@mx.google.com>
Date:   Mon, 13 Jun 2022 08:01:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1300054500486836366=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: Fix callback->func =! NULL in the xfer_complete() func
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220613112242.9407-1-wangyouwan@uniontech.com>
References: <20220613112242.9407-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1300054500486836366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=649824

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.46 seconds
Prep - Setup ELL              PASS      54.03 seconds
Build - Prep                  PASS      0.62 seconds
Build - Configure             PASS      10.20 seconds
Build - Make                  PASS      1870.58 seconds
Make Check                    PASS      13.00 seconds
Make Check w/Valgrind         PASS      552.84 seconds
Make Distcheck                PASS      292.56 seconds
Build w/ext ELL - Configure   PASS      10.64 seconds
Build w/ext ELL - Make        PASS      1821.67 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1300054500486836366==--
