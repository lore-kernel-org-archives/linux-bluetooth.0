Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AA3C54EBC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Jan 2023 10:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjALKmA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjALKlT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Jan 2023 05:41:19 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E96574DF
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 02:35:08 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d16so3149681qtw.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 02:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A3RKxR7l5mYa4Yh4zERlM/38hhOvRSC1pGdBDDMGeQY=;
        b=K6x/Qky1XKGnqHc0JAsP+3bOdRt/jOJl0RWpPKV39O8j+Q1AJSQIEtKagwD4yyAI/8
         +5rrHs7sGKYJm/uKe1kt2/cS1lYOGV+YVpwQ7E1omUVEHiGt0L3oTvtbytULGLp853mD
         Ut/KxWA11Z3na9faRK8clgO5891Q0f6gsns3ppiIt9dRU7L/HF2UzCeXLOulkllalRWB
         AyvaLHErGbXYnCnxmb51J3VLrkwKea08v1sz6vyzt+OQqIv+N8ePK7z5c+77arnjvFTx
         cyn58ABrBRvulI2l9su7wgjz736wLxrpmz0CjUZPKHqZb92J//8f5+vThEy/cqjvCwS6
         jmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3RKxR7l5mYa4Yh4zERlM/38hhOvRSC1pGdBDDMGeQY=;
        b=6Lwv+R/w9ouT6pYbgW5dc5dl+BjdRP2uMCiqsK+c571gJaBhU4daw1mYRn0N//z+RJ
         TWAvA5fvLCwulsKR6VdurPTzBskGHGNrEnK6CJqpuGJ1V8Cfo6cnqGxbWYobmm32+IUs
         /LMxTqfbHGR18hLB5Wvh6yVJFagcCGUMsaOaUXfcEs8Dx4zHnXK4L5N8j6VOH2xR85Du
         5C64DnHCpKvmFyAS8mmRetDMazEiu1dRW2VJv84L1r0nI+wVDqboEodp+BMckPTMtb/X
         jnGDgcSSwkfPB7jpfY/v06civfLMpjpm+HO5uBwKFibFr6bX25go7zlUX+vimst3egK4
         jLuA==
X-Gm-Message-State: AFqh2kq8ULCUz/TpTdzGVRPURNKhAkiKkL2s9myN9nMwr1u9jppPCDvu
        lb8LXG6STrLdt//l4gNwdmwgE1x4tavvww==
X-Google-Smtp-Source: AMrXdXuxj4QrIvuoVWcyDABZqNEsgUXXzXLPjceXwMt8ZrGMK65Z7b7AioZwmM++32uKM3xNRY24Mg==
X-Received: by 2002:ac8:5e06:0:b0:3ab:5bb4:ae6d with SMTP id h6-20020ac85e06000000b003ab5bb4ae6dmr135422703qtx.43.1673519706972;
        Thu, 12 Jan 2023 02:35:06 -0800 (PST)
Received: from [172.17.0.2] ([172.177.106.96])
        by smtp.gmail.com with ESMTPSA id b3-20020ac86bc3000000b003ab7aee56a0sm8904850qtt.39.2023.01.12.02.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 02:35:06 -0800 (PST)
Message-ID: <63bfe25a.c80a0220.beded.ed2b@mx.google.com>
Date:   Thu, 12 Jan 2023 02:35:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1562886034574875610=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, victor@allwinnertech.com
Subject: RE: Bluetooth: btrtl: Add support for RTL8852BS
In-Reply-To: <20230112094240.49794-1-victor@allwinnertech.com>
References: <20230112094240.49794-1-victor@allwinnertech.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1562886034574875610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=711242

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      31.76 seconds
CheckAllWarning               PASS      33.94 seconds
CheckSparse                   WARNING   38.49 seconds
CheckSmatch                   WARNING   107.54 seconds
BuildKernel32                 PASS      29.94 seconds
TestRunnerSetup               PASS      433.26 seconds
TestRunner_l2cap-tester       PASS      16.07 seconds
TestRunner_iso-tester         PASS      16.08 seconds
TestRunner_bnep-tester        PASS      5.53 seconds
TestRunner_mgmt-tester        PASS      106.54 seconds
TestRunner_rfcomm-tester      PASS      8.71 seconds
TestRunner_sco-tester         PASS      8.00 seconds
TestRunner_ioctl-tester       PASS      9.35 seconds
TestRunner_mesh-tester        PASS      7.10 seconds
TestRunner_smp-tester         PASS      7.89 seconds
TestRunner_userchan-tester    PASS      5.81 seconds
IncrementalBuild              PASS      28.34 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============1562886034574875610==--
