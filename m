Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51024C433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6B720738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdlp+htH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbgFVXrh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731038AbgFVXrg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 19:47:36 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D479DC061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:47:35 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h23so6983163qtr.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rrgx3QzLafDFLlvI6ya1xil1HwEXXTrYfRGxcCMQ3io=;
        b=tdlp+htHXgttsUjWLOF4HgPBaOR6r/w0jDSjSF/9BdaZ5rUUn75na/JiXQRaM5OaAF
         SVBIMEjfZYp4Wy17rKw63fufSKt6lrxfCXaT3WMCLRC1dosYnNgpd1xHVYH51dsG7Cru
         hCGfxL5jSOmFJxgjiCai8skUb7qUF5cjQLABeTwzIdwWkXzLoCGxIDptW2q2MSnsHfir
         dcsKOlBgav2b+jlsPIXEK9hJDCTRQZ19b/pFEinH5WTVHX6HSH3ODIwqAqkJDV0LyYfK
         sSJQ6E7IPwuttPnTsrnysVelhs5cFb4Z6Rnq7VSOOgkHnFVJXAvSTsb8Y66SmAfAQ1fi
         KSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rrgx3QzLafDFLlvI6ya1xil1HwEXXTrYfRGxcCMQ3io=;
        b=tHIQZy0Jd87ozM+jrX7P+mHszpS7171Vq/OmeLwg1+jnGpqdkWa33G2M1k0mn+1mkM
         gwZw+39DZcdUyxFJ6n9/EJCXyyTFms2EiWMgu+ObMfBQN1P5bSofCMqJStMTvgxuPUH0
         Vyq6KxXEPFtUpZToq3BccIgoqjJrxSQ63KySGP8C62pO6oGAqLVJt+wcKZB7+6SbtMmD
         GvMxQZx3epWjbISE3kS1fxObxdoJ7wUA8aXVO5ozpUYSluRzr4TaI85GcY1qdzkk9Nbs
         erCcTa0zuE92nWimTJfB3E13+8hAk0RUFsEXfSAAKgfBp29JclbcgwxU/PLKe98BiWk2
         9dQw==
X-Gm-Message-State: AOAM530EHl4flaK+C35Hwpp5vAMX8Ewsc0sauBx450Rxnd2JgIaws758
        kCLaMQJyQXIBcubr35NyHq3BCiW4wKg=
X-Google-Smtp-Source: ABdhPJzOa+sPYTGxmCNz23lYw51C1m6oJVrgziSNQTu17UdXfW6CcQZ4WM7Yz5zAvb0W5LRkRCrZ6w==
X-Received: by 2002:ac8:1304:: with SMTP id e4mr3379640qtj.24.1592869654976;
        Mon, 22 Jun 2020 16:47:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.9.213])
        by smtp.gmail.com with ESMTPSA id x4sm15883664qtj.50.2020.06.22.16.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:47:34 -0700 (PDT)
Message-ID: <5ef14316.1c69fb81.1c0d5.c627@mx.google.com>
Date:   Mon, 22 Jun 2020 16:47:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7957446438671994022=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@chromium.org
Subject: RE: [BlueZ,v5,3/6] device: Support marking a device with wake allowed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200622164003.BlueZ.v5.3.I1b0ff04f458fdaec2a193d27c2b94ce8f2cc4138@changeid>
References: <20200622164003.BlueZ.v5.3.I1b0ff04f458fdaec2a193d27c2b94ce8f2cc4138@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7957446438671994022==
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
WARNING:LONG_LINE: line over 80 characters
#66: FILE: src/adapter.c:5130:
+			"Set Device Flags complete for unknown device %s", addr);

WARNING:NEW_TYPEDEFS: do not add new typedefs
#175: FILE: src/device.c:180:
+typedef enum {

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#351: FILE: src/device.c:3286:
+	 * Otherwise, we enable if profile supports it. */

ERROR:OPEN_BRACE: open brace '{' following function definitions go on the next line
#368: FILE: src/device.c:6702:
+uint32_t btd_device_get_current_flags(struct btd_device *dev) {

WARNING:BRACES: braces {} are not necessary for any arm of this statement
#400: FILE: src/device.c:6734:
+			if (flag_value != wake_allowed) {
[...]
+			} else {
[...]

- total: 1 errors, 4 warnings, 390 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============7957446438671994022==--
