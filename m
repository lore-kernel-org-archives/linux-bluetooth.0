Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526A0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 09:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351754AbiDOJgy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 05:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351771AbiDOJgw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 05:36:52 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689F021AA
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 02:34:23 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t2so5626503qtw.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=KvNQsCU8RthqSM+sEnjTuVIcE12RRmLMiOEzOwZeP5U=;
        b=XzV4Y6/G1m70jxP6fS11iZRrXg5BCnH6oQ5alJJPaSq58G2u0bdS71x9SRCSuL3Keo
         NrrKa20DTdOwTmWqXX0L2I4tu159s99FeK+kKbTGvHiJKcSB8ka+TQj5Q81vbZWA6Cws
         QhLazy5xS6OelC8uJPUSvY7tNy4LUV+WifXmLmu4BPDUiWnEW1OSDQYESS//zIQfCIgz
         L/UcPaYa1JkXg9vr29m1Z9inSaPK1VZxrId94WOf1zWT5ScpniHh1GwD6sFxmAmOZz49
         0OhLwA0UN3rnF5lhKqKA3TmiGTLb8EHfnRZ9KkIUG2Ukam93ru6BtXZW095kuKhN6poY
         zENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=KvNQsCU8RthqSM+sEnjTuVIcE12RRmLMiOEzOwZeP5U=;
        b=BCHPfVuH/h55VhUl0iDLJJE2QBFVL51vefm2sNfXm6B5UAbjQxrGbwAXIJ8bgzyqOf
         Rbl76eJyRzMsYEWHMucJbLi8wbZvaj+QbryHBFnEHeBh5QNZXNGfe58sCTusDrveLu1a
         PmiQ8c3eFOkLOoWgwxxdDt2oOmiuodPXupy/qBqLbTjmuLhLGR5zlmmeZvTWu+4b85hQ
         p80vXXtOso9KG6yNMi39px05vp8pGZK7tZ/59XpHNXWXBCX4EEcaNc6ZnNAJw2OQwtJg
         CYoTSpN3xgK7Ir6jSIRRY9XdLaXSdv9BW3oANmEDU43AmtIkHD5rh4sEVNb1P1Sa3F2R
         4i/A==
X-Gm-Message-State: AOAM530KKND19Ctasl5i19YmcsZ2n4O4neYUTqT7fEwwbN25MfXyqqiD
        2beRC/o6inAOzZ4QWKWVhamV1j/9Gjw=
X-Google-Smtp-Source: ABdhPJzqhhFCfPXP6Ukj7Tlr4qi4zdEPgjhIfhJ1dj+rBX73tClYt+vG9gapG4qL6HnPjRJZjy+Wjw==
X-Received: by 2002:ac8:7d08:0:b0:2f1:e349:adb7 with SMTP id g8-20020ac87d08000000b002f1e349adb7mr4210689qtb.616.1650015262436;
        Fri, 15 Apr 2022 02:34:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.191.150])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm2716352qtx.58.2022.04.15.02.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 02:34:22 -0700 (PDT)
Message-ID: <62593c1e.1c69fb81.4bae3.ff90@mx.google.com>
Date:   Fri, 15 Apr 2022 02:34:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6648070053627017062=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [BlueZ,v2,1/9] adv_monitor: Disable RSSIHighTimeout for SW based filtering
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
References: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6648070053627017062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=632021

---Test result---

Test Summary:
CheckPatch                    PASS      13.07 seconds
GitLint                       PASS      8.92 seconds
Prep - Setup ELL              PASS      42.51 seconds
Build - Prep                  PASS      0.67 seconds
Build - Configure             PASS      8.45 seconds
Build - Make                  PASS      1277.32 seconds
Make Check                    PASS      11.44 seconds
Make Check w/Valgrind         PASS      448.86 seconds
Make Distcheck                PASS      234.77 seconds
Build w/ext ELL - Configure   PASS      8.45 seconds
Build w/ext ELL - Make        PASS      1244.94 seconds
Incremental Build with patchesPASS      11371.40 seconds



---
Regards,
Linux Bluetooth


--===============6648070053627017062==--
