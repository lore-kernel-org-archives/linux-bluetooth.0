Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05C4C0015E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 22:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjHIWgA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 18:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjHIWf7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 18:35:59 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0514E2
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 15:35:58 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7658752ce2fso25140285a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 15:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691620558; x=1692225358;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mMGwJAwlo6Nby6+7E1tUnheezn432XYoPeenBxB9fEc=;
        b=Zh1in8VsF5CKoSQ4Msl1EGgtYJY6ZtNXSHfw8XpiNwIYSp9iS+mtgYsZnCYEC04756
         HJQD/xad5N0wABtFkbrpBVpuVHb/2jAHeuCMFD7+U/cXHVcIw3jI2mC0q+AOMiiT2Vem
         ROR05MpK+wzIzZwU93YBUZ36ovXi2mi5nsxt0QrBYFZ1E2hpz5k/G8koy8PqobxZoRsQ
         wWWg5eiK3cRkMEEKRlqrzF69W+LXfSBZEkBJtniEQ3RZgC4QDi4C75gouHz2vGrOIZyh
         PyjVKb/Aqf6Vh6mO2FgT0nAnBX7zasMihgc6AMEreDGWkpt2pnYZv2IpRRLR0IgKhRXB
         7xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691620558; x=1692225358;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMGwJAwlo6Nby6+7E1tUnheezn432XYoPeenBxB9fEc=;
        b=bZLp643qz0GFKAFOGUVEGp3Efwkdmg3BCkfan2niFPQ8r9svSMGi2wUIwbFHK2y7yF
         XcmtiqZPbX9G/aUS2zJtwRZO2ksBMffXqlYszCwv3+RKpSsx0VNSw5UID2IM65E4YSA4
         eIe0ZflGxq9R6g0tjYqNP/lpKsui0Y/bUgnypJoSszHaDcs1idVVJRcKOHAeBWoTlntf
         k0lwX0gJTw+os4DrGVV4ioh+qJkGLaBGUzG3z0IBeERpA2vvnYb24ic4lmGVzxZ8ru5W
         wW4CwzuRuaMqm2wvxrFfQu49O9gS021HjROKB9GCNjrRqTmvAbsaFWd3fDDQ9xXSllUV
         /TcQ==
X-Gm-Message-State: AOJu0YzMBf9Ei/x1P5jN8X4rn27wzM+3ckbXSifzzzyd5eepbnC7qbZq
        o5fQqyttmQUZ9njR3z51W9A8M7E2JJU=
X-Google-Smtp-Source: AGHT+IEgIFB5r7GGjGS3VoCmLy2+VAbpXvbk7lj3ia2uPrTGztAwm2N04IA0O/LedtT/L17Gh1e1lg==
X-Received: by 2002:a05:620a:1a05:b0:768:3bda:b1ba with SMTP id bk5-20020a05620a1a0500b007683bdab1bamr430953qkb.28.1691620558007;
        Wed, 09 Aug 2023 15:35:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.16.144])
        by smtp.gmail.com with ESMTPSA id w3-20020a05620a148300b007671b599cf5sm34480qkj.40.2023.08.09.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 15:35:57 -0700 (PDT)
Message-ID: <64d414cd.050a0220.aeb0d.01e6@mx.google.com>
Date:   Wed, 09 Aug 2023 15:35:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3628538663858874176=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC] Bluetooth: hci_sync: Add hci_cmd_sync_queue_once
In-Reply-To: <20230809213916.1636311-1-luiz.dentz@gmail.com>
References: <20230809213916.1636311-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3628538663858874176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774703

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      34.36 seconds
CheckAllWarning               PASS      37.62 seconds
CheckSparse                   PASS      42.89 seconds
CheckSmatch                   PASS      114.80 seconds
BuildKernel32                 PASS      32.97 seconds
TestRunnerSetup               PASS      500.42 seconds
TestRunner_l2cap-tester       PASS      23.92 seconds
TestRunner_iso-tester         PASS      47.37 seconds
TestRunner_bnep-tester        PASS      10.75 seconds
TestRunner_mgmt-tester        PASS      222.24 seconds
TestRunner_rfcomm-tester      PASS      16.37 seconds
TestRunner_sco-tester         PASS      19.50 seconds
TestRunner_ioctl-tester       PASS      18.45 seconds
TestRunner_mesh-tester        PASS      13.75 seconds
TestRunner_smp-tester         PASS      14.72 seconds
TestRunner_userchan-tester    PASS      11.37 seconds
IncrementalBuild              PASS      31.40 seconds



---
Regards,
Linux Bluetooth


--===============3628538663858874176==--
