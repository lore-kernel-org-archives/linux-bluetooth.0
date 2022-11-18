Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D38BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiKREzc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKREza (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:55:30 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F891A181
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:55:29 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-142612a5454so4110685fac.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JIRTRrqFYP7beV582oac3sb48pPBd950SIXBlgSRGz0=;
        b=o6MNbW1VdkHZ07zRJguKKX/pO6vt5sdlRgpJu1+Xu6WNM2sUnzD+v7QtOg1hxCtkYv
         Fh6nf8WlsTjBttX6YLextsQKaUlXTqxKqcQ4MQ/ksQDa0l+1udSOOtTgVKCiqvH6lhY4
         SV2VcjRIcaooZ6tKh4pzrFsnvPhJ6PKJVbg6ZvJ9kUU0WLr3JNOd7ogWRnYt7pjKrnT1
         MK/cM412i1q/lEJeeAUH6MnRTSyXactTQ8koGGMS0wZzeguHNIdjQzUQx+lijHPPejcB
         W9nnmLFiP82qv6DPgPEu3u1Htyopik9mAKPZ5Q9pRcw1IKQXV7YEypM0c7poEvIJKHys
         AYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIRTRrqFYP7beV582oac3sb48pPBd950SIXBlgSRGz0=;
        b=nNQBBb+8+uNkz5LOz8to2zFUqzGqUzf0d2aeoMbittFr+GBQsdeahYshJO6JRm1isx
         2dR0MkJabVbWcD/qIIBRWw+rGIml9CrXGhSPLpPc8m9A2z+Ip2q0Z4jH+jop22cc5Oer
         ZUq5yUjNhXcaU1fchyJuY618iO7d41eucDLjAuv0vFKm0flb48pXsxFU7slxyQY+BsqC
         RrsdVgcS7Aa8TIW/TXphj/36ZYS+GIB2LmxaIA3VYEveTflBokpkhboqt8KrokFd60me
         /zxbz7wuat6S9FFh6zL8ojAnVxHiTQSgv92qhjsbOob24D6Kv0KgAZVFkddfGkARufIB
         J6jw==
X-Gm-Message-State: ANoB5pnzVio/Xhs8t5jNH8Q4FSaPlU9DN7wMg4+T4t7Q/m6O1ktH/xI9
        At4LS8xl626pPcbNuC6/nGaQ6ipDJsE=
X-Google-Smtp-Source: AA0mqf5icOz38oOrOhjDsQREtEJmfYWbjxYLoi8jvgBDtjHJwXlVvky0pyWu4h8JdmYiq3w1nK57vQ==
X-Received: by 2002:a05:6870:d985:b0:13b:6d76:8bcb with SMTP id gn5-20020a056870d98500b0013b6d768bcbmr3063531oab.281.1668747328406;
        Thu, 17 Nov 2022 20:55:28 -0800 (PST)
Received: from [172.17.0.2] ([40.84.147.36])
        by smtp.gmail.com with ESMTPSA id z19-20020a056830129300b0066ca61230casm1160544otp.8.2022.11.17.20.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:55:28 -0800 (PST)
Message-ID: <63771040.050a0220.9d978.5517@mx.google.com>
Date:   Thu, 17 Nov 2022 20:55:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0744926573693001895=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052513.57081-1-hj.tedd.an@gmail.com>
References: <20221116052513.57081-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0744926573693001895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695796

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      31.60 seconds
BluezMake                     PASS      952.30 seconds
MakeCheck                     PASS      12.31 seconds
MakeDistcheck                 PASS      171.07 seconds
CheckValgrind                 PASS      285.72 seconds
bluezmakeextell               PASS      110.43 seconds
IncrementalBuild              PASS      772.26 seconds
ScanBuild                     PASS      1176.42 seconds



---
Regards,
Linux Bluetooth


--===============0744926573693001895==--
