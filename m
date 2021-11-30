Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D677CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Nov 2021 23:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345317AbhK3XmI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Nov 2021 18:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345282AbhK3XmH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Nov 2021 18:42:07 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792D5C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Nov 2021 15:38:47 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id b11so19717690qvm.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Nov 2021 15:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IPbq5R8njkUvkQfqMc1RHkuh8IDJuUyhdUq2so7Q8Z8=;
        b=VUy4ikFK8lh83gcN1kAC2bQzUuKueI/j6HuWyThNPlEUzGqUOnTgamzUZ58wEDDxHB
         uoVGDvlm4/mBTgwS6ZyEboHbMzDKjKlqhl+OAtbqOQ4stAkJ5o5AsqDFgLi53T0vYQwn
         25fF+E1UAudpFBTqEemSR0QYoQhzfpJxfc1wwItGnRV7Sh7eUQ9VBBvSWIsK5hjFubSU
         aFl48qtA6pZzZS/hPSDcdlG0tPDVMwaWWmSmbAFLu/P83vNtPPzo93FuGlXUWGJ0/tER
         6z1jXROR0zK9k/kaM3LhMJSky/Poe0/Eq8iDGA5dpntrKOatRQl+uss/0FkXpc/6RnQC
         1+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IPbq5R8njkUvkQfqMc1RHkuh8IDJuUyhdUq2so7Q8Z8=;
        b=7Jh1zzRA03pijoum2ZkaOLDE5L4CtHuZEzndpZpjPh8xbF4aOmZLSKMeuYfCwqYset
         G4cXRMSfq0Kl5wSZqAzQEXfpwEGfdS6wMYdcBpfYSYp1NX6LL02p4Hhw0zDsFG0JHQ7X
         2axqTcBQR2B8pc5VMCay/5aFUy4u4tFWdWHKhWp68O0rnM/eHfnc6Sy4K8Ih83n5amYr
         vaVtbLRxcHpFsuk3/jy8VU5RAKAzXo3l0N2tHEpQrh0LQePgTTgcHiSvXnRXGuojC1yo
         Xc6w431+/ekn6U0pfr3S0LAvfh/Tyqz0GOFVkBVcNvPlgO+EgguNwDPiEt84b+/cJr4B
         R0Iw==
X-Gm-Message-State: AOAM532qkdL9tMaolYU3ZXUL6pt/zXxaTpBHTD56DDFTlRM87NELAlqE
        QHVJRadXyTCNy/PT2Tt/7TfNy7vfVQIVeQ==
X-Google-Smtp-Source: ABdhPJx17MiyyIwIIiVegfUZD/JNbb5ZudgP12nqG0K7R9NVBnsSoFcyLkHKFyhRobdgPSTUEBfgAQ==
X-Received: by 2002:a05:6214:e49:: with SMTP id o9mr2688712qvc.74.1638315526354;
        Tue, 30 Nov 2021 15:38:46 -0800 (PST)
Received: from [172.17.0.2] ([20.115.11.182])
        by smtp.gmail.com with ESMTPSA id s10sm9979353qke.132.2021.11.30.15.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:38:45 -0800 (PST)
Message-ID: <61a6b605.1c69fb81.eee49.4bc2@mx.google.com>
Date:   Tue, 30 Nov 2021 15:38:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5372027833290398471=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: Don't log error for false positive mkdir failure
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211130231412.97437-1-inga.stotland@intel.com>
References: <20211130231412.97437-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5372027833290398471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=588207

---Test result---

Test Summary:
CheckPatch                    PASS      1.33 seconds
GitLint                       PASS      0.89 seconds
Prep - Setup ELL              PASS      52.68 seconds
Build - Prep                  PASS      0.44 seconds
Build - Configure             PASS      9.91 seconds
Build - Make                  PASS      220.95 seconds
Make Check                    PASS      10.23 seconds
Make Distcheck                PASS      266.36 seconds
Build w/ext ELL - Configure   PASS      10.03 seconds
Build w/ext ELL - Make        PASS      208.33 seconds



---
Regards,
Linux Bluetooth


--===============5372027833290398471==--
