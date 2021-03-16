Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC5BC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 22:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F52664F18
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 22:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhCPWiU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 18:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhCPWiG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 18:38:06 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5B3C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 15:38:05 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id o19so539416qvu.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 15:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=BT1BCJt1RG+uK0xo//DlY7Qp/I027KUswiduHC2k2DI=;
        b=RwgnB7jID1FQBEj71yagM+/0dB6vAGNJLiqaM1xxbfii3As7WqbDrAvWrYlpYfRCWP
         HnVn1+tWQ92Hr+WvAjCS+MEPPtUt8inKszXVwsk5KbYQo7TQ5ISxl1MWUE0WgJHf9Ifn
         knci9iCY1uGei29EMdzSUIXN7XhY/1iPEZ1uUUe1z6a4P3c6JAxL+QMK7cQd0BBd6ygt
         Di7LOZR8HMFeYiyrZ7/GrCO9K2lbUz5eOYC0Uku4QpSbVv4b8FFlKbOhiQhsUcljM6wD
         u9gIQNerwayoodQVZCXbyJvYV3XSCBchd4qU7PgBy+UbWPvVRs6CcYjqGX+Du9aamfz9
         189Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=BT1BCJt1RG+uK0xo//DlY7Qp/I027KUswiduHC2k2DI=;
        b=tNRs4x6Y7u7JZNuNn4UVjpoRiMzRcNghtM3FpchQTfQuaOuyfcFmg92rUo1s0Cv06c
         bPZpnTmE8hrDo7j1Ak9FsuUGFUuCXgh3OM/WEInLeaK9fM0mZJIkXLmeyra4sXoulexz
         cShhz4g348Og02Sym8OO+rQGskWV+6YWRm8HtcaoZHH6kc1HooA2z/ZhbNHJnbXp0BW8
         QPt8pjwnQaP67SuaHgaBKhp8mcCijM/ZpebRz/Z1obMKISWnN0D6f0rko0GIxpfsu6qB
         wxweLErJmRAurKtsmJE/atLziQ7+Iu+CcJrTQEYVqfuZsZrGVmefhlCQVBWA9TfZdHkR
         t6MQ==
X-Gm-Message-State: AOAM530lL/rDIIQfIxUrNKEyxmKBSp5H6DKew997KmVZOt/1zsWuNt8I
        /aVeAo0EVx3WVFt1e/vx/AL1xQCZ7nAZmA==
X-Google-Smtp-Source: ABdhPJzqavlKzgTnGr6JecDHa6cY8Liw4bLjlQ3bz3ZwfINBGrunV+UDS1rGGszmw8atHJkcJRV7zg==
X-Received: by 2002:a05:6214:d4b:: with SMTP id 11mr2275592qvr.42.1615934285036;
        Tue, 16 Mar 2021 15:38:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.147.167.133])
        by smtp.gmail.com with ESMTPSA id k127sm16386755qkc.88.2021.03.16.15.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 15:38:04 -0700 (PDT)
Message-ID: <6051334c.1c69fb81.f5935.9d86@mx.google.com>
Date:   Tue, 16 Mar 2021 15:38:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7466690725273535486=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] monitor: Add option to force output color
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210316221648.11839-1-sonnysasaka@chromium.org>
References: <20210316221648.11839-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7466690725273535486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=449559

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============7466690725273535486==--
