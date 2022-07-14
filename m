Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC22C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 03:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiGNDOY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 23:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiGNDOX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 23:14:23 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254341A811
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 20:14:22 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id cf13so487536qtb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 20:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=XobLFaW97SZ++DC70ufyFir64gao2VTr2Fydjlgz1Jc=;
        b=DVMuzVndXH6PHC8tp0u6hR6SIOEkdmug2dTLhYoaOI3zLWgA3BXT5yS6Yv9ibGG7bC
         6DUDeJ3Q1wzwuuHSsa1FfcDzh8fgToWQ5ZP9pYs0O09XeOXoTVge2ti535d2L5For2ta
         gpUNhQCP6S1xhj/PdPAXVrojRaTrzTmxxh6Oz3gAOblzvu3ZCfnVDQB4CG7aAQoJc19W
         GP6PCSdS1aErsUOwuCMkSxLTFMQqge8lPUan0deTcBipdGCx9B98YF23K7xA4iqJk2nQ
         tj2xvpOXGkFoMMVvJ/uK31W6wR6t4mr3y/Ryw8Z4JcBg3TYMh8ZOeoBjJRdTbOT5ilWj
         CQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=XobLFaW97SZ++DC70ufyFir64gao2VTr2Fydjlgz1Jc=;
        b=fMDzObl9XEhSwLQ+/dPCwBrLnvHzEEizHr3qudUKQXGIdb230aV300LrUm0B/I+e1+
         g3EShRUR+c7n2CCm2zE5MRhlHVfcQ8LFqL1Qp9NMh+tSqo4latjxw4zprcAp5uDZXRPT
         YOIEl9YqULN3FUSAbr558PR8zmcuJT24hZtj4kl8bj3hq3cgQH08uNCuP/OXxcjFE2+B
         XPUHqIYARMNmJf9uY6Bi/equzUFVUM230zwN/MHCWKe2dhv5OZbz59xAUTkfe1CGU1JP
         /BstmrpkAuu1MUvu1R8A2rGXRlWqk5iSFf52LTaCTKwSh7P9HBOqisCXwnESVArMRgqP
         JFog==
X-Gm-Message-State: AJIora+pnEIl4eNkg7HQEMsanKYM5vR3BkpU1xGVialhoaCoV6ZD4bbu
        MyT5tyIvcJtvPjGA3wtS2pli0wdGLWA=
X-Google-Smtp-Source: AGRyM1uqwta6ZjyR+n2OlLaT4CdS0HCy1FVqWXA1CHlv42TFe1/khuX0gTdwf4vwLGZ8XQrIImXCQw==
X-Received: by 2002:ac8:5a02:0:b0:31d:32ca:9a4a with SMTP id n2-20020ac85a02000000b0031d32ca9a4amr6205387qta.340.1657768461075;
        Wed, 13 Jul 2022 20:14:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.65.206])
        by smtp.gmail.com with ESMTPSA id s27-20020a05622a1a9b00b0031d3996d304sm551253qtc.17.2022.07.13.20.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 20:14:20 -0700 (PDT)
Message-ID: <62cf8a0c.1c69fb81.3fffc.0d85@mx.google.com>
Date:   Wed, 13 Jul 2022 20:14:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4988579518100205290=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v7,1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220714002225.3540241-1-luiz.dentz@gmail.com>
References: <20220714002225.3540241-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4988579518100205290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659500

---Test result---

Test Summary:
CheckPatch                    PASS      1.93 seconds
GitLint                       PASS      0.97 seconds
SubjectPrefix                 PASS      0.84 seconds
BuildKernel                   PASS      31.35 seconds
BuildKernel32                 PASS      27.67 seconds
Incremental Build with patchesPASS      39.54 seconds
TestRunner: Setup             PASS      477.86 seconds
TestRunner: l2cap-tester      PASS      16.80 seconds
TestRunner: bnep-tester       PASS      6.05 seconds
TestRunner: mgmt-tester       PASS      95.02 seconds
TestRunner: rfcomm-tester     PASS      9.15 seconds
TestRunner: sco-tester        PASS      8.96 seconds
TestRunner: smp-tester        PASS      9.08 seconds
TestRunner: userchan-tester   PASS      5.94 seconds



---
Regards,
Linux Bluetooth


--===============4988579518100205290==--
