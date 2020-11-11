Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49274C388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 01:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9BE21D91
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 01:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uah4vc9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgKKB2Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 20:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKKB2O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 20:28:14 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B22C0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 17:28:13 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id b16so47354qtb.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 17:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CQjRMH9hVt54jHreyt4WHkl3AOrQT81z841LxykUlPo=;
        b=uah4vc9uiSIZEtEibufiZWuBRnstDK4jhtMiT/AG5rIwUV0e+xXSpgE+/7FPqh2l5X
         eCgG02by5DhW99HOAnERJNia0p/r+vO5we3/hhHBKp9aUUHVEniuIIf0gKmXyVyxZIk4
         Myafcznt1YDLazp0pA853tqQ2/kmlD+akI4QmMWuGjKSqCsHYtrz0uTOlKIGID11UuqD
         VPAqaIb9jxcX5C3J7KEZeZgzDbfqK8WFi3gWLuaLTTapbPyYj17VviqMBp8sFKrqz6d6
         D8R9GEIuxLJWQ5EOTX/ut1LCi+vgmPMboysIRYFOmyFjacJxemZArIRtyYTDTi0Xq0yu
         GD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CQjRMH9hVt54jHreyt4WHkl3AOrQT81z841LxykUlPo=;
        b=KagZpMrEuZ+5FfMMpiIm/DT9FuId+XpdVFz10Kn2uB0vB63UbrPVEs/FlGmZ9+GrSf
         Zc8Kk6LpWEYJC2xdHyGnTtg9kiAXrnvZFAGHVtbaXx+QUJX8v4583NrU01SAnjGcXJ0i
         7VsvSEyCOhvmH57DuvV/kdAxqpx/vxRRS26kaGmvM26KkxBnhCPPbPjwBGmyx0TBkzYl
         NNO1Ecdh5SzKKCVnf5c/SNK58/yJuXbQL6ldIlXVsJtuVcRngxxseMXkQBkgOKUJp7Og
         +Tr6ylUzyrIPsDuDA4qkFWuAbIBhyoZaVzOIBgGYBz4ofeEmSCbXksq0zGFEto0z5jKk
         D94g==
X-Gm-Message-State: AOAM530BSprJoOUsHOX8TRBWEkicnnAMrNoo0/Xee0o+s/YrrD/MsF58
        54qRgI59d7E2Oogd1tSXImX7KWcQKklYmQ==
X-Google-Smtp-Source: ABdhPJwOuE9qgG8DPA5jRmzWyfxkRttlNr9zehzx1RGLXA3scjeC8NXdfg1f04qnDmNBRcJ35out/g==
X-Received: by 2002:ac8:43d8:: with SMTP id w24mr21706690qtn.55.1605058092936;
        Tue, 10 Nov 2020 17:28:12 -0800 (PST)
Received: from [172.17.0.2] ([13.68.75.195])
        by smtp.gmail.com with ESMTPSA id j124sm619541qkf.113.2020.11.10.17.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:28:12 -0800 (PST)
Message-ID: <5fab3e2c.1c69fb81.9e9fe.31f0@mx.google.com>
Date:   Tue, 10 Nov 2020 17:28:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1255734791578808316=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v2,1/7] battery: Add the internal Battery API
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201111011745.2016-1-sonnysasaka@chromium.org>
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1255734791578808316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=381631

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
battery: Add the internal Battery API
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#71: FILE: src/battery.c:38:
+static struct queue *batteries = NULL;

- total: 1 errors, 0 warnings, 215 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] battery: Add the internal Battery API" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

test: Add test app for Battery Provider API
ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#12: FILE: test/example-battery-provider

- total: 1 errors, 0 warnings, 230 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] test: Add test app for Battery Provider API" has style problems, please review.

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


--===============1255734791578808316==--
