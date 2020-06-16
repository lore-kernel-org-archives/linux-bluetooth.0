Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EF8C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 10:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C77020707
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 10:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFJYxjcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgFPKH4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgFPKHz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 06:07:55 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9FFC08C5C2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 03:07:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j1so9271377pfe.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=FAWKaUVV2261wffuy2/hxVDqWdsecafZN1e6ThCFKeQ=;
        b=mFJYxjcmggrrRJNARJee43trnUgCtJwJTgpUkagONTLhSIbSLhQ5yGCOWu80uKB+oO
         xatUzXaoiRMw1M0P3IVUIbqeLdi0hpVeba+JBNg4D6RLNghexQX3BW9IM8YJsjQCrVq9
         5gYEwGcJHH5ze/5TRcSop3Rl8fE/5ptCAfTXeUb+YMeXvhyJn3Ru1crtT4OC2c9cWSi8
         VDJFYtKqKK8y/lkhUT92XhpOwMhLWvHqbXMmPBUYXQXy2ZsELGZiXyUGCWjDqIulhaji
         6BaEKWqEineIfBYbcVwEqo4WphD7xMla5LJ75og0lUePP7mXUbCkl71h2ZwvPD7aO/PH
         GsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=FAWKaUVV2261wffuy2/hxVDqWdsecafZN1e6ThCFKeQ=;
        b=Zt9MvujT3gErTIfIqexEm17gnFDvstDjwMmutzVaT7vNk4OilM2quvJq9FvVnnDCPs
         DkRmOLpRrJDGMB5DJXvrgYMtZVDSBf5yORGHe94QTmUYQkvyaT9qB1HGDU6eyVJaq+0U
         Z0yubgOBcuWI5LP9DYzdhaGRKXFGPPCxoak5CzrFJFky/dDQ2jjz550qWZz0CZa/Q7/H
         fnvPh0S1oQY9owoSFX7vvc7TJXetVqfyshBLkft6xSjNvT+P+Uv7p2y7QwVofpAVWI4X
         J94DEmWpm7INXeq878QUeC1W8fjqGzsTNCnZZw2xoY/x7xNQx8H9A/84gKF1caJ5XR0h
         2MAA==
X-Gm-Message-State: AOAM531Eav466T4Ob3RhuRNUqhefc2K5VtOLPCxBDhIQMcaZde4CcQH3
        4ISwEz6+HDnkv/eXya0RlT79Iq3R
X-Google-Smtp-Source: ABdhPJwpRhnrF5BgTNgj3GlYqGxOAdawySIJfZEtSFsLydWKKXVquFaYxvwAo8Iqvw3CVIw8wA6rCQ==
X-Received: by 2002:a63:7987:: with SMTP id u129mr1427580pgc.353.1592302074959;
        Tue, 16 Jun 2020 03:07:54 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.127.65])
        by smtp.gmail.com with ESMTPSA id u20sm17687249pfk.91.2020.06.16.03.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 03:07:54 -0700 (PDT)
Message-ID: <5ee899fa.1c69fb81.4fec7.95e9@mx.google.com>
Date:   Tue, 16 Jun 2020 03:07:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7227962952878718802=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michal.lowas-rzechonek@silvair.com
Subject: RE: [RFC,BlueZ] mesh: Allow calls to Attach/Leave before replying to JoinComplete
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200616094009.21753-1-michal.lowas-rzechonek@silvair.com>
References: <20200616094009.21753-1-michal.lowas-rzechonek@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7227962952878718802==
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
WARNING:LINE_SPACING: Missing a blank line after declarations
#107: FILE: mesh/mesh.c:466:
+	struct call_data *pending_call = l_new(struct call_data, 1);
+	pending_call->node = node;

WARNING:LINE_SPACING: Missing a blank line after declarations
#157: FILE: mesh/mesh.c:704:
+		struct mesh_node *node = node_find_by_token(token);
+		queue_pending_call(node, attach_call, msg, user_data);

ERROR:OPEN_BRACE: that open brace { should be on the previous line
#170: FILE: mesh/mesh.c:726:
+	if (!node_remove(node))
+	{

- total: 1 errors, 2 warnings, 269 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============7227962952878718802==--
