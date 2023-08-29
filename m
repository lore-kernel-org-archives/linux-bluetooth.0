Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1D2C71153
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Aug 2023 13:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjH2NUn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Aug 2023 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbjH2NUb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Aug 2023 09:20:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2A6184
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Aug 2023 06:20:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c1ff5b741cso5302855ad.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Aug 2023 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693315228; x=1693920028;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iU9l/+Yc4Sb6CRES1zHDIgBUdkLfYg54/LO+9a0nGWs=;
        b=F1Rugvf5s//XNd4FNhcOCvQdq9ZYtXfZ9Gl3j/OyBVdO0+lrGJwWcze0DNBusq8HDi
         t19s5RgbVX7P7Q0WCpXpWEsm8puTVFMeAKLpn0b5hToRdEx8pMT9sMW3SQVg/G+IqWe1
         2yM7Wxikpa/J4x3H9HufQWlKPgJJ49KuLPoVihXC8RcgYXO6eurMeDGBtudC0D3QAAQj
         raMvAJChSSDAyfMf12lqfQtny8NdAdK8AxG5EAjE0vitxVfgrVpwL8nIdzQrtTKGW8ql
         vxz2GIZnr0O4RNfX38WZGjuGzJfHL69ZwGw5WkCuZaOirw8E0UowG7nJwuW8tBeKYP0r
         aFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693315228; x=1693920028;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iU9l/+Yc4Sb6CRES1zHDIgBUdkLfYg54/LO+9a0nGWs=;
        b=cqDgK1zm6NKIAN/DkDMxFfGvW6I8mP7m73quu3qTHX+ESD16Vh68jDPX1trurHfGhs
         AohTmKvUFn7DwBdsYI6U28S7a8HGEkQjesTDXEmdy1SqbG1+JQ4xnSi2b+7NOWh/Yc3l
         CfZa4BLgA3ZwYR0gwx9Z8zNCbzS31Tx7v7w24L1U7sTZBqyz/JZS9S+pM6abhhBDUp3A
         S/b/LaW/KW0zeAfO75cXLhAibpggjBSTKOQIQgk1WN0HEXRztpHKs2wcekxoM0ylvG8c
         n/XqoUqV+lGxLiponv3NmAoGpKxbEqAF4gRDOo+vIk/0iIEL5BSKLc82ipPmqcSdneIm
         O8GA==
X-Gm-Message-State: AOJu0Yw734gyE9F3tWBRsLAyffUNEjdc/xVehhMDsQFWIXBri8gGEO0I
        yoMnn7vhGnVbPbTDUTvzh68ocL9/pxI=
X-Google-Smtp-Source: AGHT+IGcQwXyHO73ZDaK9eHg9UvChrl+AlMk3766P5FIzHd/eK+5+2einzI0tKGT2V8Z2Pmk2Ma0pQ==
X-Received: by 2002:a17:902:d4cb:b0:1c1:e258:7447 with SMTP id o11-20020a170902d4cb00b001c1e2587447mr7598716plg.22.1693315227535;
        Tue, 29 Aug 2023 06:20:27 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.245.225])
        by smtp.gmail.com with ESMTPSA id ft7-20020a17090b0f8700b0026b45fb4443sm10955629pjb.4.2023.08.29.06.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 06:20:27 -0700 (PDT)
Message-ID: <64edf09b.170a0220.f7a66.18ee@mx.google.com>
Date:   Tue, 29 Aug 2023 06:20:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5159454191252380712=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vijay.satija@intel.com
Subject: RE: [v2] Bluetooth: btusb: Add support for Intel Misty Peak - 8087:0038
In-Reply-To: <20230829124024.40592-1-vijay.satija@intel.com>
References: <20230829124024.40592-1-vijay.satija@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5159454191252380712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780202

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      39.35 seconds
CheckAllWarning               PASS      43.28 seconds
CheckSparse                   PASS      48.66 seconds
CheckSmatch                   PASS      133.15 seconds
BuildKernel32                 PASS      38.26 seconds
TestRunnerSetup               PASS      580.94 seconds
TestRunner_l2cap-tester       PASS      33.88 seconds
TestRunner_iso-tester         PASS      74.23 seconds
TestRunner_bnep-tester        PASS      13.19 seconds
TestRunner_mgmt-tester        PASS      243.85 seconds
TestRunner_rfcomm-tester      PASS      20.51 seconds
TestRunner_sco-tester         PASS      23.15 seconds
TestRunner_ioctl-tester       PASS      22.53 seconds
TestRunner_mesh-tester        PASS      16.58 seconds
TestRunner_smp-tester         PASS      17.65 seconds
TestRunner_userchan-tester    PASS      13.80 seconds
IncrementalBuild              PASS      35.80 seconds



---
Regards,
Linux Bluetooth


--===============5159454191252380712==--
