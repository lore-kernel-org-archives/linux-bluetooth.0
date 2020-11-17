Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985D4C388F9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 03:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B46424694
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 03:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETvMRGM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgKQDRC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 22:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKQDRC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 22:17:02 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB43C0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 19:17:02 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id d9so19216258qke.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 19:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=MkCfMdOcj62u+3G/JLhv+hs9m4UV+2+RLyX4/oubm7k=;
        b=ETvMRGM9Ftp2a/BaYC/0LvOAu87ZpwBTASgHk9Slneo8sIsYDPF+UJGJq/RcH824jS
         4fOVu+YsQI1f7PaVZYsgxnnuEfxtZg4Wonv6T41mKXgr7IHyiIwhjIR2N0fBicNhulir
         rT2eSeuZADgEjqFvQZ5eJNDdPlqrsWbqLn7Qhojl058C19h7aKeF2M1TG5f75iglna2U
         jaNgJTjQFjnbZ3+WbXHU55W44sLDxPmayqwcQ8O9o8PFXuLV2XEJiPfsctb/Kry+Y0m6
         mBPBoi4GoxTLey3sa6cSNX67j+bJ8WkkBDjzD2yHpCMnleFwRZFy7mhN5eX00p77SBkL
         IGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=MkCfMdOcj62u+3G/JLhv+hs9m4UV+2+RLyX4/oubm7k=;
        b=UKTFmDReAbRgVUduC5v0ZrkOoodBRaf6HLFYEW+xJP6zNJUX2X6tgKrMGe30Yds/XZ
         ITi1ixdPpcl3jagtCqgJs0Pd53kc7LGPFC+bWZdasF/JB8IRibXPcrv6sZ0GhINdF3b4
         490KBEMlFEJtxFm94jCBPTFn2wYvRxa7MnOTHX8CZS86dggrvEXMA3p29LADueFYZY/S
         jsP1NTxEestbUM9K+7PplAmQ2dcWBIeg/tzYQVqNoAuGpadZ8aejpI4+Yl2OjEZosEwT
         5gQ2792pQTstN/ZmsHHKe0ADr+0Baq9rwnzJUmx/x03uJsng5vtYuVtiqbdgW/k5z9qY
         hWnw==
X-Gm-Message-State: AOAM533zbuFCn+TtzwewWAsfAFOqy1aBTnKdiI+zEbVRxYPCEg4NhEnB
        dAB4Ibi4aHMjhzTDhB2wZGlbNGLpecSiEA==
X-Google-Smtp-Source: ABdhPJw61yL7wWEiIYsa+zhjEwV4DOfqqWHPFtDEfcU1FdjqIjx7m+BMCdbwJvHy611IBuxWUWhCTA==
X-Received: by 2002:a05:620a:1087:: with SMTP id g7mr17547185qkk.457.1605583020932;
        Mon, 16 Nov 2020 19:17:00 -0800 (PST)
Received: from [172.17.0.2] ([20.36.206.99])
        by smtp.gmail.com with ESMTPSA id n21sm3570438qke.21.2020.11.16.19.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 19:17:00 -0800 (PST)
Message-ID: <5fb340ac.1c69fb81.7cd1f.7b10@mx.google.com>
Date:   Mon, 16 Nov 2020 19:17:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7438779654736696587=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jingxiangfeng@huawei.com
Subject: RE: Bluetooth: btmtksdio: Add the missed release_firmware() in mtk_setup_firmware()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201117024332.165771-1-jingxiangfeng@huawei.com>
References: <20201117024332.165771-1-jingxiangfeng@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7438779654736696587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=385607

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
workflow: Add workflow files for ci
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#20: 
new file mode 100644

total: 0 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] workflow: Add workflow files for ci" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - FAIL
Output:
Bluetooth: btmtksdio: Add the missed release_firmware() in mtk_setup_firmware()
1: T1 Title exceeds max length (79>72): "Bluetooth: btmtksdio: Add the missed release_firmware() in mtk_setup_firmware()"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============7438779654736696587==--
