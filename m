Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755CEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB01611BD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 05:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbhJOFi5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 01:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhJOFi5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 01:38:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6F3C061570
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:36:51 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id om14so6448076pjb.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Oct 2021 22:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3sBGzjI02ihR0DnDXdm1S4GVfIiBFoUpt7wkZX75/UM=;
        b=VmoEH86PhpnEHtJ0DG/hknD++Rf3e6wrzsxJELiCkOxn+X/EJ2GYiD2fZk3XN9w4FO
         h1qfIi5NtlIrUKaLWiAFWyN0cy9SNa8vcinzNCKTiKZ3sCawxdDnzlPFBgonOVSXApOP
         NvFWBvYUzciPFLHocTskBvE9wBiEFAv6O5RqQ3raJHRsY56H6cqAiV0kDRzAl8JG0W+l
         Lt9ZFhk1aUxD7/XVQ0DTPzOENdqjn30IwUbl2tlN3SyEXikNSyDt8WpDqW4JKIDkGfKq
         5qZmudBVw60XkzkfFFMCib8eodBbS8G+V4gcsZYclFbRaoGn6dWZkqABwCNFgBmBK5RD
         pI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3sBGzjI02ihR0DnDXdm1S4GVfIiBFoUpt7wkZX75/UM=;
        b=HaVLReXCPRrunGDZKF+HxX4djwCT04/8+z8TnQ4PiAXNX2X4bhitOsut3U+Djc5VNw
         NTQiFB9BPcXMK7bPwXwBL7g1oLq28w3XPPo+D8gGMt1Rx8jlqW/cnUvmDTK35SMXUHwf
         IRUW7PmA0iqMJQUfSjDLfpUW0CBC+VP44dZ+Zl/IN9pchPVa4f+ijPS1/q9/AY/T4pOH
         ImChdKirv2Ary+SYgTQjYiWTRpDoFPS4sClJtueIxbkP78oHOBTjOBJt8Bi7BtY7OdX9
         BktK3WaV2LF58MJWwb5DZ9IFkrPtyeOrJd/wjVFE5u3+LpyHTSAPGZqYCtVdN+OO4a8M
         YtzA==
X-Gm-Message-State: AOAM532zVV+QwWOtyBceg7o2FVLfP5XSaLUY7WO//+qcrZmc2u6ASHzE
        TlSawPwadUXG74hJ3vtiDjAu7DasRFU=
X-Google-Smtp-Source: ABdhPJxKDBdDmiYYvJ7yFtigSgPSZUQiF2FGYX2+0P7jlYWTOJWlQp6z17yJmV79huG9YQLsl6EKbA==
X-Received: by 2002:a17:90b:3852:: with SMTP id nl18mr11210146pjb.94.1634276210460;
        Thu, 14 Oct 2021 22:36:50 -0700 (PDT)
Received: from [172.17.0.2] ([20.94.193.60])
        by smtp.gmail.com with ESMTPSA id k1sm3910154pjj.54.2021.10.14.22.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 22:36:50 -0700 (PDT)
Message-ID: <61691372.1c69fb81.e2f2e.cdf5@mx.google.com>
Date:   Thu, 14 Oct 2021 22:36:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0568048249262757922=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/7] monitor: Add packet definitions for MSFT extension
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211015050929.3130100-1-luiz.dentz@gmail.com>
References: <20211015050929.3130100-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0568048249262757922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=563859

---Test result---

Test Summary:
CheckPatch                    FAIL      4.45 seconds
GitLint                       FAIL      2.34 seconds
Prep - Setup ELL              PASS      56.30 seconds
Build - Prep                  PASS      0.25 seconds
Build - Configure             PASS      10.00 seconds
Build - Make                  PASS      238.32 seconds
Make Check                    PASS      9.34 seconds
Make Distcheck                PASS      279.48 seconds
Build w/ext ELL - Configure   PASS      10.29 seconds
Build w/ext ELL - Make        PASS      226.33 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/7] monitor: Add packet definitions for MSFT extension
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#101: FILE: monitor/msft.h:31:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#109: FILE: monitor/msft.h:39:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#120: FILE: monitor/msft.h:50:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#125: FILE: monitor/msft.h:55:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#132: FILE: monitor/msft.h:62:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#137: FILE: monitor/msft.h:67:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#146: FILE: monitor/msft.h:76:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#151: FILE: monitor/msft.h:81:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#160: FILE: monitor/msft.h:90:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#164: FILE: monitor/msft.h:94:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#170: FILE: monitor/msft.h:100:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#180: FILE: monitor/msft.h:110:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#186: FILE: monitor/msft.h:116:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#193: FILE: monitor/msft.h:123:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#198: FILE: monitor/msft.h:128:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#205: FILE: monitor/msft.h:135:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#210: FILE: monitor/msft.h:140:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#217: FILE: monitor/msft.h:147:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#224: FILE: monitor/msft.h:154:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#233: FILE: monitor/msft.h:163:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#243: FILE: monitor/msft.h:173:
+} __attribute__((packed));

/github/workspace/src/12560019.patch total: 0 errors, 21 warnings, 154 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12560019.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,3/7] vhci: Read the controller index
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#173: FILE: emulator/vhci.c:95:
+} __attribute__((packed));

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#179: FILE: emulator/vhci.c:101:
+} __attribute__((packed));

/github/workspace/src/12560021.patch total: 0 errors, 2 warnings, 172 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12560021.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

[BlueZ,5/7] hciemu: Use vhci_open to instanciate a vhci btdev
WARNING:TYPO_SPELLING: 'instanciate' may be misspelled - perhaps 'instantiate'?
#72: 
Subject: [PATCH BlueZ 5/7] hciemu: Use vhci_open to instanciate a vhci btdev
                                                    ^^^^^^^^^^^

/github/workspace/src/12560027.patch total: 0 errors, 1 warnings, 355 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12560027.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,7/7] mgmt-tester: Make use of vhci_set_force_suspend/vhci_set_force_wakeup
1: T1 Title exceeds max length (81>80): "[BlueZ,7/7] mgmt-tester: Make use of vhci_set_force_suspend/vhci_set_force_wakeup"




---
Regards,
Linux Bluetooth


--===============0568048249262757922==--
