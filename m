Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED33CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 03:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiBRDVP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 22:21:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiBRDVO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 22:21:14 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522DB136
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 19:20:58 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id v10so12292971qvk.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 19:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+swSFcqxh48rIz1iafz3JnZlVrEZ7NeFM3JLWgVdn74=;
        b=pRbyfea64jOVBJdPq/NV8IhlFa658Mu+/SLFItV1J5/F0OJFFUoezN/NsGqlP//c/Y
         5ejCpHhUvj4BGLg4YJcZrYHQ1CzxxLZ+s4soJb/pRpqphbV69Nl89S0sdo1EyD8iYS6P
         UjVQMYEM90Mwmwc6G0KUaSqnijkftTiQ60R0wD6WZbtSa9yWaKOqcXkLD8zBghV8gxCR
         dhT7/DZzwwUWUz9CgsIpyyFkMdWp/OMyBmo6zss+UqAV8oNHDfNDaSw40By5WeMONyVT
         pHwgHrXI8jYgBO4hGx4as6a4kNLiznky0s/LxUMYBofFv1o4K595Laa0h+1jUJB0eJqP
         xCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+swSFcqxh48rIz1iafz3JnZlVrEZ7NeFM3JLWgVdn74=;
        b=NCApOb2jL6Zfa3eOYfVtsjxDLXDegjpzPnTytpdhIiXkk7F5XSYSOdKZ1uwi0NVegz
         TTW/zfkvLSseG4LjG6/myiNneA62CcE99ut47SliRfYfibI0Y12i3s3KWpSb845YnwO4
         2i5bDfv2JxvXaDjyUiKSsQiPF7+kgMqGHxf/JeaSAIhTKibb8duvmaco6oxqzpMvCkzA
         Mi9o7LCFElsxS0l6WWuglmXQ2J4xgTCy6cQ7ivvb/fePvBFykmprpdX3nhc9ANE/D6rg
         MGVlHKS/Yz0zZnweVfTThX4pcznD9gK2nVY5QwmoMvAsMlrFDVANU637bhxsD5kTPtGp
         YdUg==
X-Gm-Message-State: AOAM5307f0HNua0jIzFal2e0ea3tNYUX9BxQUAHnznk2Pqeo19myimQ/
        sbzWQ7fX+jIYhRM1DGBDVTvCUCObddmUKg==
X-Google-Smtp-Source: ABdhPJzzze3DGWTKXf/74JvCe5Zv1k1qYWWLH6/WZFC/OLz5Q92NCP6XWU8yjQ7F0l60lgEeNbPSzQ==
X-Received: by 2002:a05:6214:2461:b0:42c:3e46:7ddb with SMTP id im1-20020a056214246100b0042c3e467ddbmr4395462qvb.10.1645154457325;
        Thu, 17 Feb 2022 19:20:57 -0800 (PST)
Received: from [172.17.0.2] ([20.36.162.245])
        by smtp.gmail.com with ESMTPSA id bq33sm22075051qkb.64.2022.02.17.19.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 19:20:56 -0800 (PST)
Message-ID: <620f1098.1c69fb81.a39bb.dd75@mx.google.com>
Date:   Thu, 17 Feb 2022 19:20:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6277770181532622623=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] main.conf: Introduce MaxControllers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220217233902.3093404-1-luiz.dentz@gmail.com>
References: <20220217233902.3093404-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6277770181532622623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=615589

---Test result---

Test Summary:
CheckPatch                    PASS      3.20 seconds
GitLint                       PASS      2.11 seconds
Prep - Setup ELL              PASS      51.36 seconds
Build - Prep                  PASS      0.78 seconds
Build - Configure             PASS      10.27 seconds
Build - Make                  PASS      1447.42 seconds
Make Check                    PASS      12.29 seconds
Make Check w/Valgrind         PASS      524.58 seconds
Make Distcheck                PASS      273.84 seconds
Build w/ext ELL - Configure   PASS      10.39 seconds
Build w/ext ELL - Make        PASS      1438.64 seconds
Incremental Build with patchesPASS      2933.71 seconds



---
Regards,
Linux Bluetooth


--===============6277770181532622623==--
