Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7710AC432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 23:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C4DF60F91
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 23:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhH0X4K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Aug 2021 19:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhH0X4J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Aug 2021 19:56:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1408CC0613D9
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Aug 2021 16:55:20 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j1so5584127pjv.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Aug 2021 16:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Q29JPdd0UXEXLxDco3aU/7qf3VIAIliSlmbiacUAHKQ=;
        b=m/8t1aybcOtgyuWow52ICMJyPBzg83Fk82WH6wsVHJia0O9R8HIrk5B8Hzrd5wEcf9
         s98E6s+CVymDS1nl5pElX6CaJYCERFahstRJ6xuZAE/adyBuqfafog6Npz9DojHltSlH
         IXAgXvmHmvcbCLe2f3Ar6PAC6YmCurpciC2eUSxU6uH3WXY3mW+2K/7rH1oszLBORxfb
         RLBuAGDD+15h975nIn907WvchNEAUvQ7H5h8UnptzWKOHCuaxTspp7M1W1676REAtGeP
         g565jlZYYYR0OoYQ/5t4hPLCUp4S6lUy3cAqxGJq7ymOEnSq+YKHtIy/lKm8/FPubCnI
         gbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Q29JPdd0UXEXLxDco3aU/7qf3VIAIliSlmbiacUAHKQ=;
        b=lVCI9/kPIcAwksXHXwx/BChDCFf3OVkioAvU6EGGSWCqhRsgSBa0AosbrgUlQdlABq
         AWEETQxa7OZAAIyQj4E0ZI3GiXkelH1m4xMebM/AdJBfsh73qb+5La56A4qdjK+6bz7c
         AAQE4zQijDGaHL74QQnBaxoeTycuFGLP7juo/nFfK7XNOwFgjd8BtXgCAKv0KFMRsNYD
         Clf29MKZy+Yfpk9Cdt2WV5d3ol/KbmqqnurkDZMPoDLru+rwZQRvJfl9MSt66Ty3t7WF
         z9ZJ/L4oJx3rk98ccslLZrymDVKeAqtW8h4DmyvpZ3VV7rLTWJiTPKJT/ztwPyv7Ooso
         5v2A==
X-Gm-Message-State: AOAM531LcmYXuhbWHRz5Hk+rK2qDgmrEnZWHouOUWuvdkO0tZXBUSTzH
        tupLFpZ6NcdS74zNzgCMPwMos8D6pOw=
X-Google-Smtp-Source: ABdhPJy81ISiqfPMJ7yH5wE4fOK+r9vC5Vg6E3Z1+VDPyp9xxAmvEUZPYxYEJfcWmdr+5znb2spqTw==
X-Received: by 2002:a17:90a:b00b:: with SMTP id x11mr5231972pjq.214.1630108519280;
        Fri, 27 Aug 2021 16:55:19 -0700 (PDT)
Received: from [172.17.0.2] ([52.156.116.96])
        by smtp.gmail.com with ESMTPSA id b20sm13016836pji.24.2021.08.27.16.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 16:55:18 -0700 (PDT)
Message-ID: <61297b66.1c69fb81.f3a8e.27eb@mx.google.com>
Date:   Fri, 27 Aug 2021 16:55:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7628003814137210834=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, david@lechnology.com
Subject: RE: [BlueZ] device: add MTU D-Bus property
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210826164211.2936133-1-david@lechnology.com>
References: <20210826164211.2936133-1-david@lechnology.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7628003814137210834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=537891

---Test result---

Test Summary:
CheckPatch                    FAIL      0.41 seconds
GitLint                       PASS      0.12 seconds
Prep - Setup ELL              PASS      45.55 seconds
Build - Prep                  PASS      0.15 seconds
Build - Configure             PASS      8.05 seconds
Build - Make                  PASS      198.09 seconds
Make Check                    PASS      8.91 seconds
Make Distcheck                PASS      234.38 seconds
Build w/ext ELL - Configure   PASS      8.19 seconds
Build w/ext ELL - Make        PASS      186.01 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
device: add MTU D-Bus property
WARNING:LINE_SPACING: Missing a blank line after declarations
#62: FILE: src/device.c:1481:
+	dbus_uint16_t mtu = bt_gatt_client_get_mtu(device->client);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &mtu);

- total: 0 errors, 1 warnings, 56 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] device: add MTU D-Bus property" has style problems, please review.

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


--===============7628003814137210834==--
