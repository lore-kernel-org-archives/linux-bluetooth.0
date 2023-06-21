Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB06FEB64D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 06:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjFUGj6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 02:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjFUGjW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 02:39:22 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D023A1BD4
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 23:39:18 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7624012c0b4so422049385a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 23:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687329557; x=1689921557;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=skv+QG+wrU9sDOR6lOPjERpY+4XmpyF7JV+hVLdORdY=;
        b=RnY01ItofJzoBouXuG9cy9rIaD0HPoobiXqvM7JXxkaFnWwEed4GPNV+LkPpa4XNwp
         zTFkJXZSPPvGHwtaC0xdlZnRL2Lao+JLlWbp8UHwbsP0a/tH72o7mzQDL4tYP9hFggWs
         RtlIzC7dyoCS5VQAAIWiE4Mx6SbPA2+bZDUvYX7q1PfVQIvGLV6PqxBMc7CjpQO4U8z1
         oaBZEHn9zizOFNwMrcNH/afPbg5H9cPlK/Bm6Q7se1/V1BM3jTRL2lXJWgK3nB+kCQLi
         o+CuRxCg9LhxJW0zrDPDfc/diRyU2OWqht5z+PzCDkajKtd6ZPu8HICw+6Q15kTRvKF3
         Tb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687329557; x=1689921557;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skv+QG+wrU9sDOR6lOPjERpY+4XmpyF7JV+hVLdORdY=;
        b=SIKW+cR+vpccb0yOaen/pdEhjFejkwI81rh9t9qPx2waIlhjdzp6wOa3UaCXL4YJOx
         0UKstQppZAj5roB7TDO4+fZdkq7+ba3ygO97YIT2fe8oR/WUilv8wfd9UPoh46j1BTDb
         MP0DIjktNGplDi5X2zH03502h0pB0fZtYJpL9REjw0oMV/rih1mUxtBARdg6ytw4Q7nO
         TAz5rZ2g50vBF3cV52Pawyq0xSdgPFV1VU+T8MN0znzq8pF7lGFmEKeckiQT6E3tfi4p
         HL2YWTttkryaYd+hvLgp/7AJTt8gLBndYV3MWdT0wgb6bmqGLe912J+mMX0DW5NfW709
         XBTA==
X-Gm-Message-State: AC+VfDxZ3icMD4fIG5fekXUFJ4e0LFxYeu45JT6fKuq2I86KpJK5Zz/U
        0LzG3l4sRmpmnZmUCbAhQF0nfli2heA=
X-Google-Smtp-Source: ACHHUZ5E6KBwQ0WOvw6q5y/SwMZ0To6Iia6bNZLJCPBAH1/IxwGY9L1wt+I2HdSLSxkIhDRnplUbzw==
X-Received: by 2002:a05:620a:8e17:b0:762:55b8:cf89 with SMTP id re23-20020a05620a8e1700b0076255b8cf89mr8292729qkn.21.1687329557553;
        Tue, 20 Jun 2023 23:39:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.10.19])
        by smtp.gmail.com with ESMTPSA id v22-20020ae9e316000000b0075f2c1afb65sm1945846qkf.45.2023.06.20.23.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 23:39:17 -0700 (PDT)
Message-ID: <64929b15.e90a0220.98d29.6023@mx.google.com>
Date:   Tue, 20 Jun 2023 23:39:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4427445355570995489=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: RE: Bluetooth: MAINTAINERS: add Devicetree bindings to Bluetooth drivers
In-Reply-To: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
References: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4427445355570995489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=758931

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.40 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      39.08 seconds
CheckAllWarning               PASS      42.42 seconds
CheckSparse                   PASS      48.03 seconds
CheckSmatch                   PASS      131.28 seconds
BuildKernel32                 PASS      37.56 seconds
TestRunnerSetup               PASS      538.53 seconds
TestRunner_l2cap-tester       PASS      20.04 seconds
TestRunner_iso-tester         PASS      29.23 seconds
TestRunner_bnep-tester        PASS      6.95 seconds
TestRunner_mgmt-tester        PASS      150.96 seconds
TestRunner_rfcomm-tester      PASS      10.97 seconds
TestRunner_sco-tester         PASS      9.97 seconds
TestRunner_ioctl-tester       PASS      11.87 seconds
TestRunner_mesh-tester        PASS      8.65 seconds
TestRunner_smp-tester         PASS      10.05 seconds
TestRunner_userchan-tester    PASS      7.35 seconds
IncrementalBuild              PASS      35.48 seconds



---
Regards,
Linux Bluetooth


--===============4427445355570995489==--
