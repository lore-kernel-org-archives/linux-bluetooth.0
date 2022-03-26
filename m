Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A497EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Mar 2022 07:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiCZIAD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Mar 2022 04:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiCZIAB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Mar 2022 04:00:01 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0073E1AF3A
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Mar 2022 00:58:24 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g8so7659518qke.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Mar 2022 00:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=B2gUcRfluOCBE3UY2+0SbLkBlpINKuSBtj12BBA04Ck=;
        b=Bpt+ZrsDLKDumH1/4GJaGNVn/NXkVEy0ZjZTtZNcetZM1kftJOZKg3RjjE/M+cGM3V
         lbEamX6hug0zNR3LmlxrH0jbJ0WHyshVMx3OkHQJgoyi0La4zv2G2JVAFJSwBln3Bx/N
         ZBCkucTgRuWXoul5ftu8XrUDRnmEfA+rP/wFNI194v/dnAZUNm/EjSaFiPEZ0DTB/EI1
         Nt3L7DPSaXmMIpVUAuQaXJ1wLBYf4xVM9io0ygvKArj1x/4J8wnVOPtjY+/41Lvd0h/U
         WR0q3WLm0D/M00ZwyYXXhI7Hl22By6lbI4hfnXWkWQ17Y1oGkfqQshv6YEOtyhxYMGQQ
         DYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=B2gUcRfluOCBE3UY2+0SbLkBlpINKuSBtj12BBA04Ck=;
        b=d1wKsUCdB31rQoJPx+uNRCfPtLTt+len1OuGJ7zuvxZ/bkouKvZ34s1XM6AuUU2N02
         7++F5yw6gJlpt/YvZGnkmjmfycEOTFPaefQZYggDAo2/loaO7nUMQt5ezqHlRPbAFrNz
         Sr/zKvCukWkSSfF0OVCgQ4aKkqU/3MfIva854rg2//dfbzW4oe0HCKUjFg1caVH35s3U
         QNO9HN5flmRW0Z6/IEQza4apQsm2cY3qSP8eqyh9Yg8bsPHsiObje6LG4jokJIxPpkDD
         R2EWUezXz+w9g1xnZ7YzSqD6Pfd/4MJx1/ZrcMgztLjUXcrOkzX8JxoT+1s2BkZU2u4L
         GexA==
X-Gm-Message-State: AOAM530DuVhtgUDllsh7LchOEUn1mIz4DFQExMCnbyyHsa4YvQEz4ob3
        sZKSlq0OJuBepob+QpUPuVQSCeMEbPBs+w==
X-Google-Smtp-Source: ABdhPJwDlqHtto/2nY/U0nAQ2r3zLcNtlpwzLbbR5Rhm8ggaz/PuLsAlfONKhC7ixU9qNbrs0tQdxA==
X-Received: by 2002:a05:620a:280d:b0:67d:2480:fdea with SMTP id f13-20020a05620a280d00b0067d2480fdeamr9369847qkp.157.1648281503701;
        Sat, 26 Mar 2022 00:58:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.22.248.79])
        by smtp.gmail.com with ESMTPSA id u11-20020a05622a14cb00b002e1fd9dce3dsm7467596qtx.60.2022.03.26.00.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 00:58:23 -0700 (PDT)
Message-ID: <623ec79f.1c69fb81.79c7c.8ff5@mx.google.com>
Date:   Sat, 26 Mar 2022 00:58:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3675802086115517722=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: [v2] Bluetooth: fix dangling sco_conn and use-after-free in sco_sock_timeout
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220326070853.v2.1.I67f8ad854ac2f48701902bfb34d6e2070011b779@changeid>
References: <20220326070853.v2.1.I67f8ad854ac2f48701902bfb34d6e2070011b779@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3675802086115517722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=626497

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 PASS      0.83 seconds
BuildKernel                   PASS      29.67 seconds
BuildKernel32                 PASS      26.55 seconds
Incremental Build with patchesPASS      36.25 seconds
TestRunner: Setup             PASS      466.04 seconds
TestRunner: l2cap-tester      PASS      15.40 seconds
TestRunner: bnep-tester       PASS      6.09 seconds
TestRunner: mgmt-tester       PASS      99.78 seconds
TestRunner: rfcomm-tester     PASS      7.81 seconds
TestRunner: sco-tester        PASS      7.58 seconds
TestRunner: smp-tester        PASS      7.54 seconds
TestRunner: userchan-tester   PASS      6.33 seconds



---
Regards,
Linux Bluetooth


--===============3675802086115517722==--
