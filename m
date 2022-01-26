Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDA8C28CF5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 09:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbiAZJBR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 04:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiAZJBP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 04:01:15 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F95C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 01:01:15 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id g11so22289632qvu.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jan 2022 01:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=iko48Lj6ufCj7/am0xWXB5yUuRjxLoZ4P58zTLESiNs=;
        b=Dh6CXpRVaDVP9NKtO75miKFz/zbeEhIAw3txNZDYN3SdNylfw0W36RalpDDQ/PLFjZ
         O+3JTWnN8ByrWKAH3XCma8R7RqMLkADjfJlrJeA3NTiAPCwm2rryGOEe7PBqVrE+WOaM
         ohFX8wh8HuWSF9NAvy+sHh1FlhLyBtkPSyfCgfx0KcBn4LI9PVsZTuScckmJ0DVLkfG+
         jsRyrxqnxaQCKRj6BoWb6h7X4kxiqVdtmtCULcRYY6B2oTQrZEXGNSdGOESTy8imWZm3
         QxIjrOul0qJ5PkLYi2eMEZNaCw31Es9wRqS5hWsjLIWBeC5tIltc/kpZK5B5kN5qByp9
         Cing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=iko48Lj6ufCj7/am0xWXB5yUuRjxLoZ4P58zTLESiNs=;
        b=7Ztc0ruUWXHFcb8JXttoBcLDR2CZzBkRHLaHDopdxjuNSmk4UabYrpwes3P+3W50Lh
         mM9ux3IwFSZKK9rv8rXxjQR7lpvBUxGdYxKN1+aHW8zU0cJ/5exgGwhUVxPPHNOmCzt1
         gT36HhwTG4fLNkl8DF+To7uLWcjK1sNpqu5KCmEOGevkwNAAuP+Lu4oV4t0Ts5GJ2Fpe
         LZAsn/NXzVkcjB6oPWvwSxO+Lgx3bpqjivtbuB9Zd7vKPFxzcvLypE3qEHcXlNpqyaVz
         yzq2I9nspCHQC1+GeZ8Gos9Vd+Nimyw6EKV7JBd8FZUA4QuPFMH9yInK8L3TNHvPr9Mr
         HCKQ==
X-Gm-Message-State: AOAM5339UAAm1i86drLEm64OZydY/yDO22/2u3hVYMPKLG7nuJAt78ve
        XolrgunOwvhnxRJmgORIdnmaZjoi/B0k7g==
X-Google-Smtp-Source: ABdhPJwPDebQTMWq24zBPmEWY+Ds1sZgUK+wASVPMlWiNsdz0+TDONMGMZbcycdc0c341peot/9UcQ==
X-Received: by 2002:ad4:5cc6:: with SMTP id iu6mr2512129qvb.2.1643187674510;
        Wed, 26 Jan 2022 01:01:14 -0800 (PST)
Received: from [172.17.0.2] ([20.110.199.225])
        by smtp.gmail.com with ESMTPSA id x4sm1641924qkm.47.2022.01.26.01.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 01:01:14 -0800 (PST)
Message-ID: <61f10dda.1c69fb81.5dbba.94e1@mx.google.com>
Date:   Wed, 26 Jan 2022 01:01:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1688413748838057953=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, adeep@lexina.in
Subject: RE: Bluetooth: hci_h5: btrtl: Add support for RTL8822CS hci_ver 0x08
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220126073905.3637841-2-adeep@lexina.in>
References: <20220126073905.3637841-2-adeep@lexina.in>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1688413748838057953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=608555

---Test result---

Test Summary:
CheckPatch                    PASS      3.17 seconds
GitLint                       PASS      1.85 seconds
SubjectPrefix                 PASS      1.66 seconds
BuildKernel                   PASS      30.22 seconds
BuildKernel32                 PASS      26.49 seconds
Incremental Build with patchesPASS      41.70 seconds
TestRunner: Setup             PASS      464.47 seconds
TestRunner: l2cap-tester      PASS      13.18 seconds
TestRunner: bnep-tester       PASS      6.00 seconds
TestRunner: mgmt-tester       PASS      102.76 seconds
TestRunner: rfcomm-tester     PASS      7.29 seconds
TestRunner: sco-tester        PASS      7.65 seconds
TestRunner: smp-tester        PASS      7.42 seconds
TestRunner: userchan-tester   PASS      6.24 seconds



---
Regards,
Linux Bluetooth


--===============1688413748838057953==--
