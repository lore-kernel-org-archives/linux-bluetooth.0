Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C835C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 18:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3AED64F1B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Feb 2021 18:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhBZSj7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Feb 2021 13:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhBZSj6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Feb 2021 13:39:58 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1F5C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 10:39:18 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id l132so8865897qke.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Feb 2021 10:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+d9UrLJmQtORl9HbVbXWVb85xVaoICh4neqo0TLs9hU=;
        b=ctlsLtqhhwoqQdD7zwsz5di4SJ9iQlrgo3SwTxWoHiW2qIw9Jqg3NiVcM9/PMXq1s/
         xy8XGk7R2vqzeNHwCs+9K1DeP3P+KEUb2HkllmkgJqigAj1U4HT21s2o+iCiuHeUZ6Lv
         K4nQPnDMzo5cN2sLgLEfn1a7foZwnqaQyxzQEv8t4L7g0S9NEJ9+XQVXcr7oWKs3+Zo9
         ydbNigW6pwREAxrkvsZhTU55UDlLxYcZ6gYcsEiK/9L+eM4qGmkUMRuAv+2xK33GfmqH
         aiEKrGLkToZt0VVWZNMKgJwEHssYQ5rlGmr+Jol9oGcNGiADlz2PRlFMkyauETF9zmuh
         P8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+d9UrLJmQtORl9HbVbXWVb85xVaoICh4neqo0TLs9hU=;
        b=AVK1FZYx3FH9rlDZe++T9AxLAWxtc7BVxPkq5Zvx68UdGqKo8o3oGHVmsh/DDQirLU
         VevqT/6JLUSbAFYBuHKy+aT2GigkKZBsAipSb9Jr+0eZpX7puf/uLwmGKVQ1Wc4bPZYW
         RwtMi1Y9fRKxULxNIB9sc+H4rP1RA1nJRa0QEGDEuF1MRC3Ngl5v5pnIwWGhStQNC9T6
         PawEeJ0XFgI1EKQpbrLdkbyf9j0qM/9nZSez9EvDPQQLHlIczeC9z6Bf2SLdrNA73l/I
         68T5y76e96D3kwTNkS192NyWiqob7h+ju0TiPgrDoJyAeisx6Cpk/L5nbpEaaVU9KIHW
         NYYw==
X-Gm-Message-State: AOAM5308a+zEkfq3UFb+qFAm0crgqULcn98pJIZiiJ432K8mZ6wspsN2
        BydVy4Zs+09aRAhtngpGGvjs8vc7njr+7g==
X-Google-Smtp-Source: ABdhPJwAJvGVtXvOm4e4f1PVGfhk9iiGndp35qMP/4B2zFu5tDoUKGaDIDhT2c3cM89QSAV4kC1Y7Q==
X-Received: by 2002:a37:a151:: with SMTP id k78mr3896111qke.359.1614364757139;
        Fri, 26 Feb 2021 10:39:17 -0800 (PST)
Received: from [172.17.0.2] ([104.41.129.89])
        by smtp.gmail.com with ESMTPSA id z5sm7017862qkc.61.2021.02.26.10.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 10:39:16 -0800 (PST)
Message-ID: <60394054.1c69fb81.8a305.bab1@mx.google.com>
Date:   Fri, 26 Feb 2021 10:39:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1115396284454684824=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] monitor: Add option to set fallback width
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210226181158.6538-1-sonnysasaka@chromium.org>
References: <20210226181158.6538-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1115396284454684824==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=439141

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
monitor: Add option to set fallback width
ERROR:INITIALISED_STATIC: do not initialise statics to 0
#56: FILE: monitor/display.c:31:
+static int output_width = 0;

- total: 1 errors, 0 warnings, 107 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] monitor: Add option to set fallback width" has style problems, please review.

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


--===============1115396284454684824==--
