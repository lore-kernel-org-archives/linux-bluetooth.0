Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37E7C001DD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 08:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjF0ImM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjF0ImI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 04:42:08 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB213C6
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 01:42:07 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-56312517201so2829341eaf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687855327; x=1690447327;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yhX7OGKSiHYEllaqynYoZkc+fmhD+mgNZi0KqT5XXLo=;
        b=ZcTa4xbXY0FZqRvCHG+/69AlILiJwyQ7UxiwbJISKdol1QQi6G7LTfcszHom9vouDE
         BdYNndIWgmtyaX1kA8UiFXUlc/poItgPgjSi1FPtAxHVeo/uNrKtIElzEhCG83nNuFox
         WHY66Y0aLHEN8umNrVzZ1/CpaNDZDdaChUgPhRFg5H8PYgXtiaPiH4A0B4h6O1Id6v7V
         2gO8K1Q3nP/swiNUWcrHfUb6AgpNGfxkZSWJCenEMaen48uFJBx2Zm8o3BIHpiqMOyVn
         gzetl2Zq3QkpP/T6LIxbVVk3podRGql+zuy5/TSYVUOZwMsq4Vor/0xnl3cF2FiON5gU
         U0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687855327; x=1690447327;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhX7OGKSiHYEllaqynYoZkc+fmhD+mgNZi0KqT5XXLo=;
        b=GYgXUNtrgABV1pWeBM31g8E4vQxvUveeMYopui5YXDluEiO70ZDB7OGFDcE6OiCNuW
         6WFhPDOtX9e4sw3NOMJtoWpcLXz0CskhlOl8U4+zF1QWp3OlZX42jr8K0K45rgI6+Au7
         MsHgqoVE1onMst2zj+ZTfzKYyNnqL7T0wmxPKIqGCXoAXm2lc1piBuTbi7W60akJotCO
         AmZkIwkV3up3i+rpgytWPMpH6Dva4VOvQ8dwpeMToBYdKKEtDLpp3EdGUFoXezQI0A9T
         x1XB43QuSqUSZyRVU5Qt4OCVs5Glk0JqPBkc+hRK9c+KXfBzX9GkfDbvddQFEM7uW+yp
         EdOQ==
X-Gm-Message-State: AC+VfDxRImZIAJBeiojoAYhoBtsS73bal4dtFKbZFSuK9U9d8Jx/4WWM
        WY24hxL+5qjj/b3Hv9usCr50qCN1LHGKZQ==
X-Google-Smtp-Source: ACHHUZ402LSg321SypTv07kekmStpprpuEESrXgdn/MM4T/dC6KICJaoOyQNvAx4SNzauKdmz11J0A==
X-Received: by 2002:a05:6808:23d0:b0:3a0:b5c2:7c21 with SMTP id bq16-20020a05680823d000b003a0b5c27c21mr17396497oib.48.1687855326812;
        Tue, 27 Jun 2023 01:42:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.158.219])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7811a000000b0065017055caasm4965027pfi.210.2023.06.27.01.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:42:06 -0700 (PDT)
Message-ID: <649aa0de.a70a0220.50d67.8e08@mx.google.com>
Date:   Tue, 27 Jun 2023 01:42:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4827556477844023740=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neil.armstrong@linaro.org
Subject: RE: bluetooth: qca: enable WCN7850 support
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v2-1-98b0043d31a4@linaro.org>
References: <20230620-topic-sm8550-upstream-bt-v2-1-98b0043d31a4@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4827556477844023740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sm8550-qrd.dts:22
error: arch/arm64/boot/dts/qcom/sm8550-qrd.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4827556477844023740==--
