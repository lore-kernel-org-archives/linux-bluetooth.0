Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B77C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 17:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiLARLM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 12:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiLARLI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 12:11:08 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F664A8FFE
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 09:11:07 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id c14so1789177qvq.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 09:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kvfSePvYf7ljWOerbsgyD2YE947PPkiyitevKf/wSlY=;
        b=ElZhm4FCSz0k5XpbZkPs28fOmSblNRhuHYZQ/s7ysXXWxfUFA4tjuODFMMZvw74kwK
         t6H08h4nVYQB4eqDeIfieGFjmPcvCjTPU0jNWTuBFgfoxb4ySrqF8SqkJkC3QC2zC3q1
         /eBmkPr9uKI6xutK1W3LI5uWgoaHsThJkwCWd0def1NpvjCajsJqG9JEXK0jf4DseV8D
         rc616eSurKuFznZuFxFXErR244unZciaNeYzld67PP2eXbB7Ln3t5Wkc2m0S3bcqlayN
         lkjR1IiOJ3bHdd96id4HXHTXmWK+Jq3lNg523/LFlfChqhSKxy6HVRtJ4TIZYJBIqHBJ
         ByIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvfSePvYf7ljWOerbsgyD2YE947PPkiyitevKf/wSlY=;
        b=uB6BCoFot07tEnRqDKi5MndlJW6bewaflrvOoml57ssSD9ATRq/xpXa7Zf6IeLcxIh
         /sT6E1VembvP+jYr8Q+kXan37p3P9A9589jzdd735QerqYVds+r6IzHVVR6DzGBanks7
         TFbB24yKSvsxlJ85KApC/gSxcmsVXFxKgWEDbMrNMxjlOvxDVWOr5MQSqnEVnJLwWgPq
         ituGVzbN0NIfTaQShVmSIZSHAfU/fq3gGJ1z9BBGLsrQzCOpIn2Ey+l6UDZiTWJWvF8b
         E40qBQcp4FacrfE7WWYTFHFwaf+1I3U80t0Ljhai4LzL5nrYas+EEU+6EMdmgifRBWiH
         3mdw==
X-Gm-Message-State: ANoB5plyYRIyLyDtw2pwJzKwUBXOJQaN+7pz8B+NqxZzi53CuD1tF+01
        5jKc9JVlG4D6O4wWhZ7mCfNrWsDZU0Ap7g==
X-Google-Smtp-Source: AA0mqf7ds78Iw6mOKW4ZmlEwil8YBBaWr/E4LOb5gy4tGv3FiwIk6zNtBL10Zv9UbJIBpn7Do0ud8A==
X-Received: by 2002:a05:6214:1843:b0:4c7:2b1f:841a with SMTP id d3-20020a056214184300b004c72b1f841amr3556281qvy.68.1669914666394;
        Thu, 01 Dec 2022 09:11:06 -0800 (PST)
Received: from [172.17.0.2] ([20.97.177.103])
        by smtp.gmail.com with ESMTPSA id az20-20020a05620a171400b006e42a8e9f9bsm3734514qkb.121.2022.12.01.09.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:11:06 -0800 (PST)
Message-ID: <6388e02a.050a0220.1ee07.e13e@mx.google.com>
Date:   Thu, 01 Dec 2022 09:11:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3662265921141036691=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, allenwebb@google.com
Subject: RE: Add missing sanitizers.
In-Reply-To: <20221201161502.1067068-2-allenwebb@google.com>
References: <20221201161502.1067068-2-allenwebb@google.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3662265921141036691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=700907

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       FAIL      0.59 seconds
BuildEll                      PASS      26.49 seconds
BluezMake                     PASS      768.96 seconds
MakeCheck                     PASS      11.50 seconds
MakeDistcheck                 PASS      148.78 seconds
CheckValgrind                 PASS      244.46 seconds
bluezmakeextell               PASS      95.06 seconds
IncrementalBuild              PASS      639.32 seconds
ScanBuild                     PASS      979.22 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/1] bluetooth.ver: Export sanitizer symbols.

1: T3 Title has trailing punctuation (.): "[BlueZ,v2,1/1] bluetooth.ver: Export sanitizer symbols."


---
Regards,
Linux Bluetooth


--===============3662265921141036691==--
