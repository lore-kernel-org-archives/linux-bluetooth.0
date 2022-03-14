Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9241BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 07:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbiCNIBE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 04:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbiCNH7z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 03:59:55 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4578038A
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 00:57:46 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s11so3459994qtc.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=qVWjh09cS4byqhWUc6Nxzu6UDf9em73N3ZWz1s2Zt4w=;
        b=EoVWfBZtPrr/p6I0Rd5uTkAas4WJbXPiyzNHI1kPyHG+0xsxy9j+2vZ+XbCuHOUKuZ
         r0JDizdw9JmLz9gvfxjYPhxXDKp+DC1HI500a8gy5Llp3/bswP9W9IqDLY56PgdC4cDH
         U5xncLDKpVaryvbg0vXW415gg3YWqO4g3yS/0hJpwSPxykzoQal92fHDodPgUq7SC67z
         5Gzkrvy3SXpSW1BzGNaJmuJQF+2lepsrg9mUZq4s6mBMNWdy0mx8sMN+nUBpaNO2a228
         FAZEz/9aci02mMTjCGmX1AeMrVLko5L5FhwPKFlVg2sH6Oasiild2o/JiooyI2axb5xW
         K1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=qVWjh09cS4byqhWUc6Nxzu6UDf9em73N3ZWz1s2Zt4w=;
        b=b4nZ6eLrTg/qUNbohdRvN2byrxn6P2zmmv109xRrktmoCXGUcbdD10cnXW9yM9Th2C
         os8ZmImoPlZoSmEczZW7wTCdEd0BM/5f6TwRqpkIA3lkaARz5YFPTkVnihsRXJm9pjEw
         j8NYfSTGCiHixfPoZqWq18caU5JekiLmbF9NcfclBp+yyw2dwG/kwXvNimx1oYr17BcQ
         GY9F4wPTmKvGmWzYsF1OLtyfbYjKl72Y3Nl89f6u5Zt7oEEoHlzgqUxXjG2vDFGNTssJ
         ERzD62WdVD4mJMuTiSk02vvai5X8cS2EK4GHCidwGrwRr0TMuow609tm/NurHxrMefcB
         HraQ==
X-Gm-Message-State: AOAM530WPmEV0gtkf2NEglIBMZmCeN5joz++qgB5x42lNHkZ7OHaHj84
        d64huoeoPOkgLJagJgo5KZi+Dr7HHyBWPA==
X-Google-Smtp-Source: ABdhPJxDLGE0qW3rkcIHOQICMkSimpW3gGnokcL1D4L0v2JO7cLZr0ywQMCc4g475Hc3FfVvvuSdgQ==
X-Received: by 2002:a05:622a:1016:b0:2e1:d620:d2be with SMTP id d22-20020a05622a101600b002e1d620d2bemr1334516qte.180.1647244661301;
        Mon, 14 Mar 2022 00:57:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.127.109])
        by smtp.gmail.com with ESMTPSA id y16-20020a37e310000000b00648c706dda1sm7570255qki.6.2022.03.14.00.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 00:57:41 -0700 (PDT)
Message-ID: <622ef575.1c69fb81.266a5.9434@mx.google.com>
Date:   Mon, 14 Mar 2022 00:57:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6693743202205710445=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btrtl: Add support for RTL8852B
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220314065422.1446-1-max.chou@realtek.com>
References: <20220314065422.1446-1-max.chou@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6693743202205710445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=623044

---Test result---

Test Summary:
CheckPatch                    PASS      1.69 seconds
GitLint                       PASS      1.01 seconds
SubjectPrefix                 PASS      0.91 seconds
BuildKernel                   PASS      34.58 seconds
BuildKernel32                 PASS      29.48 seconds
Incremental Build with patchesPASS      42.12 seconds
TestRunner: Setup             PASS      527.74 seconds
TestRunner: l2cap-tester      PASS      16.67 seconds
TestRunner: bnep-tester       PASS      6.50 seconds
TestRunner: mgmt-tester       PASS      110.60 seconds
TestRunner: rfcomm-tester     PASS      8.55 seconds
TestRunner: sco-tester        PASS      8.33 seconds
TestRunner: smp-tester        PASS      8.36 seconds
TestRunner: userchan-tester   PASS      6.95 seconds



---
Regards,
Linux Bluetooth


--===============6693743202205710445==--
