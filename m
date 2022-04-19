Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D898C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Apr 2022 16:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbiDSQuX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Apr 2022 12:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351376AbiDSQsp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Apr 2022 12:48:45 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64617BF77
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 09:46:02 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id e128so11835500qkd.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Apr 2022 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=FN3Bwr+3LiAKt27wsWCCPVUQMB73gHbm2ZST1KijKxU=;
        b=j8XGkP/3+2BM65GrxigglCtjMsKh3Vcm0ythUCWw+LI3OhyESXgw0umQCJqHuvaf2L
         UYNhJ9ifvEd0YZXm2lt74Qrwh+kBgIvFV9w8cjBE8/9ZLppgvNfZHKUFIzl/R5x8gdGw
         ediCCo1p/WL0OSlIz8rrwOKXN0XEyi0M7HDSOLRCHcUF+5ideSMMndELo6qpfZNW6p73
         TmPQ/m+R/+S/19sLunKZ2yHilHk7xe5JwmRb1cu64duLgDxJ0RkpR1czAd6IVB/qWAHJ
         eEfIrVQJsZe7WiRwHdydgrL6Pk7b64YIbFOfXqeQybGYtTgaJSDSpfalrYfBkuraqL1g
         NogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=FN3Bwr+3LiAKt27wsWCCPVUQMB73gHbm2ZST1KijKxU=;
        b=FRJl9Gvq3M3rTJxO+UExSIvhb+CpxPBkeZH2GTqHelda7K/bH66XLICZ96GP625MYy
         M6s5HFepL98XBsGpkrJUMI27qHih7rxTedMzGSqAmIAxnVRAk1eNZtUXpy4q/t2Ef/og
         wASZKtDP/on5KkihvG5XAzLvrajey/SgGhwdlQqAy6aD/lLZF4AHlDNOx/S47NyxkJOD
         ZiuGkXGlvpxk2d4BHAvNFnH4coTULOpCRZsa+2EduWIoCFfNF2D+8r5raVfP/b4NmXPu
         dGmiCmPuTqPoyiHGcf4YBOzzgJc7pfY/V0+g55BKUzK83+JFnUttu3z7xVoWLVUcsF0r
         hahg==
X-Gm-Message-State: AOAM532p/TylgOwZV7C9bNCUyrHcRh04Arfv2CKKt6JYu/AVM3HNw55X
        +n/F4UXehW422aL/8b/9c0DQoXu56OfsaA==
X-Google-Smtp-Source: ABdhPJzJRFITwNJhhrCbS/ZVPu9zaN4/yI8nzYMpR4B28UUL96uLeOm5PwI4gDyeVq7MjZCQzvu2iQ==
X-Received: by 2002:a37:3d4:0:b0:69e:5f43:5904 with SMTP id 203-20020a3703d4000000b0069e5f435904mr10326690qkd.372.1650386761266;
        Tue, 19 Apr 2022 09:46:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.231.78.167])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85756000000b002e1cabad999sm307089qtx.89.2022.04.19.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:46:00 -0700 (PDT)
Message-ID: <625ee748.1c69fb81.f467d.3295@mx.google.com>
Date:   Tue, 19 Apr 2022 09:46:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3377407720228907584=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, diego.rondini@kynetics.com
Subject: RE: [BlueZ] test: changes for Python3
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220419150949.694702-1-diego.rondini@kynetics.com>
References: <20220419150949.694702-1-diego.rondini@kynetics.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3377407720228907584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=633425

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       FAIL      1.03 seconds
Prep - Setup ELL              PASS      51.69 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      10.42 seconds
Build - Make                  PASS      1526.18 seconds
Make Check                    PASS      12.78 seconds
Make Check w/Valgrind         PASS      536.49 seconds
Make Distcheck                PASS      278.84 seconds
Build w/ext ELL - Configure   PASS      10.43 seconds
Build w/ext ELL - Make        PASS      1486.05 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] test: changes for Python3
6: B3 Line contains hard tab characters (\t): "	AttributeError: 'dbus.Dictionary' object has no attribute 'iteritems'"




---
Regards,
Linux Bluetooth


--===============3377407720228907584==--
