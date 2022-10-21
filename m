Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B5AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Oct 2022 00:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJUANL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Oct 2022 20:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiJUANE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Oct 2022 20:13:04 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DD21826CC
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Oct 2022 17:12:58 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so862710otu.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Oct 2022 17:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SraBV+rf2fyK5JrFl9LLUJBUHN1/t00QHn4E5vsfh98=;
        b=IPv9ntvv8zJdXNebaFiYvkgJpC2mIVrnTBbLR649FpmmMLfLmB0Zg+JTOIV7e5Hb39
         DszftJZ0erf8LZkxBk20GXqBy4q5oi3J5MO1nR7PtCQDcLNgfgrmoreuGek5yS9OkUmS
         aio5Aqq1rsiSwlTpXWwWHLg2AA74g02iOTAo5wtdn8jxEs/JAY+NmlDADO4zaiHzTBzD
         raXwpTTTkaymDgPme3/j6zLRKwq5KDwfBz/zTWA9+ZiBIE6pSHarm0XU2EnS0mihdBOU
         UVwu83pQ2eU+o5HBmCHjbGLpTbZnd8pdyAc0wzIGqkf9wPp4sZqa6gwGt8C/WDyL02AS
         blTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SraBV+rf2fyK5JrFl9LLUJBUHN1/t00QHn4E5vsfh98=;
        b=vIu7BNjmZxt4sFUJDhzhv/DTPZkvG3mwQ7Zyd6E94nlNLH25p5uXNP0xlrBrawh6xU
         hTvv07b3qDGOZK56RmowtzlIep93OPdnsAoBeR71yLD7LC4QAQAnop7Yz7Ndwt+/LfJl
         vYvOdP1AtC7qg3PpZGvzNHXT1E022/Kb6lmn3MbraGCLtk3VJuuzeVNNH2OARXIiiZ5R
         RpLARrPjy4pB6HCccsgFm4CseWxaslXThN8TaE8eolgQTieoOc8Pe218FY5ZexfKd2es
         vPhPOaKOZcueObrxsdkIOh8dhESUP+QzqacSMT6MZO0GwMNNMl4j1FWbeAWGRJ1ZoWWf
         kIyA==
X-Gm-Message-State: ACrzQf0H6PW+1czYMq/0OUVqLgZrgucsQaQ8u0UHyRh0J+FKgC/2P3Op
        RlGbnC6JQkf0nHWBW2VwfXEL8fZRHc8=
X-Google-Smtp-Source: AMsMyM6QK8fltuha0UudiRBhNuF4/RgXlT+0pqLwRDSPEeHrI2Lh4bNPpPgraUbqO3txN3STBmWHYQ==
X-Received: by 2002:a9d:7ad3:0:b0:661:b172:aa3a with SMTP id m19-20020a9d7ad3000000b00661b172aa3amr8173830otn.285.1666311177578;
        Thu, 20 Oct 2022 17:12:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.199.50])
        by smtp.gmail.com with ESMTPSA id eq4-20020a056870a90400b0010d5d5c3fc3sm9616228oab.8.2022.10.20.17.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 17:12:57 -0700 (PDT)
Message-ID: <6351e409.050a0220.a005d.7d1b@mx.google.com>
Date:   Thu, 20 Oct 2022 17:12:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4130602643818541372=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client: Fix advertise.data command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221020225804.291712-1-luiz.dentz@gmail.com>
References: <20221020225804.291712-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4130602643818541372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=687318

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       PASS      0.71 seconds
Prep - Setup ELL              PASS      26.94 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.32 seconds
Build - Make                  PASS      763.73 seconds
Make Check                    PASS      11.17 seconds
Make Check w/Valgrind         PASS      292.39 seconds
Make Distcheck                PASS      241.02 seconds
Build w/ext ELL - Configure   PASS      8.40 seconds
Build w/ext ELL - Make        PASS      85.42 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      489.74 seconds



---
Regards,
Linux Bluetooth


--===============4130602643818541372==--
