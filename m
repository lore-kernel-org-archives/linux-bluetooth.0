Return-Path: <SRS0=UgXA=AK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD30C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC64E20776
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 23:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4O3iYRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgF2XRg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgF2XRf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jun 2020 19:17:35 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF37FC061755
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:17:35 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c139so16909776qkg.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 16:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=If8BED5CxUbyr2Nlg7+BlGGjcspyE0m9D+qYhSZYdPw=;
        b=Y4O3iYRgl75pX4RMcXpWzwLyL0WgGGWO7wKd7Ho/1QHBbLqgJUl6MBQTkFt6P6FXDd
         CsN9y3Sa7OmXOn02nbu0ZqPdDv8YF5jdTsy3+B8mh1mMK7cpjIj/9p7VejrTz7AMl5nf
         9F7JY4qEO0kZJirM0g4//XMdBSLNcMyXTlXLP9zlPN2vuLAmU2DskpJALnMaZdzJ7DyJ
         WZ3UZsSboQ4j18kT1NJMhSyH0kZIgjqjMk/6lnG7WP8TtJ3pm30r+DhV67AcmcR7l2Cr
         gpAFqj0HxdFLnwEo0t58/LNvSWcYsx3CjsxINzoyRAcRgxPfmzgE0NJH4hAvUS6f0K0e
         RCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=If8BED5CxUbyr2Nlg7+BlGGjcspyE0m9D+qYhSZYdPw=;
        b=LhXvUQD9zWqz8oqadCDkFCSRue13t2nL04h+gvFq49VvwhLBasjx5IeIlj5KdDITcS
         TFdL9feJhABTvauAx7q0WZRxwtHCvkVMxdVNnq+csY2cwGXRYnKk2nc/U/lYRzczL2dz
         3nHgYXBXi2lqY3zJGjuUaJ9FJl3LIaeyw+ubIIM3q5PbGgTPIzVnjUktiqbvxxFJicaz
         RGhj0roST3NhvvIw+zykucyPzZTFPvz0qbLZ9AusBK2FF9iegLBU95Jp8yfhnF2Ikzpv
         oyb3oX8EjtLPYfmQriLJaCNz0VXIokPjLGWUyN7AQFuMHkPGGVie16LzoE+c3Aqszr3m
         LfVg==
X-Gm-Message-State: AOAM530mCm+lbLzhz1oe8h96w10akp4W9gQ7fwB3iPS3s9eczcxpHrhv
        6CHesysJrIGbQf7fSQmw+AG/r+nIdgo=
X-Google-Smtp-Source: ABdhPJzOfFnGwt7z41cAS8Pl74dYsL/LKpfZVaSU9XtwdhQ4RphXLWn9WPtNd6F53xboNUFne0WMww==
X-Received: by 2002:a05:620a:10a4:: with SMTP id h4mr17054251qkk.320.1593472654869;
        Mon, 29 Jun 2020 16:17:34 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.198.18])
        by smtp.gmail.com with ESMTPSA id m14sm1578774qke.99.2020.06.29.16.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:17:34 -0700 (PDT)
Message-ID: <5efa768e.1c69fb81.40c6f.7950@mx.google.com>
Date:   Mon, 29 Jun 2020 16:17:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7808158541305794472=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@chromium.org
Subject: RE: [BlueZ,v6,3/6] device: Support marking a device with wake allowed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200629160206.BlueZ.v6.3.I1b0ff04f458fdaec2a193d27c2b94ce8f2cc4138@changeid>
References: <20200629160206.BlueZ.v6.3.I1b0ff04f458fdaec2a193d27c2b94ce8f2cc4138@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7808158541305794472==
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
WARNING:BRACES: braces {} are not necessary for single statement blocks
#259: FILE: src/device.c:1389:
+	if (wake_allowed == device->pending_wake_allowed) {
+		return;
+	}

- total: 0 errors, 1 warnings, 414 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============7808158541305794472==--
