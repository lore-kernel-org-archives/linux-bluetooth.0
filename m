Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F7BC19F2B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 09:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbiHDJOd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Aug 2022 05:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238999AbiHDJO1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Aug 2022 05:14:27 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D281761DA5
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 02:14:26 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i7so14736870qvr.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Aug 2022 02:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=gKAEFuDiSGA+1EGbtaLtu1f8Xf6XHh7Agdp0xmer+Zw=;
        b=XYOUWMcR1Qr0VNHjm8S3oc/uPQHq2BMhoMFmkFxxjVF1E4p+BYd+sdLE5frGIEnn8V
         B7z816Xe/OVddyj/xAfr/X/YmJYVZ55z/3oASPG8E/ZNDBHDSbRjcw5ban9ng+24Dc+c
         KjJjkbFcXCVPkR5LzlPQf1lnKQ+vto1AqzzdVFDHLOE8Vs8r9vMDHZlIlXvd3USNMQj+
         cxO59v4S2WqEbZ7ej7lhEmmq1Avd0zjDIUFog4z002tmi1/dMNxOWJ5UNp82ROz1m13D
         xFCjaoUNOzkC6/RzDOBEuXaXeCQPBS9R6NKEGEc0iKlh3b2qc/6HHlyGaTysmLhbgiqy
         NraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=gKAEFuDiSGA+1EGbtaLtu1f8Xf6XHh7Agdp0xmer+Zw=;
        b=VsDsoIY1cDyOjlneewpFuK9pmCEx3GSTgipdoSjFXz+kR/4SfuWV06K1AdWluWqP+Y
         4tGKla+I77zKXr76rlsSIYHL+6XsangOkLz53vV3s3ArNimYrys3SLHu2lkGKX+tQnFv
         uN3YPRiuB2NP2CV/OTuZB8YTGFQpwGecYOd9OY6J+vC2lUDGLQiXAGKdrkEZH+m1+2S0
         wxd7bwZ/o8Hr0UW8QR8X6O5mrzUrbk2p4RPfQMT9XvZl8QQGWjFQH9DhwNjcis1ZAOWY
         LitvgsKCqBrssgF5T9JnGd0pdGJR4wzd2da1NhnUWjKeCrU8WAZQJ4e7PV/IWhQOjvbZ
         qdgQ==
X-Gm-Message-State: ACgBeo20sqCPfboLLIrBtYZViJk7lAS3qcMfYhVXQo1mrnC+gZz0lOtv
        L/0/dleNAOdd/nuvaZFcNuhUWt58cRo=
X-Google-Smtp-Source: AA6agR77wFpnS2Bq1HJ4EpSgV9gcYmcbm0ph5fVANzKNBpQtTjw0oeqLIdFFnkAtGImMNriXqybXjQ==
X-Received: by 2002:a0c:b319:0:b0:473:82bd:327b with SMTP id s25-20020a0cb319000000b0047382bd327bmr621036qve.43.1659604465658;
        Thu, 04 Aug 2022 02:14:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.121.215])
        by smtp.gmail.com with ESMTPSA id c25-20020ac84e19000000b00338ae1f5421sm341077qtw.0.2022.08.04.02.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 02:14:25 -0700 (PDT)
Message-ID: <62eb8df1.c80a0220.6485f.07fd@mx.google.com>
Date:   Thu, 04 Aug 2022 02:14:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3993120454768552046=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiapeng.chong@linux.alibaba.com
Subject: RE: Bluetooth: Clean up some inconsistent indenting
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220804081556.94743-1-jiapeng.chong@linux.alibaba.com>
References: <20220804081556.94743-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3993120454768552046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665287

---Test result---

Test Summary:
CheckPatch                    PASS      1.61 seconds
GitLint                       PASS      0.94 seconds
SubjectPrefix                 PASS      0.84 seconds
BuildKernel                   PASS      32.60 seconds
BuildKernel32                 PASS      28.70 seconds
Incremental Build with patchesPASS      40.59 seconds
TestRunner: Setup             PASS      477.31 seconds
TestRunner: l2cap-tester      PASS      16.88 seconds
TestRunner: bnep-tester       PASS      6.30 seconds
TestRunner: mgmt-tester       PASS      99.26 seconds
TestRunner: rfcomm-tester     PASS      9.72 seconds
TestRunner: sco-tester        PASS      9.36 seconds
TestRunner: smp-tester        PASS      9.43 seconds
TestRunner: userchan-tester   PASS      6.57 seconds



---
Regards,
Linux Bluetooth


--===============3993120454768552046==--
