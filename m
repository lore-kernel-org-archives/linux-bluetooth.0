Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F78BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Jun 2022 21:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiF2V3K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Jun 2022 17:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiF2V3J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Jun 2022 17:29:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6957F1F2DC
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 14:29:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id w1-20020a17090a6b8100b001ef26ab992bso783977pjj.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jun 2022 14:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wtYpQa2OhjKeTB0/fN27cPDJsKAYIAduRHgvva87WPE=;
        b=h8MaooojoayYJTRoBOCSF8UfEifI7cOwCOPa/7x1PEKaEMN/UP4NkXTGw9Db/elKxn
         VauxP5MvKs7vyXlc86zDBlkoKCHQhSMvpIvp9WVNGQdSfpd6mxcvMDvaYIAEC6bOyE8p
         NAQSscHeZ7geY+G0PvjxUHZXFqtzxuE5Z9Cogetg9cEE9Yyjn8Adcujlg2E6/BIzJG7D
         gXJThieJRvKHHwmcylnyCbN2f6y7bM21L3X00c6s1xRz3+MBbz+qZezTfF3aS77u/3Rt
         7tUSCIgeXu0rlqE0lYlIKFgq1Wal5YYXdALHifAqZJz3l22Z1ZX12SowVUcMhr54WIm/
         PvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wtYpQa2OhjKeTB0/fN27cPDJsKAYIAduRHgvva87WPE=;
        b=fWkjH2tVeqPvNTyyQ0yPVMGfYseTq9Tt7BUD+pRT49drjbikA88lb6Gj43pUORNtNr
         T2Z/xgVfgz18eXyiokwBtjnzYWork8fR0kMB0pOfJRJzOTSXVmqPSEX5aYFhVZ/MLToN
         UQEl9LMVJv5Z12gzWEL0eRSlWqr+thzUq6zfaTI2tPBxzqdMlG3yd891gWEvbZFgRfTx
         U5jA1s3aPMlHmu3hTl9oBBxWaLsh39Jmg3Ic8oH6NyhrBiVMk9AzdklCibbKyM2PEebV
         mHs7s4nFcdev40jjsIJNYu1JrRIQic10Pz4MZzdbzTuQ96+I/dKVNkYx+ExSXlG/YXPA
         9pTA==
X-Gm-Message-State: AJIora9x16g1VY4AyIsqLd0uUMVX02aBc6nL/8CH4uT3YI1HZ49GA9P3
        86PG51GgoGSvOdTLMtDBQLY8wIA32a8=
X-Google-Smtp-Source: AGRyM1vZFIkxRInTFiVMvwyBtKV9v7QtZctpHbKkoig79LGLPPVE6SoH9uOmBOJ1wG8m/MXRQ3+cxA==
X-Received: by 2002:a17:902:d2c3:b0:16a:4028:4738 with SMTP id n3-20020a170902d2c300b0016a40284738mr12231813plc.8.1656538147620;
        Wed, 29 Jun 2022 14:29:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.173.251])
        by smtp.gmail.com with ESMTPSA id fy21-20020a17090b021500b001ec79f0da37sm2666380pjb.14.2022.06.29.14.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:29:07 -0700 (PDT)
Message-ID: <62bcc423.1c69fb81.ef5ed.46d3@mx.google.com>
Date:   Wed, 29 Jun 2022 14:29:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6502053365253016418=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] monitor: fix usage of size_t %z formater
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220629191943.17326-1-brian.gix@intel.com>
References: <20220629191943.17326-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6502053365253016418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655153

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.53 seconds
Prep - Setup ELL              PASS      42.41 seconds
Build - Prep                  PASS      0.50 seconds
Build - Configure             PASS      8.27 seconds
Build - Make                  PASS      1398.73 seconds
Make Check                    PASS      11.07 seconds
Make Check w/Valgrind         PASS      430.93 seconds
Make Distcheck                PASS      228.60 seconds
Build w/ext ELL - Configure   PASS      8.40 seconds
Build w/ext ELL - Make        PASS      1384.88 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============6502053365253016418==--
