Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DE3EE4996
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 12:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjHUMtJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 08:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjHUMtJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 08:49:09 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00A1C2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 05:49:07 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76d8f2be749so204610685a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692622147; x=1693226947;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iacDazpxcGmpE5tfTGWK8/z3IMdam1YuMdnS0F+uKls=;
        b=qdn9hOLl3FZjUZ4XC456N0ag7sMJ7Hl4SPKY6WLfIKlJ8qCe5dms9ehgDfGf3Zoq2t
         MKNpMigfVgskwRmuXTVhWtSHNxyCED6+v+Y+FTUqZpZhlK0esRTBXZcvNAOFAcmWU23e
         fAud+Y+p8o8Ze7ngtTjLxyJvNDfCb/JQu1wxrZjB6x1hH1fZKofu/wkn8AVTe6vFW7f2
         oXW/5MPQavZWnXuYIEQASoxbuKGFxhojenZrRv3hPodGZ46BcIUOIiZTag96Zp8j33UF
         4ZtctZmFjv0GW/jAIq7X4XEfpqxP7u2xpbsRxNgBb9lwq4nRBhH/FrgzQy1xMVdyn1zB
         ZgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692622147; x=1693226947;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iacDazpxcGmpE5tfTGWK8/z3IMdam1YuMdnS0F+uKls=;
        b=dFODZWhzC9LLTdh30tYIMpME+sLS1JuR3yuPiC+FOto49nq93GpokOubfbMef+hDik
         bKotfX50DU0yjxN/xNNL75WRhwf90CEUpOxKxAKy0y12Y8BoG+gzMhVTyvNwFWl3AqlA
         /WMJFkOpJlnAUNDml67Lk8E38b8LnUq52zjJ8av+Pryd86iPv2fGo4F25oEAb0ME5WQc
         k1DUtqVlAYsvHCu4B0pr1AS9vTDmsY1G5Oy9kjxB5cxtBlbquLvkp2HDm++s/rK8qD5o
         mLXEv2HBOdS/lQkXJ6BezBalyCDcKkn2wndcVGD8ghlfzjzCcvxOwMkCMRDv11GjrDdf
         r/Fw==
X-Gm-Message-State: AOJu0Yw5aUJTftZ1//NZqjseHUMdrUd3ijd7qhlFp6NgrXwuXS9dNf4U
        RJFKpL0j1GJ+Eu9FpLYXxeCjU7/iHXo=
X-Google-Smtp-Source: AGHT+IHMwGWx86xyqQM4rb07RfmQ5L+k+9ByQ27QL9Ia58iNbXnzCXNyuMlJa+hKohrW+mvFfT6RNw==
X-Received: by 2002:a05:620a:28d3:b0:765:48af:ded5 with SMTP id l19-20020a05620a28d300b0076548afded5mr9537568qkp.11.1692622146720;
        Mon, 21 Aug 2023 05:49:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.154.28])
        by smtp.gmail.com with ESMTPSA id 19-20020a05620a071300b0076c72dad35dsm2439999qkc.63.2023.08.21.05.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 05:49:06 -0700 (PDT)
Message-ID: <64e35d42.050a0220.f83fe.81c2@mx.google.com>
Date:   Mon, 21 Aug 2023 05:49:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7046618339361315681=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Add support for handling encrypted BIGs based on BIGInfo reports
In-Reply-To: <20230821120014.28654-2-iulia.tanasescu@nxp.com>
References: <20230821120014.28654-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7046618339361315681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=777862

---Test result---

Test Summary:
CheckPatch                    FAIL      7.08 seconds
GitLint                       PASS      0.76 seconds
SubjectPrefix                 PASS      0.26 seconds
BuildKernel                   PASS      40.50 seconds
CheckAllWarning               PASS      44.08 seconds
CheckSparse                   WARNING   50.02 seconds
CheckSmatch                   WARNING   135.66 seconds
BuildKernel32                 PASS      38.60 seconds
TestRunnerSetup               PASS      586.89 seconds
TestRunner_l2cap-tester       PASS      33.68 seconds
TestRunner_iso-tester         PASS      69.55 seconds
TestRunner_bnep-tester        PASS      13.64 seconds
TestRunner_mgmt-tester        PASS      257.14 seconds
TestRunner_rfcomm-tester      PASS      20.40 seconds
TestRunner_sco-tester         PASS      24.45 seconds
TestRunner_ioctl-tester       PASS      23.13 seconds
TestRunner_mesh-tester        PASS      17.27 seconds
TestRunner_smp-tester         PASS      18.23 seconds
TestRunner_userchan-tester    PASS      14.51 seconds
IncrementalBuild              PASS      71.39 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/2] Bluetooth: ISO: Add MGMT event for BIGInfo adv report
WARNING: please, no spaces at the start of a line
#130: FILE: include/net/bluetooth/mgmt.h:6:
+   Copyright 2023  NXP$

WARNING: please, no spaces at the start of a line
#183: FILE: net/bluetooth/mgmt.c:6:
+   Copyright 2023 NXP$

total: 0 errors, 2 warnings, 0 checks, 70 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13359355.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============7046618339361315681==--
