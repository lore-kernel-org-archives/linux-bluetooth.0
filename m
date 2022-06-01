Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D00FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jun 2022 01:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348994AbiFABdq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 21:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348996AbiFABdo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 21:33:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC6A5B3F9
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 18:33:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u18so377928plb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 18:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2WgqDEPakmAi2/CM4fgEcIAwBVivVgEhhxAgRB3zERo=;
        b=UH7dWbQ4FvWuxQtPJgnmy8uoDYiEMomJijUAIKk8iQW4OIXaLg+V2XavGANYUl3Rhz
         2tVGMLK6076UBjW7tlGW//dIriEKJFURqUm7C1DiJeOmZ9FILxsW+WKHqzkcRShzjSN4
         +h1zrL27+lIzIWSS0il2I/HCkU8OH6mjQ7TThC2/AwMOjbhL7fZjmkwUnJcQJW/XI2kX
         jBulCU+XjR3WPPlpRUZMC49g4iefhuErSSZGbZRo74C8ZcVr6XX28YBA6bPjqiegzZ4G
         bRSG824pOKuJ1ToQ/OcXZ9VnroucvVBHljAzvohUsyEXk1cuyYv1kXDlkrXth5K++x9Y
         5ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2WgqDEPakmAi2/CM4fgEcIAwBVivVgEhhxAgRB3zERo=;
        b=gVV8hNtEtiUciErvaUeJ5OMUFVn9OgNX8Q/iFWrI4wPz5QxVIQ7g7v2M+qGqFxSv9+
         phNIfK42Ayjc7mQjdZE0NKSHRmaEERbWX2/9L9uLsu3koV/k4MvcJ+8xmfRY7PwpSyle
         Miaj60qYE1MsV4FxvE1IpjhtyoFeNqF8cV8yRCq/vXlgabKLjdOhvdvYE8eSGsbDLKpd
         U2mI0T77hJj9WhcSId+qLurzS7OHrK3xklqaGjr+1yhRZZSvuOYYQEcBBZrfG1q79aby
         3V4yKM/uvjAiHyWGgrfaCSpUufRwL5WMWbVSjzp53wwVZmhU5FwY6agAqUJzWxi/undi
         W8Gw==
X-Gm-Message-State: AOAM5323vxzmJNVoMkxzDzhBvepZ32sQ4beviam2x0CyXXfjrZzLez8h
        D2h3YlPFGejMKqhVDDIG14Bj5s/HPp4=
X-Google-Smtp-Source: ABdhPJxO8qGMAJXGkJyvj8lj5MTRn1tey8qI2hFJtxkZpZCD77J781rqLqZFfCVb57MFiFlL68cibQ==
X-Received: by 2002:a17:90a:c202:b0:1e2:e772:5f0a with SMTP id e2-20020a17090ac20200b001e2e7725f0amr16141078pjt.109.1654047222751;
        Tue, 31 May 2022 18:33:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.38.175.43])
        by smtp.gmail.com with ESMTPSA id je21-20020a170903265500b00163b02822bdsm163042plb.160.2022.05.31.18.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 18:33:42 -0700 (PDT)
Message-ID: <6296c1f6.1c69fb81.f40eb.0c55@mx.google.com>
Date:   Tue, 31 May 2022 18:33:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3329708944159671157=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5,1/8] lib: Add definitions for ISO socket
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220531205509.1062466-1-luiz.dentz@gmail.com>
References: <20220531205509.1062466-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3329708944159671157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=646365

---Test result---

Test Summary:
CheckPatch                    FAIL      8.95 seconds
GitLint                       PASS      4.40 seconds
Prep - Setup ELL              PASS      42.79 seconds
Build - Prep                  PASS      0.49 seconds
Build - Configure             PASS      8.37 seconds
Build - Make                  PASS      1401.49 seconds
Make Check                    PASS      11.78 seconds
Make Check w/Valgrind         PASS      447.86 seconds
Make Distcheck                PASS      232.37 seconds
Build w/ext ELL - Configure   PASS      8.50 seconds
Build w/ext ELL - Make        PASS      1382.27 seconds
Incremental Build with patchesPASS      11273.15 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v5,7/8] tools: Add isotest tool
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#1222: FILE: tools/isotest.c:1106:
+		/* fall through */

/github/workspace/src/12866162.patch total: 0 errors, 1 warnings, 1219 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12866162.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3329708944159671157==--
