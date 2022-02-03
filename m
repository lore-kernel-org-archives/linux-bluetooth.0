Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC1BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Feb 2022 15:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351701AbiBCPNb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 10:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351694AbiBCPN3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 10:13:29 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63141C06173B
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 07:13:29 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m7so2729117pjk.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Feb 2022 07:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=e8r/qPy4xiEC5v8Opo6Cug10Q5WgTRGOwx0c8CBSSII=;
        b=EeFuNBtLOPJGnmyhw6gFlz4LmmLNk8ERzl/aO2qjggB+sqxAFlhtd5fB/ykIAOYlSe
         28gnO/YqZDb+XWT5YcPMdl71t6brk16d3eR7sTnPrObgRDgcMjpmNZRpEemt3il8Y23j
         +0OlrxR3nSeKdJOzRJeRwQCHxLhZUm4WPmhqyJcDhclioHR3hlijgFJxRiwIqHWd1p6J
         XbPpesXRLgDv+z8YGtUNu506bWTsjIYErg920ceH/Zz/12VRRwN0bVit53Srs9lSZTet
         LnlQgyFjKbER0CDivEFRdXpC1pe9cBM8GQBLwS+/L1x89Fksr/2Oh9MTYNYOKACw2aEA
         DKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=e8r/qPy4xiEC5v8Opo6Cug10Q5WgTRGOwx0c8CBSSII=;
        b=jEgsLTjwA7+zXC5cOVWrpvTDqPdRo2Imjsjaei9JNVzdM4ryFSXR+Wszclg2hVzwqE
         sc4hO1/4pSBLLSM4v62Vdpp6gXhzROLy1WJo2vUw9qwOnyr7L5W8320ITAuguGAtpxZ4
         2w2XyhYmdEanxenYQSsRecYkzI4lHU1Rr+muI/msoLSLCjEewChmLtyur2royFuQpEpT
         FUsACAr1OfpoChkgqkUMtYTjDONKVPSawvx+qhe2pWRLnyRY9kf0b64TMzoUMG0IJyMi
         N7J7W0KBoY23jD5Mc90Y+Ki9C9f27Bn1/c1Rk9TAaKeD2B3K7Kh79W3uPJtPVoHsWK9W
         udRQ==
X-Gm-Message-State: AOAM532ZZl4+m7Xub48m9WChoutF6pkp6o4scqfpNWKlkYUTY++ncJpH
        Gw0LNrQbgzpxUY3oaFtRO9AKWjFq7DfWlQ==
X-Google-Smtp-Source: ABdhPJyYs4z+ZXWxQE5NxgOlUvlMm31ruz3MlKP9fl6vftaSfojmhysCZ0Dz0mtlwaR3Bt8MH5RxcA==
X-Received: by 2002:a17:902:bf06:: with SMTP id bi6mr35964296plb.24.1643901208615;
        Thu, 03 Feb 2022 07:13:28 -0800 (PST)
Received: from [172.17.0.2] ([20.190.48.242])
        by smtp.gmail.com with ESMTPSA id h18sm29925145pfh.51.2022.02.03.07.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 07:13:27 -0800 (PST)
Message-ID: <61fbf117.1c69fb81.bc54f.d5b3@mx.google.com>
Date:   Thu, 03 Feb 2022 07:13:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4216640843539718419=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michal.lowas-rzechonek@silvair.com
Subject: RE: [BlueZ] mesh: Allow mesh-io to use dbus when initializing
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220203141234.710019-1-michal.lowas-rzechonek@silvair.com>
References: <20220203141234.710019-1-michal.lowas-rzechonek@silvair.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4216640843539718419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=611014

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.37 seconds
Prep - Setup ELL              PASS      41.12 seconds
Build - Prep                  PASS      0.42 seconds
Build - Configure             PASS      8.06 seconds
Build - Make                  PASS      1205.09 seconds
Make Check                    PASS      11.08 seconds
Make Check w/Valgrind         PASS      405.96 seconds
Make Distcheck                PASS      212.16 seconds
Build w/ext ELL - Configure   PASS      7.76 seconds
Build w/ext ELL - Make        PASS      1143.43 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4216640843539718419==--
