Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEB5C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 17:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D8C613AF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Apr 2021 17:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhDERFp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbhDERFo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Apr 2021 13:05:44 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D211C061756
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Apr 2021 10:05:38 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id j7so9008345qtx.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Apr 2021 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=AiCi6C3t+NvLstvs15N8IRxGUltqtal0Dc3G40D8xVc=;
        b=Pp2TJjQpJH/u+qtouecpWtvsAC7UZJnXuq1xTqLYhmWrH0KUttkJx5xBQYw1a4KobC
         oANhCVc+xw8ptX+1fcYdNRJjHIelA3xtxNtzXXoFQQmtmRNYR2/j3WUAbIVrsYwi9k1p
         AyCsBcMITOtLT2hE4QQ692JER0cn+mWrIJPbVH5YhTqkjdjs2XUlx6uwDqO9mVBRPDC+
         ez4D0kdBlL2Lq8UT0kStrsUJhzMa9GVwEv9DwNlFGr5D+iuHtbMT8smkkT5s+optk7+V
         BZJ/spNIB7L3x95dxgnz440GQaYMht7tJ9X1+rJV4V1juxF9R4X6IFu4l4x7evYRPjcO
         28Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=AiCi6C3t+NvLstvs15N8IRxGUltqtal0Dc3G40D8xVc=;
        b=LWQ+9/4B9Jn8i8TIzr+TDR8KfqIy/+QtmywyzQYKoATmvlJvQ3eHgSptytVvxxFhvR
         t+TbnQiYBIgRCBpiS+YFlNvO3i2HXIQkI+yvdg2Q+9xFcqKmrdP4ZCAgyT6ZlvpX/kqk
         Fc2PWVDyUDqIXgCXFudF/tai3jcQPU8qUnt6h1UiJSekmCTimGu5RuWdvJHRSTSs9W5p
         7xlIiqmcIaA1EpYXeu8ngvzdQvEmgw2vU0yS/PYygD8npJ1VZadSKF2EYqCoziU78nBZ
         OBxRLPWyaE0iDtKibsQWdcNmiU+xK45DD/niNtoRQ76pvMZv2yTZwM8/HglXRUW/orF8
         PymA==
X-Gm-Message-State: AOAM530hFvr62saSmcSWUzbGUHvrU69Za5/6ecaader0VBNpA6fEszzP
        7ewR9ujlzdKR7sBO3M0JpQSee0amj7I=
X-Google-Smtp-Source: ABdhPJyXbjRBOo8sMP/2o4sUszJv6qzYSj3OMkXY3l+4zvZz+BHGuBoSPYsfBPepm0hVeu4UKCxvnw==
X-Received: by 2002:ac8:5fc6:: with SMTP id k6mr23502058qta.206.1617642337449;
        Mon, 05 Apr 2021 10:05:37 -0700 (PDT)
Received: from [172.17.0.2] ([137.116.81.155])
        by smtp.gmail.com with ESMTPSA id b22sm14345303qkk.45.2021.04.05.10.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 10:05:36 -0700 (PDT)
Message-ID: <606b4360.1c69fb81.5078.ff09@mx.google.com>
Date:   Mon, 05 Apr 2021 10:05:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1001474014883542330=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Framework for non-interactive mesh test
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210319203825.459070-2-inga.stotland@intel.com>
References: <20210319203825.459070-2-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1001474014883542330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=451875

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild: Setup ELL - PASS

##############################
Test: CheckBuild: Setup - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS

##############################
Test: CheckBuild w/external ell - FAIL
Output:
/usr/bin/ld: tools/mesh-cfgtest.o: in function `join_complete':
/github/workspace/src2/tools/mesh-cfgtest.c:703: undefined reference to `l_tester_get_stage'
/usr/bin/ld: tools/mesh-cfgtest.o: in function `dev_msg_recv_call':
/github/workspace/src2/tools/mesh-cfgtest.c:967: undefined reference to `l_tester_get_stage'
/usr/bin/ld: tools/mesh-cfgtest.o: in function `attach_node_reply':
/github/workspace/src2/tools/mesh-cfgtest.c:630: undefined reference to `l_tester_get_stage'
/usr/bin/ld: tools/mesh-cfgtest.o: in function `import_subnet_reply':
/github/workspace/src2/tools/mesh-cfgtest.c:579: undefined reference to `l_tester_get_stage'
/usr/bin/ld: tools/mesh-cfgtest.o: in function `create_appkey_reply':
/github/workspace/src2/tools/mesh-cfgtest.c:480: undefined reference to `l_tester_get_stage'
/usr/bin/ld: tools/mesh-cfgtest.o:/github/workspace/src2/tools/mesh-cfgtest.c:356: more undefined references to `l_tester_get_stage' follow
/usr/bin/ld: tools/mesh-cfgtest.o: in function `main':
/github/workspace/src2/tools/mesh-cfgtest.c:1411: undefined reference to `l_tester_add_full'
/usr/bin/ld: /github/workspace/src2/tools/mesh-cfgtest.c:1415: undefined reference to `l_tester_add_full'
/usr/bin/ld: /github/workspace/src2/tools/mesh-cfgtest.c:1419: undefined reference to `l_tester_add_full'
/usr/bin/ld: /github/workspace/src2/tools/mesh-cfgtest.c:1423: undefined reference to `l_tester_add_full'
/usr/bin/ld: /github/workspace/src2/tools/mesh-cfgtest.c:1427: undefined reference to `l_tester_add_full'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:5884: tools/mesh-cfgtest] Error 1
make: *** [Makefile:4058: all] Error 2




---
Regards,
Linux Bluetooth


--===============1001474014883542330==--
