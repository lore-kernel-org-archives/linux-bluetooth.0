Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36019C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Feb 2022 10:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbiBLKfq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Feb 2022 05:35:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiBLKfp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Feb 2022 05:35:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0388226130
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 02:35:43 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso11139996pjg.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 02:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=x3HVJdyEp7jTYKFCpgtyr4fzoKpf0UO1KC2qeI+rfIg=;
        b=buufTkO7e+uQFAYzBJRoIu8MF0RFMir/nHkS6UuBSxN2AaWaSNyMfXqEikvs/AyTL1
         TJKf/E+HD5KCufjW7pcWpcJHT1Ow/zCAEmAXAndPlIQBiJ+WCxNckY9ca3YRi6zRuisa
         n8HOLGm+SwFHhPtOJGn9Oim3V/X5RWluv80SZT/9Bp/bia6KXHx000lsaZFhtc3uDr+/
         /ifoEXSlccemsOLDWLMrfpK//PAZWyttoRGP1/VfXmiKHJbsmB9E9Fl+RJnZfUpMvJqJ
         ckZIyNXZpgG3EwnE4gMBUrTHQA30gtpVOaFI9O6SjSswrbz043Q4jSl5jggSVf/vNtsk
         cNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=x3HVJdyEp7jTYKFCpgtyr4fzoKpf0UO1KC2qeI+rfIg=;
        b=Jww2xASQNNrlt9UQlS6lrw5hKTj34BLLy1SxlNIkg8QElc1JkHpAqJESwdCcLltH9K
         ET4OAsU3YVexNCNT7iLuQLMcAfiwutCe5Ibb8YbnUWYRLojj6gmK37XajptnhdHsamPQ
         o+grXVvdorSi5dkiRHwzJh/aaV/KckkyI7rGZ8lmeQVgAH5voIFpfXC8EH+5+xDNsuhC
         j35iB1vUiN0eNdt8nm/iMS/twjWxOwXDQiir30JMQpAmjvKzzpJkARhLSoRkzaZUQSnv
         h1fCXiScXFh3RasXCQb2HBHgqPcJVf3y/8hAbGWTywDY95f/F9QOiEbTvDpuMSlr184Y
         K+0A==
X-Gm-Message-State: AOAM530gNxYC1yGFGCkaw9XSUMwTfDXykSiXukOzl/Mm5CsfFODMl9Te
        bqatyr52V98Acwgeg9oZtWP5CdpF4p4=
X-Google-Smtp-Source: ABdhPJz2aXjfF7V3+eI0WDbwKVXODxjRhIsDTMYq1aeFfO6/UZyt/FzLuGVVjltd0/2HgHzsBqS1rA==
X-Received: by 2002:a17:903:11c3:: with SMTP id q3mr5385465plh.97.1644662142118;
        Sat, 12 Feb 2022 02:35:42 -0800 (PST)
Received: from [172.17.0.2] ([20.115.138.98])
        by smtp.gmail.com with ESMTPSA id q32sm22513451pgm.26.2022.02.12.02.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 02:35:41 -0800 (PST)
Message-ID: <62078d7d.1c69fb81.14533.86db@mx.google.com>
Date:   Sat, 12 Feb 2022 02:35:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8858007672696300822=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, daniel.trnka@gmail.com
Subject: RE: [BlueZ] adapter: battery provider for non-LE controllers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220212084541.221196-1-daniel.trnka@gmail.com>
References: <20220212084541.221196-1-daniel.trnka@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8858007672696300822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=613710

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.41 seconds
Prep - Setup ELL              PASS      48.76 seconds
Build - Prep                  PASS      0.59 seconds
Build - Configure             PASS      9.52 seconds
Build - Make                  PASS      1713.11 seconds
Make Check                    PASS      11.99 seconds
Make Check w/Valgrind         PASS      520.57 seconds
Make Distcheck                PASS      267.76 seconds
Build w/ext ELL - Configure   PASS      9.52 seconds
Build w/ext ELL - Make        PASS      1682.08 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============8858007672696300822==--
