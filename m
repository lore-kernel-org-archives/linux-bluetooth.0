Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4427C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 18:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B1C61040
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Oct 2021 18:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbhJZSoV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Oct 2021 14:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbhJZSoU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Oct 2021 14:44:20 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E16C061745
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 11:41:56 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id c28so112778qtv.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Oct 2021 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hhZXeo3kDGvjzmjVCFhOoA68QDviKqHasK4kh5ft+g4=;
        b=TluayF5FUJBMWxdridtvk83aFi8WIkyRrKLgxlJtdW8dVMsiWJU8DiRO4zC97esErf
         kY4bNv/m7ShtWNTiscAzijAHLRRxgYHvZwRogHRHtYuoVSKDzmtJxikBqHQHP4nI7cRN
         g2HlGrOXCp/phETwW1GX+VKRk3JsaKPh8MXfe+AXyO8PlScZvc8NTFxxiOfDvVVQcsPX
         9NqCPZRfokDIrMi9TJh83DqOIxame1B3ODdxURzXnOcWC06fvUKjMNEbCreXrQ6Cbiqu
         tPhn5Fp6GkuHQvzps3L3pPOpiKiV4mOgjEqYO3+idu9GLqakvQfa40GXnu8U7JrvOD03
         PHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hhZXeo3kDGvjzmjVCFhOoA68QDviKqHasK4kh5ft+g4=;
        b=z4RaV2iRFofVlDN66cFK5hV0moVeCatu/uviLcxA53i0+VUkT+fNebcgVV859uMwOv
         i5eijccP63gNaLv4D5oMZXI1oe2HBTw+K11boduTs0p4waN3lLRnfZsUI1GUTdxyxFu0
         RPC5XzPi1Vfln2o17lGtGW0n/fk8nC4jf1EypnnPbZxFDH/7zi/C4l83VykSXfrhUEwr
         S/0/i8O2jc8VNtvWZ15eYVIrPrJigE5KSPlNsG8IquZzFtKn5nzzjG4nJy4gQQY7QNMg
         mxPaGvOynf6P3O+1aFTfHiJn1mE0TLHeXYAR4qP32dJwP+EbpdgrQLG0EsOZxVl/CJsL
         ISVQ==
X-Gm-Message-State: AOAM532WvMnAKwQBBEnewY1FJvfDGtyd+VHbq3D26BsZ9asHqDxbc8HJ
        qYlbGUJk9zhirc4QxoQLob9GPARAqcpZGg==
X-Google-Smtp-Source: ABdhPJzn4qNjws8vNz7wf7hICzY4b8S+rIg5dJ1tFTaLFVXb+RT/CaxxOXMxKxBr/wiYUmBgYDxbCA==
X-Received: by 2002:ac8:6158:: with SMTP id d24mr26558661qtm.115.1635273715612;
        Tue, 26 Oct 2021 11:41:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.188.56])
        by smtp.gmail.com with ESMTPSA id k8sm10791819qkk.37.2021.10.26.11.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:41:55 -0700 (PDT)
Message-ID: <61784bf3.1c69fb81.18660.8cd6@mx.google.com>
Date:   Tue, 26 Oct 2021 11:41:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6392800116022099843=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] Makefile: Fix code style
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211026181815.1305602-1-luiz.dentz@gmail.com>
References: <20211026181815.1305602-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6392800116022099843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=570633

---Test result---

Test Summary:
CheckPatch                    PASS      2.98 seconds
GitLint                       PASS      1.96 seconds
Prep - Setup ELL              PASS      52.53 seconds
Build - Prep                  PASS      0.53 seconds
Build - Configure             PASS      9.97 seconds
Build - Make                  PASS      216.18 seconds
Make Check                    PASS      9.08 seconds
Make Distcheck                PASS      243.89 seconds
Build w/ext ELL - Configure   PASS      9.39 seconds
Build w/ext ELL - Make        PASS      184.54 seconds



---
Regards,
Linux Bluetooth


--===============6392800116022099843==--
