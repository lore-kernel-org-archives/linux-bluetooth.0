Return-Path: <SRS0=NBlN=DW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C0BC433E7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 03:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAB02075B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Oct 2020 03:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrTqpfyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgJODuK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Oct 2020 23:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbgJODuK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Oct 2020 23:50:10 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAC8C061755
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 20:50:08 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t12so2565507ilh.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2020 20:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=M+HxzCKDR5Mdns2txIQ76OKDuqkfiRNsRcWF2pgzBWM=;
        b=RrTqpfyzU31xDCckFyxYs7wv9vCf0eYa7aIslayVyG4XZ9cIG14gf/y5780qCrd6/x
         YTifk6ipU8pTY/1ZWGZaphSDO3ycz/b/rdi4/UcAhkSmcaBH2JPANx6quTb0Rz51YNd1
         zh4jQbH7NZy23TbL8w9ATnDDanJQhhvWFnncm+fDoVy7KOofLj1laISuXKdon0ADfBRs
         Aqjhj4P02fHtcL7FOZN3MKkPqihVFOsgHiXFizugWPiboZqvncaFO6YsrPEcdG41qOW6
         uzbRN6msdSGRBZOPrj72PKx/RVsJVI3QpuYcoYJJreHm5HNx8pdGKIW2XgoEopT8cg3M
         ODnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=M+HxzCKDR5Mdns2txIQ76OKDuqkfiRNsRcWF2pgzBWM=;
        b=L3yVcm4WYI3sscJatndDBWPQbd8EaWMZoMW2CvCyT6fiDU6/J3+1WJeFTlAtXjgw/n
         QudezdKwKtDZCHTKMApybks6xWSRdhKIpkaG93eDco08wZDkGU/eCG0GdinyM3Lsxht6
         QBwkj7rvrRL+t3O4vzL2LiiomV7lrRb6zbyInjlbdPwTVk+klgv7WvnCcU7k+fUhEOFP
         P1ZOqgfJ/E9/TeZ8n9Hj5ANZlop4UW/ApMVIAL+m+CA9AWzFAAK5XAqYyIgGV6BVAPR4
         mMOwfi524drwxc8EvMpRu7HgPQsBQP3t4fpXJKKTzbkl8+04RdggvCnvvM4K+sr94Bsy
         7vQw==
X-Gm-Message-State: AOAM533+pPfpULsRoTH2o6JOKeupZkzLxtaqbyXJ8h5hngX8aHrf1B4Q
        s5WgqDfcTwetNt9dvlYvLL7QG0YJe8o=
X-Google-Smtp-Source: ABdhPJwFFTXYhtfc2IATHFtWLY6Ch1zKybMG0v8Z08jkouWvxJcQId1dxfHPSSYF66w+ouy2PQtw6g==
X-Received: by 2002:a92:d850:: with SMTP id h16mr1670743ilq.281.1602733807551;
        Wed, 14 Oct 2020 20:50:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.252.60.59])
        by smtp.gmail.com with ESMTPSA id y12sm1417000ilk.56.2020.10.14.20.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 20:50:07 -0700 (PDT)
Message-ID: <5f87c6ef.1c69fb81.a4e81.aa6b@mx.google.com>
Date:   Wed, 14 Oct 2020 20:50:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7576170092869495906=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [BlueZ] core: Add support of variable length params in mgmt_config
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201015113406.BlueZ.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
References: <20201015113406.BlueZ.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7576170092869495906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=364843

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
core: Add support of variable length params in mgmt_config
WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.br_link_supervision_timeout'
#132: FILE: src/adapter.c:4231:
+			sizeof(main_opts.default_params.
+						br_link_supervision_timeout),

WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.le_multi_adv_rotation_interval'
#200: FILE: src/adapter.c:4268:
+			sizeof(main_opts.default_params.
+						le_multi_adv_rotation_interval),

WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.le_multi_adv_rotation_interval'
#202: FILE: src/adapter.c:4270:
+			&main_opts.default_params.
+						le_multi_adv_rotation_interval);

WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.le_scan_interval_autoconnect'
#214: FILE: src/adapter.c:4276:
+			sizeof(main_opts.default_params.
+						le_scan_interval_autoconnect),

WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.le_scan_win_autoconnect'
#227: FILE: src/adapter.c:4283:
+			sizeof(main_opts.default_params.
+						le_scan_win_autoconnect),

WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.le_scan_interval_suspend'
#240: FILE: src/adapter.c:4290:
+			sizeof(main_opts.default_params.
+						le_scan_interval_suspend),

WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.le_scan_interval_discovery'
#264: FILE: src/adapter.c:4303:
+			sizeof(main_opts.default_params.
+						le_scan_interval_discovery),

WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.le_scan_interval_adv_monitor'
#289: FILE: src/adapter.c:4316:
+			sizeof(main_opts.default_params.
+						le_scan_interval_adv_monitor),

WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.le_scan_win_adv_monitor'
#302: FILE: src/adapter.c:4323:
+			sizeof(main_opts.default_params.
+						le_scan_win_adv_monitor),

WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.le_scan_interval_connect'
#315: FILE: src/adapter.c:4330:
+			sizeof(main_opts.default_params.
+						le_scan_interval_connect),

WARNING:MULTILINE_DEREFERENCE: Avoid multiple line dereference - prefer 'main_opts.default_params.le_multi_adv_rotation_interval'
#487: FILE: src/main.c:376:
+		  sizeof(main_opts.default_params.
+						le_multi_adv_rotation_interval),

- total: 0 errors, 11 warnings, 551 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============7576170092869495906==--
