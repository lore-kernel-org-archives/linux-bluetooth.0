Return-Path: <SRS0=Ypkk=IF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E143AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Mar 2021 09:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A5365012
	for <linux-bluetooth@archiver.kernel.org>; Sun,  7 Mar 2021 09:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhCGJhi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 7 Mar 2021 04:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhCGJh1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 7 Mar 2021 04:37:27 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B2AC06174A
        for <linux-bluetooth@vger.kernel.org>; Sun,  7 Mar 2021 01:37:26 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id n79so6504755qke.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Mar 2021 01:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Lz/9ZkzdPvzLd7K+Eu21ZShOIrBL7yRljH0WYM3zwMw=;
        b=m1m42D7Lh4RtYo/cSXAwzStxSKFJWBgDWMrw9Gf9KvlFmYXQ9aCdF1bOlMefoNTjJM
         ddt8cbwupeeQ9PjCZu3pveZSevlZAXPN+MTxMf+F9/QDZ8cUEH6ahAY/PVFP0Kzqv0rC
         EUbzVAtQa4mCq4lUe5wr7DwUZLBX03+pu0PTiybzJ8wbQrjy0bzdU0nFBinMAshXTb6T
         uxbqOB3N4liz3gvFrCeOPot7cx1AuQ2fZI47PmQjRD9COUvRdpI3RyC0JSWq9kY+B5zd
         XqF6unmyjR/OlFlDc8+uZKJNImflOHdoXh+XRyjuhUFYMM5Wxky7xu8Zp97ttQmLMFE7
         dHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Lz/9ZkzdPvzLd7K+Eu21ZShOIrBL7yRljH0WYM3zwMw=;
        b=t5a/6SP9oqXkR4TmCWM69W2XVEIt8nN7CoTmAFhcHb2ZXvFWajuxO/UYDbGbIkhMhF
         e4tldFatYdxHIqlyHZgnic6xdiV5y5up2n8tQkFyQZxoOhqI27jA8PlwpDwSCIFpgIVo
         NDBlO3WFNZvxMqkTt4Rh9RdNkcEijktVXZG1IdZJh9ypl11QcLMTaYgaeGrkjAGPa/QD
         5F5OQFLln2V14NwBqyzfHlIfdQ5drZFmh6lr0eYtt2DwhQduxSHCJBjBTWYUfjLd/Ajt
         ZAnEDI09H2s0sJ3ly7baVJBT4nIKz9ZPTO2uKqCCDiCdBEr+e5ftNI20GKSA7EvNOnuE
         rc6Q==
X-Gm-Message-State: AOAM530z5cJZuz4zPJYq4PY0p1riiqwHZxMNtNlPapapuCWb6KZvOHJK
        mYBfcBmY7E0hqJCpFPCwV6IUNnJLBGF1lg==
X-Google-Smtp-Source: ABdhPJyVoryWIgFA8k92l/I61LAFfxYrE4R0MPrIHktQ8SUUuwn/IKtOiFi+J3F2uDG3q2AFQwg8wA==
X-Received: by 2002:a37:5f04:: with SMTP id t4mr15756610qkb.440.1615109845978;
        Sun, 07 Mar 2021 01:37:25 -0800 (PST)
Received: from [172.17.0.2] ([52.247.70.55])
        by smtp.gmail.com with ESMTPSA id u13sm5468967qtq.87.2021.03.07.01.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 01:37:25 -0800 (PST)
Message-ID: <60449ed5.1c69fb81.1e850.17f8@mx.google.com>
Date:   Sun, 07 Mar 2021 01:37:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0863816076525415376=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] monitor: Fix decoding Read Local Supported Codec Capabilities
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210307091845.13269-1-kiran.k@intel.com>
References: <20210307091845.13269-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0863816076525415376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=443331

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============0863816076525415376==--
