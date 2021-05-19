Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2417C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 01:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8541661363
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 01:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhESBjk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 21:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhESBjk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 21:39:40 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC71C06175F
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 18:38:21 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o27so11301766qkj.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 18:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=iSf8Zw8k0m4VZxm8u0p2upG279SmD5ZoLh0M059Gs+Y=;
        b=Hj3ge69B+IgTOhmhwE1RKV9L6nMJxvFUBh4NGh8TpM5gfpsGLoujzocz1mECQd7jVZ
         gRKHnCSGdoOo3flbr9yZHFzwzYhekS5XbyCerv+2sZV1xaFMEbLdHHvaau++ZG+9XVTT
         8ugol7cJTCOrzhsxH7MrXDYBwCa04Oi9xFx334DePDYO1Jg1hTpFm5izkXShJIyLoK0x
         50zY7WPQlNy4hmrtNoCF0RHq1ie9OfZZh6DTDtAOF6cZ6bWfE/SNBNj26xWwMCt2ithp
         FOXT7CWVSqz4PPGMydxkMlQMbeItFN+rD+CfTcw9sBCvgck1k0gWHuZQmKcdtTcJKiBP
         NNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=iSf8Zw8k0m4VZxm8u0p2upG279SmD5ZoLh0M059Gs+Y=;
        b=cmJra5F0lANh0MqhZ8zCHrRgzW9cCXCdywUAaIpAzPppBoYuHfRqGF1jnFg+NthK7L
         ZWPI7YOXKXfLoQivpEK2BdL2ui4klVBKPm4RfY0yzJsb0uDht3fXbKPVqXhVvNqXpzRH
         hvCljsnSD286ii5gRGCJUkTnMwa3kJNhLOdRxTKre7OIkBZrzQ/gfo300GkaDwFgeiIJ
         0NUQ5lZmxzQU4OMzlsYtoq3zTdF29YZZNkUxMhILy/9fIhfAT5X/Ae52Qi+WkWYy/LSS
         b+/0ohzPa6q3A/OG7ZT7+XdSN4LoOfDOWOuHWry2zwj1mJlymv1mIaLSHxutjIzS+Kpr
         +p3Q==
X-Gm-Message-State: AOAM531N9e46dKFwoRZetCHjbYfHv8BBXj5ef7cFtckA+JZi2vumsGVm
        /9BshuGJiIOw+s5gIrc1lv2zMPVwxGs=
X-Google-Smtp-Source: ABdhPJzi76Y+fU4vTRSWztqdgjBsHNugLNknUl+77dcWNw+CH6YPsZsDMupghojrEzxJrJn1oMmjQg==
X-Received: by 2002:a05:620a:8d6:: with SMTP id z22mr9193290qkz.407.1621388300528;
        Tue, 18 May 2021 18:38:20 -0700 (PDT)
Received: from [172.17.0.2] ([40.117.250.89])
        by smtp.gmail.com with ESMTPSA id l6sm13851968qkk.130.2021.05.18.18.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 18:38:20 -0700 (PDT)
Message-ID: <60a46c0c.1c69fb81.facac.b774@mx.google.com>
Date:   Tue, 18 May 2021 18:38:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4981810334731631331=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: OOB Authentication improvements
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210519001027.1540720-2-brian.gix@intel.com>
References: <20210519001027.1540720-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4981810334731631331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=484617

---Test result---

Test Summary:
CheckPatch                    FAIL      0.88 seconds
GitLint                       PASS      0.45 seconds
Prep - Setup ELL              PASS      45.27 seconds
Build - Prep                  PASS      0.13 seconds
Build - Configure             PASS      7.80 seconds
Build - Make                  PASS      196.35 seconds
Make Check                    PASS      9.34 seconds
Make Distcheck                PASS      231.73 seconds
Build w/ext ELL - Configure   PASS      7.83 seconds
Build w/ext ELL - Make        PASS      185.18 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
tools/mesh: Add all supported OOB methods to cfgclient
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#18: FILE: tools/mesh-cfgclient.c:107:
+static const char *caps[] = {"static-oob",

ERROR:CODE_INDENT: code indent should use tabs where possible
#65: FILE: tools/mesh-cfgclient.c:594:
+                                               struct l_dbus_message *msg,$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#65: FILE: tools/mesh-cfgclient.c:594:
+                                               struct l_dbus_message *msg,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#66: FILE: tools/mesh-cfgclient.c:595:
+                                               void *user_data)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#66: FILE: tools/mesh-cfgclient.c:595:
+                                               void *user_data)$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#68: FILE: tools/mesh-cfgclient.c:597:
+       l_dbus_message_ref(msg);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#69: FILE: tools/mesh-cfgclient.c:598:
+       agent_input_request(HEXADECIMAL, 64, "Enter 512 bit Public Key",$

ERROR:CODE_INDENT: code indent should use tabs where possible
#70: FILE: tools/mesh-cfgclient.c:599:
+                                                       agent_input_done, msg);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#70: FILE: tools/mesh-cfgclient.c:599:
+                                                       agent_input_done, msg);$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#71: FILE: tools/mesh-cfgclient.c:600:
+       return NULL;$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#81: FILE: tools/mesh-cfgclient.c:641:
+       l_dbus_interface_method(iface, "PublicKey", 0, prompt_public_call,$

ERROR:CODE_INDENT: code indent should use tabs where possible
#82: FILE: tools/mesh-cfgclient.c:642:
+                                               "ay", "", "data");$

WARNING:LEADING_SPACE: please, no spaces at the start of a line
#82: FILE: tools/mesh-cfgclient.c:642:
+                                               "ay", "", "data");$

- total: 4 errors, 9 warnings, 68 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

"[PATCH] tools/mesh: Add all supported OOB methods to cfgclient" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============4981810334731631331==--
