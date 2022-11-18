Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06320C43217
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 09:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241943AbiKRJbR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241953AbiKRJbP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 04:31:15 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE008C0BD
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:31:14 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id k2so3017709qkk.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rRXGC90r8Hi6ej+/KdloWFGe6ZD3tt3JrHSE6i86BVY=;
        b=KO8r/R5CHaMtYM42pLh32Xxy4Cr1ixmU8kqk+Pw0Z9xxc9fxBazfOgU0wg0+Bc26Fb
         5Y79Xq2rytpk+PTFr/DJsCnj1ATVjEI5K9ot4LZ6Jb9Cy1hZhf3fmN0IpRY5tjENNFfi
         Id8GiWHWZvT1F3WGnzwuKVnTn2kaShH+irGa/izF+Y9b5L9/qupY/NNMLl4DIGtrQwGG
         qdzAFky6CAZrcujHSaIMH8Fm/SdKqPquSwzBxCuvpfO+w3ogc1hMiBflf6tgP9mNhLEu
         9MDwnVqssO1H3tZ1NCyuleWgJyIA5WnPsJs5NDJnCKTyaj1+bFg26/XBPgjzNq6klgUH
         MdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRXGC90r8Hi6ej+/KdloWFGe6ZD3tt3JrHSE6i86BVY=;
        b=Dr1yPhQQyxrVa4H2BpxmkNe0r3l7l1eneYQoEZzfBqTbPOFDkOEPwcMYkQtiLB0wki
         DED4Lly63AKTsQQODh8yO4HwKpBa4UKJOq7DY0hoDkP0NEyHr4XNCKFgrZR9VlXR+osX
         sMS5ZWW5fL8di5Vn1QTjk/ZowxcO+r5Jmd7Z2fPqjX/+Zm2yLJhPYYSGQqpkG03hZONW
         YsBCYjlahaB6q+HzEPfHRPRwEBus+gB1CK61epAAf4JqUDBpitC9fxkNzEIvBI38Uw46
         ajkE0pGLfLGgJc+m8/xgrifaQjdNJRiSAP+iaOzYpLd5u66fvKpE2z/Y2NejR7HplUT/
         audQ==
X-Gm-Message-State: ANoB5pmUQtRNUUGXq2fHJoTwnpxGizZJPGYBq0jYhVEzWZKfcgP6wvCS
        HqhUK0aBzXrL5v4q67L7//4fHJZzV89mJQ==
X-Google-Smtp-Source: AA0mqf4QpV9S/2qZbjF731S+1UkhGjaovlG83ioKOgM/hfHDjL6vy9shUWu5MJpTObQhgvmPtCHGZg==
X-Received: by 2002:a05:620a:20dd:b0:6ef:15d4:a3f with SMTP id f29-20020a05620a20dd00b006ef15d40a3fmr5082559qka.262.1668763872963;
        Fri, 18 Nov 2022 01:31:12 -0800 (PST)
Received: from [172.17.0.2] ([20.242.97.49])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05620a17a200b006b929a56a2bsm2130913qkb.3.2022.11.18.01.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:31:12 -0800 (PST)
Message-ID: <637750e0.050a0220.7ec03.9ea1@mx.google.com>
Date:   Fri, 18 Nov 2022 01:31:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6697888017259245675=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org,
        dominique.martinet@atmark-techno.com
Subject: RE: Add serdev support for hci h4
In-Reply-To: <20221108055531.2176793-2-dominique.martinet@atmark-techno.com>
References: <20221108055531.2176793-2-dominique.martinet@atmark-techno.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6697888017259245675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=693092

---Test result---

Test Summary:
CheckPatch                    FAIL      1.90 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 FAIL      0.48 seconds
BuildKernel                   PASS      33.47 seconds
BuildKernel32                 PASS      29.76 seconds
TestRunnerSetup               PASS      416.59 seconds
TestRunner_l2cap-tester       PASS      15.74 seconds
TestRunner_iso-tester         PASS      15.05 seconds
TestRunner_bnep-tester        PASS      5.26 seconds
TestRunner_mgmt-tester        PASS      102.94 seconds
TestRunner_rfcomm-tester      PASS      9.04 seconds
TestRunner_sco-tester         PASS      8.50 seconds
TestRunner_ioctl-tester       PASS      9.68 seconds
TestRunner_mesh-tester        PASS      6.56 seconds
TestRunner_smp-tester         PASS      8.37 seconds
TestRunner_userchan-tester    PASS      5.46 seconds
IncrementalBuild              PASS      35.86 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC,1/2] dt-bindings: net: h4-bluetooth: add new bindings for hci_h4
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#114: 
new file mode 100644

total: 0 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13035921.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============6697888017259245675==--
