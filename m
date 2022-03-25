Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 04:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiCYEHg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 00:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiCYEHf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 00:07:35 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7942C6245
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 21:06:01 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id v2so5616976qtc.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 21:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3zJfTC0zvKlwdhTA326I8oXsVHGM8xN6wVF5xA1hKag=;
        b=X2n41KGRxa32+h9KHsug+H41FVFAwvBfBzQVuwHdQ7aK3jgAAmCvjlffhQBzaaQNti
         5B+DzBcs92YtVDAoF6Fd8bMlnz3VrirpnIWKINtkuml2UuRVeVsPaNrJv7jrBvlGGIrH
         Nvpu9ej5pdqp9cs5Hgt6E5L3oGPTEZ/wWPRIzye0hlaQY/nt5qIfFEmyDh/JW27dkELg
         0v3VR4no8h7WKdpjHHe+TXgmPCSdFb0Mfy8N1dYUJeyAs+SfvyGEECJlqAAa4QDa2L6a
         YZWhS0ulwCVeDQrqW0n5ePmkRYV8z1i4T0ZNMfKaJOemiGT6kE43M/kCaZqq+FIKBiQ9
         BwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3zJfTC0zvKlwdhTA326I8oXsVHGM8xN6wVF5xA1hKag=;
        b=tmyT/1sm8Ndc4oYRGx8bT17E8XJpBx+79/w/ESEDEWUlG/QLG7fWysLYT0fU9Jc3xP
         Enpqsh/degb8sKwvUjjwhsbIrE9Z2U7FdhFlU2B26JNFHQsQr8uCazgHZQI/7AgigHW/
         plpQXbEJ/afn1H1RGf3jOHy3c6yfuwYzE8BnEyuJlrQtRHyrW0T1lRSdE6Bw42UKQ9DT
         R0Pdx5uimprS9y9TFeCJm0QkzuQbP31fCFDIKWBfH7hO8F0K3GEBRKeGr1SyZO6oHbLH
         YfdpFD6VcMjqXv4i9ShK5qAEB7qCChFjrOAIlA4lpCfWsxSSMvrxfgAZxsyFPfGsVOYK
         AdrQ==
X-Gm-Message-State: AOAM532pCGqP1FCw0U9dwCeTXGX0x3OB61qXAIdCW9zS7RCoVjdFxd31
        2dNn/MwvkOeBuqtT5GeNvCCgKM45Nz+Efg==
X-Google-Smtp-Source: ABdhPJySRvwAEOI/uxspVpNNd2qPkoofFVJ0Qgd5FX15CkeH60sLG65+tfGt9TiCpkdNqvuHnK9vqA==
X-Received: by 2002:ac8:5dc8:0:b0:2e2:3514:3f2f with SMTP id e8-20020ac85dc8000000b002e235143f2fmr7524640qtx.407.1648181160693;
        Thu, 24 Mar 2022 21:06:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.232.203.141])
        by smtp.gmail.com with ESMTPSA id z19-20020a05622a029300b002e1a763dac1sm4021954qtw.9.2022.03.24.21.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 21:06:00 -0700 (PDT)
Message-ID: <623d3fa8.1c69fb81.b19c7.8cd4@mx.google.com>
Date:   Thu, 24 Mar 2022 21:06:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8902765170834206684=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220325033028.1.I67f8ad854ac2f48701902bfb34d6e2070011b779@changeid>
References: <20220325033028.1.I67f8ad854ac2f48701902bfb34d6e2070011b779@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8902765170834206684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=626220

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
GitLint                       PASS      1.01 seconds
SubjectPrefix                 PASS      0.82 seconds
BuildKernel                   PASS      34.79 seconds
BuildKernel32                 PASS      31.51 seconds
Incremental Build with patchesPASS      41.66 seconds
TestRunner: Setup             PASS      529.53 seconds
TestRunner: l2cap-tester      PASS      16.42 seconds
TestRunner: bnep-tester       PASS      6.76 seconds
TestRunner: mgmt-tester       PASS      108.12 seconds
TestRunner: rfcomm-tester     PASS      8.97 seconds
TestRunner: sco-tester        PASS      8.37 seconds
TestRunner: smp-tester        PASS      8.39 seconds
TestRunner: userchan-tester   PASS      6.94 seconds



---
Regards,
Linux Bluetooth


--===============8902765170834206684==--
