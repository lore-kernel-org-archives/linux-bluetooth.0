Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C639BC636CC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Feb 2023 02:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjBICWZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Feb 2023 21:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjBICWY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Feb 2023 21:22:24 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42C728209
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Feb 2023 18:22:21 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 144so397375pfv.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Feb 2023 18:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t4EnEtV3R67I2kTgpQFTrd6dPUEf7OAxVKXNovecEaA=;
        b=cGgrdCD5iWbodWI1zMiTdQqoMXLS03Bq/VCoB54XyLpvCysjvEP2sZ5GTJgHterxne
         toJ8hhjWb9lj5QcvLEoNrRHe7C3YMzsktGa6tRZGbvimcOWMCxp9+GDtzvqg6S69Q3q0
         z4Lzu/F51BEU+c3rwwN45D88W5nRdqszh4zctQSiUyuaIYRxa80pNNFppMan6n9dJQmq
         zFmfP+xUOMY6OjH0yj7JWWij3PiCWuqvO6TcvKqzvVq8HfJJFsfGH8SDFuseu2A5Yz8c
         WbncIR9mlRth5RlqA63mukLeE0N44bZJAxUNTdPOgERixNgjMdfDoE5OV8RUZlQ9ih+z
         7+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4EnEtV3R67I2kTgpQFTrd6dPUEf7OAxVKXNovecEaA=;
        b=3qVWIp3BM60w7vmLGOjHz8MV17szxOdqgEAzVZJOMG2FV5ah6diR9h+XJ64wfIy1pv
         PWioOsbrVI1Or7uI4nCRE4NvGLEyqE21ZXp/jjPbx63nZw9AwglYxCZB2TlDVvNnyMRv
         HCp+RHG6XHu9OiQZ7Mb5GAhjXLqgx1VJb/BOnZDyP8uVIe03SCJQanI+S6+B0tOxOZqT
         1hjZfcOlEo+DdqNRuW/cHUe7DYXtRbzJoOQEgySBZQET/3gWbosuoPTipmmtNuqTp4gg
         QfEYQB2yoy06jN1BftgX6+UKcw1OY04HrTEMdkf3DkIS5CouJqdug/udl3Nzh63PD1B6
         6HRA==
X-Gm-Message-State: AO0yUKWltaQU/Drx9/BiYVxd8wsQBMeLW7pitgJQDQO0Kz/Parnr2wvI
        mmMah2ssGshT7Z6+Wmui2chHnJFn4As=
X-Google-Smtp-Source: AK7set+MpOQwFpYZqWBhq0GodXuJGkJaMYUsagIBM2LjR9qyYpceoN3w5N1pO+iGOqr52Fx2shIapw==
X-Received: by 2002:a62:6488:0:b0:578:ac9f:79a9 with SMTP id y130-20020a626488000000b00578ac9f79a9mr6913434pfb.15.1675909340916;
        Wed, 08 Feb 2023 18:22:20 -0800 (PST)
Received: from [172.17.0.2] ([13.91.161.16])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78803000000b005a8577f193esm130355pfo.68.2023.02.08.18.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 18:22:20 -0800 (PST)
Message-ID: <63e458dc.a70a0220.1b8bb.053a@mx.google.com>
Date:   Wed, 08 Feb 2023 18:22:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4864038124014705236=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, steev@kali.org
Subject: RE: Add WCN6855 Bluetooth support
In-Reply-To: <20230209020916.6475-2-steev@kali.org>
References: <20230209020916.6475-2-steev@kali.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4864038124014705236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sc8280xp.dtsi:1207
error: arch/arm64/boot/dts/qcom/sc8280xp.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4864038124014705236==--
