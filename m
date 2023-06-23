Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210B0C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 09:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjFWJs2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 05:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFWJs1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 05:48:27 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E80C6
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 02:48:26 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4007e2598f5so5301651cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 02:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687513705; x=1690105705;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KP3ovih35je2fUIkqLK3dAzvbmsEphIay2MTOdK/aQc=;
        b=rBCCoZZwy7EsJUuhnM5OR4+C/UBooO3oFQdVOomoKRGQLVV35bUIRcn0vL4MKxm4FB
         ppGRA2eDk1rUj7hTRQBURd5FKobzXdSz/F3X9uFr7b2PffY2zBSktWmUGZjsgPtXBkPW
         6JBYVeYV4epy3NZO5cPWbE61Mk3UWkRuqzXChA1P2a6PVbk8l55MS1kzckOI8NiasXk0
         cJ2x4+MQpYkZ5o6FoKOo1pNEZkT+epg95iGQn+e1FWVUAqYVjQfiunZPd6ZbiqTwEOMt
         4PuML+Z4zwJYxxAt888cfhPxAjNe2UDNyRMs4itZqvlwsxJHTbYr7u7wamin3e3p0PNz
         t3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687513705; x=1690105705;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KP3ovih35je2fUIkqLK3dAzvbmsEphIay2MTOdK/aQc=;
        b=JQLuV9kqsCco14pPA8SalcPPJKHsGMglIu5X6EXrMqmSKMgirJlIR4tCo3kpCdkRjU
         4m/YDTViTjYXnVpumnxpkrZledNv37lCy2MlctQzQMchnGqg4kczVI/FYfqj1iaRs4gH
         K3lhDkzmlttsbDQtXykCHgWqYCR4Bg+UvBAHnwTMPepeHGrUPYvUjXQ3cqX4Rwwl+BfX
         ouwdgimJn7jRdw+gdMoYra8SvNxYBRxHcmkRiaQ22Xple8sxQT74g0ofEfl1KPSbrBLI
         HgiCb3eIYmfNb9PK2ZA4dppgc+vNN+kW1P5zY0nuURsYM29ypw3QRLp00rfkVIczDTGJ
         gu5g==
X-Gm-Message-State: AC+VfDzDiOaC2z9890ynVt+HBaRXd5n1eZHAV1066HbDtp1X5irisxt2
        MCl+7u8anQ5oiLAt/wXguHQsoc+D4rM=
X-Google-Smtp-Source: ACHHUZ5BZwG3XJdTxH5Lm2lY2RswMqzkOfKFBfc7OkQDTmvZ/QB50cCLdQT/t+w2YtXgWrb15/m5UQ==
X-Received: by 2002:ac8:5781:0:b0:3f5:a0a:b30c with SMTP id v1-20020ac85781000000b003f50a0ab30cmr27454260qta.42.1687513704764;
        Fri, 23 Jun 2023 02:48:24 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.149])
        by smtp.gmail.com with ESMTPSA id y11-20020ac8524b000000b003f9af049c55sm4655484qtn.18.2023.06.23.02.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:48:24 -0700 (PDT)
Message-ID: <64956a68.c80a0220.85931.e707@mx.google.com>
Date:   Fri, 23 Jun 2023 02:48:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4401757688504006709=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: shared/bass: Introduce Add Source opcode handler
In-Reply-To: <20230623074657.16618-2-iulia.tanasescu@nxp.com>
References: <20230623074657.16618-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4401757688504006709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=759717

---Test result---

Test Summary:
CheckPatch                    PASS      1.71 seconds
GitLint                       PASS      0.77 seconds
BuildEll                      PASS      31.78 seconds
BluezMake                     PASS      1072.85 seconds
MakeCheck                     PASS      12.32 seconds
MakeDistcheck                 PASS      169.38 seconds
CheckValgrind                 PASS      277.82 seconds
CheckSmatch                   PASS      422.93 seconds
bluezmakeextell               PASS      119.27 seconds
IncrementalBuild              PASS      1911.14 seconds
ScanBuild                     PASS      1314.19 seconds



---
Regards,
Linux Bluetooth


--===============4401757688504006709==--
