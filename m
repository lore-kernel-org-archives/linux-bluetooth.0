Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC33C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 03:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1ADA20738
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 03:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG7iqi6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgKQDve (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 22:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgKQDve (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 22:51:34 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A3DC0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 19:51:33 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id x13so9998112qvk.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 19:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3eON0OgQK3LjkfPq3MQ6DQe6r+k0CRZvZakF7tBluXw=;
        b=SG7iqi6FMEnqFSFwxarQZ8sIzxtm5y6lNkWAy1WGoUO+jsB47HE5O06FFPbaRESwhU
         N7I0HJpMyhumIjKOzd3T9LbpJV5QrkmmE0AlEgFave2MAnir593CVVX6Ppn+pCEbGaQT
         QI53SX9KvxhIk1Ek6ArycK16RQ3lLk7ff9/Z+jBvp+/4GJGy9qV6HqbzqHu5pISpBF0K
         5RKigf5APuMY7VEyayUBH5Zu5EvhTQT9Uk757unN+7KW49ypPIcVi0jQc85KXk3SLNcT
         YL+PUupx+1UD5DG95Ug9/rBVjjUFcxK/UNWBEjnJKlywzvaIwoGFx8leHnqgb23FDSyR
         AOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3eON0OgQK3LjkfPq3MQ6DQe6r+k0CRZvZakF7tBluXw=;
        b=QIMF7ORAco4pTwe9MVTUcWHz1oVByrEPtzsn7YcvEO9PSQVjhi9Wf9I6SxOxfhBB6s
         a3qpf1rv50BiyIJsUjODwqimO1EX14X6x4ZFxaJ5JSijpb+Pb9oE/RLicDdZ78jQWMrt
         Ej460Eojj2UByDRQhOCVjJG/ozGdFadhb7hAfhRvC2FH3tEmcUYE1dWmy3PY5aCh9KXq
         6K+oIXStFhAwvfXuTyRRYcyeMAQ4V6AO1FhpbuyMAOamM/GnAEjXa1lYDptiOEo0BVrX
         o2BHseLlxiaad/qei1HJPdQhZdbmu07fn4uyxo2rQ+QOaonA4DoudTYj6WkIh1GG8qmI
         SZ6w==
X-Gm-Message-State: AOAM532uvuBvbPYe5fBLhM+LGLRUlMF50wqugfpwAF6LhqiS0xlXcLBP
        VyknXvWECYsV3Ng3o5LKuv0Vpv9MFiKwUQ==
X-Google-Smtp-Source: ABdhPJyiN9YHGPeAg9aHiYzunwOhYFE4SvmTq26H90PiWXXFDbYEF+k/7/dWenffqrfnd7HVQ21gZw==
X-Received: by 2002:ad4:4807:: with SMTP id g7mr18364066qvy.26.1605585093131;
        Mon, 16 Nov 2020 19:51:33 -0800 (PST)
Received: from [172.17.0.2] ([40.71.210.121])
        by smtp.gmail.com with ESMTPSA id j202sm13425451qke.108.2020.11.16.19.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 19:51:32 -0800 (PST)
Message-ID: <5fb348c4.1c69fb81.28ffb.f988@mx.google.com>
Date:   Mon, 16 Nov 2020 19:51:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7019094892774708034=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jingxiangfeng@huawei.com
Subject: RE: Bluetooth: btusb: Add the missed release_firmware() in btusb_mtk_setup_firmware()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201117025917.168761-1-jingxiangfeng@huawei.com>
References: <20201117025917.168761-1-jingxiangfeng@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7019094892774708034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=385635

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
Bluetooth: btusb: Add the missed release_firmware() in btusb_mtk_setup_firmware()
1: T1 Title exceeds max length (81>72): "Bluetooth: btusb: Add the missed release_firmware() in btusb_mtk_setup_firmware()"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============7019094892774708034==--
