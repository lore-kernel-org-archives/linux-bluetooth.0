Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0D1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 23 Apr 2022 00:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiDWAIF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Apr 2022 20:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiDWAHm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Apr 2022 20:07:42 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5244021740F
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 17:04:17 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a186so6932220qkc.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Apr 2022 17:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=LPsNTrzr0ad0zbPa6F6mL0l2ylKShAA3ibDaZL26zA4=;
        b=IvSrRN7S2NZYIR7BxkVBTTVSUQrZQd6MnrpNmulen1n1PHOtDeYSPidEfj6YeZvylm
         H+RSA5oVph+HtsfvqZkvLAe9szaRKXayW0GkAmjibTtSmaX/A1ME1hSXFG4a4e+DbyAH
         0es47OmAW1SjSH5whCo2C8/lxfVf7NDHvw0gEIsGuh2Q/i3Jl7R3ZpgumuOQSrBvs6P0
         P0zToAR4r7jcG2e+/M73H9NJoUT3IAnLIsXa7+1P8GzSFb4Rsg10rPoNxS/66YMeLcW5
         /hfEkDmAIQT/f6N7rdvXHO2LJsz7Y2peRLsf6RyiAEGbg4XPfFP//6i8zcJEP/3Z+mFO
         k7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=LPsNTrzr0ad0zbPa6F6mL0l2ylKShAA3ibDaZL26zA4=;
        b=cheQ1eIo0O7cC2faG7hrqum+LDgGh9GAZ96DRMvu4T4AB0RDnjqo47/9ZxqapFtmcq
         pkT3mMaVNns8c4Ci6l4h0/by0sWxZjRbEvkXFL11jPYItNHBNuNSgrDpG+00qiD5t5d4
         v+wHars93jYxAhnYyO8+sDzO7YayRLWCbVGdycVR3x6oScIivmewueFK7b8r5mJAY14W
         XaaDxgVUFW4OkOW1uw92Oo9XhVah6Ghy6TSrf1bIlwrNBv8V79BBSlKlRpl8tIBbH8pu
         zLwymsntiINn1N4hFRQXIOajh6vTWwMvO3ezvnp5cb6dHmIWbNTBZ2z1De0IlNRiaWzh
         YxaA==
X-Gm-Message-State: AOAM530ft/RBvTgIqjMsmJg5b/2CWZYnD1KqdZS8+PXl5ExNxIbiTxUa
        MvNbLQuctqguK+VuYJCXwzY8/WZL/hbwWA==
X-Google-Smtp-Source: ABdhPJyU9fT6NaNGix0r9XuLUOxlLBCSiF9lalMSpmM4AgnQl1S53PKszqbhbKSllGrXMNyWvhr6lg==
X-Received: by 2002:a05:620a:29ca:b0:69f:4d2:ed89 with SMTP id s10-20020a05620a29ca00b0069f04d2ed89mr4402460qkp.241.1650672256209;
        Fri, 22 Apr 2022 17:04:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.106.113])
        by smtp.gmail.com with ESMTPSA id v67-20020a379346000000b0069bdb3bb132sm1622525qkd.37.2022.04.22.17.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 17:04:16 -0700 (PDT)
Message-ID: <62634280.1c69fb81.ec994.a84f@mx.google.com>
Date:   Fri, 22 Apr 2022 17:04:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4785014943619241389=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dossche.niels@gmail.com
Subject: RE: Bluetooth: protect le accept and resolv lists with hdev->lock
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220422223116.70026-1-dossche.niels@gmail.com>
References: <20220422223116.70026-1-dossche.niels@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4785014943619241389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=634829

---Test result---

Test Summary:
CheckPatch                    PASS      1.81 seconds
GitLint                       PASS      1.06 seconds
SubjectPrefix                 PASS      0.91 seconds
BuildKernel                   PASS      39.15 seconds
BuildKernel32                 PASS      35.25 seconds
Incremental Build with patchesPASS      47.65 seconds
TestRunner: Setup             PASS      588.43 seconds
TestRunner: l2cap-tester      PASS      21.02 seconds
TestRunner: bnep-tester       PASS      7.75 seconds
TestRunner: mgmt-tester       PASS      126.80 seconds
TestRunner: rfcomm-tester     PASS      11.60 seconds
TestRunner: sco-tester        PASS      11.37 seconds
TestRunner: smp-tester        PASS      11.30 seconds
TestRunner: userchan-tester   PASS      7.83 seconds



---
Regards,
Linux Bluetooth


--===============4785014943619241389==--
