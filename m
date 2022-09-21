Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24157ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 12:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIUMJI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 08:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiIUMJH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 08:09:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024D692F44
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 05:09:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l10so5412687plb.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 05:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=E4hEVvssnolpM39Pq4mENoq+mFpTpQQql8Qi+6EguwQ=;
        b=Qd7P1aX0cRDyApCb8zLVIDNAvuwFUYKM0NE2dQizZUEtCj0DpoSwgHuCcqYWMUb/vw
         pisDIrTnS5yQAXmbk++Huw8IuBz6GvKMm8rDl8ODYEBgTHVBGUs7Uu7y3T1BoqkhS4po
         0ameBroy4Xkv4ndkwSimR8o5ACgQnuVAdnpDs8jksHNyKW42tTI+aBrstI1MKkPnxrCE
         /8nU5HHV3JJ1MHbhdII0DF19DLlSWb0NUYw5IduEHwwWbNzSc47dBuSOObtNEdcp5/ib
         OORTFXOo3vNB0rclPyv48g/3C69oyP68dCCNrYI5ngoOXsdAo+aTdVeYyldTy9nfHYud
         3qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=E4hEVvssnolpM39Pq4mENoq+mFpTpQQql8Qi+6EguwQ=;
        b=SUeUhoN1A30Z2HqiVZvZPz2K6eOYo8YxueLLW11ETATFezjC/I/f965lXHYdEfrbtT
         cJ5ZujUO3IbhMQeNeOXp4Mqj2UnrSpZXbr6VDNT6J9XAO2mHH6lZ2oUhOeJllQnX9lLt
         I6WpIWByLNLvIqNqo0eVnWF4Kr4ezJ9wsCeBpZNOjd0s30QHLNCrON/9yM/qv4MZ/EH2
         vkekWkB7Kct28f34N9lVPIbghqd/s1m8pw01eLFZxcmFiVc9XfzF+f0OK2p5DOYsQ2DQ
         ThMrDsV7+0bIENZCtZun94znmoP9owQHxiWsdG15ho9sfxiImGZJW/AdMxak+b7/jNGi
         eUGg==
X-Gm-Message-State: ACrzQf0dUVlmxFgdqVSY9+nGK7amHc8koX8i/0H8gHaxLXPBdSBBlBG/
        p2MiEzCw4o8s3CgnYX35BQmxFEi57nc=
X-Google-Smtp-Source: AMsMyM6KhJwr+xnidWdEyaTP/KZqc7H3X5iUfTlks2FqrcnYCgtB8YNI6vUpbCO3DflzkKljX0nMiQ==
X-Received: by 2002:a17:902:eb03:b0:178:29d3:5537 with SMTP id l3-20020a170902eb0300b0017829d35537mr4365120plb.63.1663762146285;
        Wed, 21 Sep 2022 05:09:06 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.11.65])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902e9d100b001755e4278a6sm1788623plk.261.2022.09.21.05.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 05:09:05 -0700 (PDT)
Message-ID: <632afee1.170a0220.2ae6e.35e1@mx.google.com>
Date:   Wed, 21 Sep 2022 05:09:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2676750956309353622=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, isak.westin@hotmail.com
Subject: RE: [BlueZ,v2,1/3] mesh: Add interface output filter
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <VI1PR09MB42395F76D2702B0C26F326C2E34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
References: <VI1PR09MB42395F76D2702B0C26F326C2E34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2676750956309353622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=679006

---Test result---

Test Summary:
CheckPatch                    PASS      2.01 seconds
GitLint                       PASS      1.40 seconds
Prep - Setup ELL              PASS      30.17 seconds
Build - Prep                  PASS      0.63 seconds
Build - Configure             PASS      9.86 seconds
Build - Make                  PASS      897.95 seconds
Make Check                    PASS      11.76 seconds
Make Check w/Valgrind         PASS      308.60 seconds
Make Distcheck                PASS      255.88 seconds
Build w/ext ELL - Configure   PASS      9.26 seconds
Build w/ext ELL - Make        PASS      89.46 seconds
Incremental Build w/ patches  PASS      313.90 seconds
Scan Build                    PASS      553.99 seconds



---
Regards,
Linux Bluetooth


--===============2676750956309353622==--
