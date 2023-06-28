Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7797DEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 12:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjF1MB3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 08:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF1MB2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 08:01:28 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CBD2D73
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 05:01:26 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-635783b8b80so39535406d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 05:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953686; x=1690545686;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VbU5dTYU0K5/GpOcOYDspEPV9uG2ZVRnNyNR9N06FNI=;
        b=plZvpANNX6r4wkZqyfZcMhiFGdJEC4ycAUy+/k2xWFCkjzenwPkAhuu5e6n4eMnZTq
         HXYKxk2k3iiglQGiKZxKicL55S9ekRGqqWMPNTliQ0c39ZrxhqZCvrFy2ivFU4Hsjyp0
         lfzfrEQpB+rOeVNffdMPAEpSe0wLlfUHzKDOQJaoJK+4QYaxl+YBl/JJubJ8qO8FTRL1
         L6nJHCCC9Al2ou9uYtr/cUflkPouafrL9TkFWlsq7Kh1dxMi3d7f8cOxeDH/c1KsKccO
         T54rkhRISQqiaUoOmNzsBG/mefhxPqQbyps3UcRB2b9TNwKD7e9ocdCexzRo3tlMknJ0
         jnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953686; x=1690545686;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbU5dTYU0K5/GpOcOYDspEPV9uG2ZVRnNyNR9N06FNI=;
        b=UN61Ddu5S4DLjIs0mjorh6bsNClOw+Dj1EAyj9MqI8obddFjEhwVq71N18aRCaU3oo
         eAUuRhXZEnWKaZESOVWZ5RYUsZ6yJ+dtOwX6u3hvc1pggA9sr3vUbHgnsfF1rb50m6B9
         gma0ofHiPZZbFqgIchDyqsjIE9k7E3iBRTWjEQsJFwuADQV4ZHHjrK4UrvuifTjJUIHm
         7F3sKPkfJO5fGrBXZPJOKV0Oy61HlBXWPeTrs/MoljP6GQo1BAjE3V1pvSgaUOOutqMG
         Jsb+orDoS+W9R4w7zuNqyOa+yKl+nR5JSKeYHpLKaRhMpwg/e0JXWKFIckmyJmpZpzp+
         viYQ==
X-Gm-Message-State: AC+VfDxWA+3owWy1GjCqAonvGEcb3ofNUyAaFb23eZeoy9hoggjmadWh
        VHpgsML5OoGEn0uYcRLdIITZiOGqOBY=
X-Google-Smtp-Source: ACHHUZ5SbArzEOpNsXTwgMbIvAF+29cZTmP+u7nTArLHBQ00Cuh0mWcjtSuRhz7U7Znn7TPufWs1fQ==
X-Received: by 2002:a05:6214:2524:b0:5f4:5af6:1304 with SMTP id gg4-20020a056214252400b005f45af61304mr36791173qvb.16.1687953685899;
        Wed, 28 Jun 2023 05:01:25 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.106.107])
        by smtp.gmail.com with ESMTPSA id ec17-20020ad44e71000000b00632191a70a2sm5572280qvb.103.2023.06.28.05.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 05:01:25 -0700 (PDT)
Message-ID: <649c2115.d40a0220.8c780.c094@mx.google.com>
Date:   Wed, 28 Jun 2023 05:01:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6125695127208237411=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Add support for GalePeak
In-Reply-To: <20230628113934.824668-1-kiran.k@intel.com>
References: <20230628113934.824668-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6125695127208237411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=760911

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       PASS      0.39 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      39.30 seconds
CheckAllWarning               PASS      42.86 seconds
CheckSparse                   PASS      48.51 seconds
CheckSmatch                   PASS      132.21 seconds
BuildKernel32                 PASS      37.94 seconds
TestRunnerSetup               PASS      539.07 seconds
TestRunner_l2cap-tester       PASS      20.30 seconds
TestRunner_iso-tester         PASS      28.33 seconds
TestRunner_bnep-tester        PASS      7.13 seconds
TestRunner_mgmt-tester        PASS      149.78 seconds
TestRunner_rfcomm-tester      PASS      10.86 seconds
TestRunner_sco-tester         PASS      10.08 seconds
TestRunner_ioctl-tester       PASS      11.76 seconds
TestRunner_mesh-tester        PASS      8.97 seconds
TestRunner_smp-tester         PASS      10.19 seconds
TestRunner_userchan-tester    PASS      7.29 seconds
IncrementalBuild              PASS      35.70 seconds



---
Regards,
Linux Bluetooth


--===============6125695127208237411==--
