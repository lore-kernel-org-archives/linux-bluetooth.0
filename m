Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3281CA0EC1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Sep 2023 21:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbjIKVRH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbjIKJ0X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 05:26:23 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6D5CA
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 02:26:19 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34e12396f6fso15632865ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694424378; x=1695029178; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b352E+O+T8HPHUIHyQRiH1mwbnY//WNj7hLVvnE4XW8=;
        b=kUqIK0TvpSAwCB0mw2H5bf5hB9Bx7CRt2ohboeqvTjt+O6ffxZ3vvYguX7CfwMgTRx
         HJmhkq25zkY6goBuWpR2KYcwhTarna96olT0yc1HJggeWy1aRK9m1b6NEgNeqmv1AqbU
         23bfhnk8at9MsyORPutgQrVunp+kr/JBdKk5jIen9p4d+btLJNqcz2Wg4TEe4Hg3J2j6
         567F2bFIkYl0RFIiG4J20QGe8yWH7GhMKNT6Z+RYZGQsXkhs9f/diHrwb67Ss5HsvtJb
         9ShBStsKpWt1q3SgDrsTWz9dXCRFfxutn0M6SLGZj4PWRaVWgV8ipbNpgF/UDeaVJXhV
         LaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694424378; x=1695029178;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b352E+O+T8HPHUIHyQRiH1mwbnY//WNj7hLVvnE4XW8=;
        b=rLv7F7ywjE0/nMV3wfbtRkFuHcXLE04gOIhXQ6FDOug2LQS+Rxecj1FxtHkVGQbXuh
         ZyHuNfV9WkF3+V96VxiQV2QKT/uwOYEb/eifEF4PavxwrD2gZEVYYS/YjvMtOdAqVC+i
         1c4eM/OxOQiU+jjKxlTBipN07BMF3ltPBM09DZPVohwzmp+1W4jkm1hG2horms1Uf6JM
         Mx46hpnT4bMVPJ/uGMG8aCdf0WXJCsbd/GrOVV8GrA1MsskJY0mA86BYvIDrG1Q6HKG/
         47OedZj/vsFBwsAsGPxuqb3Pq++UktFdd0gm/mL0prUyOFqtAiiyQOYJNH4Sh+HFebdT
         OjbA==
X-Gm-Message-State: AOJu0Yz41XOFa1YSY+vH4egaFR5QjZr9p+ECYVxnUsZvXyREEEjG3ZKL
        qUD5kSULK5DzsRY2GiiWHC+MNz7N4zc=
X-Google-Smtp-Source: AGHT+IGpRlnDwVoCdnziPJx8UCjTvvNh05dmh35ySk6OUeXMiyTBuRQgEO9uNAEEJf/4SYCw9Vrkug==
X-Received: by 2002:a05:6e02:1c21:b0:34c:d41e:8599 with SMTP id m1-20020a056e021c2100b0034cd41e8599mr12760684ilh.25.1694424378510;
        Mon, 11 Sep 2023 02:26:18 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.235.116])
        by smtp.gmail.com with ESMTPSA id y12-20020a92d80c000000b0034ca588f17esm2252110ilm.61.2023.09.11.02.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:26:18 -0700 (PDT)
Message-ID: <64fedd3a.920a0220.1063d.2ce0@mx.google.com>
Date:   Mon, 11 Sep 2023 02:26:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5702752830750115283=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Update transport acquire/release flow for BAP bcast source
In-Reply-To: <20230911074711.62493-2-silviu.barbulescu@nxp.com>
References: <20230911074711.62493-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5702752830750115283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782830

---Test result---

Test Summary:
CheckPatch                    PASS      1.00 seconds
GitLint                       PASS      0.58 seconds
BuildEll                      PASS      27.23 seconds
BluezMake                     PASS      810.49 seconds
MakeCheck                     PASS      11.90 seconds
MakeDistcheck                 PASS      159.21 seconds
CheckValgrind                 PASS      254.71 seconds
CheckSmatch                   PASS      346.27 seconds
bluezmakeextell               PASS      104.10 seconds
IncrementalBuild              PASS      1346.24 seconds
ScanBuild                     PASS      1040.07 seconds



---
Regards,
Linux Bluetooth


--===============5702752830750115283==--
