Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB71C001B0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 12:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjHGMpq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 08:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjHGMpb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 08:45:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CD22724
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 05:45:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so39325185ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Aug 2023 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691412294; x=1692017094;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2iTYt+8/j3SwRPjIETQbee0bQ6OSvCIyQWAuV1SyhwY=;
        b=GIHtYihP2ZR9WsLAtu6MdGJ358f4cZwW/8ekrRVvsXkgy175JrV0oJE9DoPeo2Hftc
         UZEYPhxZ1ycMWVFYbbZS38D9D3Uqb2eyiFp2vhULByq6riKAo0A0nRq2Qp8KsA5wIFN3
         fxftcDa33WJrcrZ4tdyb5NEw3gBVzqTH6bNRFi1tm+MmvFzcemmXBEPFbLY/Z9gu7tB/
         LUmIMStUuIRgyAgW2NuHs9Pnbuabb+xoJSZDoG88aX/xTdU/L3pRRvCHqYYfQWgTTJ9c
         SdLDLjzpGoFlb70dN8kE81Jv3Pjh0Bd0SKaTPerraaB2XNEB/CygxUM1yNb/4CRew+7A
         6t5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691412294; x=1692017094;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iTYt+8/j3SwRPjIETQbee0bQ6OSvCIyQWAuV1SyhwY=;
        b=RShm4qpQJo1cy6pmO+WQXVIjzRRFmje0iZkfNH8QXsG9CjBy8EB3LBJB6nmU4d6Z6Y
         1+ITTtyI9G3Yw1VgDgd0kL5qe/hGyObUpeBJ2YoXEVe64T2HkbQGM+jfZ39WDUk45A+K
         WosPOC4F+400WooPt5762Qdp7mSXN7JyR8XTmIi8QiF9sB/8huPNr/HeUcrI+3iutSCk
         e6ObgJ5Imqh3IZkisUbeM3VadCCKlhuIymq9iaNRbddXgqzVDg3BWnMzh3vfE1oIvDIU
         T9OtYFsJgdFrok/DBmJU1KEbPaAu/IxFf5YHvBN0IZjKspZ0c5d3nfJnxdiLrnClBTar
         8gkg==
X-Gm-Message-State: AOJu0YyWSMinXahpVmZkB8HewuzqYO022xOoOvvxS+puh2t5odS3vV2+
        LIieZLfe1iNTCPsKLNbvYfaA0MlYMBY=
X-Google-Smtp-Source: AGHT+IFE73LFG75pYRq87aBtOT/G+MYa7/KKRVuBU9QduXoVTA1PAN9eLNmVB3E4iRu1TrxA1Ofa+Q==
X-Received: by 2002:a17:902:e74c:b0:1b6:68bb:6ad0 with SMTP id p12-20020a170902e74c00b001b668bb6ad0mr10500123plf.55.1691412294250;
        Mon, 07 Aug 2023 05:44:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.133.131])
        by smtp.gmail.com with ESMTPSA id o15-20020a170902d4cf00b001b866472e8dsm6804776plg.241.2023.08.07.05.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:44:54 -0700 (PDT)
Message-ID: <64d0e746.170a0220.dde72.baa1@mx.google.com>
Date:   Mon, 07 Aug 2023 05:44:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2417483460066119596=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [v4] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C
In-Reply-To: <20230807114259.13654-1-max.chou@realtek.com>
References: <20230807114259.13654-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2417483460066119596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=773633

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      35.41 seconds
CheckAllWarning               PASS      38.11 seconds
CheckSparse                   PASS      43.41 seconds
CheckSmatch                   PASS      115.98 seconds
BuildKernel32                 PASS      33.56 seconds
TestRunnerSetup               PASS      509.78 seconds
TestRunner_l2cap-tester       PASS      23.97 seconds
TestRunner_iso-tester         PASS      49.11 seconds
TestRunner_bnep-tester        PASS      10.87 seconds
TestRunner_mgmt-tester        PASS      221.06 seconds
TestRunner_rfcomm-tester      PASS      16.57 seconds
TestRunner_sco-tester         PASS      19.54 seconds
TestRunner_ioctl-tester       PASS      18.57 seconds
TestRunner_mesh-tester        PASS      13.79 seconds
TestRunner_smp-tester         PASS      14.60 seconds
TestRunner_userchan-tester    PASS      11.53 seconds
IncrementalBuild              PASS      31.95 seconds



---
Regards,
Linux Bluetooth


--===============2417483460066119596==--
