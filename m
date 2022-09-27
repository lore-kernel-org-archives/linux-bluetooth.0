Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CC8C32771
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Sep 2022 00:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiI0AUK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 20:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiI0AUF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 20:20:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A825667169
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 17:20:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e68so8273757pfe.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 17:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=bAWF8FtWaERrKQyhW+ZtTRbEpnIFnQlsDlekqZMyJak=;
        b=lOcSh0rQHxTwJ60TDwB8sMoakN7p25w2AjsIxJzGtI9emH30xPh2HvzbJoKOJ0GTAd
         bT9PdT6fKjzSexUnxfKirQVirc7aII8j4AlGJ5dbRc46sYwl+1B4R3lldHEiAPjMOi5j
         EyGmhA0kJ1adpHV0+oD/Au1yYT1ptrC58bskkruuMs75uDUuf+0Z8L+nGcANm0lPyJbv
         44OVBaoykFr0skiITbDI/H2Um+/DOyvSjRtRixWIqIFbPol+ltfUHJQiJctciMIYx+U/
         mjp3F1rJ7s1JCqVqljlL/ECUHq0RqmZSz1GvTzahq2k9eJxR0fD1250m4b1GsSJvWAsJ
         iQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=bAWF8FtWaERrKQyhW+ZtTRbEpnIFnQlsDlekqZMyJak=;
        b=lzTOyG0o2QKtFWo/DttBns6DrsRIn4HaWkXCbZIS2KA4dIXYGnFxSU3a2UFPLwz/0H
         BthxGL2L3TbGM3lvHR4lG410XVCZLCOCcGX0XZgPT39P30UbgCW3CK3KpaVZm1ZFCa4V
         WyTmJET0Bmsx2O2174T0f/oFxUfZZ/z/iDOmsjL5euaODkRcP9Whw2uU9+itGAnPCSiW
         w5ACw3FNeMBOIxFBjIasyJUy+nstbhbAUo6owoP5ymyLxAA/fdzBOCpI4sPPhPWWhb2k
         xZGhS2XvMNr7oJamnHZSRlWIV6/nUIxeIqOESulUHgfr11ze+G+upfPjwt+2EpQbHqEI
         c+0Q==
X-Gm-Message-State: ACrzQf2kMWNIXHK/NadSFyWfAkvnpag0I5sRgctbySi0RSkG7NKpcOwt
        Kk+minUQl/kDYsPUmpvevDvJrMjedLM=
X-Google-Smtp-Source: AMsMyM5bcQgRqpBwbfyampM9c0flIu56T3FTY5oDv3Wcw2bIm2++lpOdLAS6PIe9waJP88PANdpFAA==
X-Received: by 2002:a63:5d18:0:b0:439:61d0:7487 with SMTP id r24-20020a635d18000000b0043961d07487mr21703642pgb.268.1664238002659;
        Mon, 26 Sep 2022 17:20:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.86.219])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090a070200b00200b12f2bf3sm27581pjl.51.2022.09.26.17.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 17:20:02 -0700 (PDT)
Message-ID: <633241b2.170a0220.d3ceb.0128@mx.google.com>
Date:   Mon, 26 Sep 2022 17:20:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0451951035859748914=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@google.com
Subject: RE: Bluetooth: Prevent double register of suspend
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220926163057.1.Ia168b651a69b253059f2bbaa60b98083e619545c@changeid>
References: <20220926163057.1.Ia168b651a69b253059f2bbaa60b98083e619545c@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0451951035859748914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=680770

---Test result---

Test Summary:
CheckPatch                    PASS      1.16 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      48.10 seconds
BuildKernel32                 PASS      41.63 seconds
Incremental Build with patchesPASS      59.24 seconds
TestRunner: Setup             PASS      700.91 seconds
TestRunner: l2cap-tester      PASS      21.04 seconds
TestRunner: iso-tester        PASS      21.89 seconds
TestRunner: bnep-tester       PASS      8.31 seconds
TestRunner: mgmt-tester       PASS      136.48 seconds
TestRunner: rfcomm-tester     PASS      13.33 seconds
TestRunner: sco-tester        PASS      12.64 seconds
TestRunner: ioctl-tester      PASS      13.88 seconds
TestRunner: smp-tester        PASS      12.32 seconds
TestRunner: userchan-tester   PASS      9.08 seconds



---
Regards,
Linux Bluetooth


--===============0451951035859748914==--
