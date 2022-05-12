Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FD1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 22:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358891AbiELWAp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 18:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359020AbiELWAn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 18:00:43 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E68D42
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 15:00:40 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x22so5559910qto.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=p71y2NwAAdUGrA0DvULCOpPhthPTSSEofowXc1BU6vI=;
        b=aGk3kd6GLxdUHhKzv5abKyARKkTGO6l05CRwMARGoZqy0B/8Lw2XZ0jHtlFlyp7DK9
         38AvovQYqOKGYysAK9qCFHlasDDyjr/ESFaDfJY63Pf0J81AiJAMG4ZK5dbAyAfqhOMP
         O9KxynzunGwadtdUkQ4WLNKBE0vZs8TSA3/18XeHteeuWYB3xEFd/e8xpx++Vlk5VF2k
         YUIQIjz1i7b+n67HUiRlKriQ6P0COmpe6LKMPSjjtcbehvVPSirpNLUVHhlSUoiVEfL8
         d+9Il5JPQGEP2dnszFN+9NHOW+K6U0CyrzkFhnRy7dkzTB0n6llqO4UrqHAZIsLM9f6B
         8X2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=p71y2NwAAdUGrA0DvULCOpPhthPTSSEofowXc1BU6vI=;
        b=stbO7X9Oy0Unj+NA6ojs0feZevINx2jPzL8lkI7y5xCJTb+Muoji6PWdnpf8oASqKq
         Elj9B4A2OUo2ar0KkSWgOKKtfIUZOOO1f3SC5Ppxl+0/pRdfacmS747TLmUYsV7obOuA
         Cf7rpL4YWX1HAVHfnp3zr2Bzuz+RK8XDUTumlHeHhc90HiLPMa8Pxb0cAIfPGu1LMuNr
         Lmld5qjBIlUVvMsz4YqWb1g34UeeFU5l0wIN844vjhH8eWF/6td/lCgzGfYgWPgQfm3F
         cNNAFJoCZ5TbP+/TrKDDjCVLn4F+/WhN68IQIr0/ehdMw6c+/RL179Xn4j+pHzbx+mcl
         d1sQ==
X-Gm-Message-State: AOAM533fmsjzWHcINpT45En0vvV1xqmZQDQaNb5SKh0RZeGXGptLnpeG
        d9mPL26RXlPfn4rX/nDOTRSpvAxvKvY=
X-Google-Smtp-Source: ABdhPJzU3mEKB13Q2sjyVb62uipmdMcY+QKImckScD4yGWyPoj534W0OGK2wcGfiTgLqlEcwZVOOcQ==
X-Received: by 2002:ac8:5b53:0:b0:2f3:f26b:3d25 with SMTP id n19-20020ac85b53000000b002f3f26b3d25mr1913153qtw.357.1652392839643;
        Thu, 12 May 2022 15:00:39 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.147.130])
        by smtp.gmail.com with ESMTPSA id i133-20020a379f8b000000b0069fcdbabdb4sm402482qke.69.2022.05.12.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 15:00:39 -0700 (PDT)
Message-ID: <627d8387.1c69fb81.dbef3.2d66@mx.google.com>
Date:   Thu, 12 May 2022 15:00:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7973511841045018563=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix attempting to suspend with unfiltered passive scan
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220512205613.992901-1-luiz.dentz@gmail.com>
References: <20220512205613.992901-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7973511841045018563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=641155

---Test result---

Test Summary:
CheckPatch                    PASS      1.74 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      33.34 seconds
BuildKernel32                 PASS      28.56 seconds
Incremental Build with patchesPASS      37.85 seconds
TestRunner: Setup             PASS      466.89 seconds
TestRunner: l2cap-tester      PASS      18.60 seconds
TestRunner: bnep-tester       PASS      6.03 seconds
TestRunner: mgmt-tester       PASS      100.03 seconds
TestRunner: rfcomm-tester     PASS      9.71 seconds
TestRunner: sco-tester        PASS      9.86 seconds
TestRunner: smp-tester        PASS      9.80 seconds
TestRunner: userchan-tester   PASS      6.14 seconds



---
Regards,
Linux Bluetooth


--===============7973511841045018563==--
