Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2A2C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 22:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551D761056
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Nov 2021 22:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbhKIW6E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Nov 2021 17:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239822AbhKIW6B (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Nov 2021 17:58:01 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9545C07E166
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Nov 2021 14:37:39 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id bl12so620083qkb.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Nov 2021 14:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=NhB/mfPdgRijwCPY7M9nqQuwcA99PjY1yvFXF4iQ+ms=;
        b=B9Q2vdV6dCuW8cylX78yd0c5WaLsQer3uy/4aPBQKBigIeFFsDRX2n0O54+nFOYYXP
         DrdRZrvfylBtw4SfqEPaaeI2+HXr9GY7hyjSGmVmQp4rWVvrbHmJBNcH5jw299h8nZQ6
         jZd+BR7GPebi//g/M1YBqPU2RYZ8cpsasABGzTrrAguxbURqxOBc7pjHS4ShIsrz0GGK
         wif5QpvU8fU0NXNLOS7tyabWpxevr2SIfQ4siLKXr7nxzDOUv02ECm9RCLO1mfQ5pKpY
         OeS7afivYsp8le2XXfwyOkZxqsRuSTzcl1yweWOOcx7S0ny7IHQOIZf9o/a+/uOQ8vJt
         nmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=NhB/mfPdgRijwCPY7M9nqQuwcA99PjY1yvFXF4iQ+ms=;
        b=WzIDB/d59wbxVxxL2zSM9OviHPvGCkSzMAtOShwFHDmNAn5fJg1HYQ4tyAA7fPcr1y
         b8OC30ra/YgBg7deI9WvF3JhDqg6Qq1edBy/BNbJ1IUu1nRA57PysubO6YDkmhlZVQ1r
         DvW9IcAA8tnyf9XdwbN4osHtYGPaWLktClDo3lc8r8Mxpg7q8fWrMixgQjduuMaD9zPE
         /IWTJXPUBjb3dP9Sps0/5sQCvgPRWqRHG9P6JjYcpBZ2J7BPdaec/slZJIJsbUkhec41
         Ex9bqCDZJ115t4OX7Ej/xXt9aMVeFfjxu5JOKK/BtDm+wGe8fHQefN5uYllUMRpQmgrI
         /owA==
X-Gm-Message-State: AOAM530OVUXe6yO0kM9rTewFUHffy+zL0BWK+N+wbbnxfM4V0TILVCLS
        pAv9Ds2Kg1/ntObFVWna1abRhAGc7Mq82g==
X-Google-Smtp-Source: ABdhPJyA77/ROtLMA8TXSeZn6Pq9ZmDAVcWHjU1UnUdejf0tAKtpCj+T7LczgY4eQATLgXOMqSAyCA==
X-Received: by 2002:a05:620a:371f:: with SMTP id de31mr8816406qkb.255.1636497458746;
        Tue, 09 Nov 2021 14:37:38 -0800 (PST)
Received: from [172.17.0.2] ([20.121.190.16])
        by smtp.gmail.com with ESMTPSA id bk7sm12578189qkb.72.2021.11.09.14.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 14:37:38 -0800 (PST)
Message-ID: <618af832.1c69fb81.e5dd0.6ba1@mx.google.com>
Date:   Tue, 09 Nov 2021 14:37:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5177878656857999020=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] media: Fix memory leak
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211109215322.1124566-1-luiz.dentz@gmail.com>
References: <20211109215322.1124566-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5177878656857999020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=577661

---Test result---

Test Summary:
CheckPatch                    PASS      1.30 seconds
GitLint                       PASS      0.87 seconds
Prep - Setup ELL              PASS      49.54 seconds
Build - Prep                  PASS      0.46 seconds
Build - Configure             PASS      9.05 seconds
Build - Make                  PASS      204.90 seconds
Make Check                    PASS      9.80 seconds
Make Distcheck                PASS      244.96 seconds
Build w/ext ELL - Configure   PASS      9.09 seconds
Build w/ext ELL - Make        PASS      194.61 seconds



---
Regards,
Linux Bluetooth


--===============5177878656857999020==--
