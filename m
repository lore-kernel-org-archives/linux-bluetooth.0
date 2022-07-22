Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A071C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 22:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiGVWIU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 18:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGVWIT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 18:08:19 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB1A2316B
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 15:08:19 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f14so4673947qkm.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 15:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=dpuJ2qQB/uFo/enlVrd3lk9BCBSyIteaqH5i5lWeyLs=;
        b=OCMrBPm4Ltd1TzRU4v3qVJ959ijTWkNdPmtbL1hxD2zuBVUafi3ZiAwmvfK9AyVhg7
         t6GrhBv2Rt7Dl0nf3UFyVLRfgvaDsFO/4zRJOVYml1JbbO+gebLti9/xqRAi044MGrYu
         myQgwI1i5e6V9snmGdPX7QrX6YPcDArjgln8qpNhTNrUwYWdjXxZLSE6mj2OPYHAYT9G
         IA7MEplDV3jvTnByTmzjjO1oZXjMPtCesph/skuL5g9bNknBXWASQy46E6ak2I4iHYCc
         CxZoystr+Qa4k9PQTPlYze5xgYJtS96pz9h3p4kES7SSlOdCeejMOlu60ZqdZd0+v1oZ
         A1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=dpuJ2qQB/uFo/enlVrd3lk9BCBSyIteaqH5i5lWeyLs=;
        b=fxk0lt/qeD4Q+wtlvfY2uSV4mukVvH1KwrPE6FDAqoJ0M/bdKNaCG9u8GHzIq0hnOs
         6tO1Ie6RhqYw7GDPG33t1YwUDTvCG22CcbHHFIya+K9oIYzkAQsVCWVsVSYXYqawwQr/
         IORKNUnPzzPjv3hsNija+zIYCe5nyg9wNAfW8vgN/WImD56c8Ue9O1Yp6O0dfwpe2tQw
         FFLDyx9xQqpna227Y6F0NCLAYZGkf3AQu+sNI4v6ZzuTCIVQsEI9II4S+Ns9AufZ2De/
         +nUOWVhIKPC/C6Yv1/e/VWFKi1w0NUeQSfGpDzfuo8VXd71XWnoZXugRpul84h7EZGt7
         2vRw==
X-Gm-Message-State: AJIora9Ok6CYgonUU5g0gmjMpdu14oHcj46VX2OVjIUYz728zreBipk/
        xxVw5OZ/KctbO21OmYAxxjUV9GL8lSBXLw==
X-Google-Smtp-Source: AGRyM1uaQYfQtwUXhMQlmJPYbuINcEYa1Muh+1L1UqDPHwfUidP2chqhxy4GxlWBy1ken3KhPqmE7w==
X-Received: by 2002:a05:620a:4444:b0:6b5:f7a0:ff50 with SMTP id w4-20020a05620a444400b006b5f7a0ff50mr1642721qkp.211.1658527697931;
        Fri, 22 Jul 2022 15:08:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.172.126])
        by smtp.gmail.com with ESMTPSA id w24-20020a05620a095800b006a6d74f8fc9sm3798247qkw.127.2022.07.22.15.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 15:08:17 -0700 (PDT)
Message-ID: <62db1fd1.1c69fb81.4ed7a.bb16@mx.google.com>
Date:   Fri, 22 Jul 2022 15:08:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0670426525972186141=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v2] Bluetooth: btusb: mediatek: fix WMT command failure during runtime suspend
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <d78a3734ffb59fcb1d19bacf59d217957d7b4091.1658515026.git.objelf@gmail.com>
References: <d78a3734ffb59fcb1d19bacf59d217957d7b4091.1658515026.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0670426525972186141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662359

---Test result---

Test Summary:
CheckPatch                    PASS      2.01 seconds
GitLint                       PASS      1.05 seconds
SubjectPrefix                 PASS      0.84 seconds
BuildKernel                   PASS      38.91 seconds
BuildKernel32                 PASS      34.50 seconds
Incremental Build with patchesPASS      56.52 seconds
TestRunner: Setup             PASS      571.71 seconds
TestRunner: l2cap-tester      PASS      17.82 seconds
TestRunner: bnep-tester       PASS      6.83 seconds
TestRunner: mgmt-tester       PASS      112.02 seconds
TestRunner: rfcomm-tester     PASS      10.18 seconds
TestRunner: sco-tester        PASS      10.01 seconds
TestRunner: smp-tester        PASS      9.95 seconds
TestRunner: userchan-tester   PASS      7.01 seconds



---
Regards,
Linux Bluetooth


--===============0670426525972186141==--
