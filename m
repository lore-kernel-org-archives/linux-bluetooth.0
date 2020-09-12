Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E10C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B577214D8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0eNKGxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgILGvi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgILGv2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:51:28 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF8C0613ED
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:51:27 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g72so12125998qke.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2020 23:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=UNvSwneC3lW+y+Venzokn4WMeSbjIHLO72zq8UysDdY=;
        b=Y0eNKGxbw2NoO0UhyJ1OhLZvP0QE8nTFaTMN3wLp2cB6bxHMxXw7XO9ukB+oxXnjAF
         bPe5OJKVessvih5jJEDT/2FtFYivNUz4S8ddpQAe2GLaEUxu5V1TMHnq6Iu/H62nglIl
         twBuKIIPVu+AeQ1i+o7d6bUJAA+DNpwn+Ex7a5BLgSAKgQVWl9TgTKH4/GISD/neescD
         1cM4/bFKUGd7/oz55wG+tsj5ThdhGv3Xf7PijJYXF+MN6jhdDVhO1+lr1cs4aCBg6Thp
         P82/g5FDTPXswQ+3VjGgSKIz2F+mnmahmNg+J2+DOUC5jMcxVqy4r5JS2mbwm/hSYbOG
         YDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=UNvSwneC3lW+y+Venzokn4WMeSbjIHLO72zq8UysDdY=;
        b=JG0b653FmXngP2P0ylcxIP6AFLc/r4Q5nJ7bSvmJDOWXOS3lENTvJFHhNvuLZaSsOX
         laj7HsBKuTXtNyKUWuKfjRVJVXUZ9IkPXYUlyPwBYXSgtJrnZMHh9OixFxxQF3dfS/QS
         yr+jNe+FCYI1pLvVskJHJpn119oo2MD8tMFw8On4oTT+PYLVQnmAWXLSh27kiLE+zV4E
         j4Ufq7jqtNedH1m2ntGnLZ+iIuKC2wbeueUDd6WvP75mWMVIgOi+8XvNxa1tIrR5xYfh
         RlE5TzBhufvIjVv71iMv94qtWyNyUSsDtGt74DgVUXzksdLVHCwSu0Hd5HEe5POiaDv9
         X83A==
X-Gm-Message-State: AOAM532izyPkQX3MlgmaGFR1BJNyFR+kGQABfiXOMCXujblGVWV3sraL
        BaRd5p16QT9OgxDo2kTrNCAF3fNWjYRWYQ==
X-Google-Smtp-Source: ABdhPJzNJcQ1+fA1492hFnJDrG28jgCgDHaSJhIjC0OQBceFcwf3jqr6nXJwF8Gsw2dlKEuR3R48Vw==
X-Received: by 2002:a37:6892:: with SMTP id d140mr4535699qkc.58.1599893483208;
        Fri, 11 Sep 2020 23:51:23 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.17.224])
        by smtp.gmail.com with ESMTPSA id b190sm763988qkd.45.2020.09.11.23.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 23:51:22 -0700 (PDT)
Message-ID: <5f5c6fea.1c69fb81.43f41.1e35@mx.google.com>
Date:   Fri, 11 Sep 2020 23:51:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3487050300692952400=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tedd.an@linux.intel.com
Subject: RE: [BlueZ,03/17] btio: Add SPDX License Identifier
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200912062357.23926-4-tedd.an@linux.intel.com>
References: <20200912062357.23926-4-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3487050300692952400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'btio/btio.h', please use '/*' instead
#31: FILE: btio/btio.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#31: FILE: btio/btio.h:1:
+// SPDX-License-Identifier: GPL-2.0-or-later

- total: 0 errors, 2 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============3487050300692952400==--
