Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F14FC76195
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Mar 2023 06:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjC1G5H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Mar 2023 02:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1G5G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Mar 2023 02:57:06 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3B51BE8
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 23:57:05 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id cu4so8600628qvb.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 23:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679986624;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hq9qsm/zojurLKObrtoPuYHrNO3g7j7OAr6txrXVpEE=;
        b=jYa0+qrKxT2lQFhg0phiXRv5q8gROMhqpjuv/C9/qUkY5tyhSK9herUZeHpCjzIm7s
         hHxuLAElt35a2NqcC6TlU9MhG1pwNbW/B8XTsex8wM31KBYyzij7vrdDt/vHsPYEsQ5e
         bvT5prpyjr6xHaeV90jg12Pbl7axmVbHudlhKnX7Jo3pZpYkHHeCSGlxGyN3TAtf9BRX
         5E43c+UCMXNDkhjg7axpFyR8qU20wJvxYYH/1Vm+gzn3C8HXBwTx7vLrKGxYzDneB8Gp
         7/TBTaJxQXGpfmb6FYNHGr2+ql2xGpcRXEuxw7Ton9XbWbQvjHadSRnUO6LWa9ECyh8L
         vMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679986624;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hq9qsm/zojurLKObrtoPuYHrNO3g7j7OAr6txrXVpEE=;
        b=VtVMiLR2rUYKvRbvRvpma9num8nWS9Gr21JmyWq9erR8vyAEVW3zpU5tMxSEQFZVpn
         aDhtbEol5vtcE83G8rFFScANAnTtJp61FR8siKxoOvobmf9BhZIr3PhhcFFIAuHIxNYQ
         ETwRUZ54Pj7pWQqGvYWNTjz+qZ4cyH7Kr/aHm5KrORuOMTyO+A8/iiToEHb57H+U+7BR
         8TOLQFqk+ifBdbqiZu+9dTl8MJF4BiDwcTuzvMRd2dILc6VUxqEnl2yWZCaSVBzr83+Z
         ghlHz3yLgy5Q2kzDrdsJEhiJRGl+qF/IbudPteqXTysi13/oxjAXLKiauqDyy09mvwsr
         S1bQ==
X-Gm-Message-State: AAQBX9ceez4FurcfK3VF58R/neC8lxcT4iZoyh44WTHIxF0iUFi3djoT
        KXGs02I9ZkaDpRA5DRjaO9FQRpH3NlI=
X-Google-Smtp-Source: AKy350Z0zAxwHcBRFJ+jS63RMwIgM8e5z0Gq0/TZGCWYSgHEnGVoxqAnMLWu6d3Pj5WWDgDcdK3DmA==
X-Received: by 2002:a05:6214:761:b0:5ce:7b40:89bd with SMTP id f1-20020a056214076100b005ce7b4089bdmr23079232qvz.18.1679986624298;
        Mon, 27 Mar 2023 23:57:04 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.36.124])
        by smtp.gmail.com with ESMTPSA id q2-20020ad44342000000b005dd8b9345acsm3527508qvs.68.2023.03.27.23.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 23:57:04 -0700 (PDT)
Message-ID: <64228fc0.d40a0220.43ef1.c3fa@mx.google.com>
Date:   Mon, 27 Mar 2023 23:57:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5198064046316477830=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: l2test: Enable hex input for PSM
In-Reply-To: <20230328052619.1357253-2-simon.mikuda@streamunlimited.com>
References: <20230328052619.1357253-2-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5198064046316477830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=734449

---Test result---

Test Summary:
CheckPatch                    FAIL      1.32 seconds
GitLint                       PASS      0.68 seconds
BuildEll                      PASS      27.26 seconds
BluezMake                     PASS      1033.05 seconds
MakeCheck                     PASS      11.60 seconds
MakeDistcheck                 PASS      153.92 seconds
CheckValgrind                 PASS      251.46 seconds
CheckSmatch                   PASS      335.56 seconds
bluezmakeextell               PASS      101.56 seconds
IncrementalBuild              PASS      1774.04 seconds
ScanBuild                     PASS      1067.84 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,2/2] l2test: Fix setting mode for BR/EDR l2cap socket
ERROR:SWITCH_CASE_INDENT_LEVEL: switch and case should be at the same indent
#110: FILE: tools/l2test.c:160:
+	switch (mode) {
+		case BT_MODE_BASIC:
[...]
+		case BT_MODE_ERTM:
[...]
+		case BT_MODE_STREAMING:
[...]
+		case BT_MODE_LE_FLOWCTL:
[...]
+		case BT_MODE_EXT_FLOWCTL:
[...]
+		default:

/github/workspace/src/src/13190513.patch total: 1 errors, 0 warnings, 44 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13190513.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5198064046316477830==--
