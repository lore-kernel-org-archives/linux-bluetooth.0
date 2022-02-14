Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B56C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 20:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiBNUMT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 15:12:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiBNUMR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 15:12:17 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DFC11E3F7
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 12:12:02 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id o12so15397463qke.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 12:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3/NuX+5zXsusGOk4KhGvcgwA8/D/OjkXTSO2mjM6e0Y=;
        b=cLbQ2M04yhVG4giqOKqElvVUEVKxmWxcUAss7e+G0Idt9jfqEgiO4Ziv6XSPDbvPf5
         DBhEhjnAkegXo2Mjf4vbRtifCKckMRHgjuTcdJQk6I5ZNkHHKk3Yk+XpisTE2O+wjmFN
         VqnCY1IW+CKyB8y9x7c6OsGx5KAbnk51q95G5QmR7JuGadv9bRb7QxEVYRs6zGm6VQH8
         Lc3hXcmBRvycnPtdtUOIhIAh4ho0t/0vdHf7ugcTZ63jmq6NjAYdgdLHUVUyNEIxyhEV
         fXqLuksqr0AuWMfzlK+jw1lhYri9/uKOSwjnSp303HkHjHMMCps07rEzyUfc93kZfDko
         MspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3/NuX+5zXsusGOk4KhGvcgwA8/D/OjkXTSO2mjM6e0Y=;
        b=6/PB2orsJY3ZiRtOFibye7DwmhkA6H+eePaDu0CfE/N6zN4vDaJDI3eGkJaZL9EI6l
         hR0q5ycvh5RjFUvAEqeOirNIB13aVYYtQ1q46p/orLtUv2kjgZyp7rDF0MuiAbctmK6L
         OoYg7mR0R63MQYfPaZxhkfpT2um6QXDKc3D7tyS+VVBwOlQj90NbrTRWkdXS3/cK/gn0
         SIJImRlfsYjNC8Djv4aLUB1VoIb+1KxkoP+c0ElRAo9k3vktZXA+G6Y6hKHXfBIG7sJe
         +cHuHW3vaH7Yyd4bD7WbFSyKXVG+x7tiEYkDAwLPXXL1xBWAzbenksUmhDHVCPQatF6X
         Ud8g==
X-Gm-Message-State: AOAM5300Lqr4el7FXTR0xuZmG5ffkImAS8/ZT03Nvjdj0R1u6DTZAG6W
        SMNDxdiVsugSQxKXM7u7xQObarVpE01Cng==
X-Google-Smtp-Source: ABdhPJxfnwNzMJgwznKhYem1zK7Hf/FopAFKeZpfgLESaJp7Mx2c1Z4+i6vlWVIfljK1+6xEKEuXEg==
X-Received: by 2002:a37:8003:: with SMTP id b3mr315520qkd.388.1644868721733;
        Mon, 14 Feb 2022 11:58:41 -0800 (PST)
Received: from [172.17.0.2] ([52.179.8.80])
        by smtp.gmail.com with ESMTPSA id d15sm11507024qtx.30.2022.02.14.11.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:58:41 -0800 (PST)
Message-ID: <620ab471.1c69fb81.48cc6.08d9@mx.google.com>
Date:   Mon, 14 Feb 2022 11:58:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4651594451670356696=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] obexctl: Add optional argument channel to connect command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220214183214.1803894-1-luiz.dentz@gmail.com>
References: <20220214183214.1803894-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4651594451670356696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614210

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      1.01 seconds
Prep - Setup ELL              PASS      48.15 seconds
Build - Prep                  PASS      0.86 seconds
Build - Configure             PASS      9.88 seconds
Build - Make                  PASS      1716.51 seconds
Make Check                    PASS      12.72 seconds
Make Check w/Valgrind         PASS      494.06 seconds
Make Distcheck                PASS      263.34 seconds
Build w/ext ELL - Configure   PASS      10.39 seconds
Build w/ext ELL - Make        PASS      1692.25 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4651594451670356696==--
