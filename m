Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E750C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Nov 2022 15:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiKUPeS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Nov 2022 10:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiKUPdv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Nov 2022 10:33:51 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A4AAE60
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 07:32:54 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id q13so352851ild.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Nov 2022 07:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ6wtAX2PgFD3HDaoJIl5lFnR7KdxJ0dNuOg5VeF5jo=;
        b=bCce2scAsQ9LaOCFboMPOE77dyg6qFG6NK1Zq5XeTUa60/KrMjDwdbK5UB62jLx0mU
         Rf5/IEPxkj6ywfmGwen/6AFD+nMI2iCgXwQG1SC3LjZ8RxdYFuhEvcC9yGn7h1cvJD1z
         16mMDmBf+9/6YqqbR7ipnm5n6wyBC7LfrWp/UV632wkGLNzD5W0MsVIf7LBiJqFYZqwX
         Rnlmeko5TVnohmxeByDfqZR1/txpprwz+jRphP0vo131A0++AKUMme7Ez1giqj7IDw2q
         D6dUS5RIS0AQJgkDwgzSG/AwgmzYFYRmOIZ7yR4fG9aQaGOC4VOsb/+xmsMYKppL59XM
         CS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZ6wtAX2PgFD3HDaoJIl5lFnR7KdxJ0dNuOg5VeF5jo=;
        b=5NccFABUdh1KRd4++HQoCsBzRVgG70YSPOsGcNB0O4n2Z+X24mPOCaRF7AMK01ZTV3
         HNiQbcHXoEN5iuJ+yA8MaY2vvCmpm26b0wIlps3/M29h1In7EfGXFoW5I75AdUt2rGsN
         2Ln1AAOMkBt58fKm+G+JcP+f6qc7+1pu6BRjZQtA0aNIgJWUfLFgrJ0xFUZeYp9073Id
         3Q49kRZDzMhRsICFfLPlgSXt4Wv7roKkIgpBy+fcX9JXMUgbYzsAqWOl5Q3gGvqkGBuu
         ke4Osa5ciNwtIuHwUyfzkUHdZALDVqwlH0qBwbLJ/gIGzNJzKMgJA4gFodqABQp51GWw
         u+Bg==
X-Gm-Message-State: ANoB5pkQsrcIoTbYoeBW3BU91BnMU/nBEWV7lJtCwsfuipbV3jBsDN6R
        mxlE9YfcZ70bDWt5MAZOnf6kWeYtcPY=
X-Google-Smtp-Source: AA0mqf41rsKSQovTzAX1+F/ncTv5TRxm+JRmicIn4HE4n8KEz5p3vbPy87GeB21/aKOONYvjUXLIfQ==
X-Received: by 2002:a92:c089:0:b0:302:bc38:9a58 with SMTP id h9-20020a92c089000000b00302bc389a58mr819796ile.159.1669044773224;
        Mon, 21 Nov 2022 07:32:53 -0800 (PST)
Received: from [172.17.0.2] ([40.122.198.252])
        by smtp.gmail.com with ESMTPSA id m13-20020a056638224d00b00375b92f14c8sm4305550jas.94.2022.11.21.07.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 07:32:52 -0800 (PST)
Message-ID: <637b9a24.050a0220.d998e.8831@mx.google.com>
Date:   Mon, 21 Nov 2022 07:32:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3633166577072642819=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dimitri.ledkov@canonical.com
Subject: RE: [v4] Bluetooth: btintel: Correctly declare all module firmware files
In-Reply-To: <20221121145125.1303097-1-dimitri.ledkov@canonical.com>
References: <20221121145125.1303097-1-dimitri.ledkov@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3633166577072642819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=697683

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      35.41 seconds
BuildKernel32                 PASS      31.63 seconds
TestRunnerSetup               PASS      435.73 seconds
TestRunner_l2cap-tester       PASS      16.12 seconds
TestRunner_iso-tester         PASS      15.91 seconds
TestRunner_bnep-tester        PASS      5.62 seconds
TestRunner_mgmt-tester        PASS      107.99 seconds
TestRunner_rfcomm-tester      PASS      9.60 seconds
TestRunner_sco-tester         PASS      8.93 seconds
TestRunner_ioctl-tester       PASS      10.25 seconds
TestRunner_mesh-tester        PASS      7.02 seconds
TestRunner_smp-tester         PASS      8.81 seconds
TestRunner_userchan-tester    PASS      5.93 seconds
IncrementalBuild              PASS      33.30 seconds



---
Regards,
Linux Bluetooth


--===============3633166577072642819==--
