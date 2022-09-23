Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2ECC07E9D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Sep 2022 19:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiIWTYz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Sep 2022 15:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiIWTYx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Sep 2022 15:24:53 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5192C1180C
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 12:24:51 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s125so1025449oie.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Sep 2022 12:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=mfHlX0/y7GK/Q8rTlIfHFyLcZNY1F3sKCzpvmcqnrh4=;
        b=i/jsbmjbwMPjx3sL1+gR72VWCdBh2jLzdvOinfZlMRmeFxazhSkKz2avHTmvCeh9fE
         8NCwQXmYE+SpeX5TTAkqReWAtC9jz/+G829GhLumCjV4W7mufhgESeZEiEh0wOvefWol
         QmTQJIttTPO73Y7eC653B+fjfdSms7V8U547lrehWmXy8XJd9+1VNxYyQ8J3aSBOGULz
         9YWSC2Yq4RTNgovCAiykFfsMTti9Mq/YyuOIA20ZLuZCqu7yHjp8661X86pZwwJLJEaj
         ifWhuE6JiLV5UDFy1Idzf2MK4RM0prNfSVzGfe2/nXNn2Zb8oN4L+fdeHYd0zByil6Dk
         fXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=mfHlX0/y7GK/Q8rTlIfHFyLcZNY1F3sKCzpvmcqnrh4=;
        b=PmdEouW0PAR+8byk4WtTQR+SR2d1eCqfcxZgoHU1CW5Ct/ecDHcB9g/RHHlV9YT4qS
         qFCEhyGWUbGpsx6V03+zVCe3JKhP40NG0oVbpvJ4nFKQ0ymL2QoEphlmc5QbNvOBfVAw
         eKK4/ArooozCIMgtZ91XOSJJ8+KwM5T5TemD6dt43qMXwaOIEJjbeJ9ssc/0WqXI74cV
         DCMjaVWSwKfp0dXuOT9sTVDw1p2j2NKCY8xqb9v+1Xh5cNl4DKqx1rI2ZInPQ4xOFo2J
         BCven9gyJriOSxDxTIorxIgXtl7maWtXGP8Xgxru9FPg7qmHDJeDRSaQIA5l2hhIyc/I
         t8Rg==
X-Gm-Message-State: ACrzQf3v2V4sc32VqPF6k9cGfF5JUURxE83xrvBJ58TQJ/c17hNkL47+
        srEKXzinyUEdlDOYWRe/XQqo0bZgNWzciA==
X-Google-Smtp-Source: AMsMyM7l4dyiAtcTa4o5sSCIbsL54I90WmuCP4pq1yKni4EDRpC4LyPVRL0QR5rZwb0STBHAARuhFA==
X-Received: by 2002:a05:6808:198e:b0:34f:f114:8921 with SMTP id bj14-20020a056808198e00b0034ff1148921mr4796042oib.1.1663961090465;
        Fri, 23 Sep 2022 12:24:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.124.205])
        by smtp.gmail.com with ESMTPSA id k18-20020a9d7612000000b0065af1b094dasm4510681otl.28.2022.09.23.12.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:24:50 -0700 (PDT)
Message-ID: <632e0802.9d0a0220.dbaf0.26e8@mx.google.com>
Date:   Fri, 23 Sep 2022 12:24:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5499553349279950364=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Mesh demon switched to using kernel Mesh MGMT
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220923180018.815614-2-brian.gix@intel.com>
References: <20220923180018.815614-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5499553349279950364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679972

---Test result---

Test Summary:
CheckPatch                    PASS      3.72 seconds
GitLint                       PASS      1.59 seconds
Prep - Setup ELL              PASS      32.34 seconds
Build - Prep                  PASS      0.80 seconds
Build - Configure             PASS      10.16 seconds
Build - Make                  PASS      962.18 seconds
Make Check                    PASS      13.10 seconds
Make Check w/Valgrind         PASS      346.94 seconds
Make Distcheck                PASS      288.02 seconds
Build w/ext ELL - Configure   PASS      10.29 seconds
Build w/ext ELL - Make        PASS      101.50 seconds
Incremental Build w/ patches  PASS      239.82 seconds
Scan Build                    PASS      663.36 seconds



---
Regards,
Linux Bluetooth


--===============5499553349279950364==--
