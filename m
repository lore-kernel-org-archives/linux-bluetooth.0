Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF58C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 06:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350756AbiDOGyj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 02:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241069AbiDOGyi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 02:54:38 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87524B3DE8
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 23:52:11 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id b17so5964939qvf.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 23:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OBJ3xolkVE5OK3Zinms8RnqnIklYKIr5XkSOuCxkId0=;
        b=NB8qwOO2rQJkvm4VEXYTuQjlUnxtIWLXfHC55K/CgeDRql+zxS82Mm9E+5URCemf4G
         OCo0ZxFIOLoC77X2Mc1qgzrDjTpBa84kxUx/MJra0Z3K8Qvil3zVohmc7GhR+uaXXXW8
         DNScMUpOnJ2uFAVXzN7xPTH8QnDDYG7M1Gahe8WEHyLsK0epzp5LAc1PmOLXN0okU18I
         akYLLtILxKvGfJFhRjnakRPYaatGaT/NMWeYK0pxZ5CwRBXf46A4lJeJ64o4bKkzK0ni
         rcfmdX3T+ITWmxFMsIaBi0QSSiTEPce4BTZ1Agr1hJ4e/w4F+lYflp7badMuvXRUuENj
         ghPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OBJ3xolkVE5OK3Zinms8RnqnIklYKIr5XkSOuCxkId0=;
        b=vTfKYVItLBCh0nWZkV7kdQyM8HAHDNkG++o/te1A87cPTh8lk8q8tTS4Rq6iFCtWKB
         dK+F8jsM3/xEIuvxRLt9XvRO8NJzodGeekQ+gfw0ICJebBtXwiOAVhJ29vun6Gwl9Uaw
         TgVaF3FmqgXEIBiDPLb+EglPFixbu0pc61zFGARxO8UrsM4YIlVA0gDrgRc684zO6yPa
         2BqergxMAkuBtsx6RjuaHRrxSxMuuwS/Bss/MV6uLoanPyF8C38SgdAiHPP/FxBx2pen
         ijke86OM1d8v5MNAFdOCnxC7TjeVUogjH0TuAsDzRB5wSHBOGXmg6eB927Wx6ql1Wi8R
         emXQ==
X-Gm-Message-State: AOAM530O7K38Yt5GoeX4Dpxn+Lo1lDRpw8YBYNY/XfLxqQyzx1ufIEz0
        oULXJkeqOBkrMutIoWiHjB5fZ1LVi4btfA==
X-Google-Smtp-Source: ABdhPJxSEHCOd0416k/UJBj8oOuujcvAvwDuI+ADMrwAf0sdy3NEf4rDmZZjRSxbbFHMqHP7vUryzA==
X-Received: by 2002:a05:6214:22c:b0:432:6b2b:95d0 with SMTP id j12-20020a056214022c00b004326b2b95d0mr15922264qvt.63.1650005530518;
        Thu, 14 Apr 2022 23:52:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.23.92])
        by smtp.gmail.com with ESMTPSA id e15-20020ac84e4f000000b002f02b21f1b7sm2907194qtw.57.2022.04.14.23.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 23:52:10 -0700 (PDT)
Message-ID: <6259161a.1c69fb81.948b3.1d03@mx.google.com>
Date:   Thu, 14 Apr 2022 23:52:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2537833642247925108=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ] build: Make use of StateDirectory and ConfigurationDirectory
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220412201949.4011833-1-luiz.dentz@gmail.com>
References: <20220412201949.4011833-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2537833642247925108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=631621

---Test result---

Test Summary:
CheckPatch                    PASS      1.31 seconds
GitLint                       PASS      0.97 seconds
Prep - Setup ELL              PASS      42.44 seconds
Build - Prep                  PASS      0.70 seconds
Build - Configure             PASS      8.65 seconds
Build - Make                  PASS      1405.14 seconds
Make Check                    PASS      11.34 seconds
Make Check w/Valgrind         PASS      433.27 seconds
Make Distcheck                PASS      226.63 seconds
Build w/ext ELL - Configure   PASS      8.61 seconds
Build w/ext ELL - Make        PASS      1392.50 seconds
Incremental Build with patchesPASS      1416.97 seconds



---
Regards,
Linux Bluetooth


--===============2537833642247925108==--
