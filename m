Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B18C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 01:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A594613E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 01:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243578AbhI2B1W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 21:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243515AbhI2B1U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 21:27:20 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F02C06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 18:25:35 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c20so868200qtb.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 18:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rSAEnmGTu9O5HVou3Sdtzzx2K+IA0UCpG/aay3DY4Hs=;
        b=FiRnSvqDF9/TNWnce/Os9+OuN21LyBFQAzqwLsO9j3mOQGivIgvEBBZegnALAhsaUB
         D2LWXAg1nKqNWVDpqbYa+XFl+D8l+5WjIu9R+w/v+koDc4pJJqnJh4uwdwUQvMU7kQyC
         c/qagnK1HZU3mQIpX2r3c2vP6WXBnYtufmRXIqihn69kTe5glAho91cLazg8on0yMOs3
         c9tOX8NRtPlC+iFGm6lKmpBxJXM+aDGDYgkZoFNuJS0JeIO5K+Iho16/OXtGjq5sdh/k
         liOvlDkw1VREfQH8Eow+JOf3bdcsPSRD1qywVM4G9zOoms1mCxhEDI1DsB5q1+pcyoX0
         otVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rSAEnmGTu9O5HVou3Sdtzzx2K+IA0UCpG/aay3DY4Hs=;
        b=AKXiM8iM1sasJz2DxSyge1eH4G0qylg9kjCKLMqVNBk68uW6v1l9OHsmc8sJ+p/NtL
         d2c2ioj7lwxg9J+hkltVGshS07q1e3FSm5VwbQDuwZfYgPiRA0N1ZcVn1AI1WHiqyIly
         4nrEFAXg7eyuBPxoYLUnE4uEcwAHEPk2JDuGyDYjtCf9+jT11OjLzoH9B+uOQ9pVysPh
         8eUp5l4J7YhEAxPaLbdeqjJqefj8U9L5ujDBnTGhs9Q9A1NFYR6dfGx0EedhkS4fqhJf
         JomEX9foYUY8TLo+qOVXR5YAs0CfLAEn2Bo7K4fOR63rhiGqVq5ou/VsMh1YaoEtWeXg
         CY6A==
X-Gm-Message-State: AOAM530TzZEJK69t1NFR1+N+1fNOgBigbiB9e7Lox8uhq9c6ksBbRx+C
        W1Dqq5SgnI4PoR3VTsOYkWKFfV40zg0GLg==
X-Google-Smtp-Source: ABdhPJzhrRtBVXhHEJCQL+WLEh0fHumN0RiBEg3I/uK1eoswqXLVEmOpIikNmKFZB0TZGlfYlnVkhQ==
X-Received: by 2002:ac8:4c85:: with SMTP id j5mr9372433qtv.230.1632878734289;
        Tue, 28 Sep 2021 18:25:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.13.121])
        by smtp.gmail.com with ESMTPSA id 9sm616187qkc.52.2021.09.28.18.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 18:25:33 -0700 (PDT)
Message-ID: <6153c08d.1c69fb81.f5831.4749@mx.google.com>
Date:   Tue, 28 Sep 2021 18:25:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8249687517907158285=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/5] gatt-api: Add MTU property to GattCharacteristic1
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210928235447.3077055-1-luiz.dentz@gmail.com>
References: <20210928235447.3077055-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8249687517907158285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=554631

---Test result---

Test Summary:
CheckPatch                    PASS      6.84 seconds
GitLint                       PASS      4.61 seconds
Prep - Setup ELL              PASS      50.24 seconds
Build - Prep                  PASS      0.49 seconds
Build - Configure             PASS      9.07 seconds
Build - Make                  PASS      219.53 seconds
Make Check                    PASS      9.21 seconds
Make Distcheck                PASS      256.90 seconds
Build w/ext ELL - Configure   PASS      9.34 seconds
Build w/ext ELL - Make        PASS      205.94 seconds



---
Regards,
Linux Bluetooth


--===============8249687517907158285==--
