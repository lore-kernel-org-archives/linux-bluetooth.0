Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DDAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 09:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiFVJPz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 05:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiFVJPy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 05:15:54 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F49CF61
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 02:15:50 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id k6so6620695ilq.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lGiRYsQWp/Le/QpQicw76XHC2kE9Fj45CfAJRx6KzqQ=;
        b=F4H9w30Qib5eTukEAtt8nKQtBKVnBxpoFEKB+f7Tw+76qJn2XiGb0L43OgwxkgApE1
         Su6xmdMY8+Pw99JD2YHMBgkfIdbHvQtl1728o83OqHze6ZKTKZbMNaXNsJ5t6hZCE5l5
         JxCa3h22SbrGgA5nxrSzQLcLJ1UtCiLlYVrTNbaWVrYGlRHEzXkLR5MPXaf++g71Wchp
         QlBr1YKdyUdqHfy6G4Si0A3TrrMfY/aEL39DwqtqYVV/aYTBADn/85+JJMJnQWXLeCVh
         26rD9YmQjhZN5Z5Y0orRPZTDg4pQlv0qs3gqtT7PXhcyDUYo/o6H9XjDa2uyEk/5BJjW
         fflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lGiRYsQWp/Le/QpQicw76XHC2kE9Fj45CfAJRx6KzqQ=;
        b=TEHaLDdr2mVbm4AZ+w0onhxiBX1nisAH4u8d18EgyO6+MfV1/uu2mokiDZG97dCThx
         CgUqbwatjj17Xsth0AOR7xHRYNFshuLRe9iCQVTx4s6Dz3DD4omfu+x/9GjQb/c4jFPZ
         syOTaI12nH/eqmlTp1v82YnevfPZwlg8gIN9+qe/m9NK0rbX+TscYvtvohF+LB85dT4x
         AJvNg8UVKGnnH4Vxks7FZix/62dQRkUWqEXuhPq3Greu8QHWSgCR2cMhExYwGuUOM6Fq
         voyE3KCT1X/ZAvuEBEZMeW2mKdIkFXVoT5xq474Hmnl6/Ms8cy9y2B6T7kiqV9aEknKD
         7kNQ==
X-Gm-Message-State: AJIora/vORu0jp3CTIeLsyLaURT2gWIhtuJ28wrwhKaAmxtT8tK5jPpr
        BOeGTQRjlHVG3vU6XgdILMw+vXw4Ako=
X-Google-Smtp-Source: AGRyM1ub0KZohI1PjZaxsBvX2YmOenPXhUcJ+y9QpQn0pEJBXpxl+8usOJA5WwxRZdAKNprivXCc9w==
X-Received: by 2002:a92:c54d:0:b0:2d3:dfea:c0e1 with SMTP id a13-20020a92c54d000000b002d3dfeac0e1mr1429159ilj.177.1655889349428;
        Wed, 22 Jun 2022 02:15:49 -0700 (PDT)
Received: from [172.17.0.2] ([20.9.52.236])
        by smtp.gmail.com with ESMTPSA id b21-20020a02c995000000b00339bddbe608sm2704409jap.62.2022.06.22.02.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:15:49 -0700 (PDT)
Message-ID: <62b2ddc5.1c69fb81.24421.3c54@mx.google.com>
Date:   Wed, 22 Jun 2022 02:15:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2576038648453682028=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lee.jones@linaro.org
Subject: RE: [RESEND,1/1] Bluetooth: Use chan_list_lock to protect the whole put/destroy invokation
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220622082716.478486-1-lee.jones@linaro.org>
References: <20220622082716.478486-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2576038648453682028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=652672

---Test result---

Test Summary:
CheckPatch                    FAIL      1.22 seconds
GitLint                       FAIL      0.73 seconds
SubjectPrefix                 PASS      0.63 seconds
BuildKernel                   PASS      41.39 seconds
BuildKernel32                 PASS      36.81 seconds
Incremental Build with patchesPASS      47.55 seconds
TestRunner: Setup             PASS      648.42 seconds
TestRunner: l2cap-tester      PASS      15.98 seconds
TestRunner: bnep-tester       PASS      5.24 seconds
TestRunner: mgmt-tester       PASS      96.63 seconds
TestRunner: rfcomm-tester     PASS      8.55 seconds
TestRunner: sco-tester        PASS      8.32 seconds
TestRunner: smp-tester        PASS      8.43 seconds
TestRunner: userchan-tester   PASS      5.41 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.22 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[RESEND,1/1] Bluetooth: Use chan_list_lock to protect the whole put/destroy invokation\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#96: 
  CPU: 4 PID: 705 Comm: kworker/u17:14 Tainted: G S      W       4.14.234-00003-g1fb6d0bd49a4-dirty #28

total: 0 errors, 1 warnings, 0 checks, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12890300.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.73 seconds
Run gitlint with rule in .gitlint
[RESEND,1/1] Bluetooth: Use chan_list_lock to protect the whole put/destroy invokation
1: T1 Title exceeds max length (86>80): "[RESEND,1/1] Bluetooth: Use chan_list_lock to protect the whole put/destroy invokation"
12: B1 Line exceeds max length (103>80): "  CPU: 4 PID: 705 Comm: kworker/u17:14 Tainted: G S      W       4.14.234-00003-g1fb6d0bd49a4-dirty #28"
13: B1 Line exceeds max length (99>80): "  Hardware name: Qualcomm Technologies, Inc. SM8150 V2 PM8150 Google Inc. MSM sm8150 Flame DVT (DT)"




---
Regards,
Linux Bluetooth


--===============2576038648453682028==--
