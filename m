Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AFEC43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jul 2022 06:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiGYGTj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jul 2022 02:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiGYGTg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jul 2022 02:19:36 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A458DFEC
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jul 2022 23:19:35 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c24so7933338qkm.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Jul 2022 23:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=NdOnNWI+/Gyb0+2RaKoPujjuby3km/m/DDadh54u8go=;
        b=ZlxDBf19mxN76nDUMaFKyfLOJVarojrvjV1lXAYvn8JAMPAw4OrfhnSyzJ3TWOF+Ss
         jr3+UFOjfdPvLJQoG/+w6PLXgfgQ8hS1arvBaecI8tq7RN0Fhvrt0mfU7m+omUaKs5Ls
         DYA4dRPzN4tAvQCrF69xb7gN6Fwhckv7XDHOWi7iTVS9pVjRusrw/e3nlOeIfE8EweQ4
         9B32KyOy/9YZirgWGWuEp3jg41GCAetplmkXxfTtXoJOzbN+bMSvB9+YnNIgLw1/FUuY
         Ac2nfOl8FdORO8sf14KhlKTCm1ko/BgU/h/jlVQpbCoQvH4/EuvQH4ejSNhacgjecCsz
         gAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=NdOnNWI+/Gyb0+2RaKoPujjuby3km/m/DDadh54u8go=;
        b=E+im1PqU0goo5XMWdm8kb0rTHJj+zlOz72z63NoCDs6vr+46F30Ui43NjYbFxCJjzy
         CsrVcI1kqjd4RMAV9A104npmk6mAQELVoVnz+pKAPpqd/RqPR5IY5V/a5FktG6xQbEXl
         3dnVcyN28L8LnOKjKTQYlHjxd1+p9F/Kd2+HhDB1itomAdDWwauQSvxycyDzMtbimps0
         cgfa0yCXOXvfhfKwwn4P7v5ur1o5iJUwr7ja0wyf64rL2ZQeUoey7RKAmgNwiVMoHqa1
         ZQ4tjgnYIDIjLAM9aNkzM+piF/JEIQapQ4l2IXZdYB29Yd7duMwou8kfCyRt9A2niC3q
         yVTg==
X-Gm-Message-State: AJIora8GZJsUDcJuPENtJtN55qrg/2d2Rh0M5f11YdDO/BvOKMtyfuS5
        tjT1bl1DVVQZiQeB95kNt08hs0t0bcM=
X-Google-Smtp-Source: AGRyM1vRvGHi5Tt+fTdZFfGnOr/QsgVxgMPpdJusDsyOoEEvxNZs9l6GQusiRED6Y4Mzoq+rDW1hhg==
X-Received: by 2002:ae9:e313:0:b0:6b5:e41b:64fe with SMTP id v19-20020ae9e313000000b006b5e41b64femr7951549qkf.323.1658729974185;
        Sun, 24 Jul 2022 23:19:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.184.40])
        by smtp.gmail.com with ESMTPSA id ec5-20020a05620a484500b006b61bf3153bsm6594461qkb.112.2022.07.24.23.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 23:19:33 -0700 (PDT)
Message-ID: <62de35f5.1c69fb81.71e58.ee67@mx.google.com>
Date:   Sun, 24 Jul 2022 23:19:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0234323810395036346=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, samuel@sholland.org
Subject: RE: dt-bindings: net: bluetooth: realtek: Add RTL8723DS
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220725055059.57498-1-samuel@sholland.org>
References: <20220725055059.57498-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0234323810395036346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662655

---Test result---

Test Summary:
CheckPatch                    PASS      1.85 seconds
GitLint                       PASS      1.03 seconds
SubjectPrefix                 FAIL      0.85 seconds
BuildKernel                   PASS      37.79 seconds
BuildKernel32                 PASS      33.93 seconds
Incremental Build with patchesPASS      53.12 seconds
TestRunner: Setup             PASS      564.78 seconds
TestRunner: l2cap-tester      PASS      17.91 seconds
TestRunner: bnep-tester       PASS      6.67 seconds
TestRunner: mgmt-tester       PASS      105.07 seconds
TestRunner: rfcomm-tester     PASS      10.16 seconds
TestRunner: sco-tester        PASS      9.92 seconds
TestRunner: smp-tester        PASS      9.87 seconds
TestRunner: userchan-tester   PASS      6.98 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.85 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============0234323810395036346==--
