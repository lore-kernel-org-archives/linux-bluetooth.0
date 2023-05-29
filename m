Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9F6C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 06:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjE2Giw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 02:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjE2Giv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 02:38:51 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C3690
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 23:38:50 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3942c6584f0so827112b6e.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 23:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685342329; x=1687934329;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gQdnNLd4ldDfT1aw1hz3CiI+6suFXknTcO+4bgshpqY=;
        b=gILVcVSrqtfNm0kmJ4HI02j6t7uWYQkpp53V4XmeZ4vLWKLPGXXfhZvMmqyCoi++3M
         L2VDA5mQ28YtitZfNGcgVRh8bfR+UU5gZY56uhdfS4Q/WhtLlUzatnHWeXBdV46PvQ6l
         DUx5Od08rJB4xRYkAF/ZoGCjU4no7GnoRg4H1r5XaUGIW7yuk5TZBz4cVxjMQoIuDCNV
         EpWxfpcuAuabYeA/7M2C2x2AAQ8D7XQOffXwrUwMKwHUpAe+K3uvDaWhC6ObaeYRn50B
         /JQMRXzXNi99S6rsTThkXDYJW9ZcDoGz64cfxyeAzkvgTLoXHem1PugV4BCFTEJgZyyR
         CJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685342329; x=1687934329;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQdnNLd4ldDfT1aw1hz3CiI+6suFXknTcO+4bgshpqY=;
        b=d+QT4yVsQsVOpWp9eTpiGepF8TPQm9i3pdLWHC2ptaWXbUa9RocPlRpf3vuyIks5yH
         hGXjhkB1nT4lB31k3VOgg3VVB9lOQB4p8Cu5YENkHLN6BAzn67GBeEmO7uIjNH6Gd2Jq
         5i1TuX99ra1WB8QrDbyt77vnZRVpdwpn4QVoKILmzjl/wVtyntGONi9BrFzt/USB+6E4
         DjjtkszDTrSaEqlGzVEeDMsbAKhZSV2l5Plkq5FTJuq1AjeCxEnrThzGp7AS1JY2wmV3
         wwDfn75fSsm/CbP6AWEBMTlvAdCEK5PmuotcGa8jxfBkXD+DRmJSIzhcsSMgpSEdZshP
         cCvw==
X-Gm-Message-State: AC+VfDy4Aqmrut6Qunokg37GFlC/7fLEOO3c65u5wVeNferZF4PsSBEW
        g4MWeyTw3OFXJGVeiXIjL80hQbI0J+o=
X-Google-Smtp-Source: ACHHUZ7THQQ0UQaplzOHnwYc2i2dlMSHq3B7sgegiRCROhyHw6AqfNipNWzXIXUDuHh4WLPYQTu5xg==
X-Received: by 2002:a05:6808:328d:b0:396:957:cbde with SMTP id cg13-20020a056808328d00b003960957cbdemr4204633oib.21.1685342329175;
        Sun, 28 May 2023 23:38:49 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.132.178])
        by smtp.gmail.com with ESMTPSA id w16-20020a056808091000b003907c4bc505sm4111320oih.11.2023.05.28.23.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 23:38:49 -0700 (PDT)
Message-ID: <64744878.050a0220.5000d.1d9a@mx.google.com>
Date:   Sun, 28 May 2023 23:38:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8423806606648259426=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Add support for connecting multiple BISes
In-Reply-To: <20230529061057.3107-2-iulia.tanasescu@nxp.com>
References: <20230529061057.3107-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8423806606648259426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751739

---Test result---

Test Summary:
CheckPatch                    PASS      1.52 seconds
GitLint                       FAIL      0.60 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      37.61 seconds
CheckAllWarning               PASS      40.56 seconds
CheckSparse                   WARNING   46.17 seconds
CheckSmatch                   WARNING   125.75 seconds
BuildKernel32                 PASS      36.28 seconds
TestRunnerSetup               PASS      514.38 seconds
TestRunner_l2cap-tester       PASS      18.66 seconds
TestRunner_iso-tester         PASS      25.30 seconds
TestRunner_bnep-tester        PASS      6.57 seconds
TestRunner_mgmt-tester        PASS      128.98 seconds
TestRunner_rfcomm-tester      PASS      10.25 seconds
TestRunner_sco-tester         PASS      9.34 seconds
TestRunner_ioctl-tester       PASS      10.88 seconds
TestRunner_mesh-tester        PASS      8.05 seconds
TestRunner_smp-tester         PASS      9.30 seconds
TestRunner_userchan-tester    PASS      6.83 seconds
IncrementalBuild              PASS      34.26 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/1] Bluetooth: ISO: Add support for connecting multiple BISes

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
84: B2 Line has trailing whitespace: "        Codec Configuration: "
100: B2 Line has trailing whitespace: "        Codec Configuration: "
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


--===============8423806606648259426==--
