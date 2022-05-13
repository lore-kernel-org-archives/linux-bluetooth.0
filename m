Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 04:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376923AbiEMEFE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 00:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiEMEFD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 00:05:03 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E98E27EB9A
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 21:05:02 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id n8so6248163qke.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 21:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nkIbkpVwl/lj9pW5IZKa09QV8Z4Iho7mant5ibA9j4Q=;
        b=aOi+Hdh9D1uibDlKsh57KzLUdPH9TWWU9dzPiQU++tZyt4B/oBreH7Xm05xmbTypSx
         5aKwvM05OD5y4GokD6GZyB/17Q2n6wjqkGPTG3sjd+su6mhmH9aRpgr41iRznWdAhmR4
         9TSt+UBRR02X9JfTKOxbUBjjSjUYCWqV+mMb215pKltIXY/1P0qOABz29KMYI9Zd+fst
         jBXDJlikhb4JC2u523kPwZ3rSr8/NzwWFD8E4HKvch5aGLYYHaoUCITAg+oR/p9hXdvO
         c6xxEipyqhjpAX9piHc6O48WTzWxx2eIhLxf9uWCSwe8CNxCC70aCSomqnU3piZXiH0k
         N41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nkIbkpVwl/lj9pW5IZKa09QV8Z4Iho7mant5ibA9j4Q=;
        b=EYSWxGezAaNo7DcVNmwsiAfZ4b5jYvosqF9eIbedPHrVaE0Pae7ZzRBjKRT+k0pyx5
         bGlrqtPS2jMGhTbe9KZfsuFPASAzEH6K1msbwiRDsOlni+xw3V95awMiL1Bv48ZImTqj
         X8Oq1gM/8YHwLJRu3ytcGHPdN/U7OnE/0BF061ExnS0iS9KeK5YXJri2g/k9sEy4LFzE
         wAQcoII56xlI+nkK4Q6nZkRMIyHlmT1HStp8E2qy0Hl6XW8CYgTSS0VfQeF4ZGqAwWgy
         brVcLiaID/1CKzh7cvpw/nOR/aYhFJqs+ZM2tor1enmcnQSu9bpZXcCEbfus+o0D5Sdj
         erfQ==
X-Gm-Message-State: AOAM533rchGdmtbPR5yDCpLs6w3+cZreQUsohJBrIiZ8pQUbS5l+VdQo
        +Nad8fIKkL3bkZyeBkF4i5qARMULQSo=
X-Google-Smtp-Source: ABdhPJw+tcZFqLcrjOxR7tNrW8CD3w/eHqmVXsGQ+cThuJxTqKbSC6w1AHUGLFuCaayFwLGu/WXhvg==
X-Received: by 2002:a05:620a:2588:b0:680:f657:fbd6 with SMTP id x8-20020a05620a258800b00680f657fbd6mr2270303qko.287.1652414701017;
        Thu, 12 May 2022 21:05:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.30.89])
        by smtp.gmail.com with ESMTPSA id 16-20020ac85650000000b002f39b99f66bsm831151qtt.5.2022.05.12.21.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 21:05:00 -0700 (PDT)
Message-ID: <627dd8ec.1c69fb81.61251.50ba@mx.google.com>
Date:   Thu, 12 May 2022 21:05:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2642295234559280797=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] device: Fix enabling wake support without RPA Resolution
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220512234835.1042988-1-luiz.dentz@gmail.com>
References: <20220512234835.1042988-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2642295234559280797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=641190

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      1.05 seconds
Prep - Setup ELL              PASS      48.28 seconds
Build - Prep                  PASS      0.88 seconds
Build - Configure             PASS      9.59 seconds
Build - Make                  PASS      1686.51 seconds
Make Check                    PASS      11.78 seconds
Make Check w/Valgrind         PASS      479.73 seconds
Make Distcheck                PASS      257.98 seconds
Build w/ext ELL - Configure   PASS      9.27 seconds
Build w/ext ELL - Make        PASS      1677.27 seconds
Incremental Build with patchesPASS      1693.25 seconds



---
Regards,
Linux Bluetooth


--===============2642295234559280797==--
