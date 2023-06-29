Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974CFEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 14:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjF2OhE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjF2Og7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 10:36:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5395E4C
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 07:36:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b80b343178so5121815ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 07:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688049417; x=1690641417;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TokwA+/dOAYsSpsXVgBgQ7HhtOdmI9oW9+BETkud43k=;
        b=UObcQouuKV6nztfip5mSFKXNJN5QJatQc6JMJNoNdNgLAaF32tnTJHL6tp6D+1JNEN
         RmbkS8228IkLdg//Y+zXIOVEvcVeybnepR/CQ5qknksotUESzQdeUgoWxEFdj4iLGadd
         IcpgDNG3semF6Yq4/NWuG9Cd0569r6ERAha8YM8wdZsmLPQ60pcwl/1SX7uHzhPohJwo
         A3aVCRABDnhHWyXaXTmPz6H/7Zo9v26shBLWEMNccbyYzjofAkD5qXcCeh7OTh5nkSGv
         BjqNI5Rcy2LkUbgtVVCkaWmYnReyAM9WmgwO3SwFFj5HITQP8cePd9xHaz7QoojOZbfH
         Ajwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688049417; x=1690641417;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TokwA+/dOAYsSpsXVgBgQ7HhtOdmI9oW9+BETkud43k=;
        b=h4jKkpU6pax90Bd/1MeUflkEIGJg+mKXdYMx9beuWX1xsfU4EGROvcsEDkP8tPgOQP
         a8M2ZU3rQotEhwvdQEN5HWY7DGH6L4WvtnJWrdcq91Wx9ltSdN/T0XukxlwEMCJ5VfS/
         rxDsYQyqFKBLOps32O/UXFFT0/BSSG/HoPMmUl5Bl8h3zplEvKNsqZu6Rjf8Le/bp3lY
         rG3cZsQp+UcMp//t0ZjBlXplGckbRnmXswq4D0fsZCEVQSDXM1Kiuqle0xuBoGjaAt/H
         3K78pM6AJn2uebg/IUTatX7Mer1wBBSHyYyF6nmKFcc7vjH6++ijLIKlei7c/8zrxNyC
         tFGg==
X-Gm-Message-State: AC+VfDwZL1z++Bdzb9j6uDr/2ck8UC7BvpM5Al5kTTa/BcuzW1tuY6H+
        TuhNHO/NBnUqgwyRtDtWS6XTbzOhqMMsNg==
X-Google-Smtp-Source: ACHHUZ4d4Aata+mZSiOA9OfrGIGin8VUhjTJrnhwfFIdOZqDg688TNuMaJToeVnCVKKmx63ATF6lGg==
X-Received: by 2002:a17:902:ce8a:b0:1af:b957:718b with SMTP id f10-20020a170902ce8a00b001afb957718bmr15828811plg.39.1688049416851;
        Thu, 29 Jun 2023 07:36:56 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.168.229])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902988c00b00198d7b52eefsm9200321plp.257.2023.06.29.07.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 07:36:56 -0700 (PDT)
Message-ID: <649d9708.170a0220.2e096.1eda@mx.google.com>
Date:   Thu, 29 Jun 2023 07:36:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2134990040577020801=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Bluetooth: hci_sync: Enable events for BIS capable device
In-Reply-To: <20230629134518.5574-2-claudia.rosu@nxp.com>
References: <20230629134518.5574-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2134990040577020801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761243

---Test result---

Test Summary:
CheckPatch                    FAIL      0.99 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      39.51 seconds
CheckAllWarning               PASS      43.33 seconds
CheckSparse                   PASS      48.93 seconds
CheckSmatch                   PASS      131.35 seconds
BuildKernel32                 PASS      37.67 seconds
TestRunnerSetup               PASS      531.43 seconds
TestRunner_l2cap-tester       PASS      19.55 seconds
TestRunner_iso-tester         PASS      28.30 seconds
TestRunner_bnep-tester        PASS      6.62 seconds
TestRunner_mgmt-tester        PASS      146.37 seconds
TestRunner_rfcomm-tester      PASS      10.72 seconds
TestRunner_sco-tester         PASS      9.91 seconds
TestRunner_ioctl-tester       PASS      11.47 seconds
TestRunner_mesh-tester        PASS      8.51 seconds
TestRunner_smp-tester         PASS      9.64 seconds
TestRunner_userchan-tester    PASS      6.91 seconds
IncrementalBuild              PASS      34.60 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v3,1/1] Bluetooth: hci_sync: Enable events for BIS capable devices
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#93: 
In the case of a Synchronized Receiver capable device, enable at start-up the

total: 0 errors, 1 warnings, 0 checks, 13 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13297055.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2134990040577020801==--
