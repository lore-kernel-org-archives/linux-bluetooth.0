Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15D6C77B75
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 May 2023 22:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjEEWAW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 May 2023 18:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjEEWAV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 May 2023 18:00:21 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31F21FDA
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 May 2023 15:00:20 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-18ef8e9ab4fso1822402fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 May 2023 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683324020; x=1685916020;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TFUCLM4zBZUa6ITqRWbIFw8WJkPn1rFWT8HLCcwvQo8=;
        b=J4pjhLXg/8ePJDIc57WrQ+TzH1B5SfC3FKwTPcJiI7n00sFAnnhMkb1wrn1mW9oTN6
         l9HGeYX9yW0f/+E3YPXYnB+anO6qJEmpAVZnoHp25I4vAnw4YkkLGismMWUb5KCDmylR
         NGQjjokp7JP3Pn72OSqOlPNn1P3e0/Ce9QS4wEiITcxsqCHjMrRLK87LTN4i4tXsnBRB
         5AKs8qfKdMcuT4p2RAcf8tmR5i0bHwHhivk5NqnWo+dU9K1T46hQqOnQxWy3YXJdTiBl
         Yol1HVeTdn+7MvPp2oT9dCEkHiDiA7qN8biHO06NmuZXGga3avUziEdPpua3ST3+9sXR
         cPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683324020; x=1685916020;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFUCLM4zBZUa6ITqRWbIFw8WJkPn1rFWT8HLCcwvQo8=;
        b=EqRhYvT3OG9IBsn+Dugqud+5gbKG8sA+SLZhwoCAHofObeBe2zUWvLNz46Lxr0oyJ6
         wqNabml26+PLdRrvqSuGS/OaZPH9Fev0R8ICWeYqBC0bRgiHCx+MlyhPneSX/J5+AMy3
         Y8VhGVNjxiGpkw6QZy4lPMLU4+AgNHxaYC13Wiks0uxn0n/aqtxYgqc4Lb4y3NlnZcVz
         ovx2h6r1VgyIR8VETVLDoHOzHsEMLlHLZUgdFQggBK1gX+YZ+QLC1P5aC6bIZ6e6M/eS
         V9UqJjsBunRzuVDI17nvay0ErHc/1Oo2uQvT8gdBwkd+qzmlce823n22DGAMm4BihPTf
         V+gg==
X-Gm-Message-State: AC+VfDyvH6UiB3Qo2mPdu7qf95dP9p9/Cdv3oez8Psp/IIg5imKDZFMN
        Ghv1pBC1J9bF2ubuswGN/++AyrU3+co=
X-Google-Smtp-Source: ACHHUZ7CkuBqK7Re0eEiWWuzYnaTzVbN8sYDwp7b9cVQw31U6zdu9hDUNyWvgCVh16Uq3nQma/qD/A==
X-Received: by 2002:a05:6870:8805:b0:17a:cf55:242 with SMTP id n5-20020a056870880500b0017acf550242mr1472292oam.53.1683324019950;
        Fri, 05 May 2023 15:00:19 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.189.35])
        by smtp.gmail.com with ESMTPSA id u22-20020a056871059600b0017703cd8ff6sm2337040oan.7.2023.05.05.15.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:00:19 -0700 (PDT)
Message-ID: <64557c73.050a0220.bfdb4.cc46@mx.google.com>
Date:   Fri, 05 May 2023 15:00:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7706029534121909012=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] monitor/att: Attempt to insert discovered attributes
In-Reply-To: <20230505203156.2561265-1-luiz.dentz@gmail.com>
References: <20230505203156.2561265-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7706029534121909012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=745389

---Test result---

Test Summary:
CheckPatch                    FAIL      1.55 seconds
GitLint                       PASS      0.64 seconds
BuildEll                      PASS      32.30 seconds
BluezMake                     PASS      1012.15 seconds
MakeCheck                     PASS      13.45 seconds
MakeDistcheck                 PASS      186.69 seconds
CheckValgrind                 PASS      300.63 seconds
CheckSmatch                   WARNING   403.87 seconds
bluezmakeextell               PASS      123.37 seconds
IncrementalBuild              PASS      1661.30 seconds
ScanBuild                     PASS      1239.79 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,2/2] monitor: Fix misaligment errors
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#106: FILE: monitor/packet.c:11948:
+} __attribute__((packed));

/github/workspace/src/src/13233010.patch total: 0 errors, 1 warnings, 17 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13233010.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1800:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3552:52: warning: array of flexible structuresmonitor/bt.h:3540:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============7706029534121909012==--
