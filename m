Return-Path: <SRS0=Tswr=DN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EBBC41604
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 16:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5064A206F7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Oct 2020 16:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLJcwZ49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFQiQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 12:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFQiQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 12:38:16 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AC7C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 09:38:16 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j22so13547316qtj.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=9OFZ4VimKVBAYGcG91zZnTjUMWxVOcW28fWbW/tfXcU=;
        b=JLJcwZ490wgs3yZoXPVQyCMlYx6WGYV0nyEV30b6pEtunndvGAii4B78+wJCqZrPSd
         xbmA8NPpNPgbWhdMAYk6oUSSZljLf4eISEckYssS511kDsbwPGCAw0h4WynpHxkZCNtp
         2v3jlVZTYISaTPMBbrZNtKvjpTpWaym5eN710QlkduN9ud3eFvq5hrEVqJe5Gju5KREX
         4bfKRrmU/LwMvsSnPaANQ9u3V/aR0WuXqVI+R/9YqABuk+KavZYToXT/9T6fG7NbFRyy
         j54KXInpTiUzRJ6ODDhnljz3mzTVJ+tcTgDA7Oc+y3ZNgsb568ZvKUVHgQPlIFkDmc5P
         zUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=9OFZ4VimKVBAYGcG91zZnTjUMWxVOcW28fWbW/tfXcU=;
        b=qmdkIvMlnoBSUrjUIR6Diy//srhPtNsoJII9oIg2ZNrY8hN7VcwDRtYx0D6ohTkF8Y
         4E3b65Nl/tLcdUM8YqNnaKOBQX/cJf9wRO9Y06b+QxgOY5hLtMm6QrnTk87ZAYIw3k+V
         p09PUKpekDIsHKgc5LrAZm/1AcUiHWkJkCN1DW81SVftdRQtZukVehtB+YZ55VP08lvN
         NqFDBN/as7PS88a+R/w1hUmLcj7VbFmdwrUX/BiG6rXZGlynn29oJVEw2tqLtN8t7I5V
         qbopKIVcQnO3wAU/sv6zkX0uPyfN4xXxDgDYEnJyascrC8p19ijYzMZ+CX4GQvwEP9Hh
         O6aQ==
X-Gm-Message-State: AOAM5322lc6WAsJwwXctg+xwpfcE4jb904jShny81hwcxbLmL1XjGLPZ
        HdGY4SLw/K++BLxJDjDgu/4OLE5G37nyhA==
X-Google-Smtp-Source: ABdhPJzdJlREEgol5UqfoeChKtmTy8FMSgcEkewoTI+fW77shRgWvprd9pRVhTQ9rD6XnppV3Kf/Fw==
X-Received: by 2002:aed:24c9:: with SMTP id u9mr5984931qtc.292.1602002295731;
        Tue, 06 Oct 2020 09:38:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.32.191])
        by smtp.gmail.com with ESMTPSA id q6sm2793375qkc.85.2020.10.06.09.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 09:38:15 -0700 (PDT)
Message-ID: <5f7c9d77.1c69fb81.532c0.5527@mx.google.com>
Date:   Tue, 06 Oct 2020 09:38:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4413864590256458257=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, henrik@grimler.se
Subject: RE: [BlueZ,v3] tools: fix forgotten index->mgmt_index renaming in btmgmt.c
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201006155034.126914-1-henrik@grimler.se>
References: <20201006155034.126914-1-henrik@grimler.se>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4413864590256458257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=360353

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
tools: fix forgotten index->mgmt_index renaming in btmgmt.c
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#12: 
                                config_info_rsp, UINT_TO_PTR(index), NULL)) {

- total: 0 errors, 1 warnings, 11 lines checked

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


--===============4413864590256458257==--
