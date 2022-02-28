Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8B1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Feb 2022 10:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbiB1KFh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 05:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiB1KFg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 05:05:36 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDBF2C650
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 02:04:58 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id h13so11798482qvk.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 02:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=UoiSLS3GqA/Vpr7i0CpyEzrtBlqxhn1a50XG7DjwXwo=;
        b=FfT++yDsFnhDyP73zGIv2ehaG34aATz3aPIHwbeQOrf9yeFHIwBvv6jp+0ziPzFHzd
         leN7q5mQc0IWMbNFspIYGSXuIzbZ7B1sB/El4ORXwdlF6iS90at7fpgFlOmIoiQS2NDy
         CGA2uF2pjAmhhzMHHE+SaEM1OkI16GD2EWSSHPTWuZBjC8cWLh5hpXi8hT32g4e3Zm1z
         IRmJODiK3ayMwVYgvQRCg0dWt9Qq7cOsqifhNXbr0kxfc768OfDQpOY5u/RIxRpKQLmx
         vYrxFp90ufhuCMkBz8FHFZYpljPY29n7AGfoGGo16EQ54+5XbXMOdXohmo3KWaQsjX7E
         3Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=UoiSLS3GqA/Vpr7i0CpyEzrtBlqxhn1a50XG7DjwXwo=;
        b=yupmyhFfjBwnjtNXi+v4mEmjxu1bwgnnxFWcYnZ7OhU4RMlhf8l2Q3J8rJmfdKf3kZ
         48prwjBvhFRds0E5qrhRCmtXBwHTntm4tcoulr+FcX8/f/CsLHnRtNejzaBfQY4Wkuid
         bzLAE+ipTWWTxOrE1UjWqEaMV7ar6IA2dV6MgxyMSbBpcO7Lm6XVopitdB5Z+PqCv+Pc
         gYTAMPht9SWlEVJVFCq5ZDv39n/dwPV5/mRmDuaTHFAS9umoWAAYQR1BSQJVhAPHFxiv
         fgnjdQYGMLiosAlrOs3MkKu24I+x2+G2dB4TlB2IkVWKJS1b5zmCjuEs5Cesk+qrq8uH
         EgHw==
X-Gm-Message-State: AOAM530iumHm6G1/p1ISC2hPJvh/g+RxioCZcHyhtxXUnnZI5FYjC57P
        1qmzY9mUQRWNA2qzO0Q8Erk5NCfSt0c=
X-Google-Smtp-Source: ABdhPJwoMrp1WAznU25BA/dyuMxYstlLQQ0gapLW63yG+NgW/L728LcbulIoo6jskejMfwu5c/hMTQ==
X-Received: by 2002:a0c:c1ce:0:b0:432:b924:9646 with SMTP id v14-20020a0cc1ce000000b00432b9249646mr12198882qvh.5.1646042697369;
        Mon, 28 Feb 2022 02:04:57 -0800 (PST)
Received: from [172.17.0.2] ([20.65.53.116])
        by smtp.gmail.com with ESMTPSA id l19-20020a05622a051300b002dff3437923sm5158478qtx.11.2022.02.28.02.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 02:04:57 -0800 (PST)
Message-ID: <621c9e49.1c69fb81.e3c57.8263@mx.google.com>
Date:   Mon, 28 Feb 2022 02:04:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8232458829682120336=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tangmeng@uniontech.com
Subject: RE: Bluetooth: btrtl: Fix incorrect bin loading by MODULE_FIRMWARE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220228085316.26856-1-tangmeng@uniontech.com>
References: <20220228085316.26856-1-tangmeng@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8232458829682120336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=618615

---Test result---

Test Summary:
CheckPatch                    PASS      1.69 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      37.50 seconds
BuildKernel32                 PASS      32.84 seconds
Incremental Build with patchesPASS      42.39 seconds
TestRunner: Setup             PASS      599.68 seconds
TestRunner: l2cap-tester      PASS      16.90 seconds
TestRunner: bnep-tester       PASS      7.67 seconds
TestRunner: mgmt-tester       PASS      126.78 seconds
TestRunner: rfcomm-tester     PASS      10.31 seconds
TestRunner: sco-tester        PASS      10.02 seconds
TestRunner: smp-tester        PASS      9.53 seconds
TestRunner: userchan-tester   PASS      7.95 seconds



---
Regards,
Linux Bluetooth


--===============8232458829682120336==--
