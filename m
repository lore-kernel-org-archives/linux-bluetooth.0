Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA78C47083
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 May 2021 03:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3840D61155
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 May 2021 03:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhEXDCV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 23 May 2021 23:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhEXDCV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 23 May 2021 23:02:21 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ECCC061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 May 2021 20:00:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q25so1613284pfn.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 May 2021 20:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=N1XFefcXrQjgQulBbFpIdLb2CsgD4jtqJek3Q/5qfJw=;
        b=A/ZfOtsY4Z9knZ+TzVZO2tKMbvo3NHWAlWdLNenmaGgs+hDDx3cfkIBR2O3gYYVjw2
         n/CGKX3WyI4DFTGUaZc93XthT2cLSGBXwqcdnj8PiK/DKKIU/8C30KhCE9yQbUJS5XK8
         4off/vNeMydn7YfFrQwmP6pwqBkfaGpInuCZO90SoZZ05wWM4zW2MXO8Wvd9xysKmu1s
         veEsL+khzkO9Cv0ph/xADMthKwyba7I/06KKVAJqVJtM6Q9bDNR2fpWGb9WlPSKAAEND
         NZKnfDaYpE+V0nL3Q+bApWYMquo7SKK5lIAqnj12CgS5lKGfAm0NL0xBEP8pad/p7GqF
         NLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=N1XFefcXrQjgQulBbFpIdLb2CsgD4jtqJek3Q/5qfJw=;
        b=SIoj2bLOTF8l/VUdKZYkCBeI9Twzq2J7bfYmAH/qHGSDin5CT+fy3kSsADJGXtKfAd
         g2Nvp503XyxjHz14bPfEANlBak+1t/ejH1Nb0Ojmq7PKixCV9WXN8WkK7d1f9OBN0Cky
         1WOvnbrBI/IMh0mR74kCY5HHsRjUFIXEjuUuL9qqvmice4ANIjGtICjjter77KZoMeeg
         BLQX6N1fdrT62oxvz8lx+o2W6B/828g2mRwR6EJqEC2ljPV1Z0V7cR8rHIyPW4PiULDP
         xa7zQMr2/LMLGx1EHRkGrorVGoyXeAFXn9bpdWpC+42GK1QmetCaRR8ReAneWO2eri2d
         CSCw==
X-Gm-Message-State: AOAM531JAc/VfnHjYLMjpzkH/OyxjdQC4P1AyD9CtlFf1+uA4bA7kTQ6
        dQ4REjtZQs40mbDnjoKuUNOYmt3pXPs=
X-Google-Smtp-Source: ABdhPJxfcf1hI+dMhKk6ujW+L2N5I1p75+rS5XmeS8RcZm1G7eVEkAVt3x/bpge4AwOZzX2LKCNOvQ==
X-Received: by 2002:a63:7e13:: with SMTP id z19mr11177576pgc.184.1621825252160;
        Sun, 23 May 2021 20:00:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.69.120.190])
        by smtp.gmail.com with ESMTPSA id l64sm10441398pgd.20.2021.05.23.20.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 20:00:51 -0700 (PDT)
Message-ID: <60ab16e3.1c69fb81.2ef14.32a5@mx.google.com>
Date:   Sun, 23 May 2021 20:00:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2162241458457966003=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] core: Add RSSI sampling period in system parameter
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210524104329.Bluez.v1.1.I3f63cfa802b3602a4ddd7604acc8e886f223912f@changeid>
References: <20210524104329.Bluez.v1.1.I3f63cfa802b3602a4ddd7604acc8e886f223912f@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2162241458457966003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=487211

---Test result---

Test Summary:
CheckPatch                    FAIL      0.38 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      44.60 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.98 seconds
Build - Make                  PASS      191.14 seconds
Make Check                    PASS      9.02 seconds
Make Distcheck                PASS      238.86 seconds
Build w/ext ELL - Configure   PASS      8.53 seconds
Build w/ext ELL - Make        PASS      190.53 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
core: Add RSSI sampling period in system parameter
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#74: FILE: src/main.c:148:
+static const char *advmon_options[] = {

- total: 0 errors, 1 warnings, 93 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] core: Add RSSI sampling period in system parameter" has style problems, please review.

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


--===============2162241458457966003==--
