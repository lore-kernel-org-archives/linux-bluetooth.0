Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9980FC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 13:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiGVNhU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 09:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVNhT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 09:37:19 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ED97D1FA
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 06:37:17 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-10d6e8990b9so6310031fac.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=o/oHF8d0AgOYdj2IFVW4B1EYKvxgURSxW26c3IJDfR8=;
        b=oJl43TcPSls3EW1BnsgqXnNYeVjpObByGBHb1007M/8sllIPNnPYSMwC2f2glZQRQh
         wvPg/0kBtBsqfeibiskL8B8IYOSJKAlE596lfDdTwD25GEOHCQRldKcTuoIzz+6RUcGN
         EMhGswa5dduzZhTVYI9Czfk5h9ggB6YoxpbjKRKENm+lSFgYcj2W1M8FOUwPMrh7TCaw
         jdfl+cgsVPzf8eO5CP2cyCpRpUaKTmvqsvC0uqFwsWz5e4TDgLC8FVE5BtgjXcnAOqIV
         5d7XxIOlvY/o6gqBhS1S8cPN93gzpCGRGk3yTSZ/h7eKKL1XcBuajt00UShyNqLLPDcE
         vP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=o/oHF8d0AgOYdj2IFVW4B1EYKvxgURSxW26c3IJDfR8=;
        b=j7IjeNjEvI47bQT1H8GTWiu0rX7yIGBIkRxQ7EYE3PtxG7gR4mqWOTUVM9xC9t1/pc
         0AIz3E1/7epIXCdzH1sqUsWV4VS85XJV7mDY3OtI3n2UvZcgOllCSx+lLWvnbR2QnU11
         PFU5jGKFlC/RWUgJ33mXLrzbqKgcFyIg4OR9RkUEQ3cr10N1NDAYg64uepkOVaMAp4Gq
         P1grvIOr3AMJSJu/IRHQGdCF92nodROe1CJWf06hD6wBhoaLEOd/z3rdSHkk5RHvXOQz
         H4PQclIddp/6Z8Su0ZQO6UrUgFn44Sn4Q/PJzZy4M7BkbnS+AO2L/RTHScPO8iZy//EF
         hoCg==
X-Gm-Message-State: AJIora+aR5yjd+A95jJopcCRnLycysGaLOwy4pvsVppYCVYYEeneAJaK
        Mw7IKXJ2Q3ov28ajHSQKHVpqtj08JYc=
X-Google-Smtp-Source: AGRyM1uAKNne2Z6fUVWNEgPUiF9ByEbU/EVkI8txS5lROtlLfoW8HxthpLHvInXixHXC0HPeHrVN4Q==
X-Received: by 2002:a05:6870:f71c:b0:10d:c1a1:565 with SMTP id ej28-20020a056870f71c00b0010dc1a10565mr965395oab.120.1658497036543;
        Fri, 22 Jul 2022 06:37:16 -0700 (PDT)
Received: from [172.17.0.2] ([104.214.30.138])
        by smtp.gmail.com with ESMTPSA id e21-20020a9d63d5000000b0061ca70905absm2020371otl.49.2022.07.22.06.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:37:16 -0700 (PDT)
Message-ID: <62daa80c.1c69fb81.ffcbe.8469@mx.google.com>
Date:   Fri, 22 Jul 2022 06:37:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3858060408352869749=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, soenke.huster@eknoes.de
Subject: RE: Bluetooth: Fix null pointer deref on unexpected status event
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220722115307.243056-1-soenke.huster@eknoes.de>
References: <20220722115307.243056-1-soenke.huster@eknoes.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3858060408352869749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=662224

---Test result---

Test Summary:
CheckPatch                    PASS      1.51 seconds
GitLint                       PASS      0.77 seconds
SubjectPrefix                 PASS      0.61 seconds
BuildKernel                   PASS      44.25 seconds
BuildKernel32                 PASS      38.64 seconds
Incremental Build with patchesPASS      65.34 seconds
TestRunner: Setup             PASS      672.66 seconds
TestRunner: l2cap-tester      PASS      20.59 seconds
TestRunner: bnep-tester       PASS      7.63 seconds
TestRunner: mgmt-tester       PASS      125.34 seconds
TestRunner: rfcomm-tester     PASS      11.56 seconds
TestRunner: sco-tester        PASS      11.17 seconds
TestRunner: smp-tester        PASS      11.05 seconds
TestRunner: userchan-tester   PASS      7.51 seconds



---
Regards,
Linux Bluetooth


--===============3858060408352869749==--
