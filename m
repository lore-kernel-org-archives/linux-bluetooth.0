Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ABDC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jul 2022 10:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiGEKci (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jul 2022 06:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiGEKcg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jul 2022 06:32:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19CF14D36
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jul 2022 03:32:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y18so2632539plb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Jul 2022 03:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=gQWFopSHANZWxgSchdXBl91KUa/himVJu0P8+sAjag4=;
        b=qbmRFnkuVNY6ME6KVnszrjHZ1gTSis8plpVrUYKMoOyTRT7DBFuS4ZEfJZj+jPrfCl
         VcOgOc9awJgT0GwzKaeASxvFKh1WSj0pCHkdXIlr1QKTwdrJFQMX7+HYGpff4Kve04ff
         NQfDsyNe0RZKOv9Kt7cCdoCSl+Rt3txDIK1WB3HRFyd2n/GJ1AsyeH6jHFSYydr7NZiv
         BF5oxy1JmeTHsvhtaI1QznLLb4QRAeMmp7c42gtNU3KiTmO7ce7QHr9P0Geg7hC/ViT0
         I5JFn6O4zcYJul+cHln8xxRqqT1hl6Ljja9UzGwBMjUFMPfa977Y9RQ7q6mv1blxSfSW
         aUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=gQWFopSHANZWxgSchdXBl91KUa/himVJu0P8+sAjag4=;
        b=u6d9GIu1ty9mSPanO1JZyyRBqhMqBJAlZUU1ukbADWG+CbyWJk0sabUmWhEzBqMaIp
         fqCmRYCM53+RrScMG0ctqq5nFDDgEUFi3ZfRJnvj5gHfRd9Kn57KwG6eWOgcHqxIcsc/
         MA8mIqc7YCD+wbGHeeo914VEvVR1pWeiR3OzazUX0M2ObU8DCQauYdKvZFk+JotjZPS/
         sxdmPMf5v2nkWfZmkipIUsox03vx5noIUVAWD8YyMxMT3Wpvq1fd/mAOcBz2yFo/q83I
         mvAX6U45BVUg8no/uQq5bP2oQvnJuOBxg0TcPeSDN1zTsHLqSPj7tev1vilwRSXLZxLo
         TYGA==
X-Gm-Message-State: AJIora9lsiLFYnqPOjv676QtCxGOk7H82Yx0dnbiIEORyokHn8XfECm6
        56yMAStavSdN4q38xLP6tX8uggphFbo=
X-Google-Smtp-Source: AGRyM1tlHrODxnn1uFuGNLUub+SY5ReTgBxLAGATDOEGiR5GMWHVbcAZOAaaRMDGzXo0jzXCdAJE0Q==
X-Received: by 2002:a17:902:c950:b0:16b:8ec7:b34 with SMTP id i16-20020a170902c95000b0016b8ec70b34mr40124192pla.143.1657017154885;
        Tue, 05 Jul 2022 03:32:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.99.107])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ee8200b0016bf185d234sm1346364pld.2.2022.07.05.03.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 03:32:34 -0700 (PDT)
Message-ID: <62c41342.1c69fb81.8d3fe.2314@mx.google.com>
Date:   Tue, 05 Jul 2022 03:32:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8005260704850114628=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: Fix the code style
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220705092952.11868-1-wangyouwan@uniontech.com>
References: <20220705092952.11868-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8005260704850114628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=656581

---Test result---

Test Summary:
CheckPatch                    PASS      0.86 seconds
GitLint                       PASS      0.58 seconds
Prep - Setup ELL              PASS      26.18 seconds
Build - Prep                  PASS      0.61 seconds
Build - Configure             PASS      8.38 seconds
Build - Make                  PASS      995.88 seconds
Make Check                    PASS      12.16 seconds
Make Check w/Valgrind         PASS      292.34 seconds
Make Distcheck                PASS      244.11 seconds
Build w/ext ELL - Configure   PASS      8.88 seconds
Build w/ext ELL - Make        PASS      84.09 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      513.76 seconds



---
Regards,
Linux Bluetooth


--===============8005260704850114628==--
