Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A978FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 22:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8690361207
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 22:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbhIPW5p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbhIPW5p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 18:57:45 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7EC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 15:56:24 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id cf2so5266366qvb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 15:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=cuNQuaOXm3p9hMMkQ34qtA99XJYiLOhN/oGj1nGHyB4=;
        b=C3CA+aVn9bEBpOKVOmBVB0kpc80atBNvpuCyePyOMdDJ1C+kXq/i5kHnDQx0EZAlqS
         bKRflZWUYaDhmn/lOm2aROzW6jQ5hPF615G6FgNPL3dFJzL3HLBnCQ0UGMn5QcC5ZQ62
         l1JF4FeSsUtDOnrn8eBWjhtsI+rZ8pvwglyT/xKB8vD9jVbZIFtY3HcgBXL0xZoqr/IT
         UlNqBFz7e+ahlF86Ocg2U4Nu9qkbyiJb74EMWO0LNjXxUBv31TCtgLS4XSQIKISAdREH
         uV36oK/RxoSul3rqKiVz/gDiEP2bnPE76fvYtPQ29HuyA6ZHfki2UysdeZPwH56/xchE
         5c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=cuNQuaOXm3p9hMMkQ34qtA99XJYiLOhN/oGj1nGHyB4=;
        b=NYiu2TJqTljT3yENplTnk34Nb+uxWB/nYXMGst9Rt9o3zOmfNl9fFC1wY2gYKlStf3
         oBX6V4sAazOpnDKBwWCZKPNh5Hx8aXBIHug4I0nbbwhk+M4SZdJKJboz6mahI1PFoz8h
         SvYNpqcMN2qIEs0yRyvAopukl4+CJYyi5j4dzkcc+d1X/weyTweZwOu8NL58iKol6sSJ
         50fL6GybgIxf+Sj5ncL44Wqw3g2gSYxn0HNHTNcuBlW40nAQWbZiSSk2Ay7bPT8mpY5k
         qpgKYB/9/S8rL3t8MPQ76s43h2vEqpHJ97Pec/qM1RL9uej7jy0gXxh7veXa3JiWtJGo
         qCfg==
X-Gm-Message-State: AOAM533cEaIhNl3Ha68K8d00vdy5Wl8ipNaA5T66X7+MVDIxcmYW9411
        OQVzLMYt6w0Qb7rmUyAPUG6Pk//6xRrJ0g==
X-Google-Smtp-Source: ABdhPJxFPvgZASRbyTN0cfD+LdElqLlNaSLs+apBWW6O9iO9VwDB77/kR5G7KJbo7qDEb5FxhWCNkg==
X-Received: by 2002:ad4:5541:: with SMTP id v1mr7891525qvy.49.1631832983245;
        Thu, 16 Sep 2021 15:56:23 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.87.138])
        by smtp.gmail.com with ESMTPSA id h66sm2819553qkc.5.2021.09.16.15.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 15:56:22 -0700 (PDT)
Message-ID: <6143cb96.1c69fb81.835d3.667e@mx.google.com>
Date:   Thu, 16 Sep 2021 15:56:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1232142574061235386=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] admin: Fix leaking uuids loads from storage
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210916223825.276530-1-luiz.dentz@gmail.com>
References: <20210916223825.276530-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1232142574061235386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=548487

---Test result---

Test Summary:
CheckPatch                    FAIL      2.78 seconds
GitLint                       FAIL      1.90 seconds
Prep - Setup ELL              PASS      49.13 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      8.99 seconds
Build - Make                  PASS      211.41 seconds
Make Check                    PASS      9.40 seconds
Make Distcheck                PASS      251.47 seconds
Build w/ext ELL - Configure   PASS      9.15 seconds
Build w/ext ELL - Make        PASS      199.07 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/2] admin: Fix leaking uuids loads from storage
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#93: 
   by 0x494C024: g_key_file_get_string_list (in /usr/lib64/libglib-2.0.so.0.6600.8)

/github/workspace/src/12500439.patch total: 0 errors, 1 warnings, 40 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12500439.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,1/2] admin: Fix leaking uuids loads from storage
8: B1 Line exceeds max length (83>80): "   by 0x494C024: g_key_file_get_string_list (in /usr/lib64/libglib-2.0.so.0.6600.8)"




---
Regards,
Linux Bluetooth


--===============1232142574061235386==--
