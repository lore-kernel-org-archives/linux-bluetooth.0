Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8626DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 08:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241572AbiKRIfO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241457AbiKRIex (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 03:34:53 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1E98EB5F
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:34:07 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id g7so2235808ile.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4IQQ1uEn/sXDkaEen8Suvwi1aQoz9rGUAf6yY6wBLSQ=;
        b=T1RRl5+W3f/j0H/DsvHb9SBoLuzV9G/7T7+O17WZfVsl0+R5k3Vok/tMwh53CVZGg4
         g24p2ltL67MSIekUuttK0UfKuaQURsmhkVLb5RFXiwQjxZ3V0IhEwTsiyN9Q3GHcf7Yp
         77Ub85sFtsa5nDzWQppd2rF5kH9WJULo6Q4tKU+YAbCv0BDNkuaPVMA2egPkCVeI/FGT
         QKeFcutvfX1Hcolwx2Pv849+NuDCEvJcIJ8HSEjvRrhw+Js84LC2ql9aAXmzCxD3xlJF
         zcuBE++jm2eiTZP7XKG68SlBQdHceeUgP1PEh41ohzTExe6qie1gXVZTv8DQqvQh+Joj
         72Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IQQ1uEn/sXDkaEen8Suvwi1aQoz9rGUAf6yY6wBLSQ=;
        b=aEEX8Qw0w9JBi/x/crnbutZz5+eZy1CgormPqQd55+7QsZFYTRXZcpOgJAsfEr+n+v
         4qkd86S92/fxkcv8cx5ue2akffvWC4PJn+xlvczYdW+idJ/ozKs0xSKBRvqRkvLIKY+0
         6kAFposRxDPjeBmmEAiEKdu/E9dFve1Ljupu31cyO4cNfme2+YTA+rjMgYCmEE2WxaDz
         3os2GJ0jpKWOndJZNH+mnakZe8b77u3Y0Si83KHdlUjQ3gBqQUWsnMLSoOF1hoqWBoj1
         ZfZCzbt+K4jjkV6XT2+qTuE9dINZu22FmJyEvMxEPtQ1Epnp4sovpBuljAT+kwJBoM+f
         E5rA==
X-Gm-Message-State: ANoB5pn5H2h2PzkAJTzsAdKoV5CXC+z3Bpr8p83bl/nvaHWvH5XtWenQ
        AAMeIzKcVUxfgSc5igVdK+FugFhFESw=
X-Google-Smtp-Source: AA0mqf6D8aXR3DlzgcFoQa40qVJIJAbcQf+l2HUup7llj1tXTd/PFEo75/gZOtodo1/1pa1CIbQrwg==
X-Received: by 2002:a05:6e02:6c4:b0:302:3d55:7a40 with SMTP id p4-20020a056e0206c400b003023d557a40mr2901538ils.254.1668760446576;
        Fri, 18 Nov 2022 00:34:06 -0800 (PST)
Received: from [172.17.0.2] ([40.86.65.245])
        by smtp.gmail.com with ESMTPSA id i1-20020a02a0c1000000b00369a91d1bd4sm1017575jah.138.2022.11.18.00.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:34:06 -0800 (PST)
Message-ID: <6377437e.020a0220.6bf88.27bb@mx.google.com>
Date:   Fri, 18 Nov 2022 00:34:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4040771578757785288=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Fix MSFT filter enable
In-Reply-To: <20221102175927.401091-2-brian.gix@intel.com>
References: <20221102175927.401091-2-brian.gix@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4040771578757785288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691340

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      34.03 seconds
BuildKernel32                 PASS      30.97 seconds
TestRunnerSetup               PASS      427.73 seconds
TestRunner_l2cap-tester       PASS      16.31 seconds
TestRunner_iso-tester         PASS      15.85 seconds
TestRunner_bnep-tester        PASS      5.63 seconds
TestRunner_mgmt-tester        PASS      109.21 seconds
TestRunner_rfcomm-tester      PASS      9.54 seconds
TestRunner_sco-tester         PASS      9.01 seconds
TestRunner_ioctl-tester       PASS      10.26 seconds
TestRunner_mesh-tester        PASS      7.03 seconds
TestRunner_smp-tester         PASS      8.88 seconds
TestRunner_userchan-tester    PASS      5.81 seconds
IncrementalBuild              PASS      31.79 seconds



---
Regards,
Linux Bluetooth


--===============4040771578757785288==--
