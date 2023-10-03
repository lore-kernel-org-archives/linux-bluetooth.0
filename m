Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960D6E7AD72
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 15:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbjJCPm1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 11:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjJCPm0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 11:42:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74087B7
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 08:42:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c3bd829b86so8573205ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Oct 2023 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696347742; x=1696952542; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b74coKe++wbfEmLJ+smTgEijQs4yDQApXt8tGfIyQPM=;
        b=eOyuJpvRUT3/bubfd9gtzmjoJEb2LKw38L0CTpIJwjOtFah5rRSMjyG4eX9Grm/kKY
         WbToRkVuTbKVNg+G/XJaNIb9gWHvllwbbwNMDQJQvH7PtCl0UnpQd94GvtcH+8hTiQXs
         /7/TnqP8a5z7X6UIH0paCO2Q78TDy8jcvsU9MDQE0QGuo2qOmpy4PpqEL07n/gbBE4+d
         sRaOy45slbxYnqJhdawiuf254QcIjFt80V7DMyj2XOiZf2QiXTGefpCuOArn+dgIYfbM
         rZIjrFTw17lBc6EgyXa/28W3wRWPhCgI2iXropQItV0J9ANyiWkQbQEyc4p9jxz6n01i
         HPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696347742; x=1696952542;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b74coKe++wbfEmLJ+smTgEijQs4yDQApXt8tGfIyQPM=;
        b=VyEE9IYg74ExBFGOXCq1ZWcN9Rn0kZH2IfEK0oT01RcDDRQObYm3kdPROadlkD+Nfb
         vJinwHHUdHklK6ihbJvEGGVzuUpeWV4QoVRg5IFUtr9stMrOPlYkI8bUg1e42O2+fGXv
         hp9iH2T9QG0JV7e27ajtP6RlkvdX0aRsdMvEYgu2/stXgeXVedw+Mif4tAV1iRCob9Nh
         ELkJ4Lci4NJCnaVWaIKbDVsxNTjzYjWHKb8Zr4Y242bZpThJCKoLFwG3hcO308Pr1XbH
         4HxBl93c/Dxl8UzDvtt2rYThO151gDaxWwig7iq+3r0S5J64YQdFS7g8strlNVny+EHh
         BUYA==
X-Gm-Message-State: AOJu0Yyi/mm940lZ73gRlrF8NwAMuXmw2eZeNSYKhl2P4ygTxGVikHpA
        L0Eue+qidrQ0SVyhH3vSowwm5G4ggg0=
X-Google-Smtp-Source: AGHT+IF8hUgLvNpJJwvENSi9xj8d7zyYzaIVHBYJUaF6t3j8VYAIdXGNFz3wK47BEzHppasoLVRRBg==
X-Received: by 2002:a17:903:248:b0:1c6:636:e40a with SMTP id j8-20020a170903024800b001c60636e40amr15809795plh.14.1696347741611;
        Tue, 03 Oct 2023 08:42:21 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.49.196])
        by smtp.gmail.com with ESMTPSA id g7-20020a170902934700b001b7cbc5871csm1726624plp.53.2023.10.03.08.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:42:21 -0700 (PDT)
Message-ID: <651c365d.170a0220.d327d.3bcd@mx.google.com>
Date:   Tue, 03 Oct 2023 08:42:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4734622079556315341=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Match QoS adv handle with BIG handle
In-Reply-To: <20231003143739.2925-2-iulia.tanasescu@nxp.com>
References: <20231003143739.2925-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4734622079556315341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789623

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      41.21 seconds
CheckAllWarning               PASS      44.77 seconds
CheckSparse                   PASS      51.08 seconds
CheckSmatch                   PASS      135.75 seconds
BuildKernel32                 PASS      40.17 seconds
TestRunnerSetup               PASS      602.36 seconds
TestRunner_l2cap-tester       PASS      36.77 seconds
TestRunner_iso-tester         PASS      61.80 seconds
TestRunner_bnep-tester        PASS      13.83 seconds
TestRunner_mgmt-tester        PASS      252.90 seconds
TestRunner_rfcomm-tester      PASS      19.04 seconds
TestRunner_sco-tester         PASS      22.40 seconds
TestRunner_ioctl-tester       PASS      21.64 seconds
TestRunner_mesh-tester        PASS      15.99 seconds
TestRunner_smp-tester         PASS      17.23 seconds
TestRunner_userchan-tester    PASS      13.50 seconds
IncrementalBuild              PASS      37.36 seconds



---
Regards,
Linux Bluetooth


--===============4734622079556315341==--
