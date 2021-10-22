Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA39AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 21:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B45C061038
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Oct 2021 21:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhJVVge (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Oct 2021 17:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhJVVge (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Oct 2021 17:36:34 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29325C061764
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Oct 2021 14:34:16 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t16so4778726qto.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Oct 2021 14:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JBYKZzHq49T8qcMsnIanN+aW2nn2eQRn/6nbsdcVxD8=;
        b=VVoEauHYFrYdNPFqRog1JvDWCCM6gredQkvlS+DR1LwFYObsKu4J/L4C3kcWG7JQEY
         HOMl8rXMKbkow2epFOxq8uuJvrmIT6CGdOxdF822CmoU3UASH75zTFe9ODUQ+PS3KeDh
         7GkEimYLEPz2dTqtaPvETMCLenex+WE302Zd+Ru+4M4MwV9oWkBt2aARUlN821PoARjO
         1EKa29OAoPDJ8P+uRrKW8E7xzASprhgjLaMYPWoeDIRTSzeDfJHMXsCKmVXYwZx350T5
         Z9Mu9g0NDnYy2at0qFQODEslZzE5SsYC57hhj5nsUknrlMH+0wimx64YDy2HZlZRbnsR
         MlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JBYKZzHq49T8qcMsnIanN+aW2nn2eQRn/6nbsdcVxD8=;
        b=eezm+pY1MipFMC6NlVg7mZ6g6QHY31Xa43rxUpu7y8hBmd1rLLukied66yrX/hcazm
         ZFQmGpI9bm8Rye5C4AN3c2QR0MOd8A4CUgj6O9K0xI7Oy8sENF1j7y5YIIE8O7ZHamPk
         8f6h4D6CV7/dgTNOCuKiStSjw/moCAIj4Qtf+KC2jQCWWlWoX09Sb5OUn7zqS95Xkr1j
         +K9QaxbZc6WHOFOxzb/hvoeoeLF7LTlc3J+1VuqU7jKh4K2kxgop8cUtOooRl6mUSTNL
         IJ43mT3ox1m2Kcp+0H4eV0Q3z9lJeqli/2Yx+pxYwaxQvYbPUb3MOqSuERiNNFzmRMsM
         nAnA==
X-Gm-Message-State: AOAM533l9grt2zBhI33rR8ZH/F+kUkl2wJTjdQjw7Qy2eZF2uM5XEJ4T
        zvXIKOesmC6UcewqYl3ScyRV5uY02SY=
X-Google-Smtp-Source: ABdhPJxwwPQmwxN9SmRvgJdlG5EsfthplIqbGgAnTOcsAuSqhwZiPn9bx8YMkQtVnu0/ZBEZi4pMwQ==
X-Received: by 2002:ac8:4298:: with SMTP id o24mr2629029qtl.188.1634938453806;
        Fri, 22 Oct 2021 14:34:13 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.190.172])
        by smtp.gmail.com with ESMTPSA id s17sm4073600qtw.95.2021.10.22.14.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 14:34:13 -0700 (PDT)
Message-ID: <61732e55.1c69fb81.68d6d.b06d@mx.google.com>
Date:   Fri, 22 Oct 2021 14:34:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0319983633703366539=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [RFC,BlueZ,v14,1/5] emulator: Add support to config the accept and resolve list
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211022204825.397952-1-hj.tedd.an@gmail.com>
References: <20211022204825.397952-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0319983633703366539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=568805

---Test result---

Test Summary:
CheckPatch                    FAIL      9.36 seconds
GitLint                       FAIL      4.99 seconds
Prep - Setup ELL              PASS      46.47 seconds
Build - Prep                  PASS      0.50 seconds
Build - Configure             PASS      8.67 seconds
Build - Make                  PASS      199.78 seconds
Make Check                    PASS      9.67 seconds
Make Distcheck                PASS      237.61 seconds
Build w/ext ELL - Configure   PASS      8.56 seconds
Build w/ext ELL - Make        PASS      191.12 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[RFC,BlueZ,v14,5/5] tools/mgmt-tester: Add LL Privacy test cases
ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#756: FILE: tools/mgmt-tester.c:10115:
+					MGMT_OP_SET_EXP_FEATURE , 0 };
 					                        ^

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1262: FILE: tools/mgmt-tester.c:10620:
+// ^Istruct test_data *data = tester_get_data();$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1263: FILE: tools/mgmt-tester.c:10621:
+// ^Iunsigned char param[] = { 0x01 };$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1264: FILE: tools/mgmt-tester.c:10622:
+// ^Iconst uint8_t *ext_feat_param;$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1265: FILE: tools/mgmt-tester.c:10623:
+// ^Isize_t ext_feat_len;$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1266: FILE: tools/mgmt-tester.c:10624:
+// ^Iunsigned char privacy_param[] = { 0x01,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1267: FILE: tools/mgmt-tester.c:10625:
+// ^I^I^I0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1268: FILE: tools/mgmt-tester.c:10626:
+// ^I^I^I0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1270: FILE: tools/mgmt-tester.c:10628:
+// ^Itester_print("Enabling LL Privacy feature");$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1272: FILE: tools/mgmt-tester.c:10630:
+// ^Iext_feat_param = set_exp_feat_param_ll_privacy;$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1273: FILE: tools/mgmt-tester.c:10631:
+// ^Iext_feat_len = sizeof(set_exp_feat_param_ll_privacy);$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1275: FILE: tools/mgmt-tester.c:10633:
+// ^Imgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1276: FILE: tools/mgmt-tester.c:10634:
+// ^I^I^I^I^Isizeof(param), &param,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1277: FILE: tools/mgmt-tester.c:10635:
+// ^I^I^I^I^INULL, NULL, NULL);$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1279: FILE: tools/mgmt-tester.c:10637:
+// ^Imgmt_send(data->mgmt, MGMT_OP_SET_PRIVACY, data->mgmt_index,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1280: FILE: tools/mgmt-tester.c:10638:
+// ^I^I^I^I^Isizeof(privacy_param), privacy_param,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1281: FILE: tools/mgmt-tester.c:10639:
+// ^I^I^I^I^INULL, NULL, NULL);$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1283: FILE: tools/mgmt-tester.c:10641:
+// ^Imgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, data->mgmt_index,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1284: FILE: tools/mgmt-tester.c:10642:
+// ^I^I^I^I^Iext_feat_len, ext_feat_param,$

WARNING:SPACE_BEFORE_TAB: please, no space before tabs
#1285: FILE: tools/mgmt-tester.c:10643:
+// ^I^I^I^I^Isetup_exp_feat_callback, NULL, NULL);$

/github/workspace/src/12579045.patch total: 1 errors, 19 warnings, 2340 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12579045.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[RFC,BlueZ,v14,4/5] tools/mgmt-tester: Add support for experimental feature in setup
1: T1 Title exceeds max length (84>80): "[RFC,BlueZ,v14,4/5] tools/mgmt-tester: Add support for experimental feature in setup"




---
Regards,
Linux Bluetooth


--===============0319983633703366539==--
