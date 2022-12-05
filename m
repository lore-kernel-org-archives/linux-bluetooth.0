Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64345C4321E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 14:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiLEOaX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 09:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiLEOaV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 09:30:21 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687C412767
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 06:30:20 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z9so5138490ilu.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Dec 2022 06:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y8gj5/pWWjOsARueaeu5SE+HHBrr/XOL7DTfccem6cc=;
        b=VBfC/DrOzebPiS37916VBkr9Cr1Ffpwh+Y503RUWlqgv2dLbCZf6oN4YaTN5npAoAF
         G/MjiI437JCahtfQmhJVzhmdgL+0Z1D6qfJbSmeRf56z5h7ggbwpONY/3Bzot+Te+NZm
         qUgyR+BsNv+Ex3UA/IjzI0uD4bildOZc2lGa6nmUntpEPGd29VlIIeK+2pOumx3C/Qf8
         PfreL3uRsZ0ZAfdAwjOSJ2oFkOwNmKT7gtv/EKlk6XNbNym9AhFmZ0qlHypk7U46oJ0N
         MZ/sDy+ZAPciZsxqxaElIhwtNnwXCjGG1kxQNIoJZtD98R61eMcEwbXmYjheEmmsOohn
         smwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8gj5/pWWjOsARueaeu5SE+HHBrr/XOL7DTfccem6cc=;
        b=pjGqTvkSH4Du1Ty7d57WiL4Kr/RJCGWA152GDRezGvAR9Z9wJ/6Xww8H9kdxnPZle9
         Qmm/0n5TLPTosD0jR9M83SRTbkvh29/nBLO8cwpglaDvlnt9wR6DNYX9pR4YkMBGKoBA
         Fw7DvcDEp+cJfUDhRrc6kc6d7w9CrxyG02WSlyKGt7HHaK/vN1Qf+XYqQKvLxxoAUH4Z
         anStwiEqnsTSRh1k/j/D3b0ayazY5Pf9kgdbfh7/b4rEDfPgF5/7VE2e6I5Gkr2A3mI9
         IRMu6C7cUdOdGrxr+Ah8X2yo6/zXdWWPTmhfzeL/wXOYxsfPQ2wvtiLkTBkUUfPyjZgS
         UoOw==
X-Gm-Message-State: ANoB5pnQOTegEeiK4vHemTaJ3qv0FaQJxZGb00ipzsg14Ej7+j/kmBg0
        9wMBINreKwCPwXAwrjaVIiEm6n1MHSI=
X-Google-Smtp-Source: AA0mqf7vFXIFWs/LBgjbuj2ciY0IlnY18BvQfdt4IfIPc63IOCkF25bAxM7neRYTSPq9HDgC+9ZOfQ==
X-Received: by 2002:a92:d144:0:b0:300:5d50:15d3 with SMTP id t4-20020a92d144000000b003005d5015d3mr27455377ilg.173.1670250619570;
        Mon, 05 Dec 2022 06:30:19 -0800 (PST)
Received: from [172.17.0.2] ([20.12.237.122])
        by smtp.gmail.com with ESMTPSA id z29-20020a05660217dd00b006dffde23fa9sm2865285iox.24.2022.12.05.06.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 06:30:19 -0800 (PST)
Message-ID: <638e007b.050a0220.901b1.3985@mx.google.com>
Date:   Mon, 05 Dec 2022 06:30:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1786916585663430043=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bobo.shaobowang@huawei.com
Subject: RE: Bluetooth: btintel: Fix missing free skb in btintel_setup_combined()
In-Reply-To: <20221205135357.3961836-1-bobo.shaobowang@huawei.com>
References: <20221205135357.3961836-1-bobo.shaobowang@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1786916585663430043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=701819

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      34.44 seconds
BuildKernel32                 PASS      31.16 seconds
TestRunnerSetup               PASS      429.86 seconds
TestRunner_l2cap-tester       PASS      16.41 seconds
TestRunner_iso-tester         PASS      16.21 seconds
TestRunner_bnep-tester        PASS      5.56 seconds
TestRunner_mgmt-tester        PASS      108.80 seconds
TestRunner_rfcomm-tester      PASS      9.59 seconds
TestRunner_sco-tester         PASS      8.97 seconds
TestRunner_ioctl-tester       PASS      10.19 seconds
TestRunner_mesh-tester        PASS      7.09 seconds
TestRunner_smp-tester         PASS      8.76 seconds
TestRunner_userchan-tester    PASS      5.83 seconds
IncrementalBuild              PASS      31.75 seconds



---
Regards,
Linux Bluetooth


--===============1786916585663430043==--
