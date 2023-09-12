Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48398CA0EC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 08:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjILIOK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 04:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbjILIOE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 04:14:04 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DAF10DB
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 01:13:55 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-655de2a5121so16859636d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 01:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694506435; x=1695111235; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hlgaHWABItIHP4Sn2HWS7ZwrfZMfO+zKuVslb3736ro=;
        b=lFv5YS1K16hx/GV5Mjwsx83TtBUk0qMn7HbyJV/6qg2w1fBjoNbG9WE17zoHmjk/XR
         +/UEhF55N59Vvj6MwvVKce2dVumVdKSEejsKJIItWQ3hN+Tx1p/+owr4m4RuQGlq+Zbx
         Ti0aNStoCyCKUxVDHsfacFRJsKQesXOofDjm3xNM5WQzBx/Jw+pXUSJtAMqpIJYg8n/m
         HLcvszczHqo7Tf4zc2XD2RP8Z32RQ/dtKkvbhHAdmkR5bOIJkmuVQJgYBvcNzMNOKuZy
         kspVpHC9Ltyn8rBLwgmdGuVYsrVllQ1db97gjIE1wAU0cfs/bmA/WSypxD+oMUVc86Dd
         mO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506435; x=1695111235;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlgaHWABItIHP4Sn2HWS7ZwrfZMfO+zKuVslb3736ro=;
        b=X+YteUB2TdJWJY88nxL9H4ZF8ylRykfIH7h9lHCsL/ql6NE8Af6B88VMprrt/P6fVL
         2GLAPyQDb8CS0KmdDE92fKSJ77AjOz0rZ8Upx5zJxDbjrxFs08h3lMcZOPLeXT3sHni2
         Oej3tZM01ehfL1/nqTiRS7yAjoXXjkuXIfaF/0RG686j1N1C00W2y+5k1KMe2BhLE1De
         hTZ+KJ2gQ1YeAw4U/D6ANtupbmYP9UhBfuqQ+D6mwFGRmjpZnLm0yJM6rGLh+whnhrik
         MhX1LHIYlG8NqiN9x5DiB4tcrzsIZObD6jXiBlfgoIg7JpHCjv3ICMNOQK61E9rlwZRQ
         ZT/w==
X-Gm-Message-State: AOJu0Yw5/ze+bcjuS98oB8Y+uxYlja5PzVashm3CZXV76kOrmkS30ZPt
        MYBVeL6d5ygLRZHkWsNUsmQjN1GZrfWVaQ==
X-Google-Smtp-Source: AGHT+IEuOnl3LK3dhTqe046iCLb3m6CXrDyn651k7ysN0sr17Q4qQ70fOWUin8zsGz4k5N1+GNG68g==
X-Received: by 2002:a0c:f312:0:b0:655:78f5:bef4 with SMTP id j18-20020a0cf312000000b0065578f5bef4mr11872781qvl.14.1694506434676;
        Tue, 12 Sep 2023 01:13:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.60.111])
        by smtp.gmail.com with ESMTPSA id dw5-20020a0562140a0500b00655e428604esm1886095qvb.137.2023.09.12.01.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:13:54 -0700 (PDT)
Message-ID: <65001dc2.050a0220.35349.65ef@mx.google.com>
Date:   Tue, 12 Sep 2023 01:13:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5338979632205787989=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: monitor: Use proper name for CIS bit
In-Reply-To: <20230912070319.1224301-2-vlad.pruteanu@nxp.com>
References: <20230912070319.1224301-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5338979632205787989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=783284

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      28.66 seconds
BluezMake                     PASS      902.83 seconds
MakeCheck                     PASS      12.10 seconds
MakeDistcheck                 PASS      161.34 seconds
CheckValgrind                 PASS      261.35 seconds
CheckSmatch                   WARNING   350.02 seconds
bluezmakeextell               PASS      106.12 seconds
IncrementalBuild              PASS      729.87 seconds
ScanBuild                     PASS      1088.43 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1859:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============5338979632205787989==--
