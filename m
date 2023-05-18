Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73568C7EE22
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 08:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjERIka (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 04:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjERIk1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 04:40:27 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB6835A2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 01:39:58 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-199fd9a0e62so1290774fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 01:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684399198; x=1686991198;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t8UUT98jtiRDBUNrls8sY4CYjCEK+ngEbgBP0LfhBfM=;
        b=W06Eu+eTDhlnKUiJK1iu9XUzXlQy2olN1H1G5qNWJBOU0o0+mAapLmeSdL815rO+5G
         VrbBLz9fQ2tVOtrrUy5nzI5SVCt6uAJYgWG/OI7bvkN66y3rakDe1LFfH/kK4msC1cSX
         Yfy+6pURkXqGvcvkwb+Vh7I5pSzBrrTQ5sqeip9wXWzGvFspt67ZIXIicqa6a1LhWhfG
         teqlF/2VE0TBRti7wLCnPWdaI7hmRFj72KJA62cziSiiLcMSKoAX79fANJRTrxLITgtt
         8MxDOnnIi2VOkMwQT4Dh4fU0cPQnuu8rKNhVVtX/R7cyWPU0EK3QFho56X+Svfk3FGml
         QhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684399198; x=1686991198;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8UUT98jtiRDBUNrls8sY4CYjCEK+ngEbgBP0LfhBfM=;
        b=ji49Otmeof7c4W4VjNJgbpygEqLJ0fmyiRCnVjwtYcVIEo2WMX3uCibuX+hY2iLpo3
         9Bts/mrVCVvDuEG4TbljOKd8g2HEzd6LRC1PA6E3TTOANwK2ktZshWwTV/BIRMLkOrd7
         kDbtzCe4C8vP9o+TF/E8EbybdS39Z+LzyWk4Un9QndQ3IbQ1JtrP7oajiYB/XipLuw2Y
         GXgFvtnh5TQntZpiCYbDziPVTOoLJHncBUQLhtSVIefzstR288K+2ap1XsgY5cOZCoMq
         Akmn2+SJ2as7OoQGACh6tOhEYIbZcTBgZM/u13XNw+QY7QRpVwudiKWud2AOK8vqA9a0
         ZMVA==
X-Gm-Message-State: AC+VfDxWw4YLZgZHKsCz8sCMt5+zOV8HbP6AkbjZ9TtCgJPE7pjx8yiA
        ZjsHWlkw6YGByAVsJOkxXQXSJTUQIdc=
X-Google-Smtp-Source: ACHHUZ6hZ/wmBOdUB++UxEuOo1krrD2xzTuYfgBmWupmMNgS0IiKjKz4eEBvH973dMSDFQ8Rwra7Fw==
X-Received: by 2002:a05:6808:d50:b0:396:42a9:9857 with SMTP id w16-20020a0568080d5000b0039642a99857mr875576oik.6.1684399197993;
        Thu, 18 May 2023 01:39:57 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.165])
        by smtp.gmail.com with ESMTPSA id 22-20020aca2116000000b00389898f4c4fsm367700oiz.45.2023.05.18.01.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 01:39:57 -0700 (PDT)
Message-ID: <6465e45d.ca0a0220.6b14e.1682@mx.google.com>
Date:   Thu, 18 May 2023 01:39:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8174888521595413224=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v2] Bluetooth: btnxpuart: Fix compiler warnings
In-Reply-To: <20230518073540.2473673-1-neeraj.sanjaykale@nxp.com>
References: <20230518073540.2473673-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8174888521595413224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=748779

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      41.18 seconds
CheckAllWarning               PASS      46.64 seconds
CheckSparse                   PASS      51.56 seconds
CheckSmatch                   PASS      139.75 seconds
BuildKernel32                 PASS      41.00 seconds
TestRunnerSetup               PASS      584.91 seconds
TestRunner_l2cap-tester       PASS      20.78 seconds
TestRunner_iso-tester         PASS      27.55 seconds
TestRunner_bnep-tester        PASS      7.55 seconds
TestRunner_mgmt-tester        PASS      143.95 seconds
TestRunner_rfcomm-tester      PASS      11.24 seconds
TestRunner_sco-tester         PASS      10.66 seconds
TestRunner_ioctl-tester       PASS      12.65 seconds
TestRunner_mesh-tester        PASS      9.53 seconds
TestRunner_smp-tester         PASS      10.31 seconds
TestRunner_userchan-tester    PASS      7.54 seconds
IncrementalBuild              PASS      39.90 seconds



---
Regards,
Linux Bluetooth


--===============8174888521595413224==--
