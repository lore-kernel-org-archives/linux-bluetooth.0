Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F0EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 11:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243339AbiCYLCn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245291AbiCYLCm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 07:02:42 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92727CC530
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 04:01:08 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c4so6173024qtx.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1N3yutMsl0/W/N3Ph4rngb84W5VDHDH9hozuTqHUkzc=;
        b=JNLlh3+ZwYFlpKpSXXHBWI/QpzPloXZHLUQ0MpnKGu5OFz1c5XcQ5hY8v2p7OMsyWN
         KiHOspBPv/nQ9JPuR4y1/aJSGEM6/GTjdvzgnTSvrPinkOw7wlfVgbwqwXRAv98TXsZ0
         ecOCdjkaD5/dZUcCxVVaibRYQog4UmzNOQ++ePZDYXdvrBP7Kl1HjM5fS155UB58pM6X
         9taKGWO2luPvLooAI+luR67alrtAIkfLtRdlmMYhBPgXbpecpurVE5ZgjNzn3vi3dGty
         1UpJdVUiLLzqEtp7bOWdQoeJaQXzBwsQJD2dO9FvWc3Y5kXFUM6LOGowL38+BvNkzBSp
         7t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1N3yutMsl0/W/N3Ph4rngb84W5VDHDH9hozuTqHUkzc=;
        b=W+3UwLZWb3htVttPAYTFHEu7XJMys46gcZfXNq74YAmDLEXS/ltCCXV2qIJb6tZHvR
         VVTI1toMHowxX1HhD3VSaHlLpcC+Mc/TBiyZ/44iTv9CkNbiNbQVBdjH+w1tPoLSPFdS
         +Rc8vUUmctKEblwr5Zj9Bd9NJxhIWseT+oxF5tktLTQOvyN4IZeRgQPMx23l2xjnojYn
         Z72dTEIHoQcv1oyO9tJRgORGDVCbJP5aC+DqTeP+XrO8QUc93HwkvAHnoINs+n5K3XBu
         1eVvr78hCmV8842K98lLowPIk5uuxkbnDr8o8WXNjbYiAcms5zjolvvFRUH0eaSEDYO6
         hwYQ==
X-Gm-Message-State: AOAM530/bg1yB/gQcjIL6cRqqrlnU2erZo3BUrQOsGHkLjbrkyEej7/M
        dmkCJFcSTt3WqzOee52npPl+4t3t85s6cw==
X-Google-Smtp-Source: ABdhPJzCXCKxSCa9Eggi/W6Ux6RElOrYHZoatwD39HUqVTvyLr7Ysxju5fkrKEI6J1SRWGynAOgIvg==
X-Received: by 2002:ac8:5d93:0:b0:2e1:ce40:3db0 with SMTP id d19-20020ac85d93000000b002e1ce403db0mr8530470qtx.607.1648206067443;
        Fri, 25 Mar 2022 04:01:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.122.88.230])
        by smtp.gmail.com with ESMTPSA id u129-20020a376087000000b0067e401d7177sm3359536qkb.3.2022.03.25.04.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 04:01:07 -0700 (PDT)
Message-ID: <623da0f3.1c69fb81.efbc.2e0b@mx.google.com>
Date:   Fri, 25 Mar 2022 04:01:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5125371807664856255=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: a2dp: Fix crash when SEP codec has not been initialized
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220325092706.17135-1-frederic.danis@collabora.com>
References: <20220325092706.17135-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5125371807664856255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=626269

---Test result---

Test Summary:
CheckPatch                    PASS      1.59 seconds
GitLint                       PASS      1.10 seconds
Prep - Setup ELL              PASS      52.73 seconds
Build - Prep                  PASS      0.92 seconds
Build - Configure             PASS      10.45 seconds
Build - Make                  PASS      1841.06 seconds
Make Check                    PASS      12.83 seconds
Make Check w/Valgrind         PASS      544.85 seconds
Make Distcheck                PASS      292.04 seconds
Build w/ext ELL - Configure   PASS      10.58 seconds
Build w/ext ELL - Make        PASS      1798.41 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============5125371807664856255==--
