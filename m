Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E741C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 05:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiKSFeC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 00:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSFeA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 00:34:00 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1546A1A835
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:33:54 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id s17so1713380ilp.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ss5NPYdsp8E0W1E6xQCJtOuZ9o0vVeQWfmxdyVIR5ns=;
        b=LY9HQLrkvcKQ9oSxvcRTMprJsFzHJM0UVVClGB9SZf3OA7s0gO1E+z4VLQbvopU1Ze
         bO8qij5V3Ehh+7EWUhdS4IzGMIY1fFgYDZyg231YRyEU18JWRsggXbDlbSzW0YnTbORM
         yxREHUVEYd4PMGdFPvHwBY55NNtNs/bm9YeVQTAxSxqEB3uw6HnXcpC/YGH4CDl9kS8l
         +vD05LNINe+WYjmi5ndCYzqnusOa1kNiAwLlS7cI5yGYpxws37ocUl8oPAUVhzBUJdVM
         BFv2GEetxKG2g1QeG5eYSeK2YEYHw5JkDgN3ad4m6s9mT70Gj7sbEOoVayIupKs7tzzC
         hx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ss5NPYdsp8E0W1E6xQCJtOuZ9o0vVeQWfmxdyVIR5ns=;
        b=3VeCvF1JDmTeYuxkjh45fagtbjk7f11UU5DalJkSvGNDLkn6TK+Pt4q306E859Nljw
         PAeE9l/+88qUSSx7AXbuLA1g8cdu4vUSje07+GOx3Lm3tY0fKLFY8FRnCwC3iRl3fTut
         kSsi51pwRtBEvdxWincSikhECtPIHvWScw0PVRKn1G2cnEbJC1HNHZCWxJYPnsvEKdDc
         Q5jI3I4VnVVMrBhJmKw3zzVMPD9bKvAuyntTXY+N0t39k7RIlcBtnE0d/mfAeeaOMZBW
         LL15WVIYplmt1X56F5AT2tunu3UaOgSj6BkwS3xjBMmiT6dGEgtnzH94vMfMupKWxSkI
         ShFA==
X-Gm-Message-State: ANoB5plE8IfKt8csfPOWo+vuBGqcygRhyF6rWZ8ylxcbEJZChm33cTpR
        axvwcfFbgeeSvh5AnhFHfZEYhFtod9aHxw==
X-Google-Smtp-Source: AA0mqf4ldZRKC/mbeAImWNOuC7h6yxeGlYlHe+zZU9PuEbsptWQcmEjACwA4deJTcMEdUh+dYI3B4w==
X-Received: by 2002:a92:ce84:0:b0:302:4ad3:fd49 with SMTP id r4-20020a92ce84000000b003024ad3fd49mr4654568ilo.271.1668836033324;
        Fri, 18 Nov 2022 21:33:53 -0800 (PST)
Received: from [172.17.0.2] ([20.29.123.154])
        by smtp.gmail.com with ESMTPSA id i4-20020a05663815c400b003755a721e98sm1949787jat.107.2022.11.18.21.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:33:53 -0800 (PST)
Message-ID: <63786ac1.050a0220.8c79f.4e17@mx.google.com>
Date:   Fri, 18 Nov 2022 21:33:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7422149208960584585=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] main.conf: Add SecureConnections option
In-Reply-To: <20221118052610.36133-1-simon.mikuda@streamunlimited.com>
References: <20221118052610.36133-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7422149208960584585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696767

---Test result---

Test Summary:
CheckPatch                    FAIL      0.60 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      26.96 seconds
BluezMake                     PASS      754.53 seconds
MakeCheck                     PASS      10.83 seconds
MakeDistcheck                 PASS      145.29 seconds
CheckValgrind                 PASS      237.73 seconds
bluezmakeextell               PASS      93.18 seconds
IncrementalBuild              PASS      606.92 seconds
ScanBuild                     PASS      956.74 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] main.conf: Add SecureConnections option
WARNING:LONG_LINE: line length of 81 exceeds 80 columns
#98: FILE: src/adapter.c:10149:
+		set_mode(adapter, MGMT_OP_SET_SECURE_CONN, btd_opts.secure_conn);

/github/workspace/src/src/13047733.patch total: 0 errors, 1 warnings, 77 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13047733.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7422149208960584585==--
