Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7648DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E0E60EBC
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Nov 2021 22:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhKAW4o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Nov 2021 18:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhKAW4n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Nov 2021 18:56:43 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7C3C061714
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Nov 2021 15:54:09 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id o12so6591994qtv.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Nov 2021 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RaWv1E1SaDkH3ooATOCPNPpoTMFO6q9KUGX8W/u3n28=;
        b=C63lDUS7rs/oThGg7ZD5uW5xh+6Y2AkkejFT7NlTff/GP8/IL8BCZfBpKWUi2zRvS3
         S22rn3J5piMmvZExGYnjb6slJKQ817FLxZEtI61xRZM6tLEBBuRJT2T8qHcneokePE0o
         NtIlfaV95BPFxcji93NimKTlWsXryfP2pDSHw5QVPBa6YAKXRTbGuNMbJvDKzvb1l/ZB
         5ksjUR+1nqx4YJrcbPy07OcV7KJt3Bza9PE4Ht/9+ljeMrSrX1Sdbl7Is3rrLVzxqMfj
         FieSxzsLOfEjExVn5mJ0T0Vp2FKpHOsXTqi0xGtVv7o5wsVlWFifhbb0t9JumPvmzRB6
         Pqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RaWv1E1SaDkH3ooATOCPNPpoTMFO6q9KUGX8W/u3n28=;
        b=C7xF/AS/UwXCP4p57OvqYt6VJBc0DI31U6bOfAByp8n1q+3YTOD0a7Ir2ZueSNo3xh
         G+1GsWpKA8kdUn0dbWWwaZVJ4/24S2ZfuTvMPa4Ni/sEdKSSnHBw2yukB60XE7Wxx3rt
         m4Pg5/5tK0cDSzAOwDxAz/v5gcDnr3I0iQp+PfnfmhiJtFy4thjA3tgPEMrzBgjPOD7W
         ubmjuU3LKtM+fRygE5sPIermPg85plWBlZhNVggjz5fqDFPy5iE5TLha1TMHZJZJ4MZI
         dWBNY9b7fP9XmTNfDtIbwIOdJNKcmv2ertaD0jl3hcWy4HFYvUT5/9e36/mOOJX3m946
         xIwA==
X-Gm-Message-State: AOAM530M3CkbwOgabsHw8kd0R0min648io/zSKrxoU+UX7AUjbHL2tp7
        +KfaLMdMIftFNQxHJJAYcBiGr4GVfQ7m5g==
X-Google-Smtp-Source: ABdhPJxALEmrI4LkAosTP0kktznxHsvSpodKHHPnGs8WLFXGbyIpCjsFdmC/dKEvHlqCh/FOmc6EZQ==
X-Received: by 2002:ac8:7f94:: with SMTP id z20mr33906158qtj.85.1635807248668;
        Mon, 01 Nov 2021 15:54:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.195.208])
        by smtp.gmail.com with ESMTPSA id f66sm6425258qkj.76.2021.11.01.15.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 15:54:08 -0700 (PDT)
Message-ID: <61807010.1c69fb81.74c29.40e1@mx.google.com>
Date:   Mon, 01 Nov 2021 15:54:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6460191098193127829=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] advertising-api: Clarify Duration property
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211101222725.2766736-1-luiz.dentz@gmail.com>
References: <20211101222725.2766736-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6460191098193127829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=573769

---Test result---

Test Summary:
CheckPatch                    PASS      1.51 seconds
GitLint                       PASS      1.00 seconds
Prep - Setup ELL              PASS      41.58 seconds
Build - Prep                  PASS      0.49 seconds
Build - Configure             PASS      7.74 seconds
Build - Make                  PASS      179.29 seconds
Make Check                    PASS      9.63 seconds
Make Distcheck                PASS      213.46 seconds
Build w/ext ELL - Configure   PASS      7.87 seconds
Build w/ext ELL - Make        PASS      170.09 seconds



---
Regards,
Linux Bluetooth


--===============6460191098193127829==--
