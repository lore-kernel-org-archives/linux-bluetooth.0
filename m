Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2234C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 16:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCJQFl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 11:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjCJQFH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 11:05:07 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5B0E192
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 08:02:27 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1763e201bb4so6355674fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 08:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678464147;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HzziJ/PVNHgZZQB/W6ji6ko1ENDqfgs7eo2hcHpnqKQ=;
        b=Ko1WxnqHFF5ASUBI2kY0ql8TWtU6rtMs4RPECXBiHzzTuRKr0ZfvEIoAJbwJn12Ncr
         UZYN7/HXtX6V3ikflC1bd8kr1IAn20qTKTFDc2crN9CiLpysz3FZidCfk1rqZRifFV9y
         tEfg66bslVXYuNNkBLzj5NZewBfII6SnhgT7+nBOjnxykpKCTvds50Lf7PjUyim8xdUA
         ZKdJXjTuwugkhdi2xneGxzwBgnZYGVuwdBNmTygQe0B5wb4wsOwoDrqQJxDZZhGWSSue
         lW/TLgWE46VfT7EOH9QRlbpQYilPlKNWrF6cfKcDTpRJ6mdJA/nIrN4ReRQLC89QLnvl
         pCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678464147;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzziJ/PVNHgZZQB/W6ji6ko1ENDqfgs7eo2hcHpnqKQ=;
        b=1GUaVzN5NfAnJ/Kr3bFNhL1ue87klREn6Fpep7+VygSuurPFv/87vC0Wfp+jYBpFZZ
         +ol4xhkqixpM7DKGOtVivwijBgQnpt0WVDxsyLmYTCXt8kjmbp1WGRF5tkaUl+xdMNFS
         VMaKbyYRCL4rPaPAgSXnmvsoTzFwQw5+80jl2Lw/sB9r6ywwv3xrmvrApudCbizeIPz4
         YiKZlUO172DhGusyxGBiPivO6jrge6v2UUWYr/y132B5TO+dtNuxTbYPFOQRJI55sy5C
         11D0mo6NpG0EP2DdcSXt7zNrVoRoqycrCAPOgPuB5GouQmVfMXxFLQeU69Gr+uZntYc1
         V14w==
X-Gm-Message-State: AO0yUKXaqiZY+1BN8Xv6WMbPFmPKQ8mhijECFMYM+0qExYb3IgAG/Ifq
        En8fzJN8fSkOyyetOaKCtk/qwFkeDso=
X-Google-Smtp-Source: AK7set8e65d/Ln345tGNwgRxQI4kuy944rU/4VN5nm1dUPuqrfQ5Z3NfHqpIej/KX6J1dKxY0GHXTg==
X-Received: by 2002:a05:6870:a40d:b0:176:3bf5:79b8 with SMTP id m13-20020a056870a40d00b001763bf579b8mr15281144oal.8.1678464147067;
        Fri, 10 Mar 2023 08:02:27 -0800 (PST)
Received: from [172.17.0.2] ([104.45.204.118])
        by smtp.gmail.com with ESMTPSA id 14-20020a05620a040e00b0074233b15a72sm1503482qkp.116.2023.03.10.08.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 08:02:26 -0800 (PST)
Message-ID: <640b5492.050a0220.7c5f8.5c4a@mx.google.com>
Date:   Fri, 10 Mar 2023 08:02:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0068482189773465662=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rcheleguini@google.com
Subject: RE: Bluetooth: Improve support for Actions Semi ATS2851 based devices
In-Reply-To: <20230310151410.2686458-1-rcheleguini@google.com>
References: <20230310151410.2686458-1-rcheleguini@google.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0068482189773465662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=728739

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      38.06 seconds
CheckAllWarning               PASS      41.85 seconds
CheckSparse                   PASS      47.12 seconds
CheckSmatch                   PASS      127.42 seconds
BuildKernel32                 PASS      36.93 seconds
TestRunnerSetup               PASS      530.68 seconds
TestRunner_l2cap-tester       PASS      18.78 seconds
TestRunner_iso-tester         PASS      21.25 seconds
TestRunner_bnep-tester        PASS      6.89 seconds
TestRunner_mgmt-tester        PASS      128.22 seconds
TestRunner_rfcomm-tester      PASS      10.63 seconds
TestRunner_sco-tester         PASS      9.82 seconds
TestRunner_ioctl-tester       PASS      11.58 seconds
TestRunner_mesh-tester        PASS      8.66 seconds
TestRunner_smp-tester         PASS      9.69 seconds
TestRunner_userchan-tester    PASS      7.21 seconds
IncrementalBuild              PASS      34.36 seconds



---
Regards,
Linux Bluetooth


--===============0068482189773465662==--
