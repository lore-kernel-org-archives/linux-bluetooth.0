Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7587EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Dec 2022 23:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLOXIm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Dec 2022 18:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOXIl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Dec 2022 18:08:41 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481F914D05
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 15:08:38 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id t15-20020a4a96cf000000b0049f7e18db0dso141670ooi.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 15:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q5jxlZFQZ32Yq30E8sqKkOeU1cMEt1wwjvJyDM4mA+k=;
        b=qp0S/65b08Pf11DpucCJwLoryVWeFDbaYq/EjJ8uJSGCqeqgVQoSf+fnkT6oXpmO/a
         Ge+T9ShYyrvg/XGWggSi3xXtnP2tdEwGnzcjmkRqUHN+nlW5PP8lGd9AS5VHkB219nEK
         1jIpoMC1408oR5AHSA+x3I3HIhT4UaafKsuP3C97ESPKzAEHdVVjWZcbQ+2rF4aJvdGW
         uAxV9Nc369+ONHdi+iI8Rv5XYW0TkXBpjxDi4MtBZx5ZWSCXlVALSZ+7zEvMQOG1zVHy
         pzdtLH7pP0u5xK/NK1gAdOsxxbRjuk+hq+JtLavSlYvA7omGZQ1CIaJZzB8cpeTzVYLS
         53cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5jxlZFQZ32Yq30E8sqKkOeU1cMEt1wwjvJyDM4mA+k=;
        b=nurBG/lkUqJ1opYBgJ8R7Ba6622v96qHza/+B3xBr1htv3Ontsh0Q+SSYW445AB9Ff
         hKd+fw55y5pqzU/cXtzC/k57oxtHw0tPeL2zzcmNwoEEcwi6jY8BvA1vk628p0YqoJ4t
         SlXbdYt9gQBriuuEDpekSxmR995a9w2xhCHlcFZBJWQAyo7f1UMJ4cVfSeY/IQeilIQ1
         oaExLFoCwmitBZjiVKdGywZ1taF2ceeMgThaxmpD3WizrQpgu15uXT8MLWsQlNOBeyPE
         /CO85LA2Xz7ljKvFvOQUG6cJrDf25ugzhFQrhBmBe5VPJH/rBjROmEeTZev6gyP3YnAZ
         5Odg==
X-Gm-Message-State: ANoB5pnR/oWJyZG/JukoJYuMxmBCnfPYPcbl7xl73p4cNWiscAlipfJz
        mRuJMecho0bAFbddGDnEjYv2VaCgj5jQrQ==
X-Google-Smtp-Source: AA0mqf6YiyXOnhEGMXY8uV2kI+mEU6NGLM0FJ5lC5oc4XfPaKw5ugvR86yQEyJLvRGJw7BwvUG2X3A==
X-Received: by 2002:a4a:d12e:0:b0:4a4:9a57:8eb2 with SMTP id n14-20020a4ad12e000000b004a49a578eb2mr5668526oor.1.1671145717404;
        Thu, 15 Dec 2022 15:08:37 -0800 (PST)
Received: from [172.17.0.2] ([104.210.132.178])
        by smtp.gmail.com with ESMTPSA id r198-20020a4a37cf000000b004a532a32408sm280972oor.16.2022.12.15.15.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 15:08:37 -0800 (PST)
Message-ID: <639ba8f5.4a0a0220.673f6.1c43@mx.google.com>
Date:   Thu, 15 Dec 2022 15:08:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5970971472181031503=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/5] client/player: Make transport.send non-blocking
In-Reply-To: <20221215211037.2686489-1-luiz.dentz@gmail.com>
References: <20221215211037.2686489-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5970971472181031503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=704921

---Test result---

Test Summary:
CheckPatch                    FAIL      2.79 seconds
GitLint                       PASS      1.42 seconds
BuildEll                      PASS      27.44 seconds
BluezMake                     PASS      779.86 seconds
MakeCheck                     PASS      11.19 seconds
MakeDistcheck                 PASS      149.27 seconds
CheckValgrind                 PASS      241.68 seconds
bluezmakeextell               PASS      95.57 seconds
IncrementalBuild              PASS      3135.98 seconds
ScanBuild                     WARNING   978.11 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,2/5] shared/shell: Add bt_shell_echo
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __printf(1, 2) over __attribute__((format(printf, 1, 2)))
#131: FILE: src/shared/shell.h:74:
+				...) __attribute__((format(printf, 1, 2)));

/github/workspace/src/src/13074521.patch total: 0 errors, 1 warnings, 34 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13074521.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/shell.c:1180:13: warning: Access to field 'options' results in a dereference of a null pointer (loaded from variable 'opt')
                        if (c != opt->options[index - offset].val) {
                                 ^~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============5970971472181031503==--
