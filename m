Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC84C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 05:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJRF5s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 01:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJRF5r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 01:57:47 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0637A75E
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 22:57:45 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u71so12447962pgd.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 22:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UiOrV1tp5kPODEJ+KU+BCJQj/7nuOVA6umbM4+n8E5E=;
        b=kKP2dxLBYGqW2RHWiEbukA9DT0kSr4UpenjPjnp3Ucma0CAdq5Lzl2Vn3qdOusxABq
         O3rqfE3YGoq0HOTfSklZCyhcRJyubdogDaQ3MkuqRlXVbRA/yPNuQOy5Kc3h0iV2jEh+
         dI9p840FyymwscjtoFHL4tHoNWwjt0GjJxeGnl528ArgrI2nBTem+P0Cs7/O+RtsxZzG
         tLtBkPHEmTsiz4wJKkgp78RuPd/fapqn0IyIkulAV/GOg5oQ+1xgqMyxDzCXrjEZeQgI
         EjILnmZCz8ZbuqRq36io7pzFxp5ulaGv8n9JYj91j13RpEAxsyJad7MN00yJqEDmcJVG
         e6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiOrV1tp5kPODEJ+KU+BCJQj/7nuOVA6umbM4+n8E5E=;
        b=YhCY4MSROY0ZzD72LuXo5oTWugI77x3Uh5N40kllExcKe5gMb5woBvxCZP2A2YDKiH
         FBteIcAh3Q+Xmk+CFf+OqgKmqu6pOKj1hRbGZBCJ7lzmeEEpQHxVNG+QuF+2kj4A0D03
         QlqSdou1kg6SbLmO1L/f2DUTKRHzGtQWomsvPsFzyr2eI6goh/TTbU42PUq2il6k8Z1h
         K7qCMsGwgp6mKoezNnjV0m5H4smg7Htg7zzCiRq+bFYrOVtUTokplFpQYgHMaq5MFlj1
         Sl4LEi9xOgiR8g1TZGb1bQmOMBa90R5Xpog7zWn+hjzO5YmL0BBy7bGzbNosLI5dNOf1
         YWmQ==
X-Gm-Message-State: ACrzQf043PWFI/lJuhA4qLWPUK2raqQH2Ali3irRkgeBGjRGqIatS1gd
        Gk+Xhu9gQJoKc5K3jLgxVA/YlrkfJzM=
X-Google-Smtp-Source: AMsMyM6v4zJpFbkcd2WYZHH5dNpnWQOS175wpTF7YRyHVCFSnqf+XRMVoOB5KBMC+cbfLLIYEkLuHg==
X-Received: by 2002:a63:4426:0:b0:464:4e1d:80e3 with SMTP id r38-20020a634426000000b004644e1d80e3mr1350208pga.106.1666072664722;
        Mon, 17 Oct 2022 22:57:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.58.124])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902f64400b00176b84eb29asm7554931plg.301.2022.10.17.22.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 22:57:44 -0700 (PDT)
Message-ID: <634e4058.170a0220.1eb9a.e583@mx.google.com>
Date:   Mon, 17 Oct 2022 22:57:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2763416975088214346=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhay.maheshbhai.maheta@intel.com
Subject: RE: Media Control Profile Client
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221018043831.342821-2-abhay.maheshbhai.maheta@intel.com>
References: <20221018043831.342821-2-abhay.maheshbhai.maheta@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2763416975088214346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=686077

---Test result---

Test Summary:
CheckPatch                    FAIL      5.01 seconds
GitLint                       PASS      2.26 seconds
Prep - Setup ELL              PASS      31.91 seconds
Build - Prep                  PASS      0.84 seconds
Build - Configure             PASS      10.04 seconds
Build - Make                  PASS      1158.38 seconds
Make Check                    PASS      12.30 seconds
Make Check w/Valgrind         PASS      334.76 seconds
Make Distcheck                FAIL      13.08 seconds
Build w/ext ELL - Configure   PASS      9.88 seconds
Build w/ext ELL - Make        PASS      102.37 seconds
Incremental Build w/ patches  PASS      488.91 seconds
Scan Build                    PASS      1179.75 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,v3,2/4] shared/mcp: Add initial code for handling MCP
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#1533: FILE: src/shared/mcp.h:14:
+#define __packed __attribute__((packed))

/github/workspace/src/13009893.patch total: 0 errors, 1 warnings, 1552 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13009893.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: Make Distcheck - FAIL
Desc: Run distcheck to check the distribution
Output:
make[2]: *** No rule to make target 'shared/mcs.h', needed by 'distdir-am'.  Stop.
make[1]: *** [Makefile:11483: distdir] Error 2
make: *** [Makefile:11559: dist] Error 2




---
Regards,
Linux Bluetooth


--===============2763416975088214346==--
