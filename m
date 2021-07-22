Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DA5C63798
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0786B61285
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 06:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhGVGEu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhGVGEt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 02:04:49 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B2CC061575
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jul 2021 23:45:23 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id a10so2141035qvj.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jul 2021 23:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=n77gpZdiQx2XoJxztEWy6+tMhTq5Fkas8RaOJhWCSKI=;
        b=KUq7ZstHal5P8z1N0mA8td533geUYkfLQEkIAhrl8fGskTu7yue2AbzrIUkzkSKOKx
         iE7WUctMG+zAY+JAIJ5qAqI7cLetaDtaM37wv4nhKTtqlnO33Zimt4+bA2qxccWnsqiQ
         Q1ggwzjMS53J6qXc3vn5yjWp21z8JKuB0S3h2Cs6quTyFj9HzFphX1B6XTvZ55omX3jf
         M+XY9uKRCw7KjzVLZ2GphRZfTbpxPs1ZskWgFiVK6f5mmWQohRawzajj5zECroIr8+in
         Q9FnbzjqyiwZndvlj0dkn5P6A6IGVq9qaYDqCTg3rrtO3VxywFHcy6ktH1ykOjnEJYc+
         kC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=n77gpZdiQx2XoJxztEWy6+tMhTq5Fkas8RaOJhWCSKI=;
        b=kECSUxyW4dnLLHLtJiw924mBXSHoO1VPFviWxby0WWu27UkJTdiEUrguGWeeJB9ibO
         VOw4DRkvSVcJun0xTjp7taQz+fxkKu7QssRlK56neignZBfyxBaOYjFGzyzMcbNQJSTG
         RTRlGOwBjxiej+3y4bF3oUq1ARjJ1P11tU/l12fbCMyFa9i/LNkO8pCZH7SNxzuuOQFN
         +TCVKyeQSd9C323Eu6gJuiXUw6/OSzWKXhEt2aDFH5HI+Hp3UAHCG0QEusrHQBELBws6
         Aw9R0/+g6chzcvkmNXM2t7p2PtP/zVQjV8q5oYh+xM2pWP0H3fQxk6iBLVT6aDeGVpCj
         18ng==
X-Gm-Message-State: AOAM532USMASQqYEv3pk7iOBBn+KmlSI2uSc2CaEkhZL9i/hccIzxDIe
        zzKSnX8nZYiqkStEN5L3MPC7QIebhnfxTg==
X-Google-Smtp-Source: ABdhPJxXl0RL9BJjHZwFBw4CWFE8pqhTCTLusBT58ijgaoi9N3338Xn+z8HI0jJ0Mw2zeNvu//uKWg==
X-Received: by 2002:a05:6214:13c8:: with SMTP id cg8mr40269347qvb.23.1626936322689;
        Wed, 21 Jul 2021 23:45:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.224.126])
        by smtp.gmail.com with ESMTPSA id y20sm12304450qkm.5.2021.07.21.23.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 23:45:22 -0700 (PDT)
Message-ID: <60f91402.1c69fb81.db8d2.c061@mx.google.com>
Date:   Wed, 21 Jul 2021 23:45:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1367524387232263948=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ayush.garg@samsung.com
Subject: RE: Support for Adapter's Default PHY Configuration
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210722052640.5863-2-ayush.garg@samsung.com>
References: <20210722052640.5863-2-ayush.garg@samsung.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1367524387232263948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=519479

---Test result---

Test Summary:
CheckPatch                    FAIL      1.86 seconds
GitLint                       FAIL      0.84 seconds
Prep - Setup ELL              PASS      47.00 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      8.33 seconds
Build - Make                  PASS      203.42 seconds
Make Check                    PASS      9.65 seconds
Make Distcheck                PASS      241.66 seconds
Build w/ext ELL - Configure   PASS      8.32 seconds
Build w/ext ELL - Make        PASS      191.62 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
adapter: Add support for get/set phy configuration property
WARNING:LONG_LINE_STRING: line length of 82 exceeds 80 columns
#103: FILE: src/adapter.c:3323:
+		g_dbus_pending_property_error(data->id, ERROR_INTERFACE ".Failed",

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#145: FILE: src/adapter.c:3365:
+	unconfigure_phys = adapter->supported_phys & ~(adapter->configurable_phys);

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#171: FILE: src/adapter.c:3391:
+	DBG("sending set phy configuration command for index %u", adapter->dev_id);

WARNING:LONG_LINE_STRING: line length of 82 exceeds 80 columns
#181: FILE: src/adapter.c:3401:
+	btd_error(adapter->dev_id, "Failed to set PHY configuration for index %u",

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#189: FILE: src/adapter.c:3409:
+					const GDBusPropertyTable *property,
 					                         ^

ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#205: FILE: src/adapter.c:3425:
+				const GDBusPropertyTable *property,
 				                         ^

- total: 2 errors, 4 warnings, 312 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] adapter: Add support for get/set phy configuration property" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

adapter: Add support for the get supported phy property
ERROR:SPACING: need consistent spacing around '*' (ctx:WxV)
#20: FILE: src/adapter.c:3409:
+					const GDBusPropertyTable *property,
 					                         ^

- total: 1 errors, 0 warnings, 30 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] adapter: Add support for the get supported phy property" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

adapter: Add support for PHY Configuration Changed event
WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#52: FILE: src/adapter.c:9944:
+						phy_configuration_changed_callback,

- total: 0 errors, 1 warnings, 39 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] adapter: Add support for PHY Configuration Changed event" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

client: Add support for get/set PHY configuration in bluetoothctl
WARNING:LONG_LINE_STRING: line length of 87 exceeds 80 columns
#65: FILE: client/main.c:2046:
+					"SupportedPhyConfiguration", "Supported phys");

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#86: FILE: client/main.c:2067:
+					"PhyConfiguration", DBUS_TYPE_STRING, phys,

WARNING:LONG_LINE_STRING: line length of 88 exceeds 80 columns
#87: FILE: client/main.c:2068:
+					phys_len, generic_callback, "PHY Configuration",

- total: 0 errors, 3 warnings, 57 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] client: Add support for get/set PHY configuration in" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
client: Add support for get/set PHY configuration in bluetoothctl
18: B3 Line contains hard tab characters (\t): "	Supported phys: BR1M1SLOT"
19: B3 Line contains hard tab characters (\t): "	Supported phys: BR1M3SLOT"
20: B3 Line contains hard tab characters (\t): "	Supported phys: BR1M5SLOT"
21: B3 Line contains hard tab characters (\t): "	Supported phys: EDR2M1SLOT"
22: B3 Line contains hard tab characters (\t): "	Supported phys: EDR2M3SLOT"
23: B3 Line contains hard tab characters (\t): "	Supported phys: EDR2M5SLOT"
24: B3 Line contains hard tab characters (\t): "	Supported phys: EDR3M1SLOT"
25: B3 Line contains hard tab characters (\t): "	Supported phys: EDR3M3SLOT"
26: B3 Line contains hard tab characters (\t): "	Supported phys: EDR3M5SLOT"
27: B3 Line contains hard tab characters (\t): "	Supported phys: LE1MTX"
28: B3 Line contains hard tab characters (\t): "	Supported phys: LE1MRX"
29: B3 Line contains hard tab characters (\t): "	Selected phys: BR1M1SLOT"
30: B3 Line contains hard tab characters (\t): "	Selected phys: LE1MTX"
31: B3 Line contains hard tab characters (\t): "	Selected phys: LE1MRX"


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


--===============1367524387232263948==--
