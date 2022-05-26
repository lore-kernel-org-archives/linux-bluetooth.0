Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5F8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 May 2022 17:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbiEZR0J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 May 2022 13:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiEZR0G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 May 2022 13:26:06 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ACA22BD9
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 10:26:05 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id m13so2554236qtx.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 May 2022 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=M1XxUGIXbtR0u55oVYA3AOTqC/+Nl+4G7NhJ+4h85vY=;
        b=ivQAx/ppIgVQmJnEDbcBT7rccYmELklAWk1r5MVpYW90fn9OgykK6/YtGi6wUTgj4/
         BSQ3vdkivREsVuBDLdVllYgYfGILtgLrHcNWDxG6RhsvdKhLN2y3orwoCILdMKYaNq3V
         Dtsmp97XGwSTFGCxb1DZEV5HpoheZOYl8uMY1VrcRknfB10vV1Ejg9+fau6CkaPnIDnc
         InKcDRmB07BsaIdPq7lRE21xvWvxM2ZOl8lztO11jxrCA26cf2Rs6b2OHHsmgS+5AZug
         hjOnKIi7zMRCUY6Mu/a+yDBiYqR86wBfVkFrUGv/snocJcMckuRnWWCaiKr3Vyi9tGrR
         kdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=M1XxUGIXbtR0u55oVYA3AOTqC/+Nl+4G7NhJ+4h85vY=;
        b=dq9iIiMOlwtMOz0XDlR9a4HW8OBcDBihj8Dl5w4iOW58vqnAdwmJ1Blf3iN/XODzX2
         jNdVfGzV10xzqmzN65iK9eudOYVJhu1Qhc4tULNoWDg9v1A7lTKWSHlGAqFZdwdhea6r
         ULJxpDcmRoSt6yT8mzMbw/YAK+WPdgrcu1f68O7F033Dnkm3XReC4+4Vt0DTqbN51cub
         7AbV4RiWWXdGmHysH+eXAbAeleEsG9SsHciufFUJNjBUm0sq8HJOF0JwogcSYvVxEkGS
         Kr/N3rFeJqVs7m/oD3AQRA61h40vGSXG93GO5pXbi4YjtsfIwHdXITcDRebXGAwwiVPo
         FPtg==
X-Gm-Message-State: AOAM532kGEJDjXUk3a4zrAgCuwxFG4KfQDKVJpiHdrAKWxz2yeFQgcxA
        rcslvs5vwiD/KwrTocSi/IwI7KMRMko0Ow==
X-Google-Smtp-Source: ABdhPJzbUT7zTXvbfVlSkYmLZgpKpTIQNM52XRJ3Y7PcU9jRGJTIfZwmhJaaxvv+CIFC5Z9iWwGeZg==
X-Received: by 2002:ac8:7fc2:0:b0:2f3:d47d:487c with SMTP id b2-20020ac87fc2000000b002f3d47d487cmr29675171qtk.157.1653585964773;
        Thu, 26 May 2022 10:26:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.25.165])
        by smtp.gmail.com with ESMTPSA id 17-20020a370711000000b0069fc13ce1f2sm1464076qkh.35.2022.05.26.10.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 10:26:04 -0700 (PDT)
Message-ID: <628fb82c.1c69fb81.79ebf.887b@mx.google.com>
Date:   Thu, 26 May 2022 10:26:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5235381562928145683=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com
Subject: RE: MAINTAINERS: Remove me as maintainer of 6lowpan
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220526162806.16618-1-jukka.rissanen@linux.intel.com>
References: <20220526162806.16618-1-jukka.rissanen@linux.intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5235381562928145683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=645314

---Test result---

Test Summary:
CheckPatch                    PASS      1.60 seconds
GitLint                       PASS      1.03 seconds
SubjectPrefix                 FAIL      0.87 seconds
BuildKernel                   PASS      37.90 seconds
BuildKernel32                 PASS      34.77 seconds
Incremental Build with patchesPASS      49.77 seconds
TestRunner: Setup             PASS      566.65 seconds
TestRunner: l2cap-tester      PASS      19.64 seconds
TestRunner: bnep-tester       PASS      7.04 seconds
TestRunner: mgmt-tester       PASS      115.42 seconds
TestRunner: rfcomm-tester     PASS      11.07 seconds
TestRunner: sco-tester        PASS      10.83 seconds
TestRunner: smp-tester        PASS      10.69 seconds
TestRunner: userchan-tester   PASS      7.39 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.87 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============5235381562928145683==--
