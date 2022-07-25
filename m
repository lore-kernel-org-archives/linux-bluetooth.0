Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A954C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jul 2022 09:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiGYJJQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jul 2022 05:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiGYJJP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jul 2022 05:09:15 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87B2140BD
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jul 2022 02:09:14 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h132so9811204pgc.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jul 2022 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OKFGRdkTo9G6v41ItbIm+4yia/M07YHNAm57oySPXfs=;
        b=H3P4SwXZ/FyR5bze6oiHK+HlICemLTOwb4hqH5d6TSWxy5yL+G3VcMulXfMVyXy2Cm
         2GGUMyXrwy0WnQKZAcvN4cmaeBkEc5XEOBMM/xKv1VRB1nO9tcqldxnODEIG6q7cohlN
         PKWwoNyT2DXLyyM+GL1fd/G1HN7akSz00fdEBwKwtWmyj0DgIEIw0Cyfhw1wMbqCsHyA
         +Z4JN4Gkmc6HVvdhs/MKUuqoNpI5qiaPCzWvoW2Q3SCSl2XGsYACr8UQXODcvtlSPXTO
         e3RPK4LVZqHoOPsbV62xFc3G5lVvPPqb5MKNcP8ge/e0ZbWnXWIsw5LJn28IwAdbP6pB
         nJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OKFGRdkTo9G6v41ItbIm+4yia/M07YHNAm57oySPXfs=;
        b=vW7nvl0DBBN65uwFCxD/5Z5VoRs1kYSZJc+nPRun5U8stNjyeQ8PoDSFDd6glPcOfx
         G8BWg3Ul+03vPcReQ/2qONvKrbQ/jJmvzs8+vbiscLEb6F5h1+qgnxxm0lNi1qL3QeRR
         X0RK4sDW0hKRdVuPHNIKr5KRqpsBPHGf33BhaqqRidzQXSq4Ls12dfVQ3kgCJgO9ZP/6
         FZF0Fqj1kvmemzF20dQjK13mv7wZ+XEe4b2gj6vMnTde6o+IUritPgKqUzaQ4BhUpdWH
         yww7Ammmvwm9W2sJtrgmZq8uiUxiZ1y0d5IjLlxryChuyFYv442XsTMXnqZt5NcsfVza
         6G9w==
X-Gm-Message-State: AJIora+6hlRQD1m2d2qztmhD6ydZo3ZFCx1D8TIIN+f1zoO0DlBLGh+V
        G5/noI4nlsF5YMJQSyHzVd8p1yFI05k=
X-Google-Smtp-Source: AGRyM1vxxWS0pu59ZMjV1FEGv3MWdqxLAebAXrFx3Cfs/qM7GsNBiBOuch3Kiqih518NoTqq5yTvDg==
X-Received: by 2002:a65:57c2:0:b0:41a:ff04:694c with SMTP id q2-20020a6557c2000000b0041aff04694cmr3202511pgr.573.1658740153965;
        Mon, 25 Jul 2022 02:09:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.48.162])
        by smtp.gmail.com with ESMTPSA id u5-20020a627905000000b005259578e8fcsm8981050pfc.181.2022.07.25.02.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 02:09:13 -0700 (PDT)
Message-ID: <62de5db9.1c69fb81.8e4d.db55@mx.google.com>
Date:   Mon, 25 Jul 2022 02:09:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6347737316644493555=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michal.lowas-rzechonek@silvair.com
Subject: RE: [BlueZ,v2] mesh: Set global bus earlier
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220725080549.4163484-1-michal.lowas-rzechonek@silvair.com>
References: <20220725080549.4163484-1-michal.lowas-rzechonek@silvair.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6347737316644493555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662693

---Test result---

Test Summary:
CheckPatch                    PASS      1.01 seconds
GitLint                       PASS      0.54 seconds
Prep - Setup ELL              PASS      32.04 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      9.73 seconds
Build - Make                  PASS      736.69 seconds
Make Check                    PASS      11.17 seconds
Make Check w/Valgrind         PASS      294.36 seconds
Make Distcheck                PASS      246.27 seconds
Build w/ext ELL - Configure   PASS      9.89 seconds
Build w/ext ELL - Make        PASS      90.77 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      495.61 seconds



---
Regards,
Linux Bluetooth


--===============6347737316644493555==--
