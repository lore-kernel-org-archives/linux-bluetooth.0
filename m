Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C99ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Sep 2022 16:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiIFQe6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Sep 2022 12:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238801AbiIFQeg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Sep 2022 12:34:36 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2F233346
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Sep 2022 09:09:55 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id h21so8402281qta.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Sep 2022 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=/Tu1RNuCDKajmyALN1qpulpNhFqo8IdS+awYsFXCFyE=;
        b=ZKshmxUxUyYp7f5/QFZlC+xiYmtQy4UzEqRswDCoeY6IoGhS2nRFbuU7+KAPTHDFeL
         /sK+/QVjgzX9EJK/eARyL+IXrJRwBAncLCHJ+nDHFjnxvrd7wiRR7yIKqRJU606DL7UH
         mrzAqUTMgIssiw7w9CBpmatl9LbpLD45KULVPyrDFipAfEO//I+uZT0IWTG9IoHSTy+4
         ZIJ+6uGhcE637TdDcUYs3jDatoymT2ObibCtibqIHdMviJoDh56AZUUkc1d0rzGwASB1
         3fAC/2ghlW4sJoxBEs1YPDt/+IZlD9ei+P+RrvcaGKUK6OLHV+svDykvpfZWJmTJ6nbf
         cFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=/Tu1RNuCDKajmyALN1qpulpNhFqo8IdS+awYsFXCFyE=;
        b=xPSDD5MrSJBqte1WrUTzzKWFzkW7F8QBGwHU9Qv5V3aVMLxOM0PJNzNBe8nsIY2z7+
         sW+t4WNNZCaHPnqPKyj9UGXp6gasJ7FdfaKOQecSWiPQ6+TUc0pQ7cwNsiMIo+3CCmmE
         3jAFotzSyyR4tZVPI0oZHVoc2kbkHYtPxnGsjvTQVyx8kChU9La1kd++fHjOCe46yV5Q
         8zA1rs/Xt/vh+K+2jRcyNajs4f/C01RIRNfL3+RMQRCzmpLBkSubsz9oDiV8ZfCeQ9EZ
         30VZ54veX2NuWdsCZuy8NOMJ8NmZfXPFG+4XoYPoaVHcReCMVCNSm/lanZtBPODEwxMx
         RRNA==
X-Gm-Message-State: ACgBeo3Ctl0KDBh+FMYLsbkud34/qQv9RSjpOuSIA2iez7qrjs2wv0na
        6QnMRmsGPvPFeuUnjpt9qsO0PmZlqRI=
X-Google-Smtp-Source: AA6agR7TwPbgwv4fDI6gL441EWr/MhLZKl1aLQbIQ2CoPH54uN9XjC43s2FjS35FgpDN9p0oHSIweg==
X-Received: by 2002:a05:622a:14d4:b0:343:7e0f:f9d8 with SMTP id u20-20020a05622a14d400b003437e0ff9d8mr44603410qtx.5.1662480594650;
        Tue, 06 Sep 2022 09:09:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.189.70])
        by smtp.gmail.com with ESMTPSA id bb9-20020a05622a1b0900b00354e5b8bba3sm5471426qtb.29.2022.09.06.09.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:09:54 -0700 (PDT)
Message-ID: <631770d2.050a0220.972d5.9fc3@mx.google.com>
Date:   Tue, 06 Sep 2022 09:09:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7749449516866678488=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zhengyongjun3@huawei.com
Subject: RE: [-next] Bluetooth: btbcm: add missing of_node_put() in btbcm_get_board_name()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220906143412.123134-1-zhengyongjun3@huawei.com>
References: <20220906143412.123134-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7749449516866678488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=674542

---Test result---

Test Summary:
CheckPatch                    PASS      2.13 seconds
GitLint                       PASS      1.10 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      36.00 seconds
BuildKernel32                 PASS      31.15 seconds
Incremental Build with patchesPASS      45.29 seconds
TestRunner: Setup             PASS      517.00 seconds
TestRunner: l2cap-tester      PASS      17.67 seconds
TestRunner: iso-tester        PASS      16.97 seconds
TestRunner: bnep-tester       PASS      6.72 seconds
TestRunner: mgmt-tester       PASS      106.43 seconds
TestRunner: rfcomm-tester     PASS      10.10 seconds
TestRunner: sco-tester        PASS      9.93 seconds
TestRunner: smp-tester        PASS      9.97 seconds
TestRunner: userchan-tester   PASS      6.91 seconds



---
Regards,
Linux Bluetooth


--===============7749449516866678488==--
