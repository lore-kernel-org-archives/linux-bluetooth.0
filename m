Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BF4C001DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 06:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjHDGmt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 02:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbjHDGmp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 02:42:45 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B094687
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 23:42:37 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bc9d16c317so1539433a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Aug 2023 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691131356; x=1691736156;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YbXBsRsxPKfJCb3vfuBURToqIBagAXMRJBrhebrG5bU=;
        b=Bg77FMX3AVJLuHnlavTX7rG53jTdQefRxa4D+jcpi92KeYZ8/9XA9Gnm6JN5TyCj0H
         HVYvCefNTnRj+d5gNG/4javg24qdgGQGqdtgu0DznhsN7rg5unS0DrS1sr+sXraiNMig
         owIZB9p2RK8NbJVjubbG2I1JW1i7gsnwl1DBaQbt1lv65QTyhmpyPBdNN6S6NMjo4Wgm
         WlwuPpoZoK8h4AphQaslSqt0u8ReaTjE7wnr+wZu+BrFPSRLkcFAN4LQwR7egYBWzTAl
         Bnavj833n0rc+Cw/YDVkx435gkQM3p4sP7w35la3jVWHRTRfYeQ7aqJSSVNAX3sFJC+X
         zeig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691131356; x=1691736156;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YbXBsRsxPKfJCb3vfuBURToqIBagAXMRJBrhebrG5bU=;
        b=hqKJpmFchLepNsvVBJcgpk3HNUd1DgCs6kT2Upyd3TVJYElB8HYWLLeexDV3psf23C
         aUWy4A5u/pvvwJRtvjki4wii3YudHKdKPtwTEaxgteWCyGsDdghBzupVJUbnTLPN+e/f
         WwNxkt7GURUCpLAn/UKt75YhCSmFh4fPbLHEysG0pbywtFvH5VESQdbaUZpIMSuFd9Oq
         1APVJ6saKuWJPyhuQWcGE3UqBemhJMvSsfbqsjvGz5ptak7tiIGy0G5jsHrwCz8AXD+A
         XJ35fGEQ/h+4m040STCQHDJvERFD3twQ/BrspT2r/kL6NskQ1qk/cdtxo/RGsweZctio
         02BA==
X-Gm-Message-State: AOJu0YxZCvbmOOj3/G+8Wmy9muPCxNVA1TUWNItmSzlNWf3XLMCXg3Bs
        MJ4J7MIU11/TPirc5HBP/uD3B5pxYZ8=
X-Google-Smtp-Source: AGHT+IH2TzAB3qyaeae6TmDPygEOhbsmQ0KKPQ1qgnG+oW0j6RdLFcleRuv9+yOa5/ckRoSWWmvdcQ==
X-Received: by 2002:a05:6830:110c:b0:6b9:6f2e:f5ca with SMTP id w12-20020a056830110c00b006b96f2ef5camr790656otq.17.1691131356224;
        Thu, 03 Aug 2023 23:42:36 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.171.157])
        by smtp.gmail.com with ESMTPSA id q24-20020a9d6558000000b006b1570a7674sm818520otl.29.2023.08.03.23.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 23:42:35 -0700 (PDT)
Message-ID: <64cc9ddb.9d0a0220.9c8b8.6312@mx.google.com>
Date:   Thu, 03 Aug 2023 23:42:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5638673438851167851=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C
In-Reply-To: <20230804055426.6806-1-max.chou@realtek.com>
References: <20230804055426.6806-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5638673438851167851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=772909

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      39.99 seconds
CheckAllWarning               PASS      43.73 seconds
CheckSparse                   PASS      49.47 seconds
CheckSmatch                   PASS      133.81 seconds
BuildKernel32                 PASS      38.42 seconds
TestRunnerSetup               PASS      584.50 seconds
TestRunner_l2cap-tester       PASS      27.97 seconds
TestRunner_iso-tester         PASS      65.61 seconds
TestRunner_bnep-tester        PASS      12.80 seconds
TestRunner_mgmt-tester        PASS      240.32 seconds
TestRunner_rfcomm-tester      PASS      19.06 seconds
TestRunner_sco-tester         PASS      19.72 seconds
TestRunner_ioctl-tester       PASS      21.54 seconds
TestRunner_mesh-tester        PASS      15.89 seconds
TestRunner_smp-tester         PASS      16.95 seconds
TestRunner_userchan-tester    PASS      13.11 seconds
IncrementalBuild              PASS      36.24 seconds



---
Regards,
Linux Bluetooth


--===============5638673438851167851==--
