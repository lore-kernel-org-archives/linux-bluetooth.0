Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397E2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Feb 2022 16:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiBLQnb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Feb 2022 11:43:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiBLQna (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Feb 2022 11:43:30 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55A6B0B
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 08:43:26 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id p14so11800725qtx.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 08:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aFX9kORzQgXpsYbEFLSXMDPG7VeISIXniLX2We37/bA=;
        b=erOEpCZ9uWMvH3RRVU2SKjO3ZwoX7rLEaLiHA5vIQbb92uHhfBmBi6nDoKl7AdUipO
         3K5yM4iuux91zX3w/CLg0OWrz5Q3i5mmEV8x40pJKvcW9i0BT93qoFJantxfpD6Vxvo6
         VE/cAQWPOZNwbbppgaUjWiOiOysKxPvRSwkaCssUZla4jv5pHhXAX4rBl0zRbPf3qmBi
         STqaKPeP+Vw+zNJRgQi0Vbhogxetcxd2o9TUuUwUSv98RJ8tMq0ndB7aCCv5qtDPhb1X
         KPtA6qZRO85dCSmQf0CxAE90I6zTVnZ1E25bObFIJjmN6z2C/ZS1MavHiDFio3b8iG6o
         7HVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aFX9kORzQgXpsYbEFLSXMDPG7VeISIXniLX2We37/bA=;
        b=bc+/i7Kf4u5Uazy6ESZMVvqtGkkk8KXd9YD+pFFheval8iPtp6pxqmbyCEqfdb12Xo
         AOt0gTYHsrf6LXbaRMcNAry6e55aieaw2fqErtjBo9t5kh8hkBXb3MAmPbo7sBgm2x7c
         A2wt90b87yrA7Eki7k2lDWLkk4bdnUPl9oSll+FGdOMogka14aggdCQZ8gL8h84ObIAY
         16Pt0koDSwBcyB8fGfYB1lN3rrESDCYrapyDDHNxPRBZCMqMXeiHNhV++GjJxoS15vOn
         d2VMQNd/CyoeDY5MH/trbRQLZT9tS7VEPpmFr8FbyPFN5OXCHvB51Bc79Sos+LV+tmCy
         Rb9Q==
X-Gm-Message-State: AOAM531uOFmZGBdPuCTFLQipsieMlj5gM0jv4TpVLAGezpAyOpSsLyk4
        oLIjsrUh2N4d0Y+ZhNk8yMkJEz0ESrhabg==
X-Google-Smtp-Source: ABdhPJzT2zyhkpF3aiY9E1BGzpGeJzwiH53p0o3X+Jd2XwfzvotFV9HHaTD7ZQ5DdHTauDsO7+Fy3A==
X-Received: by 2002:a05:622a:13c7:: with SMTP id p7mr4710362qtk.213.1644684205868;
        Sat, 12 Feb 2022 08:43:25 -0800 (PST)
Received: from [172.17.0.2] ([20.119.212.177])
        by smtp.gmail.com with ESMTPSA id bl1sm12849777qkb.16.2022.02.12.08.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 08:43:25 -0800 (PST)
Message-ID: <6207e3ad.1c69fb81.71014.67cb@mx.google.com>
Date:   Sat, 12 Feb 2022 08:43:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0522286176728904189=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, netbox253@gmail.com
Subject: RE: error: Fix typo.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220212152121.11032-1-netbox253@gmail.com>
References: <20220212152121.11032-1-netbox253@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0522286176728904189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=613741

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       FAIL      0.99 seconds
Prep - Setup ELL              PASS      42.37 seconds
Build - Prep                  PASS      0.74 seconds
Build - Configure             PASS      8.49 seconds
Build - Make                  PASS      1398.59 seconds
Make Check                    PASS      11.79 seconds
Make Check w/Valgrind         PASS      442.96 seconds
Make Distcheck                PASS      229.39 seconds
Build w/ext ELL - Configure   PASS      8.59 seconds
Build w/ext ELL - Make        PASS      1386.47 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
error: Fix typo.
1: T3 Title has trailing punctuation (.): "error: Fix typo."




---
Regards,
Linux Bluetooth


--===============0522286176728904189==--
