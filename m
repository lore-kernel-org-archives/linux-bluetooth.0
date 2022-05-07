Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8478FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 00:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353492AbiEGApa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 20:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbiEGAp3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 20:45:29 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C668FB0
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 17:41:44 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id eq14so6566438qvb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 17:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=e0I2vsQT+l0ibqBuOVJpcO5TwkQ0tdgIibseI1kZdFw=;
        b=g6yhs/1Xtexs/yeG5d5/e4+0gLprUPm+TX1sfz4juG7eLgfymHZXadSd22Dlxy/O7E
         8SQO05cdIHvUzCtF7Q5TKR8RAQgB8J6CQrol9R5Gc5LJvKVv+oGDODfOytDp4cBsobRw
         hWd3s/dOUIC1l4EQ2+Pwh46Y59ppW2wASSDDFPHXaOnYy6yiAHmYv6xOU6C+F0dS7EA5
         JurM3yHfDVKT40RynkjKJEpLNloEsmnpNRgQ9ej8V7vlOhJSS9Q8ROYJIDqUSm0cIO7H
         ZtXgjwJPNgIn0gV08qsDu4vNEIIwZD2bMfLOGG0cU5ygOb9zxWIhthjED7Aq0cuOuOdA
         LuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=e0I2vsQT+l0ibqBuOVJpcO5TwkQ0tdgIibseI1kZdFw=;
        b=pefeEuETIPmOtr0DEZ2jaiyZ2FBgK1cAFRt3vdWoUFnLV6556z6u8P3PJA8Wuv2JRH
         DOfIQu7WLAPkt2ihF7MC1SgpOe9BlDTMz1W5RFK592XyzMSNXuC5etsDwcxqFXovjj2p
         IB8xtLSl/EBHIxnT5An0AnC5qMzUR6Wk0MMkCqf5Gue2o/EthuZlSas1oxiZXbK6Ox/v
         195sJBpVVmnnyqwlI1NyKcSpOsoyMc4UjhRUJwz4Ikg7Ui5nYaxevn8wKJCyyLbXR5PD
         FE7wzx2oaHKn+vieSs1FhT0MbCvuVK49Hzh1SD4hcpJ3n9cWqp/TiIH+p4sbYcGCSR3Q
         66lQ==
X-Gm-Message-State: AOAM531rvUwI2xFLDlP2UZFFzFTroKDEdV9oi2BxdRhHi+o05LMh/UHS
        mOij7ahyZbB/8WrUPkgdWkhqfrl3tZjfbw==
X-Google-Smtp-Source: ABdhPJwN3Jklc1q8Zwms60PgugoFWN9VowfkPwI0nIQLo0cJc606pV8ErRLBZ2wFzZTLMFe9LbQXkA==
X-Received: by 2002:a05:6214:29e8:b0:45a:a993:eeb9 with SMTP id jv8-20020a05621429e800b0045aa993eeb9mr4679217qvb.26.1651884103868;
        Fri, 06 May 2022 17:41:43 -0700 (PDT)
Received: from [172.17.0.2] ([20.22.214.65])
        by smtp.gmail.com with ESMTPSA id c68-20020a379a47000000b006a03cbb1323sm2665017qke.65.2022.05.06.17.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 17:41:43 -0700 (PDT)
Message-ID: <6275c047.1c69fb81.92fd0.f541@mx.google.com>
Date:   Fri, 06 May 2022 17:41:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4041208927489862827=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,BlueZ,1/8] lib: Add definitions for ISO socket
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220506223139.3950573-1-luiz.dentz@gmail.com>
References: <20220506223139.3950573-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4041208927489862827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639258

---Test result---

Test Summary:
CheckPatch                    PASS      4.35 seconds
GitLint                       PASS      2.96 seconds
Prep - Setup ELL              PASS      41.52 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      8.13 seconds
Build - Make                  PASS      1206.06 seconds
Make Check                    PASS      11.90 seconds
Make Check w/Valgrind         PASS      443.89 seconds
Make Distcheck                PASS      232.72 seconds
Build w/ext ELL - Configure   PASS      8.41 seconds
Build w/ext ELL - Make        PASS      1272.91 seconds
Incremental Build with patchesPASS      3690.84 seconds



---
Regards,
Linux Bluetooth


--===============4041208927489862827==--
