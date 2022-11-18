Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9C4C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiKREOz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiKREOx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:14:53 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9CC6151C
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:14:52 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id g10so2702648qkl.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TZfiUfdub1G01afBc6fSUq6xJ/+aUTadkhEse01TwyA=;
        b=R87HeT22b69v75sPt5U+6KfgvazQSsysg+OYFr67H3N5NFzCvJzrY7CzKnxl72Jhrj
         sTEJ9KzudwU32nPg4d3gO+a2TNoccmSfl2ajVxVwnMb4/MCyOq17nypy70/x1lB16dOD
         bt93wqOrj5vB61nW0tjCf2UZWWnnPpH507DKGz6ORVmwuaAyR+8K9z6/1qshJZ8akpOp
         MlyvlsNFlCumcyktZybgw5KaUBGSnXqz6RHJK9qbx4h0gDLPi0ELJ+NHsXhTRexZArSL
         xgmTd/jBuLhngDNei5DREtxZJ6jCNJKBBT4lSwt+H/rIeocZ6vQAvnxfSqOnZC8eXxMS
         8brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZfiUfdub1G01afBc6fSUq6xJ/+aUTadkhEse01TwyA=;
        b=OS879tGcYJepHpon8HZNrlJdFIcTkHZoFI49mAsnjxajdLNuzFDJTdYrXTl5kFWTdn
         IXkKCWz814+yq0/69DCkgju6yyNoE7x/u1TK/X9N2ohFFv01hMxMOUrW4PuQKNtWI5ID
         1/iAZECb77x+AotLnUhKd9v3RiJCrpeszRvCT5h5nS0eie4n7bBdqBZCgA2VoaL8KEtm
         q40bG5pVRbA0dtPDxQe/NjzwHo2BQGGwsfSLYKYE/SgOdoAHGmwWI9tn6SpdROyf4Ez1
         IoZFwP+SG3sH+p3ce2tT3mpd9KUEEtJxWK29+WrBDytX/G5Z83VqezY5uWWB0Hzqc89x
         l/5g==
X-Gm-Message-State: ANoB5plI2ZA2+EJBhQM9aKVxbVzQY3WWiauMWJq/Eg2F73W1FHmC+ebH
        P3PoTnJeDFeYn5bCawZYj5ZjIYLZTp9XmQ==
X-Google-Smtp-Source: AA0mqf7SKMOSxSW/60R28uFj0KOnqbARm2tyNZ9n+p9Qh+eAIHSQblLDYLp9YmkwVYgmu1KxvHAuOw==
X-Received: by 2002:ae9:e88d:0:b0:6fa:d303:963 with SMTP id a135-20020ae9e88d000000b006fad3030963mr4554908qkg.562.1668744891187;
        Thu, 17 Nov 2022 20:14:51 -0800 (PST)
Received: from [172.17.0.2] ([20.98.237.56])
        by smtp.gmail.com with ESMTPSA id p22-20020ac84096000000b0035d432f5ba3sm1471713qtl.17.2022.11.17.20.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:14:50 -0800 (PST)
Message-ID: <637706ba.c80a0220.fc843.79fe@mx.google.com>
Date:   Thu, 17 Nov 2022 20:14:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7159546030974933526=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lifangpi@hotmail.com
Subject: RE: [-next] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for RTL8822CU
In-Reply-To: <SI2PR02MB4603DDABFC0EC1CC323BAF4ADD079@SI2PR02MB4603.apcprd02.prod.outlook.com>
References: <SI2PR02MB4603DDABFC0EC1CC323BAF4ADD079@SI2PR02MB4603.apcprd02.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7159546030974933526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695778

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      33.66 seconds
BuildKernel32                 PASS      30.43 seconds
TestRunnerSetup               PASS      415.53 seconds
TestRunner_l2cap-tester       PASS      15.65 seconds
TestRunner_iso-tester         PASS      14.83 seconds
TestRunner_bnep-tester        PASS      5.25 seconds
TestRunner_mgmt-tester        PASS      102.70 seconds
TestRunner_rfcomm-tester      PASS      8.94 seconds
TestRunner_sco-tester         PASS      8.50 seconds
TestRunner_ioctl-tester       PASS      9.74 seconds
TestRunner_mesh-tester        PASS      6.56 seconds
TestRunner_smp-tester         PASS      8.31 seconds
TestRunner_userchan-tester    PASS      5.53 seconds
IncrementalBuild              PASS      30.70 seconds



---
Regards,
Linux Bluetooth


--===============7159546030974933526==--
