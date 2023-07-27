Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE9BC0015E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 14:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjG0OBm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 10:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjG0OBj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 10:01:39 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7730EE4F
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 07:01:38 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-63d170a649eso7090626d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jul 2023 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690466497; x=1691071297;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wq253SnIl56gNBtzVsEyl45rV0C9IcmMwPWgMyt6CmQ=;
        b=HDoPqYa4fVJ1vAgiMUDboORUJJfp7PhUYXGhQB1B0aXpmxq6DZGmeICm7Nuk8A4hk2
         AbywvNgER8kv2EBGCdKWXc9vH6fVDa0h2S1LcDrce7J+7yJNGdA4I2/mNTbQ7LsDQaHL
         MBZaKv9Xn+Akvnuded+8lXV+wu6FZH61e3QTGo6BEx0hLDGzisgozHUA+Z2tWThcALWY
         rYBtjW3yCpXDwSZM7rCCcXWlt36GZflqcJPvHMWX2YzqpYoq9YuTOhKuoeBA436zPtIJ
         ROOuWYCKy8nUe4zeEEGqKhDL9bhTfVKaUpDNoJZ9SaLrLi+xW53kjRn8KBpUGMXEH8cI
         Ks9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690466497; x=1691071297;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wq253SnIl56gNBtzVsEyl45rV0C9IcmMwPWgMyt6CmQ=;
        b=FqzflE8NpS+Sgwa67pcSdaI2U4/SJ96rp7NVGlpxzOfwCksETKIGhzaszUkbFIUKNA
         fYPXfPaUtRMuvmeGq56M5fum0bRds/5K6jXj1aJwrERH3ZvPSu2nqEB+u/tfWeu5wjmM
         mWaVnjgsuQzlC5ky6IkrzyR9F5pY2nG3PBZW9QkdFVCvRWVtMMppSXglloXazJgDnxDk
         pc9OqnBfp7P45ilnP1x89oeawcTm12Z5rPzYuqNvd6yI+9pC41ucYM4GiizQxh4a6WhS
         SFDCjn9elFunlT5j5RoeizEHwT6RBYilvG5CMngNCU/fOfdt7Jp1SejV6InOAs8EGcWM
         cuWg==
X-Gm-Message-State: ABy/qLaWi9A9TGmAppOKpqGu3uY8h8EGIm7yByLVaerSVj9eTi9iucfE
        rA8LWu2sd6CzcJ0b+4rP1s5gACjToCQ=
X-Google-Smtp-Source: APBJJlEnrz/dxPtQbwJaZaZS9KN8BIlN5ocqkSkkn2cI5JJ5lJtJ2cTZ6160GCemMY+FQ4Vqu7nS8w==
X-Received: by 2002:a05:6214:1623:b0:63d:38e4:e372 with SMTP id e3-20020a056214162300b0063d38e4e372mr34801qvw.30.1690466497329;
        Thu, 27 Jul 2023 07:01:37 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.16.67])
        by smtp.gmail.com with ESMTPSA id 16-20020a05620a071000b00767cf270628sm415197qkc.131.2023.07.27.07.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:01:37 -0700 (PDT)
Message-ID: <64c278c1.050a0220.63b63.1685@mx.google.com>
Date:   Thu, 27 Jul 2023 07:01:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0566922763041943853=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Add support for AW693 chipset
In-Reply-To: <20230727133317.297014-1-neeraj.sanjaykale@nxp.com>
References: <20230727133317.297014-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0566922763041943853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770143

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.68 seconds
CheckAllWarning               PASS      36.62 seconds
CheckSparse                   PASS      41.59 seconds
CheckSmatch                   PASS      112.14 seconds
BuildKernel32                 PASS      31.97 seconds
TestRunnerSetup               PASS      488.72 seconds
TestRunner_l2cap-tester       PASS      23.30 seconds
TestRunner_iso-tester         PASS      45.07 seconds
TestRunner_bnep-tester        PASS      10.76 seconds
TestRunner_mgmt-tester        PASS      222.53 seconds
TestRunner_rfcomm-tester      PASS      16.12 seconds
TestRunner_sco-tester         PASS      17.03 seconds
TestRunner_ioctl-tester       PASS      18.18 seconds
TestRunner_mesh-tester        PASS      13.47 seconds
TestRunner_smp-tester         PASS      14.46 seconds
TestRunner_userchan-tester    PASS      11.43 seconds
IncrementalBuild              PASS      30.53 seconds



---
Regards,
Linux Bluetooth


--===============0566922763041943853==--
