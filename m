Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEC9C04FFA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 20:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjITUNO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Sep 2023 16:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjITUNM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Sep 2023 16:13:12 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1990D8
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 13:13:06 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76dbe263c68so9771885a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 13:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695240786; x=1695845586; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eWuipztbAi/54nGCS7VKUB9o88Iry/XDN21gxp7xJbg=;
        b=LbJzJp6LnPWo+T1f9EJL5Cx9dnLhTW2ufJw4a+B+GSvk13i3iOki7l9nLLxIiQvUHn
         YVpb2NJfyI/PiCL4e8rE3OZJQ9VQ+VPE9rAydVKoY5gwoKBQqBIYxRB6wZfi6vrYr4BB
         EsCaLxnSN8wiHNlasF65JF/32/eQuYTafAJqwPy5aDNpBjTA/ChQ/xvgp00z+CL9BOpI
         g57BTDjCwyKEuWH6Dx7fwvD9vDbf72xde8B4VuI6w4bsxDmpp42IA33ELH+Sw9Z6B0UG
         vGcMRCSOQpkPzfFSOid9t1lj2KLo2/OaFn1L3udAsfJ1rBkkbvCy2FWrKbdf5CGGBC2u
         sMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695240786; x=1695845586;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWuipztbAi/54nGCS7VKUB9o88Iry/XDN21gxp7xJbg=;
        b=khVjZi14KV4+N7QMNS4pOMAmIiuhHIotOAnA6VAtAb5iPdd7vC9tb8nD8VCsxDIRMW
         wKQbMqaWZI4q6p5YUHnaI5nnmzN6cqqHET2oFKSwRdD1UdgWjFtcWNE1ohtWpssU2sWH
         faheeTNk9Ty3ICHzeOL4xmktU0QXwu8HL0LYyWwI/pWKd2OfZxJa036/clcfluFka07X
         P5BYI5RveGdjDJoIBT7gLzbUD1YS7FZcbMbaJmyI05FS+eUqQWLCpSRz1jHPG19ebBEK
         14DqhJXv+JhjDQG882cI6BPPzqhfv5s4M7fy2LggNLOB6iszOazlMTM6mQ8lyC6LxWab
         QCPg==
X-Gm-Message-State: AOJu0Yx/Gnr34UGCYOD8U9C++KL1w5W0NQtq/vFy8zVHMBaELQmd9U/e
        NfGuGoMTiud65gx1K8tW5MEKTqFXjno=
X-Google-Smtp-Source: AGHT+IHAJs9a1XcuQ4agQaU0rDZ9LjkAC1WWEGytGKAFGv/K1mAy9m6o+GRZ/YC64jGt+mZ3lnxjKQ==
X-Received: by 2002:a05:620a:4492:b0:76c:ae1f:201e with SMTP id x18-20020a05620a449200b0076cae1f201emr9631502qkp.27.1695240785868;
        Wed, 20 Sep 2023 13:13:05 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.214.50])
        by smtp.gmail.com with ESMTPSA id m14-20020ae9e00e000000b007684220a08csm1156qkk.70.2023.09.20.13.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 13:13:05 -0700 (PDT)
Message-ID: <650b5251.e90a0220.dc605.001c@mx.google.com>
Date:   Wed, 20 Sep 2023 13:13:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7049884294373979805=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] vhci: Check whether vhci open setup succeeded
In-Reply-To: <20230920184313.973822-1-arkadiusz.bokowy@gmail.com>
References: <20230920184313.973822-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7049884294373979805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=786046

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.38 seconds
BuildEll                      PASS      28.85 seconds
BluezMake                     PASS      907.25 seconds
MakeCheck                     PASS      12.89 seconds
MakeDistcheck                 PASS      161.41 seconds
CheckValgrind                 PASS      264.06 seconds
CheckSmatch                   PASS      358.21 seconds
bluezmakeextell               PASS      108.27 seconds
IncrementalBuild              PASS      730.15 seconds
ScanBuild                     PASS      1093.08 seconds



---
Regards,
Linux Bluetooth


--===============7049884294373979805==--
