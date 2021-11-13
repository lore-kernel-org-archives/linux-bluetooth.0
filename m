Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C5CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 03:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BDE9610A8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 Nov 2021 03:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhKMDGh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Nov 2021 22:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbhKMDGg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Nov 2021 22:06:36 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568ACC061766
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 19:03:45 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id kl8so3031242qvb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Nov 2021 19:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=y7/PggT8/eqjxS2oBfY6TIP+ai/Mvua5mJiHoZv5lC0=;
        b=F0WOyIjVUfv5yO/KAvNGuMPWGOBUX+K/+IXSdgSBX3zHEIU1hfIY61SVCgJZLr/sPF
         aUAlFOLAzbLoJ1yuhRoGNNRSfmsSa5f9dVCRPwsdgLhP3jvZWq0qcoAVf28GhGKWm2ZS
         Rgr6rsu1uJw3NE5pTeZbas41eG0wNQ8cFPZR6Uc2v/V4yieGra2VEaiRhbCV9EM0nJB1
         0TNStnYZRce6YvCMkzfKfAXbdBDlSZrsQJ+dL0mMDyYQlppSV7y0aAaS6gRGknlvWYCJ
         adGkdAQ4d22KxrUsIgsgcX9IV7a50TUwZFV7BquJT5UASVY7ttnq4Y8U7kml0a6d/E5k
         GGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=y7/PggT8/eqjxS2oBfY6TIP+ai/Mvua5mJiHoZv5lC0=;
        b=XWwjUrClGR61VYbT0sGPv3gCaJ85jMUJbC/mUfaE6TVGgt46l/DRc13oRScdX8Remo
         ZzIDd4u80w66uSQoNiGsiEEBirxQDtkpxEZpMwihX6g6sdYLbqhSyc+TyELJ3UsBfXYJ
         2jqO0uXiIv6lY4Io9z8ckcO4nblCBR/+10Rqh2Wm2zVJIyPPE1aAr36a+v94m/AcJFzt
         N6+4moow+BV6PHK8xhttLdEMVIMGNMAZdehej3b7hXNlHhNA12PEzFH0XH2HXnuq4aj9
         uS8w0zqqvNPwES0s9dV7XdIZXyJm5QDgB9OtnftcNx1dRTSB/ETYWGf3jSNqr6+4+YYM
         ZUFw==
X-Gm-Message-State: AOAM530hby9lwZrrvFNBMz8cMukBGkLy3LzB+cdoZpjEDMaPRHK5BOm2
        Q15stxprOPEKMbkWf5PaxoJNp6r7wi5O4A==
X-Google-Smtp-Source: ABdhPJxJQjRpyKi2GkbFORNn311UN8buZQxm+z6/TgAJGrum/jv04c+Z8Psuhet/Bit4qkjyUAlxMQ==
X-Received: by 2002:a0c:ed52:: with SMTP id v18mr19086571qvq.61.1636772623840;
        Fri, 12 Nov 2021 19:03:43 -0800 (PST)
Received: from [172.17.0.2] ([20.121.15.10])
        by smtp.gmail.com with ESMTPSA id d9sm3924304qkn.131.2021.11.12.19.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 19:03:43 -0800 (PST)
Message-ID: <618f2b0f.1c69fb81.3a916.a254@mx.google.com>
Date:   Fri, 12 Nov 2021 19:03:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7304431775940561653=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/3] emulator: Fix uninitiailzed scalar variable
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211113023559.212793-1-hj.tedd.an@gmail.com>
References: <20211113023559.212793-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7304431775940561653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=579489

---Test result---

Test Summary:
CheckPatch                    PASS      3.70 seconds
GitLint                       PASS      2.48 seconds
Prep - Setup ELL              PASS      44.05 seconds
Build - Prep                  PASS      0.48 seconds
Build - Configure             PASS      8.20 seconds
Build - Make                  PASS      185.97 seconds
Make Check                    PASS      9.37 seconds
Make Distcheck                PASS      228.10 seconds
Build w/ext ELL - Configure   PASS      8.27 seconds
Build w/ext ELL - Make        PASS      175.09 seconds



---
Regards,
Linux Bluetooth


--===============7304431775940561653==--
