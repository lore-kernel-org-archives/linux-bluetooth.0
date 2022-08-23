Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DECC32772
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 20:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiHWU13 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 16:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiHWU1O (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 16:27:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3116F74CC8
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 12:59:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e19so13751653pju.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 12:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=NV3zYNsZs+FTfXjcTABH2HnMUzE5xJZekcPCzWxW39s=;
        b=TFp+RO1l85qx9y4ty6XJLePsLRqZGkIJsKsJ091hDlQIjoqSwljf5Y3+lq84JAROwC
         xLCcx+bwsHhD4myqDC0FXYB0+/gqKmA8RDPUQZmmVrhpUzPCdezlLpJ/HUiUpcd1NKnq
         C9Tus7DhuoVk4rJHk8/e0ZuMkIppU5QL9mB49opQODCe8t8dmUsRReSOj2wKchKrTgit
         srgh5QmH73JWvlCHIhgfsQ0U4ZpvsrEF2D6pcilqSACDLUvT5XA222VKgZYKokjHWEqT
         8UamDYaPArBuMEL5vIFPHmWZPVkO6UgkX33uud6Jnf1O78x/IZ9SHvm/KmDEj8Hq2bNb
         Hefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=NV3zYNsZs+FTfXjcTABH2HnMUzE5xJZekcPCzWxW39s=;
        b=Xqji5mgXnH1u6wtH7HFGz8hnVjwDt2VCpmTdx+EUax0Zg5yXqXje0B14k7BMhSgIlv
         OnmoH05QXPkMENVce9c7HqLNN4gl6aC6FKWFUEviiQmm5HFsJ40nZCu2acxrprWsdZFs
         uiaS+MPxEKyc/pOr007Zdp+1b+aRPaYFOogjELk/l1ZrvOP1Ea3ouTHat9X1rv2GhGI+
         aNDIFud2ZbfDlXpyifc2o8RZE3CDnAraEQwrbuRt+kAxScyj6uI0Y1sn7+elqLkR8C6h
         0m87uS+N575Gxm6C/iQu1b03F9zHPoz9BIByzY844vQ+zZHMwNU87UzkHRaxyKzXdIam
         VhEQ==
X-Gm-Message-State: ACgBeo22RQAEfS6tForuxc1Cr2YC722A29nt65LgXAz3FYI0oaVn5Mda
        GmKjerkZSdUlGj+h6DzoCOpDJJx1soUCog==
X-Google-Smtp-Source: AA6agR6WNXpAeAgpKvUF5o6JyDqcfMlslN7/KoNclhkAT0g74/qWwSXhFTLg/ghg6qC0DBhhuci72Q==
X-Received: by 2002:a17:902:f64f:b0:172:a790:320a with SMTP id m15-20020a170902f64f00b00172a790320amr25568359plg.149.1661284793474;
        Tue, 23 Aug 2022 12:59:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.180.89])
        by smtp.gmail.com with ESMTPSA id r35-20020a63fc63000000b0041bfa382dfesm9510328pgk.67.2022.08.23.12.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 12:59:53 -0700 (PDT)
Message-ID: <630531b9.630a0220.3794c.1636@mx.google.com>
Date:   Tue, 23 Aug 2022 12:59:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1440162200455913048=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: Bluetooth: hci_sync: hold hdev->lock when cleanup hci_conn
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220823102800.kernel.v3.1.I1d10fc551cadae988dcf2fc66ad8c9eec2d7026b@changeid>
References: <20220823102800.kernel.v3.1.I1d10fc551cadae988dcf2fc66ad8c9eec2d7026b@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1440162200455913048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=670367

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       PASS      0.50 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      41.03 seconds
BuildKernel32                 PASS      37.01 seconds
Incremental Build with patchesPASS      52.46 seconds
TestRunner: Setup             PASS      590.16 seconds
TestRunner: l2cap-tester      PASS      19.08 seconds
TestRunner: bnep-tester       PASS      7.51 seconds
TestRunner: mgmt-tester       PASS      122.65 seconds
TestRunner: rfcomm-tester     PASS      12.16 seconds
TestRunner: sco-tester        PASS      11.78 seconds
TestRunner: smp-tester        PASS      11.16 seconds
TestRunner: userchan-tester   PASS      7.64 seconds



---
Regards,
Linux Bluetooth


--===============1440162200455913048==--
