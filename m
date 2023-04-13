Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9119C7619A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 02:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDMC03 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Apr 2023 22:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMC02 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Apr 2023 22:26:28 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B828C2D43
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Apr 2023 19:26:27 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id cg4so5076847qtb.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Apr 2023 19:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681352787; x=1683944787;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1bQhNwcEQ6pFvx49TyRLWgwpe/F+6lBi0k/GezVVeP0=;
        b=rKtTTsS7/LEnoNJBbZcYcntWm7lBXPaeuzCvDNxzo9o647zUxj2xSSDCjSfvSCQ4pc
         lxaFwtxy6XjHGvE23YABwI8Y7ebO4/E9Pxy7pDI411mQ3MO/CVFPa7/7eRehmwA8HE6V
         41gjJBtaIjvhEIJ441N2LkakHmPsWBzfln6yQmcYqRBEU8PBn4a7LqWmKT0voH2rIqll
         mm9nz85wbAbZCYpOxcMV65c+VvcR3M6y8Y0uYPqLjl6XnqhFrClDGK4B1WPbpu+REg2K
         zvKujtOa+F7+f/o6LrOGX+8VfCNqommaXTFYbNK7NDGK4UkSYpBb566ac9SSvOK3iB0e
         YICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681352787; x=1683944787;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bQhNwcEQ6pFvx49TyRLWgwpe/F+6lBi0k/GezVVeP0=;
        b=V9Mv7WGBOScbKk97c33XMnEQ00LwIHRd1dbEp6cGnuN9CJ+mUpkdx5yr8YRKrkdbCo
         NFp35CbelFy/scIV75DXAaUL7Mf9utfbdXwvF5SR3aqsclRC72vUgcaheITaAbORlwwH
         UXRuyzW4yZdMS2K4c2LNlww+LWfMq3PrZimyEBsrBgalf2Jt4s7EKpU2n/SRnH1Rauty
         1HfU6z5FnDtsv4XP7Su73EzUwwEI/omMsRyKvSyxlGk7baXrlXuqfpMMgcSZ5u5WSBW/
         LQ/b1vrZCg/1TpCJfpEQ7oilAlxkJOvRJm0wCrEmjhOhGsQbVM9TE5KguhCTnrr5mXYt
         lzoQ==
X-Gm-Message-State: AAQBX9e1zwchGsJ8L3hR0SZkycVsJtcrBxCEcJgeMsWAxIn2y7N1nBHA
        vYL4cgJ/rqVLjFwd2lCa2KJx39P8oNI=
X-Google-Smtp-Source: AKy350ZDjWM2Mt25syBBlDQANwDFs6Q1IBJeBKREfViMFwb3+OYBRNBSGvihfQBKjhpK+6C+9m9ipA==
X-Received: by 2002:a05:622a:148e:b0:3e6:3c1d:a748 with SMTP id t14-20020a05622a148e00b003e63c1da748mr907757qtx.42.1681352786778;
        Wed, 12 Apr 2023 19:26:26 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.246.180])
        by smtp.gmail.com with ESMTPSA id do4-20020a05620a2b0400b0074ad04609f8sm123347qkb.117.2023.04.12.19.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 19:26:26 -0700 (PDT)
Message-ID: <64376852.050a0220.5d021.05d3@mx.google.com>
Date:   Wed, 12 Apr 2023 19:26:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5928893442766525415=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/3] Bluetooth: hci_conn: Add support for linking multiple hcon
In-Reply-To: <20230413005046.642682-1-luiz.dentz@gmail.com>
References: <20230413005046.642682-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5928893442766525415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=739317

---Test result---

Test Summary:
CheckPatch                    PASS      3.52 seconds
GitLint                       PASS      1.06 seconds
SubjectPrefix                 PASS      0.37 seconds
BuildKernel                   PASS      38.01 seconds
CheckAllWarning               PASS      41.68 seconds
CheckSparse                   WARNING   47.73 seconds
CheckSmatch                   WARNING   123.69 seconds
BuildKernel32                 PASS      37.14 seconds
TestRunnerSetup               PASS      519.08 seconds
TestRunner_l2cap-tester       PASS      18.08 seconds
TestRunner_iso-tester         PASS      19.00 seconds
TestRunner_bnep-tester        PASS      6.11 seconds
TestRunner_mgmt-tester        PASS      125.24 seconds
TestRunner_rfcomm-tester      PASS      10.05 seconds
TestRunner_sco-tester         PASS      9.03 seconds
TestRunner_ioctl-tester       PASS      10.53 seconds
TestRunner_mesh-tester        PASS      7.74 seconds
TestRunner_smp-tester         PASS      8.84 seconds
TestRunner_userchan-tester    PASS      6.62 seconds
IncrementalBuild              PASS      98.31 seconds

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


--===============5928893442766525415==--
