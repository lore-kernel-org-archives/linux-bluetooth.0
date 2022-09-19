Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F88ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 19:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiISTSE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 15:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiISTSC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 15:18:02 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154C23D5AB
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 12:18:02 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id d1so513603qvs.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=r1l4554dC8TWpf6fYGRhS9Jhlv+ajknNJ/IAR2jjABU=;
        b=VSwhrD2/hVGL2hjN1U8xjNK2ljv3j6Cfsjo1nAqIOAkTqPcCADhKfNbkac4oPijf/7
         qUj1rL8jYQhjJZLDrSn3ChWi3Lm9MUDBLA49gl62PMiRKFEEMncatq3ok1fMz+fBT+nh
         jzTjm015TMPjn2tT8F1inoSTEy8dO81xNzzJqG1EBpHIciMELDzeYg1VIKnJeltrBezs
         F0God1A7QDD02nPlvUs135jlb4vKHt8E5QKY3O56sK7fkhJU+OtJB5TyuD2y9H626KKc
         IDLZ9iwx0rbr3c+mVzO4hO2eQ1D1i6BBvTRwat11GSYQDjqQtuelmexohz5uNJUtTKKj
         +ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=r1l4554dC8TWpf6fYGRhS9Jhlv+ajknNJ/IAR2jjABU=;
        b=uV28Qbg/SgyOLFlpe2kd/Tr5+oPsNIVrmjG50v8QV0GKuVyf52OkFjYwz4st3U6/Ks
         9wI2SWwrld6fkicgGawvzM9lE+Y5yISTXu389SDtMiPqLyMhzOlbZXf9HlnTOWASU6aZ
         2Mzy5EyWVFV1GKPBsd51pIfod1JICuBf4yO9oigtdzBkCRB3MMMMkwh3V8nuPoHJq4lN
         AcZoeGlcZniHrR9U0EHlOH1olEXUkfPlJpxU8lmWSEtvoh2ZuRPe8aogyv6SA/GUmAQi
         3mMtBuLMIVYfOL1SNuGq8s57cGA9nV0vvyA/rBDEMo/IYOFXiIbCb3LhD+P663VKZRWf
         vfDg==
X-Gm-Message-State: ACrzQf3Zqro5EYCoCtpbx0SO5Qb9C6YYHVLHEyb8ME/ujcU1dUus46pf
        vnJlVtp/RRn+SVaIXPqydG8MNjJXUJtooQ==
X-Google-Smtp-Source: AMsMyM7tHB1Hrv+hSEzHlwRegjrmRN55dEJxxUVd1ioLXhGLjnTp4QXFl+I6vAIM4o7VeOPI1w5hWA==
X-Received: by 2002:a0c:8dc9:0:b0:473:14fe:7c4e with SMTP id u9-20020a0c8dc9000000b0047314fe7c4emr15932626qvb.44.1663615081111;
        Mon, 19 Sep 2022 12:18:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.172.81])
        by smtp.gmail.com with ESMTPSA id i1-20020a05620a144100b006cebda00630sm9096473qkl.60.2022.09.19.12.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:18:00 -0700 (PDT)
Message-ID: <6328c068.050a0220.cdab4.6fc4@mx.google.com>
Date:   Mon, 19 Sep 2022 12:18:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3897012838915046096=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_event: Make sure ISO events don't affect non-ISO connections
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220919181017.1658995-1-luiz.dentz@gmail.com>
References: <20220919181017.1658995-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3897012838915046096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=678338

---Test result---

Test Summary:
CheckPatch                    PASS      2.07 seconds
GitLint                       PASS      1.12 seconds
SubjectPrefix                 PASS      0.91 seconds
BuildKernel                   PASS      36.32 seconds
BuildKernel32                 PASS      31.16 seconds
Incremental Build with patchesPASS      46.26 seconds
TestRunner: Setup             PASS      524.19 seconds
TestRunner: l2cap-tester      PASS      17.65 seconds
TestRunner: iso-tester        PASS      16.80 seconds
TestRunner: bnep-tester       PASS      6.73 seconds
TestRunner: mgmt-tester       PASS      107.16 seconds
TestRunner: rfcomm-tester     PASS      10.41 seconds
TestRunner: sco-tester        PASS      9.90 seconds
TestRunner: smp-tester        PASS      9.86 seconds
TestRunner: userchan-tester   PASS      6.90 seconds



---
Regards,
Linux Bluetooth


--===============3897012838915046096==--
