Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BCCC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Nov 2023 15:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjKCPGs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Nov 2023 11:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKCPGr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Nov 2023 11:06:47 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7443C1B2
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Nov 2023 08:06:44 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41cd4cc515fso12677911cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Nov 2023 08:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699024003; x=1699628803; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=66wjp+hB/CASsgUg9CVUH6LJYwtrvf/iAUfmSZBLOK0=;
        b=ebLKuKfJ1CYzY6d49iIwW2A7kgwqvYuiLIUAZG4m+YxNHgwH1u7uUpgiPsayP9SQIh
         L8b3L3uUWSEKRPJ2WFOFVK1LqtNnxzJ5Yt3f1KWLyYJ2lRo6exKRrXIFKOOrEk5pnlE7
         HjzuvcQ3zq3YWx0PeB2+kz8XIfuGD93MOiLY8phYJRV+5ghKNhIJtn7/9KyVZvguo2i1
         psp0pqTJaRu19ISgobFDPDqFcWpIV5HOG5XscdaCpcsI0eFErI9A3EQmAdm36AADRERQ
         7DKeuFTFQgztb0p4MuI8E4kMjMiDRN5PmAlUmN1y6akPOk0tNN4I2gnWM4Bmq3jq2PPe
         kwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699024003; x=1699628803;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66wjp+hB/CASsgUg9CVUH6LJYwtrvf/iAUfmSZBLOK0=;
        b=VTg8jzJxg70eaTKQuQ7w2M48LpecxAkd0QjlJBy900aUZCkVKuZ7IDWLHSsXJ1LzUm
         Y/GRpbT2Nh2C8G7cBRNwViQUob9MsyaaJW6HCYcmrLMJ3QGTbPZEU9TPCMi6RxHQ3It0
         /SdS9vr7wB8mXHOx6GTv8nGzcfpKumNh1EBxX9GIVXmMIgo331BskZY/kih/R40alDKd
         HNhKfKJeb2UU7/dsRAIPto8csYygzoV071Smy1O825WTjNizErXfuGwiEN/PEBdd9kHR
         1Dhy5RJoUaeFom2daeda/yoNKXknUiXZwmLwIyAj+fPHT24zdKOwhTLcTsmFMNAyo0QN
         j0hw==
X-Gm-Message-State: AOJu0Yx8nuc25OOFdAOgC1c9M8TUr8p7cspkBrWS81e8OXswo5+hJ8SK
        oekj2ZKoBLF3LtgFSlPCj7Dp/XENtv8=
X-Google-Smtp-Source: AGHT+IGFHe6ZGXALWevm1CeC9ysTPHQfpI/JYAQ/Hfw6ZzG+F0NeP3UOfAqQumpeRqKywE6CymBuzA==
X-Received: by 2002:ac8:5804:0:b0:419:82fa:710c with SMTP id g4-20020ac85804000000b0041982fa710cmr26879528qtg.5.1699024003269;
        Fri, 03 Nov 2023 08:06:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.44.146])
        by smtp.gmail.com with ESMTPSA id n1-20020ac86741000000b00417dd1dd0adsm777213qtp.87.2023.11.03.08.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 08:06:43 -0700 (PDT)
Message-ID: <65450c83.c80a0220.bd921.35ea@mx.google.com>
Date:   Fri, 03 Nov 2023 08:06:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7744633169021293016=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: Bluetooth: Fix deadlock in vhci_send_frame
In-Reply-To: <20231103142126.3847457-1-yinghsu@chromium.org>
References: <20231103142126.3847457-1-yinghsu@chromium.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7744633169021293016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=798639

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      3.94 seconds
BuildKernel                   PASS      40.13 seconds
CheckAllWarning               PASS      44.06 seconds
CheckSparse                   PASS      49.80 seconds
CheckSmatch                   PASS      136.54 seconds
BuildKernel32                 PASS      39.18 seconds
TestRunnerSetup               PASS      610.28 seconds
TestRunner_l2cap-tester       PASS      35.23 seconds
TestRunner_iso-tester         PASS      61.21 seconds
TestRunner_bnep-tester        PASS      12.08 seconds
TestRunner_mgmt-tester        PASS      252.64 seconds
TestRunner_rfcomm-tester      PASS      19.00 seconds
TestRunner_sco-tester         PASS      22.07 seconds
TestRunner_ioctl-tester       PASS      21.47 seconds
TestRunner_mesh-tester        PASS      15.95 seconds
TestRunner_smp-tester         PASS      18.90 seconds
TestRunner_userchan-tester    PASS      13.31 seconds
IncrementalBuild              PASS      38.35 seconds



---
Regards,
Linux Bluetooth


--===============7744633169021293016==--
