Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7501FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 06:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244970AbiAYGUk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 01:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241466AbiAYGRY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 01:17:24 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A13C07852F
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 20:40:09 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id e20so15584912qvu.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 20:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vowgc1d6BoPw2rNsdZpW9qR+x0Lid+bAPrCQwRxbT4g=;
        b=bCYMiYGZBSvM6FZStDQVP845ldqJXd6w/LwkWnPLWRDXTtXkHbqgv86FTiPhSyO8Dr
         9cLCC6VwKSAeDOIicNJyUd0V8fuJnnMw3b2Y5dTssuKJ0n8Lo0FzGeqq3KPYf+vGr0IM
         OMojK2fnFY/tfQ53bABpWFFJ+1cKR6NISbk/0sKb7b40xBCIBVIHkaooT0sP+Nyrukae
         eETHLdAlhFk46ZHdXvhZVlI62QUykCZYHut/N2Xv0+eBdD9RcJIK5RiGVs10zsfTUSCh
         uMM0k8l8kixILCKY/8UJwtzJqqOSrASq5CmaBPuVsjKLLyIAgzr6zEyBaGtWqZV3kpVa
         l8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vowgc1d6BoPw2rNsdZpW9qR+x0Lid+bAPrCQwRxbT4g=;
        b=zKUW9xhrQTYiKqr9BwCh8B25slcTM64So28V9YLzj0OQgGqTh60dMtTK2tlxVV3j2Y
         SSwNlgf4ZUqHBpBTxg+2cPVeUVYbnwPXdEI3PuHOQW5gDhCA2E3Z3Nwm2oNFvO34kz3f
         aHiXA0efOqq9/KW7otlLA0UFIX38DiODomag9s0qa6yGdRSsIKNyQykTkj7l8ofb8ES3
         K4q9Cc43YYAE7qu3VNDaU7YklKIGzB0WYQrVbB9A7qX/CO6XORwkdOh0TjQOIiImPmzu
         OvylWtDZIHOL+6P/PwOzqPX9AbdmWFZ5/OimdTNK0pj/JECXpIQKitFJeeX5La5VXnD6
         CwNA==
X-Gm-Message-State: AOAM533sZrphBMyEuisw+9PbgvbA2z2D4e4E3hlXwiP0ULYoklif+erj
        LIuBObBdzqwTsQ1n0gFdidByFowMFv29Lw==
X-Google-Smtp-Source: ABdhPJzbqm+aFapJqQakKjrxwMFEE1RSBoab0ULleROWV2nvc+xJ2exBDJVrSKhOKiSCnc5kpdcvyA==
X-Received: by 2002:a05:6214:5185:: with SMTP id kl5mr17929530qvb.31.1643085608559;
        Mon, 24 Jan 2022 20:40:08 -0800 (PST)
Received: from [172.17.0.2] ([23.102.113.196])
        by smtp.gmail.com with ESMTPSA id ay6sm8619192qkb.127.2022.01.24.20.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 20:40:08 -0800 (PST)
Message-ID: <61ef7f28.1c69fb81.a66b2.34d2@mx.google.com>
Date:   Mon, 24 Jan 2022 20:40:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6443480041219724402=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,1/2] shared/mgmt: Add request timeout handling
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220125010458.2326473-1-luiz.dentz@gmail.com>
References: <20220125010458.2326473-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6443480041219724402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=608129

---Test result---

Test Summary:
CheckPatch                    PASS      2.97 seconds
GitLint                       PASS      2.03 seconds
Prep - Setup ELL              PASS      42.90 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      8.71 seconds
Build - Make                  PASS      1414.03 seconds
Make Check                    PASS      11.53 seconds
Make Check w/Valgrind         PASS      446.01 seconds
Make Distcheck                PASS      233.35 seconds
Build w/ext ELL - Configure   PASS      8.72 seconds
Build w/ext ELL - Make        PASS      1423.32 seconds
Incremental Build with patchesPASS      2825.31 seconds



---
Regards,
Linux Bluetooth


--===============6443480041219724402==--
