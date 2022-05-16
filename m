Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BBEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 May 2022 11:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241674AbiEPLK0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 May 2022 07:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiEPLKY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 May 2022 07:10:24 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75582F001
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 04:10:21 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b20so11936015qkc.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Br+Yf+yRAEc/NpIwv8eI5oC4ndFDqx5ggoPui0zwsjg=;
        b=nxhYwW3FS9SzS2sjdBcyMa7lEV7dUhe0Z5ZVDSuf2CqEiZeW4PFt6b+fAHF5Sg9DTp
         vDpGXZODE69CEBFyMNolPpe1BrdlsBuDbZ0OD3lO0DYxIWHYxNIfN4razpWfQkPIknsQ
         iq6E5kPCBfpjveqlgC3epDXI+4WFcGiPZHs8HDPq6t9vxGBiqLHcg7KijL6V4bj1uD2F
         qowlgop0YrWAA+dT9zZy3Iv76JjQ2DNST1gaJEXN+XwHErXiSkFVg52FHJuv6aRfqKp+
         H3XBsTQjGMfzias+69aW7YY0OtJ1sOLYD/WhRU2oTTN3gzeAL0pp7tQz8WSOJIFU8yAh
         UnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Br+Yf+yRAEc/NpIwv8eI5oC4ndFDqx5ggoPui0zwsjg=;
        b=2x9KuvN+JcF/xRds9i9IzAuX+6xQQUEt97fJGfY0dnob3k2NZyvRpCnQeQQgu5LN3+
         SX7bpA5aplCjzgsLl3EXK0lSvNNYlkLh/N0zdfPZfNm9YW8UpjxQXc5cLK2ZxO0e6QmQ
         6NqmdoUJl6kOpqNyXN0c7A6dQA+XKNSDQnnNc5+0OlC/aAkJ5bfUKc3BeRkqYIbxpImA
         8rOk9tmJTw2H6BBdMHFscXXyb62q12nOxM8WxkzIHACWpfAaERG1npIdt65CnmEuuUeE
         /E2U3fw35IgeR7H9h4X9yn6T8b0nQsDKuDHNVMSId2glN/0gqCUsvXd2OqzBu1S6Jvfj
         OGEA==
X-Gm-Message-State: AOAM530IpVc8M10IlfyHgk5lj/EC2BFdRymUpAIMO9FI/lrlMnVUx4nf
        2RAR60SE4kfAgesZWu4kxU19Nb8zX1k=
X-Google-Smtp-Source: ABdhPJy2NR+bdGqf9GLy42gc8jBKI5o9qHUlBSgDhGYXbwl/ZTOhLguvXEbbY0UjmHHW67C3RLDt9A==
X-Received: by 2002:a05:620a:458b:b0:6a0:3399:c9dd with SMTP id bp11-20020a05620a458b00b006a03399c9ddmr11575212qkb.630.1652699420842;
        Mon, 16 May 2022 04:10:20 -0700 (PDT)
Received: from [172.17.0.2] ([20.124.232.247])
        by smtp.gmail.com with ESMTPSA id bi4-20020a05620a318400b0069fcf0da629sm5460273qkb.134.2022.05.16.04.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:10:20 -0700 (PDT)
Message-ID: <6282311c.1c69fb81.9abf.b980@mx.google.com>
Date:   Mon, 16 May 2022 04:10:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8561342715878467119=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dimitri.ledkov@canonical.com
Subject: RE: [v2] Bluetooth: btintel: Correctly declare all module firmware files
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220516103329.516952-1-dimitri.ledkov@canonical.com>
References: <20220516103329.516952-1-dimitri.ledkov@canonical.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8561342715878467119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=641920

---Test result---

Test Summary:
CheckPatch                    PASS      1.63 seconds
GitLint                       FAIL      1.00 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      31.65 seconds
BuildKernel32                 PASS      28.38 seconds
Incremental Build with patchesPASS      38.41 seconds
TestRunner: Setup             PASS      466.83 seconds
TestRunner: l2cap-tester      PASS      17.46 seconds
TestRunner: bnep-tester       PASS      6.19 seconds
TestRunner: mgmt-tester       PASS      103.20 seconds
TestRunner: rfcomm-tester     PASS      9.72 seconds
TestRunner: sco-tester        PASS      9.58 seconds
TestRunner: smp-tester        PASS      9.57 seconds
TestRunner: userchan-tester   PASS      6.52 seconds

Details
##############################
Test: GitLint - FAIL - 1.00 seconds
Run gitlint with rule in .gitlint
[v2] Bluetooth: btintel: Correctly declare all module firmware files
23: B1 Line exceeds max length (96>80): "  https://lore.kernel.org/linux-bluetooth/20220509163259.1513242-1-dimitri.ledkov@canonical.com/"




---
Regards,
Linux Bluetooth


--===============8561342715878467119==--
