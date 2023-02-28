Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4FCC64ED6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 16:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjB1QAE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 11:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjB1QAC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 11:00:02 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806D87D9D
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 07:59:55 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id nf5so7173225qvb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Feb 2023 07:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677599994;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LDEsocT9YFmGiITwO6Js65MaYMkfOc5rFDtxFjvztuw=;
        b=H5ZkrNmMH9pZTarEFkWTSethRgSPPzd3ZTXhTlA9RF+b8/M64OPTxPVa8rdUml+Lmr
         /6lkpKyLYpimJ62nMh1rPF1posCH3zNSseZIO6nmuTtpyH4Fx6nktP560z5aCosIPMdP
         4gitdDuigkAvW3FR6N4r1R6ZoFM3tiI64KoIo0E2cCd5ltfxqAaBsw81OInOCr8gOwB3
         DTaOrrQRtIGbYlV5rDFncrNsJqtV88QGv8ho61k4rO3FI+r49VX5URU13+SO13gJJwmd
         VBf6mBMVQCwuZS8mZ29cMeFM+koZ0S4my/+ZUXiSUYyBaCMSC0IW+7rVuOnKaemq6z1O
         xSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677599994;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDEsocT9YFmGiITwO6Js65MaYMkfOc5rFDtxFjvztuw=;
        b=rHSJHPbOmWZvV0j0j4LxLoVAi+gMn0Me13V3pEVtbyNETHZPraSfaK28E2SALjeii+
         Ts5zDQq7ldaouCSNNAiWLt7Ge2BzKb1P0V/EyX5eKZvG2IR8VWJER2p9b0+NpfHhQHf6
         cQyCOVmz1bEaa7QX1T6tbWF45QThPmGq78Nb57Zyv5GkZC+oh/E4Il1nFFvcO4h5WAKH
         BXD3jVx0KfdeiwIBOEPBwqEx/F770lr0vNWpaUUexeDBp6oUNy8BPvYEuwEyVloG7Mzn
         2iL1kWdAEkvv8kw1ENe/hsouUdQR3tsWBD+PSOFG3Y/Uo6Tgv7lHTMRfvwTk3glvNWr0
         wlhQ==
X-Gm-Message-State: AO0yUKUWY585iXrDSsrjBBmrQB2Y6iQKZ4hPZkZHlAIpJKNz7fDVgq00
        bGjWVFlbtVz0nUeWbghO9mF9fVPzNnM=
X-Google-Smtp-Source: AK7set8NBLhPnHcgskfu5aR7ZdVNy63hmuj+JcbUZLiNNGEXdujhpHWCzDKHuSjKbbVXgQKWXYo4yQ==
X-Received: by 2002:a05:6214:2622:b0:537:62ac:97b0 with SMTP id gv2-20020a056214262200b0053762ac97b0mr7051741qvb.27.1677599994476;
        Tue, 28 Feb 2023 07:59:54 -0800 (PST)
Received: from [172.17.0.2] ([172.176.128.178])
        by smtp.gmail.com with ESMTPSA id g25-20020ae9e119000000b0073b99d515e2sm7054637qkm.44.2023.02.28.07.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:59:54 -0800 (PST)
Message-ID: <63fe24fa.e90a0220.f057b.6804@mx.google.com>
Date:   Tue, 28 Feb 2023 07:59:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1718533842151249850=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, macroalpha82@gmail.com
Subject: RE: Bluetooth: Add support for RTL8821CS
In-Reply-To: <20230228152205.133582-2-macroalpha82@gmail.com>
References: <20230228152205.133582-2-macroalpha82@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1718533842151249850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=725545

---Test result---

Test Summary:
CheckPatch                    PASS      1.99 seconds
GitLint                       PASS      1.01 seconds
SubjectPrefix                 FAIL      0.63 seconds
BuildKernel                   PASS      31.21 seconds
CheckAllWarning               PASS      34.32 seconds
CheckSparse                   WARNING   39.03 seconds
CheckSmatch                   WARNING   108.48 seconds
BuildKernel32                 PASS      30.38 seconds
TestRunnerSetup               PASS      439.61 seconds
TestRunner_l2cap-tester       PASS      16.25 seconds
TestRunner_iso-tester         PASS      16.86 seconds
TestRunner_bnep-tester        PASS      5.38 seconds
TestRunner_mgmt-tester        PASS      107.78 seconds
TestRunner_rfcomm-tester      PASS      8.72 seconds
TestRunner_sco-tester         PASS      7.95 seconds
TestRunner_ioctl-tester       PASS      9.31 seconds
TestRunner_mesh-tester        PASS      6.75 seconds
TestRunner_smp-tester         PASS      7.89 seconds
TestRunner_userchan-tester    PASS      6.04 seconds
IncrementalBuild              PASS      37.58 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============1718533842151249850==--
