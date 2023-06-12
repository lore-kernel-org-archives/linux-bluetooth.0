Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45DBC88CB2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jun 2023 15:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbjFLPe1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jun 2023 11:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbjFLPe0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jun 2023 11:34:26 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D370C10CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jun 2023 08:34:25 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-784205f0058so1603059241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jun 2023 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686584065; x=1689176065;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5t0M02TudjCnxlyTsjbXy39RSBPK7aTmQA5kOYvfj+k=;
        b=G0RX8PY3XGtl7F6BAlKGvi7flpyj8mHdvuCU/isglqbQ/gMcInu/OGdzk75nUs8CUN
         lT79YOKXPNpQ3VA1s3Hryv4Zryog+in/duUpvQj5SDG9DU/hOKazF4icQHyHxNx6t94G
         ToQNEVmqaTPWa0AJxFvLiXD2iXSlMK8HIoI5Ey6izNgSZWb+CaTwiguzCnJe+XMreaLO
         LEtZ6//dkRqevbDfNY01gGCiAWrFnduAN3005Ds1dmG7KxJmZJPUqVrGIsVC7zxg011P
         DLZoV7sNYrd7xv01urHo9Hq/3KpxUr8cVA0/Xd4LucRKu7J9/YRKllqbEsiLoHoYmdgh
         +L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686584065; x=1689176065;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5t0M02TudjCnxlyTsjbXy39RSBPK7aTmQA5kOYvfj+k=;
        b=aY/mK/RR3C2tqOy4o6ARdlzfLY3kd+GBBy/DcG7WvgHpaEU28gQ1b+WqZI7s4YcWoS
         iKzpYyQXA4KluhaAu7TaZd1U0baK24aYr2YVKeCbZbqfSKjNMhInek85FvPiglhxjLfZ
         Akyhqii6QNSq9z6qsbBgwldjCqv7tsgObFuQ/bZ2XiWV5F7ObHtXvWpf0ip0Lfb/BuOD
         JLwyeljlcUoVHCdfqP/ww7lM0BTSLWz8yhl+AZxBWDdMpeo0yMeiXeLONZEYPsbtH+Yl
         0prl558P0QUf++hJ4XpSJHSiXjGDjS6HGvy6X4naHfWD94RNT1T0vEOxV5M2rleV1s0J
         IcSg==
X-Gm-Message-State: AC+VfDw24O3OU2r6p2Qr0Wo5sU6yeXzg5C44joFpKpDlAzbrDSXX/yUL
        sV+2SY5qG6MnBH8Xbl88KjN7WyyflRg=
X-Google-Smtp-Source: ACHHUZ4JTEnyMlx0KOcwZ1FRUhAF0TOqVPuubLGMr6KYPPCr+DtSYhQJW1m8Jcm7heDhprRToDa+wA==
X-Received: by 2002:a67:f607:0:b0:43d:6660:581b with SMTP id k7-20020a67f607000000b0043d6660581bmr3713081vso.5.1686584064726;
        Mon, 12 Jun 2023 08:34:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.150.24.72])
        by smtp.gmail.com with ESMTPSA id r16-20020a0cb290000000b00623819de804sm3300068qve.127.2023.06.12.08.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:34:24 -0700 (PDT)
Message-ID: <64873b00.0c0a0220.32ace.e50f@mx.google.com>
Date:   Mon, 12 Jun 2023 08:34:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2658971986173405371=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, nitin.jadhav@nxp.com
Subject: RE: Code handling for VOCS service
In-Reply-To: <20230612133251.194-2-nitin.jadhav@nxp.com>
References: <20230612133251.194-2-nitin.jadhav@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2658971986173405371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=756305

---Test result---

Test Summary:
CheckPatch                    PASS      2.06 seconds
GitLint                       PASS      1.07 seconds
BuildEll                      PASS      27.19 seconds
BluezMake                     PASS      832.60 seconds
MakeCheck                     PASS      12.59 seconds
MakeDistcheck                 PASS      155.45 seconds
CheckValgrind                 PASS      255.24 seconds
CheckSmatch                   PASS      341.05 seconds
bluezmakeextell               PASS      103.39 seconds
IncrementalBuild              PASS      2068.15 seconds
ScanBuild                     PASS      1044.52 seconds



---
Regards,
Linux Bluetooth


--===============2658971986173405371==--
