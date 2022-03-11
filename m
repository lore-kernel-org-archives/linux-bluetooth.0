Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9471BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Mar 2022 04:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbiCKEDR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Mar 2022 23:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbiCKEDQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Mar 2022 23:03:16 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7EAA7746
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 20:02:14 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id u18so130009qtx.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Mar 2022 20:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1FRmwLHdnWaO0eS++A3sxCi+0h9B6Cw9cB6VAD4NZ1c=;
        b=lqxbmYpNuVAK3vvHw/JUoVz/MvTETX4byEb8CJ2NobxsjpaDCmfKDM7EaCii4JCOZS
         0sIbtvPdrBQn+sANzHp99qutmApHT1xM9ShhY/GYk8wgkO1/E4Ma1Ama5sj/O6AH32tx
         qYxMeyPkFJEH14m4a8AVawy7rOQ2ALurAuJt81jajfkZSem1/6gOl/PUWgnTpOS0NIPj
         O8wuttkoaKmPrIFv4C4Gz0rNnowWMM5enL+LgYevLJCFBkCwYy8Gjz0NY9xPHVocFr0R
         v6nKFr3el8P9ltoqh6zoTIBC6/xbQFaEXat0udLi5dfbx2PS8l6nG9N0My2cfzFg5yVE
         iQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1FRmwLHdnWaO0eS++A3sxCi+0h9B6Cw9cB6VAD4NZ1c=;
        b=shhkbK/81Y24EVjJlhkZ1vQHydZPUYwvguXiRT7ngtv5ti/ratI2u38BdFg3/bKipK
         8hH6HuSsBZLkGq5Dx32bl39o5CByQmVKqLwYfS1iVUkHRybJs/Vj3X7EWmIpq/xC1zCj
         LdSg8M7ei5Gbxy11Q370FJI7rcBpvPzymZ+VYMJwdo3sbumHPF6VDNsJVXDTLE2QsFQJ
         D/zmUBQiSRXCwpEgoAmFmxnxQv2UY4o/vo75yHnDUJOY/7FEvfTxKJyIFg4MJZFtoc+L
         bFWddfC/EvysowBFwVouZfUO7/lAbsIc1xNrAKRB7zQKKCLK8YBMCch2TQPPyxkBj9IY
         Vrbw==
X-Gm-Message-State: AOAM5328/awnn4J+3vwfrbHI0wa5wvCxBV7kWxqO1LDDQOV0UU7K+lhW
        d6AGwhYKebmYONPtU5yVYVvj168OEhmLLg==
X-Google-Smtp-Source: ABdhPJz/avixqeN4jZrPNAu0KgK3LomMA8FXKQAxg6mF8b3m66KqXQJDHMZagxILSqZhTmNMS0o22A==
X-Received: by 2002:ac8:598a:0:b0:2e0:5c40:8272 with SMTP id e10-20020ac8598a000000b002e05c408272mr6690529qte.609.1646971333927;
        Thu, 10 Mar 2022 20:02:13 -0800 (PST)
Received: from [172.17.0.2] ([20.230.19.217])
        by smtp.gmail.com with ESMTPSA id b20-20020a376714000000b0067b21e5d18asm3262249qkc.105.2022.03.10.20.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 20:02:13 -0800 (PST)
Message-ID: <622ac9c5.1c69fb81.ec440.3aa7@mx.google.com>
Date:   Thu, 10 Mar 2022 20:02:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7840632490909304518=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tangmeng@uniontech.com
Subject: RE: Bluetooth: btrtl: btmrvl: Fix firmware filename for rtl chipset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220311032620.28362-1-tangmeng@uniontech.com>
References: <20220311032620.28362-1-tangmeng@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7840632490909304518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=622476

---Test result---

Test Summary:
CheckPatch                    PASS      1.65 seconds
GitLint                       PASS      1.02 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      30.72 seconds
BuildKernel32                 PASS      27.17 seconds
Incremental Build with patchesPASS      36.75 seconds
TestRunner: Setup             PASS      472.62 seconds
TestRunner: l2cap-tester      PASS      15.49 seconds
TestRunner: bnep-tester       PASS      6.11 seconds
TestRunner: mgmt-tester       PASS      98.84 seconds
TestRunner: rfcomm-tester     PASS      7.81 seconds
TestRunner: sco-tester        PASS      7.49 seconds
TestRunner: smp-tester        PASS      7.23 seconds
TestRunner: userchan-tester   PASS      5.82 seconds



---
Regards,
Linux Bluetooth


--===============7840632490909304518==--
