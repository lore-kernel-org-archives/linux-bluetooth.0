Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D842EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Oct 2022 08:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiJCIFR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 04:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiJCIEq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 04:04:46 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4D643324
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 00:40:33 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i9so2977249qvu.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Oct 2022 00:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=y2RRGEE3GrWdVB+IcxpBpXUuSz9viwfydm9uleNMwyM=;
        b=jWI9Vr3J2StuF/qtRkVbL6pM6OSw9ih3bO9mp8o3M7LvboT03QGhsiQ8Usl1cc5sXz
         6JXDOvHxLkLNTqopl42k+b6p0qkdwjs9ECCiI53G8IuaTHbZe2Cs1jTllrj5RRdlcXmt
         I6IuK4MbxIVvlR1L+5Nbrwf29j6uHyAs85vcHo1FijnWqwet6uk2ZERxYQTT/T+B1R8A
         8EjulT2Bj5G409Pk5HsSB4GKpAlFeYMhYkyNZ9KKjPAhL9ejPiaeLOq8eLBCIRx2ccRm
         YlPCRhzlvhvu51yp5NScxN92WCBykVTXVD/lhMR/PpKB5rkJ6rAJCnq8F0Wnhq4OBpJ6
         slTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=y2RRGEE3GrWdVB+IcxpBpXUuSz9viwfydm9uleNMwyM=;
        b=B60ZaR8vwQrJ67+4eYCDYAlsMfiEMdyLSwC1LllFU31SUZp4Dsw7xhqB6XOpleoXMB
         mb9DtsNK9RXhKJWiImQY+qVQQvkAeEl2hlbUxedGt+/5HX4/bOWqvJ6y5/48AGWSJdV7
         ADp9q/TUupnuHEBVmlol79+yXszfhT3/Woy70POd/BMVoOmg+NRbqLCBunWW1Cs+FMP5
         E1qk/6tp6qegu4iO0P+8AaZ3avE19xihE8muMQwdIepaRg0mYkKyn/wr5vIwMx5o0Dgo
         JRi+Op9aQU8TbF2tsUrK83vRXXf2QJkBRT4N09mj7EAiMrIRpZBfsvwu7nWDgDxtEBYV
         +1Jw==
X-Gm-Message-State: ACrzQf3OUQpMObZXLEaipGd/h79ZuJxcxUz+6RnSpqPQOAa1h3nKfitC
        U/P1a2q4aZ4Vi1i6xiODORfKsJ8ksT2VPQ==
X-Google-Smtp-Source: AMsMyM4juF7inBHcsn/tJmEZz5NbsVKUb3tslrgJxYaVlS81gN2JmYPBOS0DHmA3srJKclFWBfAejQ==
X-Received: by 2002:a0c:8c4f:0:b0:4ac:94fa:a587 with SMTP id o15-20020a0c8c4f000000b004ac94faa587mr15163202qvb.40.1664782327368;
        Mon, 03 Oct 2022 00:32:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.144.31])
        by smtp.gmail.com with ESMTPSA id z10-20020ac87caa000000b0035d43eb67bcsm8665949qtv.91.2022.10.03.00.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 00:32:07 -0700 (PDT)
Message-ID: <633a8ff7.c80a0220.2df53.e4b0@mx.google.com>
Date:   Mon, 03 Oct 2022 00:32:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8313174645120193046=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] btusb: Avoid reset of ISOC endpoint alt settings to zero
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221003064836.11414-1-kiran.k@intel.com>
References: <20221003064836.11414-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8313174645120193046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=682688

---Test result---

Test Summary:
CheckPatch                    PASS      1.79 seconds
GitLint                       PASS      1.02 seconds
SubjectPrefix                 FAIL      0.86 seconds
BuildKernel                   PASS      44.01 seconds
BuildKernel32                 PASS      37.35 seconds
Incremental Build with patchesPASS      52.88 seconds
TestRunner: Setup             PASS      611.23 seconds
TestRunner: l2cap-tester      PASS      19.50 seconds
TestRunner: iso-tester        PASS      19.65 seconds
TestRunner: bnep-tester       PASS      7.79 seconds
TestRunner: mgmt-tester       PASS      119.75 seconds
TestRunner: rfcomm-tester     PASS      12.14 seconds
TestRunner: sco-tester        PASS      11.26 seconds
TestRunner: ioctl-tester      PASS      12.80 seconds
TestRunner: smp-tester        PASS      11.21 seconds
TestRunner: userchan-tester   PASS      7.94 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.86 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============8313174645120193046==--
