Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C691DEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 10:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbjHQKpv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350031AbjHQKpn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 06:45:43 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E52D5A
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 03:45:41 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1c5046642b4so2763649fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692269140; x=1692873940;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kP1gsl8Pa4RZ4ZgNj2qM3dVZaaKjqwrT8lCfRgG1tVA=;
        b=HYIliJP7jmCxdF5MjJhtHxOKvT+rQNrpEDEfkN30FvhhGCO6phLDOxVdHgr3Mo8+xU
         Hzv8n3G6aXe2iHVwz7/AnZYyWGE4Nu3ZsFFMJsnQ4Y4kOIwHbhK3yz0p5FiBucEQX5AV
         WtNjuzqvJuM8TvWgTGDR77XmJA9DMKS2v+i9uKzkOIVjOv+gcT6LePkbgUmt5V5LTwec
         WDP4g1Tccmwdu0cOFK9azdIx3msPdy7/TY7QVFArUJqFVJEKI06dmLSleMWOkL2ACi8S
         RyVLZBwpWmyd3yC70PfSbyO/q4DqW0mY2nCfLC+dIby1JOd6hJo6xpRpR2++aAGxh3Ax
         1KAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692269140; x=1692873940;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kP1gsl8Pa4RZ4ZgNj2qM3dVZaaKjqwrT8lCfRgG1tVA=;
        b=HEtibushK/UwZY5zZrLBszFajTkn3zyQVFeXLXmMqQ7r4W7dcB5lzX0tQCe7vti7Wr
         t9EHfonzzUAAj7ZxbxQ99waGMZwSfv4IwpKuO5Kb7FRLlHwt+zywXOiYWlrgo0KlyUsO
         42huAuIxzgS5ejs/ZxH/ydKhvkiuL8MuYt8GiSg4CLnbOV5B0h5fhqo9Jox4Gkt/ZyGu
         Nl+laG+WC7TzD4Ddo13nR75d/gVRGHzifgLcai1Dol18uxAXyoCnOh2cJNPyFyTG52FZ
         yikMzlxYqeak9HqvFFCnCVrRKe984W6it5T/53wp3ahH7lsTwXILWIWxS0fJ4ljMXgqu
         Kvhg==
X-Gm-Message-State: AOJu0YzsOKYRlDof6XvTIShxwfhLA2m3avQJ+o/B6vytnyaj6F+KCXqS
        E6IMa3C2deU+yJUcxEHK0lot5Eggw5I=
X-Google-Smtp-Source: AGHT+IFLl7S8aOZOWeCqS2r3QbwbUH1AOSqFeeK46j4X269tu6+vA23VjOh5nLk1RzTO9b/Gf5r/+g==
X-Received: by 2002:a05:6870:7393:b0:1c1:2dd2:92a3 with SMTP id z19-20020a056870739300b001c12dd292a3mr5255586oam.59.1692269140509;
        Thu, 17 Aug 2023 03:45:40 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.189.45])
        by smtp.gmail.com with ESMTPSA id g8-20020a056870a24800b001bb81299cf5sm8387861oai.6.2023.08.17.03.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 03:45:40 -0700 (PDT)
Message-ID: <64ddfa54.050a0220.1925b.05e7@mx.google.com>
Date:   Thu, 17 Aug 2023 03:45:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2268372662835338941=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, konstantin.meskhidze@huawei.com
Subject: RE: Bluetooth: btintel: fix dereference after free in btintel_ppag_callback()
In-Reply-To: <20230817093528.687571-1-konstantin.meskhidze@huawei.com>
References: <20230817093528.687571-1-konstantin.meskhidze@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2268372662835338941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=776931

---Test result---

Test Summary:
CheckPatch                    FAIL      0.99 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      45.39 seconds
CheckAllWarning               PASS      51.63 seconds
CheckSparse                   PASS      57.38 seconds
CheckSmatch                   PASS      154.80 seconds
BuildKernel32                 PASS      44.78 seconds
TestRunnerSetup               PASS      683.76 seconds
TestRunner_l2cap-tester       PASS      39.79 seconds
TestRunner_iso-tester         PASS      112.43 seconds
TestRunner_bnep-tester        PASS      16.63 seconds
TestRunner_mgmt-tester        PASS      282.19 seconds
TestRunner_rfcomm-tester      PASS      25.00 seconds
TestRunner_sco-tester         PASS      27.23 seconds
TestRunner_ioctl-tester       PASS      27.91 seconds
TestRunner_mesh-tester        PASS      21.51 seconds
TestRunner_smp-tester         PASS      23.08 seconds
TestRunner_userchan-tester    PASS      17.92 seconds
IncrementalBuild              PASS      42.96 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: btintel: fix dereference after free in btintel_ppag_callback()
WARNING: Co-developed-by and Signed-off-by: name/email do not match
#58: 
Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>

total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13356210.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2268372662835338941==--
