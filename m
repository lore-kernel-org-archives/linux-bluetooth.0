Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EBCC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Feb 2022 11:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbiBHL73 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349374AbiBHL71 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Feb 2022 06:59:27 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A93AC03FECA
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Feb 2022 03:59:26 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id z35so1405989pfw.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Feb 2022 03:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Yeva9zo8JPEtz2R/DaB335YkRnfItq3dFjdYToSrRL0=;
        b=K1a4xG94aRF1iBZ6I3pNVELD873PnPeqWESCZweezS0ZdR6Fh/zGA4brq0mbQ9fqmK
         TgKo0ckoyGM6zEZk3E8LeBovaVLcvmqxke+j63UhfVON4mXcedFN20lsy3xeO0TzK3H3
         9Q34qWReBo/v+qp+W8CG3MCV/AcxYcWq13amul2PPJoyfggy6ECkfSajpqg/DXt55SwK
         bGUnaA6jymosn3sZXboPhqnaR6aGl+mVeb3P7JsUvykxdJ03Wj3p2JH4/UvyqqvMxr+q
         ewBNohcS8otMIplBPHDJ2LL+gF+J8Ye6YU6VX0cK0d8oPe0R0LIFsU+yMX+/qhx8gU7Y
         9CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Yeva9zo8JPEtz2R/DaB335YkRnfItq3dFjdYToSrRL0=;
        b=ILHlPE+VThUA+HxakXjwc3RELZI5ouv8fkSofZEuCWsjAzXcHE0kShfERZBwIhGSxe
         RO53SzmRHoVrr/yj7TCrV3KCU+2zztfxjBWIIdVA/hnJCHrKYUesELXK48Oz2f/qAsjn
         wf2RE3l5j7r/z9Roe9VATAzbEJyJDw8pFwRPKXmJQk4EYuv2XMqsK1ZL0XFbgs//OueP
         1nYTgV/vpm2v/LTU1SgxB5jYMXzuKQCubH4O/SWXvKC6IiXrpbhFqr4rwT3QKISwUJoD
         7HGbeURRFav7shQ79Y7Z9T43diT8T4qDFaXi4mMn6RiVBCAuPuX/c2XiuTP4nW29KwI9
         8kpA==
X-Gm-Message-State: AOAM532Slpj8mdOIJJE9xzjByjuJBVCp8kge7I9Iuu5fIScjKkbTPlG8
        LrC6NRCWR7xMlqdGINoHpvHJJj72TOA=
X-Google-Smtp-Source: ABdhPJyY3WbKdV1WgA9NwhG966srQ0eQ6WMp8e2DmBQnatuVYhneo0H3T0MM/fG7P4W+66KfA+FgQA==
X-Received: by 2002:a63:2322:: with SMTP id j34mr1016361pgj.583.1644321565449;
        Tue, 08 Feb 2022 03:59:25 -0800 (PST)
Received: from [172.17.0.2] ([13.77.151.219])
        by smtp.gmail.com with ESMTPSA id 14sm9038483pgk.85.2022.02.08.03.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:59:25 -0800 (PST)
Message-ID: <62025b1d.1c69fb81.db2a6.61aa@mx.google.com>
Date:   Tue, 08 Feb 2022 03:59:25 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7035284455691325663=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_saluvala@quicinc.com
Subject: RE: [v2] arm64: dts: qcom: sc7280: setting the vddio supply for Bluetooth node on CRD
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1644318803-14950-1-git-send-email-quic_saluvala@quicinc.com>
References: <1644318803-14950-1-git-send-email-quic_saluvala@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7035284455691325663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=612157

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       FAIL      0.45 seconds
SubjectPrefix                 FAIL      0.25 seconds
BuildKernel                   PASS      37.92 seconds
BuildKernel32                 PASS      33.43 seconds
Incremental Build with patchesPASS      43.83 seconds
TestRunner: Setup             PASS      600.88 seconds
TestRunner: l2cap-tester      PASS      15.78 seconds
TestRunner: bnep-tester       PASS      6.85 seconds
TestRunner: mgmt-tester       PASS      124.22 seconds
TestRunner: rfcomm-tester     PASS      8.51 seconds
TestRunner: sco-tester        PASS      8.80 seconds
TestRunner: smp-tester        PASS      8.71 seconds
TestRunner: userchan-tester   PASS      7.12 seconds

Details
##############################
Test: GitLint - FAIL - 0.45 seconds
Run gitlint with rule in .gitlint
[v2] arm64: dts: qcom: sc7280: setting the vddio supply for Bluetooth node on CRD
1: T1 Title exceeds max length (81>80): "[v2] arm64: dts: qcom: sc7280: setting the vddio supply for Bluetooth node on CRD"


##############################
Test: SubjectPrefix - FAIL - 0.25 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============7035284455691325663==--
