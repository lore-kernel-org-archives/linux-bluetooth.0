Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885AACE7B0C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 08:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjI1Iof (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 04:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjI1Iod (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 04:44:33 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AF7B7
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 01:44:31 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57ad95c555eso6446695eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695890671; x=1696495471; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kclw3QWQAMrNCOe3WAb2adKgd42dokfhaeIrPvQBSnY=;
        b=WL/y0VkixLIH6Jh0QUSgA+5wRq1eRYajWS8lgLAxhsKAscvYGyKagfUMuyRs8OrTME
         G1lIwZ+7tYIn9aZdmxp3jMV8efvM3j1rJqgv3CFc8BJldfj7IfFmHxBwYj0R/1VW0GYF
         4wRl5dmxbdtZwtWiAs16jC8qUrL5EEQ544QTHD0WTA9v/rEC/VKeY1nk+KbiHjwy25Az
         Vxox4lDARmpse0xAj1td97RoZqbhAzejlK7oEfHj0ujxogMUP1WJ+UqOsHxh3JrDhXtl
         M7lV0SBbYqGFF1vXH21KVa1p6WuZEW4E7HKXW31/2Kv3jfoC5L4EaMQkTWTdq1++OhN6
         HxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695890671; x=1696495471;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kclw3QWQAMrNCOe3WAb2adKgd42dokfhaeIrPvQBSnY=;
        b=LeDBJVqQ3s4+txxAC/e2C6JWqOc2QAneCHDCMXlpwqKLnmZ4neaFz4Ayi5ZG44lWb4
         CY2K7GYK1c0oaxRca2d4XcdSU/k9HkUXkG9QliUmWd5UeYB8/JxuQyYunobwEKDiCElE
         4qIBTOyE0HViH1pv4vSqWh1DJBjrGv8TTAXSEaPGXWi7mWnVoQKfjCrD8/mO/qznsBtD
         WCd2x8mLjvzzl0CnVsTnI47Y9rbtdErcxtO3l4ZLItggf4YcdyuflNLR6AXbTwbbUunk
         imUJviuU+2YTQtU5cG/RJPzeAXe8fV/LoKP8sXsfkA0EI4K2Qxj1ZI/lMhZJPeKVw6sj
         5szw==
X-Gm-Message-State: AOJu0Yw10j0L3w3WY53ooFECdZcTS9fUi03cUON9EhKzuaorztZLWORf
        wCG8Avz4nFbTEG5KJ42HjeNml946UI/PVA==
X-Google-Smtp-Source: AGHT+IF4wxE6MRqtgK8uiQZFY3ljbmjjyStlYikw0lfuzq7Ba8wbJZ7x5uRtkCCkLeSpv3BJ0AiyTQ==
X-Received: by 2002:a4a:305b:0:b0:57b:dcc4:8f1 with SMTP id z27-20020a4a305b000000b0057bdcc408f1mr471437ooz.8.1695890670869;
        Thu, 28 Sep 2023 01:44:30 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.73.31])
        by smtp.gmail.com with ESMTPSA id i8-20020a4aa6c8000000b0056e90dc1ef0sm2657192oom.9.2023.09.28.01.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 01:44:30 -0700 (PDT)
Message-ID: <65153cee.4a0a0220.fdf45.4e4c@mx.google.com>
Date:   Thu, 28 Sep 2023 01:44:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2269654561857437275=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Fix invalid context error
In-Reply-To: <20230928075257.3123-2-iulia.tanasescu@nxp.com>
References: <20230928075257.3123-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2269654561857437275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788378

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      39.89 seconds
CheckAllWarning               PASS      43.70 seconds
CheckSparse                   WARNING   49.50 seconds
CheckSmatch                   WARNING   135.26 seconds
BuildKernel32                 PASS      38.48 seconds
TestRunnerSetup               PASS      592.66 seconds
TestRunner_l2cap-tester       PASS      35.07 seconds
TestRunner_iso-tester         PASS      66.51 seconds
TestRunner_bnep-tester        PASS      12.28 seconds
TestRunner_mgmt-tester        PASS      255.70 seconds
TestRunner_rfcomm-tester      PASS      18.86 seconds
TestRunner_sco-tester         PASS      22.78 seconds
TestRunner_ioctl-tester       PASS      21.26 seconds
TestRunner_mesh-tester        PASS      15.91 seconds
TestRunner_smp-tester         PASS      16.91 seconds
TestRunner_userchan-tester    PASS      13.22 seconds
IncrementalBuild              PASS      37.25 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============2269654561857437275==--
