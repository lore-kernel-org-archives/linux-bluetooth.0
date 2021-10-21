Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635F5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 18:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB39611CE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhJUSoG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhJUSoF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 14:44:05 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE2CC061764
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 11:41:49 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id t16so1388860qto.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 11:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=iDRMbA+pjUOFHJvnbN7THH9F6NPanOB8FHeBs9hgNWY=;
        b=Em41TW2PSupX0h+GvI3dfYXgpabQGSLFYT0SEf0HvBVa28kwAIcNaYC5yeCX6RpFR4
         hyYI+Kh03hbaq0N26BUiEU64Rs4BYeqapL66B6dKby27UU4aTfUa3yhSjtyV0BAJyoDs
         EIke/cR5g0F+ynWwtOXMr/eATykTOsf7fd5lJDhpNeFti7oZXBID/WRHJSi8U/wlgunl
         qUIMZLmoZRfH49O1Y0VLxakQGqWRh9Co3GuCbv4SYqvPVs946jgCzq75LeQryhJQNgBY
         k6NyioTBG3hK6T+B+cdChKJ2BClB7kF0bAatzQHet7EcHNogS9RPI9KpQK/dEpSzYYxj
         kaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=iDRMbA+pjUOFHJvnbN7THH9F6NPanOB8FHeBs9hgNWY=;
        b=V5oAIFqH8Yr0U04OZY4QG5w3kc5AQoa438/MJ+wCXwLYX+JGEcuYXdtTkkhIvmqapU
         lKEL7hz7qzNNY/0tJa/kjxxN24tIsneyR4lkjHAeVpOWyn+v323yBu7RxX5+j05pun5K
         9KQIE3LA2PnihRU17WQT5ae+KzF/z9+Y3YLEtiA/wMkuWIrJIX+OMnRhOktkVjGgzbS1
         zVrfzarmOi8pJbtG+2HU628EwE6COJ7ltISBxuIRksRFJ5LpUMMco2F2rz0t1h/psUjq
         o6pOZL03M+YI0mjgujXPYOYFr0tQWnHmZXgZOJ8J080Nesncq0G03w2XEdNwRiBNtQRc
         tT4w==
X-Gm-Message-State: AOAM533VS1s54VlOPeo2knPXzlYOVGIQ7LYRT8gJYhzpSgrGY2pP4dnG
        ybewUa9krnH4pE9byLHhaXU6rOKYnrM=
X-Google-Smtp-Source: ABdhPJxIZnPT+k97gwoM+65h5rGMs2j3ZV6LKI1gk1YmK1LgotJg4vi+xFttW0BC0O8YWjRxE+5CrA==
X-Received: by 2002:ac8:594b:: with SMTP id 11mr8052307qtz.191.1634841708376;
        Thu, 21 Oct 2021 11:41:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.112.147])
        by smtp.gmail.com with ESMTPSA id d129sm2834222qkf.136.2021.10.21.11.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:41:47 -0700 (PDT)
Message-ID: <6171b46b.1c69fb81.e6079.2f24@mx.google.com>
Date:   Thu, 21 Oct 2021 11:41:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5521878541724641369=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC,BlueZ,v13,1/5] emulator: Add support to config the accept and resolve list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211021174804.340160-1-hj.tedd.an@gmail.com>
References: <20211021174804.340160-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5521878541724641369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=568051

---Test result---

Test Summary:
CheckPatch                    FAIL      9.57 seconds
GitLint                       FAIL      6.29 seconds
Prep - Setup ELL              PASS      47.30 seconds
Build - Prep                  PASS      0.52 seconds
Build - Configure             PASS      8.82 seconds
Build - Make                  PASS      206.58 seconds
Make Check                    PASS      9.77 seconds
Make Distcheck                PASS      247.59 seconds
Build w/ext ELL - Configure   PASS      9.62 seconds
Build w/ext ELL - Make        PASS      197.36 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[RFC,BlueZ,v13,5/5] tools/mgmt-tester: Add LL Privacy test cases
ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#756: FILE: tools/mgmt-tester.c:10115:
+					MGMT_OP_SET_EXP_FEATURE , 0 };
 					                        ^

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1232: FILE: tools/mgmt-tester.c:10589:
+// ^Istruct test_data *data = tester_get_data();$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1233: FILE: tools/mgmt-tester.c:10590:
+// ^Iunsigned char param[] = { 0x01 };$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1234: FILE: tools/mgmt-tester.c:10591:
+// ^Iconst uint8_t *ext_feat_param;$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1235: FILE: tools/mgmt-tester.c:10592:
+// ^Isize_t ext_feat_len;$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1236: FILE: tools/mgmt-tester.c:10593:
+// ^Iunsigned char privacy_param[] = { 0x01,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1237: FILE: tools/mgmt-tester.c:10594:
+// ^I^I^I0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1238: FILE: tools/mgmt-tester.c:10595:
+// ^I^I^I0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1240: FILE: tools/mgmt-tester.c:10597:
+// ^Itester_print("Enabling LL Privacy feature");$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1242: FILE: tools/mgmt-tester.c:10599:
+// ^Iext_feat_param = set_exp_feat_param_ll_privacy;$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1243: FILE: tools/mgmt-tester.c:10600:
+// ^Iext_feat_len = sizeof(set_exp_feat_param_ll_privacy);$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1245: FILE: tools/mgmt-tester.c:10602:
+// ^Imgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1246: FILE: tools/mgmt-tester.c:10603:
+// ^I^I^I^I^Isizeof(param), &param,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1247: FILE: tools/mgmt-tester.c:10604:
+// ^I^I^I^I^INULL, NULL, NULL);$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1249: FILE: tools/mgmt-tester.c:10606:
+// ^Imgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1250: FILE: tools/mgmt-tester.c:10607:
+// ^I^I^I^I^Isizeof(privacy_param), privacy_param,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1251: FILE: tools/mgmt-tester.c:10608:
+// ^I^I^I^I^INULL, NULL, NULL);$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1253: FILE: tools/mgmt-tester.c:10610:
+// ^Imgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, data->mgmt_index,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1254: FILE: tools/mgmt-tester.c:10611:
+// ^I^I^I^I^Iext_feat_len, ext_feat_param,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1255: FILE: tools/mgmt-tester.c:10612:
+// ^I^I^I^I^Isetup_exp_feat_callback, NULL, NULL);$

/github/workspace/src/12575969.patch total: 1 errors, 19 warnings, 2188 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12575969.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[RFC,BlueZ,v13,4/5] tools/mgmt-tester: Add support for experimental feature in setup
1: T1 Title exceeds max length (84>80): "[RFC,BlueZ,v13,4/5] tools/mgmt-tester: Add support for experimental feature in setup"




---
Regards,
Linux Bluetooth


--===============5521878541724641369==--
