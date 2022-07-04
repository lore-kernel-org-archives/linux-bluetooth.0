Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136D2C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jul 2022 04:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiGDEep (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jul 2022 00:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiGDEen (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jul 2022 00:34:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1596A5F57
        for <linux-bluetooth@vger.kernel.org>; Sun,  3 Jul 2022 21:34:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id v6so6096067qkh.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 Jul 2022 21:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=fZsAwp18Y+DBNakK+Runhcbctu97dgMx71+8JM0xZCs=;
        b=MN7HTp079iIz05IiY9b3zUg4keKJ4/H+AC1Y/d0lQjOC2XzYc65VynUS4ZfiBWeL2E
         8S4KcMKPvvnfzpHcpDbf9CekS4kZLuCbpTUmOPX7gFesqC+YzHw+ImjGBcHhpbwbCBMT
         aGHpVnjXvTQOnsNlBSXbRSG1cdMEkf0MtSUQEScTkZK58g10GlmY/cz8QxxUMfPnz3eX
         8yxCm0t58MazwxDcLI3ufBJowU+4vi66bvtscDO297+OtdvAiGNn7HCp4NJVUd/z30B2
         pt9aP2RyjHLAHs1HuQgbHEI7jgF6rQwuUUZlKnOmh7dyxscAka5aHbfHsHblrSK/arYC
         luDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=fZsAwp18Y+DBNakK+Runhcbctu97dgMx71+8JM0xZCs=;
        b=Y2R3bi1e62xVyKrzqcaIlI1yaWmn/NJm1T3nZPTMPMlFyvgk0mckfFBrrIHZS7tJwa
         qIzM2hTtutFYIooYcEp1dvDLkevm1h04ZMoM1TSnCTFcOiIrKFvtZbsa2dBSbWQBImaF
         IolmG7F2WPJaiEQOdUgQJWMfxFdFDDLd8w9MO1+gVVxHZJ6QoEbzTQqHjxa3qi/GjqRG
         7W1xlfi65seEA/sWeTx+0j5pdebUoDMQe97Nm9C90pUUefXmjWj8F+jnYAXq5GjDKYAg
         JFsC97NWiTCsuF/GPj3q12Ew0BvQgw4/hd8k8TQnlU6s+3soLXWVKeViTxFfNO5Kf4Db
         QI8A==
X-Gm-Message-State: AJIora9y1lnD1fePN/2KxVtMii/zHBFXyGw2gX2+AR05xC6PYFLjn+Mq
        Dv7H3ojNiNc0nNfzqxZWTSF7zAjcMJn+iw==
X-Google-Smtp-Source: AGRyM1t1CmMBYSZqVfPNt96GUFV7KhiFMfm10X7kOFNkusVCUanQJ7QzE5ILji6K3bcSInmGk2DeVQ==
X-Received: by 2002:a05:620a:78c:b0:6b4:7012:97bd with SMTP id 12-20020a05620a078c00b006b4701297bdmr267852qka.135.1656909280888;
        Sun, 03 Jul 2022 21:34:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.231.222.0])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b006a6a5d1e240sm26032933qko.34.2022.07.03.21.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 21:34:40 -0700 (PDT)
Message-ID: <62c26de0.1c69fb81.ebc37.959a@mx.google.com>
Date:   Sun, 03 Jul 2022 21:34:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5063564700099228125=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: fix crashed after cancel the on-going transfer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220704032308.2781-1-wangyouwan@uniontech.com>
References: <20220704032308.2781-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5063564700099228125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=656183

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
GitLint                       PASS      1.01 seconds
Prep - Setup ELL              PASS      27.01 seconds
Build - Prep                  PASS      0.83 seconds
Build - Configure             PASS      8.58 seconds
Build - Make                  PASS      834.50 seconds
Make Check                    PASS      11.58 seconds
Make Check w/Valgrind         PASS      283.43 seconds
Make Distcheck                PASS      233.21 seconds
Build w/ext ELL - Configure   PASS      8.67 seconds
Build w/ext ELL - Make        PASS      80.27 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    WARNING   476.20 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
gobex/gobex-transfer.c:426:7: warning: Use of memory after it is freed
        if (!g_slist_find(transfers, transfer))
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.




---
Regards,
Linux Bluetooth


--===============5063564700099228125==--
