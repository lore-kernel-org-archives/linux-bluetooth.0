Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7FEC001DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 10:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjG1KkO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 06:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjG1Kj6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 06:39:58 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4B95249
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 03:37:50 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b9b89627c3so1645184a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 03:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690540669; x=1691145469;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pb5XArmVEVrEu1YggcpfMOJBUKUKuROTXQIvTdyOzmE=;
        b=A4SeC4WqPcbnbI5h493cf4heObDyAd0WmPTkb2YF2eL6e6zxeT+Wc8P+lxiGpWICbw
         0dMcnqwGaCV24fBMuEqp7zbLVp9qGEyp/5lm93uUtCOO2cJBlQzxCM4F8kcCO1cCWDkK
         llx974druOpYHx3tBW3RAzueZnijoQeZ/z8EQKO/toX29xzxFo1fZBKOIlTYyZ8S5ma6
         rc1MF+nfe+YIXPtTHMsGmRKxEGqDUZePiDULguDGxbTv/LgNzBG3LPD3sG8Fwz9J+9rY
         1HsWa8kTMcGVVg6Oj7fFKVbbwS3QA+7p9FELbmd7Lxh9m4kqFfMGhGf6Yplz4yUq2AAg
         X4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690540669; x=1691145469;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pb5XArmVEVrEu1YggcpfMOJBUKUKuROTXQIvTdyOzmE=;
        b=luYzqfhkFWrZbVeOsdDkUeLlDm3AmtV8dEcnBajWd8j+hz7dwUmdZNAkd+KFOm8FHE
         kJsmJLugM7FZy+qJP/VBWWGs27Df2webdtCC3HLh+n8nsUqrpmJo7HrewRYkkb19BVjB
         xwrVHdP3ZTmQtfekyGC4Nnzn1pykIXqvPFVwyjRHJ9vlluS+59vxvqInSPFHJNyFwsB2
         69V8yj/LSKn4lYZpSzmfC8lCPmF6NiXNkZzppGwt+aVSCZ/ATV7qKGH80hb2vnHR7Uxa
         +O/I1u11iM3I+AQFbEJcHpNVafeQITntRgmj9MctpF3jdSB+Qz15lq9LnCZAUIeYGZTG
         kc7w==
X-Gm-Message-State: ABy/qLav7W+1jd5Dm6ULj4u+eIoQvI4PUXMo3VZ/8SkOrBW7dhz8u6En
        2f9K0Wri26P8R05DjJmO6+shRC/mp+E=
X-Google-Smtp-Source: APBJJlEZkP2WSTIValv0MAUiatc2/VMKouosBGY5EmvKcSWV7U5E/921uuR4mBTSM+hhrCRxdbSOpw==
X-Received: by 2002:a9d:7a53:0:b0:6b9:6a43:1f7c with SMTP id z19-20020a9d7a53000000b006b96a431f7cmr2493358otm.26.1690540669212;
        Fri, 28 Jul 2023 03:37:49 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.221.243])
        by smtp.gmail.com with ESMTPSA id o1-20020a9d7641000000b006b9734b9fafsm1469686otl.13.2023.07.28.03.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:37:48 -0700 (PDT)
Message-ID: <64c39a7c.9d0a0220.bd00b.8d7c@mx.google.com>
Date:   Fri, 28 Jul 2023 03:37:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5688562433468114960=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ] advertising: Fix setting "BR/EDR not supported" flag
In-Reply-To: <20230728085627.683418-1-simon.mikuda@streamunlimited.com>
References: <20230728085627.683418-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5688562433468114960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=770477

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      36.80 seconds
BluezMake                     PASS      1270.82 seconds
MakeCheck                     PASS      13.58 seconds
MakeDistcheck                 PASS      214.05 seconds
CheckValgrind                 PASS      338.48 seconds
CheckSmatch                   PASS      472.45 seconds
bluezmakeextell               PASS      141.99 seconds
IncrementalBuild              PASS      1078.86 seconds
ScanBuild                     PASS      1495.50 seconds



---
Regards,
Linux Bluetooth


--===============5688562433468114960==--
