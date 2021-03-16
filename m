Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2310C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 13:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8346506A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 13:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhCPNtY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 09:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhCPNs6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 09:48:58 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3CBC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 06:48:58 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id n9so21674237pgi.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lyIHF9IGOqBH9CdJyzmbhMFTEACkPtdpo+gCJmKUGcU=;
        b=aFQJm1s9ezTw9AeMeC2MP+Ad5HTCA/94CBBwrQuf3X6UB68Uy9mAMWxp8uyeQbGDmY
         i3BJweFYnPNlwvlJXfKSon2H6GeHjLa42/bCAkCmCE+Arlxnvzj1DIfrYgQPcpyaZ9fw
         ARwacCbAt3A/L5OGUSiEufzrLf/r4D4lIvIuYecbCN1cDqHsCYAhFVSMmvjDkPqZsg33
         mkopum1KNUT4iBrS2G4S1KkBCyjEqFg/Zxj3zYOunHvL2O8uEBtwjxroEmPdrvybqjBw
         Fh4e/YatX4pzB2Yp5qgKtSm7n3RuMl6PiOMf8YQzagWzMOaing7hJLkEWEPUTB3KX38L
         LoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lyIHF9IGOqBH9CdJyzmbhMFTEACkPtdpo+gCJmKUGcU=;
        b=IKRupXZAvZl211n2VHs199TQQLOh2mQS80ePkXxqwSz0gyxKLXWqvnHFanG8sziZNN
         VMf9oNKNXZ3QnbjDDC3KrDktch5WCBYFZPbV+c1sRKQwOFGfZ6Cx8C37B4SOTcAtJfsh
         IN0nT8e9qNkIWO9izvKD7xi8pYKMkyHAxsgZ4xzNtnfi06vIieI8vAs5m4GQrojCVhXL
         CRsjVQg73YIKaYpl0B0OCchE4HMux+HUX6RbgM6o5P5amle3eUw71mKfmMDJUPtc4+fg
         fZ0lYw/bd2HY7xl0ISFw40L1oLl7Btoycrotl066rNAsIxQfyBZ8P8Ekn55Eh4Fbc2lF
         ebXA==
X-Gm-Message-State: AOAM533R8YggJYBCfFfrCPZUNfsDwV6/Po6wA8fq+ulf1ldRBvBWsOop
        GLOgzUb00EMjMYmhkXu+FcPrP8JElaY=
X-Google-Smtp-Source: ABdhPJxClg+WSZTuqOnWS/cQmZ+hcqjQx9EEjWeh7VmQVK8u4/dB4oDHTWkSwLN5bEDZT/J9cM2XMQ==
X-Received: by 2002:aa7:8e51:0:b029:1ed:2928:18ff with SMTP id d17-20020aa78e510000b02901ed292818ffmr28925224pfr.76.1615902537526;
        Tue, 16 Mar 2021 06:48:57 -0700 (PDT)
Received: from [172.17.0.2] ([52.233.69.230])
        by smtp.gmail.com with ESMTPSA id 27sm16756616pgq.51.2021.03.16.06.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 06:48:57 -0700 (PDT)
Message-ID: <6050b749.1c69fb81.ee012.8cd4@mx.google.com>
Date:   Tue, 16 Mar 2021 06:48:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6365205702287004239=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [Bluez] android/handsfree: Replace g_timeout_add_seconds_full by g_timeout_add_seconds
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210316132844.2532-1-frederic.danis@collabora.com>
References: <20210316132844.2532-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6365205702287004239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=449061

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
android/handsfree: Replace g_timeout_add_seconds_full by g_timeout_add_seconds
1: T1 Title exceeds max length (78>72): "android/handsfree: Replace g_timeout_add_seconds_full by g_timeout_add_seconds"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============6365205702287004239==--
