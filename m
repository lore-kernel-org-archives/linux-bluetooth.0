Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311E9C32771
	for <linux-bluetooth@archiver.kernel.org>; Sun, 18 Sep 2022 07:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIRHPd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 18 Sep 2022 03:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIRHPc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 18 Sep 2022 03:15:32 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F581E3F6
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Sep 2022 00:15:31 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id jm11so25207835plb.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Sep 2022 00:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=CFNQ2pofU3Ep29hs/7y1c6/q4/iA/l1q4gEcyssCkc4=;
        b=QTO/NqlgfIJ6r7VzskiAeSQBdPa2j+JwqQ9xQNdVML//wJdd5MHczWD2qF/zmk8gDt
         6QRoR2AVaAu14Q06/9qBfNEW6ZNm5YX6E9fMs9VclA27lKm2ajtGE6EO/90rb7npB9t3
         h/AS1K6SqDtxI/9uuDKBHjJQw817TYrAaU1FZtjTOgQoctnT3VlxXnrzabt1f/qfvV7i
         LOlGg+qOLWle6878kH8bb3TzrlOIr/x8FYMfLHdQ3rNP+gAVTVxMgD33p1gB/8sRv4L/
         b5Frtq7WpudX/ZsS6RxdNTyrUA9aPdrzFjOAUVj+XYnamgUrqhJ2UDbOT6OcDe5bnB6u
         4gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=CFNQ2pofU3Ep29hs/7y1c6/q4/iA/l1q4gEcyssCkc4=;
        b=E3Oe9YGL5SZpshBHPswmWvyM+DTsjLXLKHeSmRnGf03YDEhFaxcZpbbPaz9MCrq/23
         XhxLZc/DFnury2xLIBIUhOA0gktcJvhdeLBSNuZG9XffW7UYu5HxyOlW/lEAXrAfuX2F
         EgylVwkrSo5Wn7sSOy1ihR3WiMqzsH3zONse4fm6fYWi3qQcEgoELJ1w6fWsstwgCvwg
         Wp4TnC3uI19pn+DHA3B0Yrc0SqbcrE0HokCc5ziN0dpMShQsChkN2xxzTZQKakImJEL5
         uFJzf9a5znrKDg/Y3irE7GjEzTDwUCFmUNWcOCOWLM6SgSI1X7cd9Ydk67GkoPaX1WIH
         HHwQ==
X-Gm-Message-State: ACrzQf3Ex54sXjfhhLqD6oi0VBD4TukShjzeO2INkjmiWFVKSup7mmBp
        3Qf5pQ5qTJy8dHq1nrOkRg201cPf9+k=
X-Google-Smtp-Source: AMsMyM5HQI2LncB5fZV/XdyqldA54r7CKl0CGwFmJdtqh37QU2OG8MtZfBddgsjbNop0X73K0pYghg==
X-Received: by 2002:a17:90b:1e47:b0:200:b9b4:ba0f with SMTP id pi7-20020a17090b1e4700b00200b9b4ba0fmr24736974pjb.245.1663485329884;
        Sun, 18 Sep 2022 00:15:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.254.179])
        by smtp.gmail.com with ESMTPSA id g12-20020aa79f0c000000b005380c555ba1sm18215564pfr.13.2022.09.18.00.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 00:15:29 -0700 (PDT)
Message-ID: <6326c591.a70a0220.17d2d.02f1@mx.google.com>
Date:   Sun, 18 Sep 2022 00:15:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8158418930385492321=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wiagn233@outlook.com
Subject: RE: Bluetooth: btusb: Add more device IDs for WCN6855
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <OS3P286MB2597907F01F1935AF89ED52D984A9@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
References: <OS3P286MB2597907F01F1935AF89ED52D984A9@OS3P286MB2597.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8158418930385492321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=677926

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      33.65 seconds
BuildKernel32                 PASS      29.63 seconds
Incremental Build with patchesPASS      45.92 seconds
TestRunner: Setup             PASS      499.00 seconds
TestRunner: l2cap-tester      PASS      16.49 seconds
TestRunner: iso-tester        PASS      15.30 seconds
TestRunner: bnep-tester       PASS      5.91 seconds
TestRunner: mgmt-tester       PASS      99.59 seconds
TestRunner: rfcomm-tester     PASS      9.83 seconds
TestRunner: sco-tester        PASS      8.96 seconds
TestRunner: smp-tester        PASS      9.22 seconds
TestRunner: userchan-tester   PASS      6.19 seconds



---
Regards,
Linux Bluetooth


--===============8158418930385492321==--
