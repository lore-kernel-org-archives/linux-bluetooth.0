Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC33C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Jan 2022 11:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354636AbiA3Lbo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Jan 2022 06:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354625AbiA3Lbn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Jan 2022 06:31:43 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1F2C061714
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jan 2022 03:31:43 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso1699111pjm.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Jan 2022 03:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VE77GydQhru+qcvcTK8uZeWBQRTcEA9+MncSDYaJ42E=;
        b=idOzeEeLGMlBwfeksNqTLKRdmqttD5JO5G7IF7ABzl35x9MRoabo8BuE+Ih8VYvg3t
         LxVSPTmbDh3IntE/EXokDooLn9jQ94p4RflXOgcE6W+qUM2/3NcaKgqUQGDf48gdGH6p
         AV3Ta4MFJPMkwMc5QdOrTGdkajJXkDu5UyqBfPl34TM0YEt84AxUgFLHJHgGJKvefQYT
         gvNycbQuSxhksFAFPvE/LxC/fXHDbtxtb0W454kxvgGlgWaRNZla0OgSaQRUJP5DADWy
         UoMCnRXdk7TG76lK33a9UYFH+TVDiw47nalORR1tKoHJABkzGRM8lboGeIqFcZmFfEKZ
         tXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VE77GydQhru+qcvcTK8uZeWBQRTcEA9+MncSDYaJ42E=;
        b=YB7cPpENm441Z2/L4ATCKFw7a0DZMIzNwGLV4bWdua95dvRRc0LfjBeGPueVeueAj8
         zhgYLKSsjqonNXvN9NcDxCFOP7n8xDjDvAuYeROW27EeMvTuwMLu+k1gOF55TJ0sFdhj
         NCfRDJZ6HVgBRLqKCsWFiMK2YVv/sns+RdKh8KG3O5pgDhy2M2QIF2xA0gBzLhZIrSj0
         G4Eu5E9Tn2dGnYhg+9QcVreFoCGbZtSsfHKHKzT2ZH605Juq3m3psaLXDQJKWweq4YtX
         bXQw4XcwigfQ+DKaRVhKOU4RMinFOULLJmCGYfsXyCURwfcfKRGxaY7xQw46FUk3acQg
         Z0DQ==
X-Gm-Message-State: AOAM531AbIs6oB648U5dyfYHlYG580aII5Es/HqFOnFa9dCCjcM2OLKR
        k52npDd4DqXLTE5iXpJPQiXRWMGw1Q0=
X-Google-Smtp-Source: ABdhPJySioktP4DNIJPazvg526HKliXfoqgD+x6Sik0ib8CHbP9PaBqwYfRJtFB1YH+USFsXcW82Kw==
X-Received: by 2002:a17:902:f541:: with SMTP id h1mr16600650plf.64.1643542302803;
        Sun, 30 Jan 2022 03:31:42 -0800 (PST)
Received: from [172.17.0.2] ([20.112.121.115])
        by smtp.gmail.com with ESMTPSA id z22sm6373552pfe.42.2022.01.30.03.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 03:31:42 -0800 (PST)
Message-ID: <61f6771e.1c69fb81.9e82f.05c0@mx.google.com>
Date:   Sun, 30 Jan 2022 03:31:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2849634476866149354=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/2] shared/mgmt: Add request timeout handling
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220128210554.3997506-1-luiz.dentz@gmail.com>
References: <20220128210554.3997506-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2849634476866149354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=609643

---Test result---

Test Summary:
CheckPatch                    PASS      1.31 seconds
GitLint                       PASS      0.74 seconds
Prep - Setup ELL              PASS      49.36 seconds
Build - Prep                  PASS      0.61 seconds
Build - Configure             PASS      9.55 seconds
Build - Make                  PASS      1706.14 seconds
Make Check                    PASS      12.84 seconds
Make Check w/Valgrind         PASS      515.20 seconds
Make Distcheck                PASS      270.46 seconds
Build w/ext ELL - Configure   PASS      9.86 seconds
Build w/ext ELL - Make        PASS      1689.54 seconds
Incremental Build with patchesPASS      3406.26 seconds



---
Regards,
Linux Bluetooth


--===============2849634476866149354==--
