Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6ABFC001E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Aug 2023 15:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjHJPgi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Aug 2023 11:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbjHJPg0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Aug 2023 11:36:26 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AABF26B6
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 08:36:26 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-63d1238c300so6370866d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691681785; x=1692286585;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1eGE4NG5ZR5r2jLbgm9pljE4bD2fiyF5JeAD6rweiDI=;
        b=F2ReE/OVl+ZxoD+mYq/x6EWZQPInOUOMY1Wf1d5Tpg20Jd08lRiqRurdq/ylywo6qt
         GJu7fBwlYEoukID0xAz9hxiFpUTXKoWa9UJPrgTbMfo/N2SpGSDyhte4uzO4mX1FWDfF
         T16AZJcHsoTRXkMEZ8VSBmQ91a1izlH6Vc0N3qMLa0qWyB1FaxIYAgKZUQgwoNVaUqLr
         d2yaBieODgacAbEXxXJViEzT0lLRbR2R0TNgdz2QJM4/2C/LekiCbi2PAEtR184HLdYV
         PrIIrOMjXWENraF8KxR3sdt5lfspam5lWT+va9jo9jakWCd5vP+0LXlrEu/TQvIlWALH
         KtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691681785; x=1692286585;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eGE4NG5ZR5r2jLbgm9pljE4bD2fiyF5JeAD6rweiDI=;
        b=QcREsNGMgsWpk9NXwNpm+DT85upvvEeMV+cFXJDV3BXjr2/+5njLgLpq/X6cPJ4oBk
         gj/r2LSbpO6hK1JvTBvDmNZH56RzlCipa1cOXU3kqxNJXMbS/ECHBM0HBnKqO0cbF0lr
         sTGkVeNtusEZNbnePv/ceK//P1qCgXSbVks6SeCPSzAhYRVyGIxBTX3aMjyj8crHtrR4
         3qdL2Akq2L8J/8dzbFGkbZdBhLbjRbWIUlFSjaePUzi1EHqm56FH5/XapfirdHqTTO0M
         tTFoEc85sSIAYUhbc5lNTU12zmilAHTZ96jNQqMpo7QmlbuF+lSaz/uEqVB1fscRNE3M
         bwNQ==
X-Gm-Message-State: AOJu0YzKRxrwwlsRHQLYYe0/iKQEKkElKRppO9osCL1vjE8Qxz7DsUzz
        upax6vFftj825p+wkbDnP9vki6INbps=
X-Google-Smtp-Source: AGHT+IF9e+KYm4HEaPL5WlkzzOxccTJABBRh6Dz/NDyEPII5yeaNhcKFBDxX4kIul+TZMWWSO2MPpA==
X-Received: by 2002:a0c:d7c3:0:b0:63d:54de:afa with SMTP id g3-20020a0cd7c3000000b0063d54de0afamr2636994qvj.52.1691681784927;
        Thu, 10 Aug 2023 08:36:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.44.0])
        by smtp.gmail.com with ESMTPSA id k9-20020a0c9709000000b006360931c12fsm560760qvd.96.2023.08.10.08.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 08:36:24 -0700 (PDT)
Message-ID: <64d503f8.0c0a0220.b28f5.2191@mx.google.com>
Date:   Thu, 10 Aug 2023 08:36:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0720480993246072956=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lokendra.singh@intel.com
Subject: RE: [v2] Bluetooth: btintel: Send new command for PPAG
In-Reply-To: <20230810145653.1780-1-lokendra.singh@intel.com>
References: <20230810145653.1780-1-lokendra.singh@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0720480993246072956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=775020

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      33.09 seconds
CheckAllWarning               PASS      35.67 seconds
CheckSparse                   PASS      41.00 seconds
CheckSmatch                   PASS      113.97 seconds
BuildKernel32                 PASS      31.62 seconds
TestRunnerSetup               PASS      477.82 seconds
TestRunner_l2cap-tester       PASS      22.40 seconds
TestRunner_iso-tester         PASS      44.84 seconds
TestRunner_bnep-tester        PASS      10.03 seconds
TestRunner_mgmt-tester        PASS      215.11 seconds
TestRunner_rfcomm-tester      PASS      15.19 seconds
TestRunner_sco-tester         PASS      18.28 seconds
TestRunner_ioctl-tester       PASS      17.03 seconds
TestRunner_mesh-tester        PASS      12.75 seconds
TestRunner_smp-tester         PASS      13.69 seconds
TestRunner_userchan-tester    PASS      10.55 seconds
IncrementalBuild              PASS      30.00 seconds



---
Regards,
Linux Bluetooth


--===============0720480993246072956==--
