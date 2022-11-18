Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EA8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiKRFHa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiKRFH0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:07:26 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A56988FA6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:07:25 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-12c8312131fso4766030fac.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yNbf8vc+NcUEiA307s0Zv7u54SuP8oCil9XpMCfgbj8=;
        b=iSUpRxCzEQZpYxE/tkN1RPbBbAspHWy2QAumqCC6l5IYBjhoe0ebvEJzfmBXyDTUH6
         QK2lq670grwyiE47JAmt4Sbq8IWWKQSpAJpImnkkbh6U2epw6wcLrBPtJzB1LUuNDswA
         02Wvcfric5UaJY2ehwe+XY5V29fxaPXstCbXbHNxqPo+Mc7MQP3t95la2Lzg9FZt37Hb
         YfTAgF00MgfqqMiKX3tXoxq+5tpMa9TesvejEgGsYFmWcxei202vLfgzUqj69KO9UdxF
         +5FIDbxNI0TBg5jHPCXZJAQCzdoyTM+AjmYxK8h52AT3EMs/3Jky5gmcayLZDWMAm+1m
         wVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNbf8vc+NcUEiA307s0Zv7u54SuP8oCil9XpMCfgbj8=;
        b=xvJUinllHKay5pKvkX1XBuhKyBlp0GR+cue/lKoNn3cWRU8C3yGz5jXo6b1Q2nDcsT
         iV2h+5kB/B0k52SGSRq2AEqg3HbuYae/Xw+zTrxLIKJJlqcfeN15/9/PkOkqExrP8H4d
         S0kABhTKsouwraDV3v3CbGFDfNMUxw9/1wtLpfc9Y+vZFVNvNFV+mZWtCqf8diy5tLHT
         KK668lf9ZoK6A08UCJ1Ogwvu8wn+bFZMvVkCb58bp6kJmKwSS4+cC1fQH2SY0R5KWHu5
         5o+btGzJoyZCarlUIEUl5CoBvef2J2fIgo7MikyDCN3A/7ppIYNpPwbFvIn2THb3V90h
         KQ0Q==
X-Gm-Message-State: ANoB5pmGZi1nqtKWeqF1XFYzdG+9NuebROG3zB0U/k8CSeUMfuSVxxJE
        Mq+BFV8HD712xEMO5PDnUA1LGP90u53OXg==
X-Google-Smtp-Source: AA0mqf5rtsCdnY2opM9xu3sKGoTOu5SJ33QVPCDROamWNhoWqmyLM0EG8sCOS+RNLH6CClDjYZgCCQ==
X-Received: by 2002:a05:6870:4d1c:b0:13b:d695:7a91 with SMTP id pn28-20020a0568704d1c00b0013bd6957a91mr6073307oab.183.1668748044658;
        Thu, 17 Nov 2022 21:07:24 -0800 (PST)
Received: from [172.17.0.2] ([20.225.225.51])
        by smtp.gmail.com with ESMTPSA id h14-20020a9d6f8e000000b0066d2fc495a4sm1195194otq.48.2022.11.17.21.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:07:24 -0800 (PST)
Message-ID: <6377130c.9d0a0220.8de20.5531@mx.google.com>
Date:   Thu, 17 Nov 2022 21:07:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3544591807716804417=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v3] Bluetooth: doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052716.57521-1-hj.tedd.an@gmail.com>
References: <20221116052716.57521-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3544591807716804417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695798

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      43.68 seconds
BuildKernel32                 PASS      39.54 seconds
TestRunnerSetup               PASS      549.56 seconds
TestRunner_l2cap-tester       PASS      19.25 seconds
TestRunner_iso-tester         PASS      20.10 seconds
TestRunner_bnep-tester        PASS      6.96 seconds
TestRunner_mgmt-tester        PASS      130.67 seconds
TestRunner_rfcomm-tester      PASS      11.35 seconds
TestRunner_sco-tester         PASS      10.85 seconds
TestRunner_ioctl-tester       PASS      12.80 seconds
TestRunner_mesh-tester        PASS      8.71 seconds
TestRunner_smp-tester         PASS      10.57 seconds
TestRunner_userchan-tester    PASS      7.25 seconds
IncrementalBuild              PASS      40.41 seconds



---
Regards,
Linux Bluetooth


--===============3544591807716804417==--
