Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F42C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 09:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351674AbiDOJIi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 05:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351673AbiDOJIh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 05:08:37 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971B758E77
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 02:06:09 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id r25so5611796qtp.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5tpb7bIzzjFBMu96oeLOeFhb/P3Mdi94ev/YZuo5e0E=;
        b=hrWw6xdgJKH+XmnEEXBSow3PLc9hgdjuQHMxjqZrVySJlhcXeUj4l5fCLop/fasn+1
         8Lg/dlJiAMhWT9QNE4azgqlPEi5Itvf0N0eHa8+QoQt1LDdUBFUB6cCjKzTN/PWMYgjt
         7t5NxFT+QZLhHQ1C6zZZLGP+HCDR7coKOpX9DLqa07v2shoGDjtICgc8F/SuIscHhkMt
         yz3ZQN566IFRMGE5oc531wWUcqNoJNw70AiQ/NU1Dl7ptgUPwkrCUHE7lZ+0z9uVnfft
         wfYwzLNs2SlN2yFuXuN+A5Den86IvvbDME4opIROl1NdYtRbli44FZCHMlW5L3P8XKXr
         V1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5tpb7bIzzjFBMu96oeLOeFhb/P3Mdi94ev/YZuo5e0E=;
        b=h2VOrCqit2/RqBWw+mVyUV6Gm/awOzZlFRJA7ItPD/pG51MfWQXXK1h4fr4Khcba/C
         b8L7Ex+CvilNBOp+p9rMANiO3vYiS7ZGT0xWXycjnRODwXu0koASo1usOYXLWx0KIAvw
         SkyGSayXzu950pEWlgWRr+PopR7jxNa3YKtAuwbSrfuAbcjWQZ+HfDFUUfY+vf/syBVC
         FKCxrtlYAB5Uidr48jMO9Pm4aO7/t46GEexdJ0HBu2BjimKbEY1C8JfVuIoIO1B6nZ5C
         uI0gDmZ9wkkAX/6OScsreYm1UnHyKt/AeYP2dUBey5PTN3HCU6HM5yX59hgx8dlSDqsr
         qGVg==
X-Gm-Message-State: AOAM530Eva5m0AeCXyfzQytdaPw8vu5k2+o78gaKyqx2vxRn6zwObSWy
        WfkX0po6stYJKNTTw8J9Im1aKGYIkpY=
X-Google-Smtp-Source: ABdhPJx5WOvn4HmaY+cTdPBreGRWBoUZcaiu507XYMyrMSrv8lFp+WouulxHccD668oNYB6zT8svrw==
X-Received: by 2002:ac8:6f1a:0:b0:2ef:6eba:2150 with SMTP id bs26-20020ac86f1a000000b002ef6eba2150mr4674811qtb.466.1650013568555;
        Fri, 15 Apr 2022 02:06:08 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.16.68])
        by smtp.gmail.com with ESMTPSA id z64-20020a37b043000000b0069c0a57f42fsm2271209qke.24.2022.04.15.02.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 02:06:08 -0700 (PDT)
Message-ID: <62593580.1c69fb81.9ae82.d4b5@mx.google.com>
Date:   Fri, 15 Apr 2022 02:06:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1278042418057389698=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: Set HCI_QUIRK_BROKEN_ERR_DATA_REPORTING for QCA
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1650012368-13505-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1650012368-13505-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1278042418057389698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=632528

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 PASS      0.91 seconds
BuildKernel                   PASS      31.07 seconds
BuildKernel32                 PASS      27.41 seconds
Incremental Build with patchesPASS      37.28 seconds
TestRunner: Setup             PASS      457.68 seconds
TestRunner: l2cap-tester      PASS      15.67 seconds
TestRunner: bnep-tester       PASS      6.05 seconds
TestRunner: mgmt-tester       PASS      101.07 seconds
TestRunner: rfcomm-tester     PASS      7.73 seconds
TestRunner: sco-tester        PASS      7.54 seconds
TestRunner: smp-tester        PASS      7.49 seconds
TestRunner: userchan-tester   PASS      6.22 seconds



---
Regards,
Linux Bluetooth


--===============1278042418057389698==--
