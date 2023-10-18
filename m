Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E4DCDB47E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Oct 2023 11:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjJRLDW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Oct 2023 07:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRLDV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Oct 2023 07:03:21 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8816B109
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 04:03:19 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4196ae80fc3so43253931cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Oct 2023 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697626998; x=1698231798; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iONYt8qGa9BC7W9rZjYEzbo/gB23Cl1VbKTbG5oc/sw=;
        b=ZghJefPqrQw6tC25Ur95IFrb0vDdJb3nQwG7/ePn+imey/jBiUGyt3JF+hXi+v7FhO
         z3YFKTn9EmW4HS1ys4he6j2dQmm5cyuYgU9GvhAyfDbLGHxnvfMPlPYJV2/s9ichVRCI
         hPio7938oG44W/v5GiXkSHrOvgfctWEMRL/z1dt9alD0J/j6kZpFY442KF2RYvBwrCqQ
         wiEATf2gln8hEWMlsBMblTKjATiuxQimnnw/rgaqUuok9tTRur/L7QvqHiXf7kuRvBal
         7EDevPT1r/ybJlSsdphyhXy/A+2E5U+TSaYcNBpr6vUIsDB9xSiJfrsTqDsBdz3ev9YW
         Zmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697626998; x=1698231798;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iONYt8qGa9BC7W9rZjYEzbo/gB23Cl1VbKTbG5oc/sw=;
        b=mu8SU9bBYTz8b/lpMSCz0BXAMvgO0GZBLhTLNBi9Vv5gHAVbUHpG86PpKZPlVJNKmP
         vGT/f1Z9BEYFzHqUqK/XVeZ/ExdLYjSiRsBRFp1jFtfHpwzSIgEIjyPmYUrewcW58KO1
         NZAuTTeaddDeQnOlNsYArAC3ZZtmHdgBe5+NTmOCz1OqLq+tPNm9zFystkc/XCdTB2VU
         0/RINF1edFHyEHxrsBmNm9gjuoo2LJWm3Dzfnqq7mdrOTSNOU8TFjWxjQlfY6IzYXO8F
         pnmDRCNZAQaCBu0h3HW1sQME6z4cahoJZNqJaGSCBN0+aqtoR1IM1UBpGw8ianzmeNSL
         IEiw==
X-Gm-Message-State: AOJu0Yz2G7p+5zBxH51FyWuShqMYPiYivre8EEO5uFCHVeakcQCgjc6u
        3s4lJNCduloWPVJhoCcGA105jrSjM10=
X-Google-Smtp-Source: AGHT+IFBThZ2KGWcUj4M4bNMSA6EpYKnlnrNY4LB0xm2MDQMWhJU9SXrMaQWFkAAd897WQGtTpFW6Q==
X-Received: by 2002:ac8:7dcf:0:b0:41c:70b2:32f9 with SMTP id c15-20020ac87dcf000000b0041c70b232f9mr4653256qte.41.1697626998468;
        Wed, 18 Oct 2023 04:03:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.36.113])
        by smtp.gmail.com with ESMTPSA id kl13-20020a05622a2c4d00b0041abcc69050sm1295416qtb.95.2023.10.18.04.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 04:03:18 -0700 (PDT)
Message-ID: <652fbb76.050a0220.f3edb.60c1@mx.google.com>
Date:   Wed, 18 Oct 2023 04:03:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6915761159877470909=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [v3] Bluetooth: Fix double free in hci_conn_cleanup
In-Reply-To: <20231018103248.294565-1-hadess@hadess.net>
References: <20231018103248.294565-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6915761159877470909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794282

---Test result---

Test Summary:
CheckPatch                    FAIL      1.13 seconds
GitLint                       FAIL      0.63 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.67 seconds
CheckAllWarning               PASS      36.66 seconds
CheckSparse                   PASS      42.12 seconds
CheckSmatch                   PASS      113.99 seconds
BuildKernel32                 PASS      32.41 seconds
TestRunnerSetup               PASS      510.44 seconds
TestRunner_l2cap-tester       PASS      30.52 seconds
TestRunner_iso-tester         PASS      50.01 seconds
TestRunner_bnep-tester        PASS      10.43 seconds
TestRunner_mgmt-tester        PASS      216.55 seconds
TestRunner_rfcomm-tester      PASS      15.86 seconds
TestRunner_sco-tester         PASS      19.64 seconds
TestRunner_ioctl-tester       PASS      18.10 seconds
TestRunner_mesh-tester        PASS      13.59 seconds
TestRunner_smp-tester         PASS      14.38 seconds
TestRunner_userchan-tester    PASS      11.50 seconds
IncrementalBuild              PASS      33.41 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3] Bluetooth: Fix double free in hci_conn_cleanup
WARNING: Co-developed-by: must be immediately followed by Signed-off-by:
#83: 
Co-developed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---

total: 0 errors, 1 warnings, 0 checks, 70 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13426836.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3] Bluetooth: Fix double free in hci_conn_cleanup

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
39: B1 Line exceeds max length (87>80): "Link: https://syzkaller.appspot.com/bug?id=1bb51491ca5df96a5f724899d1dbb87afda61419 [1]"


---
Regards,
Linux Bluetooth


--===============6915761159877470909==--
