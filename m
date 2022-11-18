Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24400C43217
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 07:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbiKRHdw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240988AbiKRHdt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 02:33:49 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82938720BE
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:33:48 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 6so4302726pgm.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QHOaqn/IQVFJkHWqjvmPYtdvNxCdAw3L0GAOnz4/uLY=;
        b=RYLQANkHIaeq9dcr7uONK0O8L7pgkB2DFAlwJMlDLwklQu2aYQmCL5dOUmz0ZQ1RY+
         swpJjdUx39AXLfdf4+3gUapnlC490Y0snqJvONc4yvXc88ZBfJtdTgGFuS0v1m+ibmps
         G8MNcbQ4rPERaQYh93qu93i1ZzsKdnOlMf8al88xxv84ogDC6nsGVE7no4zVLbLOzlh2
         qddCb1y+a+8KgxspSquDj9nqF7y8jq6J7DqL6SONlZymcvVX3JGvBEcNRtHpFO1H+X1f
         Yu7uJLfcCqPY3ljjje15NtABGBfWu3BgSzu0Xk8p3/kWywwrDoaqAgiGmgh/A6MVi5W6
         F8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHOaqn/IQVFJkHWqjvmPYtdvNxCdAw3L0GAOnz4/uLY=;
        b=oo1oN5AEo/gx6dlmAw/3DWwDox9l18ahXwfPlYgb51s1qKphr0f+mmM747GgsXMl5A
         aFp7NTqEBvzXeB4feu8g13CkjvDd1bK3DX7tN/hAlC7m5HZoAcB3kjGprcYFZDspq/Wp
         sovJDtv8GXMx7H/PbyMTJi6+Sa1FZeZd66kq08WRh32e6iK4M3doTbodnveObZq9gcgT
         COufFnVwWdnTeE23S7ola3xrC9WocuDKcNZH7uh85JfOLv7XdHXcN3MGi1bLErCRAIrF
         HeNpUsTevzfuoJyqVsnrCmlOIjIhNoCaE/jYFlTcXQlGqlMpfGRjwl7FPih1VjfcaeTq
         f34A==
X-Gm-Message-State: ANoB5pmEgAjy6M9IaC0zAY5QUhioW+XnAMlBwzoeEiAz90i99SVOCVO/
        /RuEkJ7ecZ7vvekGCjhggABt7vmtnGQ=
X-Google-Smtp-Source: AA0mqf4tEjG4jatLQL+TEuC/XElmm84lNT+JLZ/n9nrygardOXdC2wLcQbdJ8k9zatGT0GtdNM6tyQ==
X-Received: by 2002:a62:868a:0:b0:56e:3a98:f02 with SMTP id x132-20020a62868a000000b0056e3a980f02mr6638663pfd.53.1668756827813;
        Thu, 17 Nov 2022 23:33:47 -0800 (PST)
Received: from [172.17.0.2] ([137.135.0.123])
        by smtp.gmail.com with ESMTPSA id y3-20020aa793c3000000b0056d7cc80ea4sm2423931pff.110.2022.11.17.23.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:33:47 -0800 (PST)
Message-ID: <6377355b.a70a0220.3fe60.3fb2@mx.google.com>
Date:   Thu, 17 Nov 2022 23:33:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0012290691969869658=="
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

--===============0012290691969869658==
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
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      47.34 seconds
BuildKernel32                 PASS      40.81 seconds
TestRunnerSetup               PASS      546.27 seconds
TestRunner_l2cap-tester       PASS      19.11 seconds
TestRunner_iso-tester         PASS      20.04 seconds
TestRunner_bnep-tester        PASS      6.56 seconds
TestRunner_mgmt-tester        PASS      133.59 seconds
TestRunner_rfcomm-tester      PASS      11.71 seconds
TestRunner_sco-tester         PASS      11.18 seconds
TestRunner_ioctl-tester       PASS      13.40 seconds
TestRunner_mesh-tester        PASS      9.22 seconds
TestRunner_smp-tester         PASS      10.98 seconds
TestRunner_userchan-tester    PASS      7.52 seconds
IncrementalBuild              PASS      42.13 seconds



---
Regards,
Linux Bluetooth


--===============0012290691969869658==--
