Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228A7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03AA560EC0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbhKQTfI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKQTfC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 14:35:02 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A44C061570
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:32:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k4so3060240plx.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/QKrWiJE+Rq38RpEEeD+RiWndQOh1d/L+6707nG8WjI=;
        b=VR6xJq2q7pPhYtr3bL+zcZU7wklE8atUdjnWNlDj/A8ieHel/IjAHXvQydmXRUVAMa
         Vc65PvwubaL2lS9yDAQHu7hDMUYB5UOK7bomi/B/QAEZvl9+MBrQ0Fln8WJbNbEJYyyF
         Fwe93ewxgRrqT5EdWoG5wycDWhDaPQC+zuwjEqr1tu65aOZqzvI70cMotwDTkY7Y1v87
         TMtG3QCMyjxQMZESO5sVuA2hKzDlVX6GUNKpDO2aPl9Zok3uxtO6bAy/IDww41oS9c40
         RSU2PKFntp16DeGg9GVKbd7OfxKNDYYjgzhTatQ6RvGYZ0eW7bgTX/cY3tiJRduxALLH
         7tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/QKrWiJE+Rq38RpEEeD+RiWndQOh1d/L+6707nG8WjI=;
        b=nFXcdxgr93GJhDBLpno1J4Uxy5qWiL+5EgLCBAW0a+ASa5nE4zAeiklyzlwHQL9odc
         fBvtMZN/xn1HX9C0vgTYLH1WRF85t8fDTQdxxa3v/WKX+D4JWHD5jLSCsE7+kMRPSAIn
         TnXLKAAH28BnDViMApgtX2MRwUJoGssD1InYV8Mc4ZirpTzHPt7JxkwJbJAdwz5p5qN1
         amRSf5JfgaYlXLXh00sEHe8nMlurmFR5+bGONaH/feYUcWi1Tc2otsRfXkoH+60ghMLH
         zdzAbCvH6FiWnYZulLQTh/RJN0bEoHEMtd+u12lLl3EzrcVJqKuKrPRvNaXO2NKqFaU8
         gR1w==
X-Gm-Message-State: AOAM530pauXslyJmyjChYc9cDW2VxcdUboGnWkxb1J/3GEJ4czKizOEz
        tg/N9VOBAFlDNijHVVVRouxRUKwKrLE=
X-Google-Smtp-Source: ABdhPJy9hrt8Yi3eVoVr9ulV+ZhiP/xmet0mexneqZizBhXNgvJ/G6yRiUdccNsraA+THdcksxhOLQ==
X-Received: by 2002:a17:902:b20b:b0:141:a92c:a958 with SMTP id t11-20020a170902b20b00b00141a92ca958mr59313343plr.24.1637177523136;
        Wed, 17 Nov 2021 11:32:03 -0800 (PST)
Received: from [172.17.0.2] ([20.112.117.11])
        by smtp.gmail.com with ESMTPSA id y28sm385571pfa.208.2021.11.17.11.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 11:32:02 -0800 (PST)
Message-ID: <619558b2.1c69fb81.b55fd.1e93@mx.google.com>
Date:   Wed, 17 Nov 2021 11:32:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8666048836220882827=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [BlueZ,v5,1/6] doc: Introduce the Adv Monitor Device Found/Lost events
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
References: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8666048836220882827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=581841

---Test result---

Test Summary:
CheckPatch                    PASS      2.89 seconds
GitLint                       PASS      1.83 seconds
Prep - Setup ELL              PASS      43.79 seconds
Build - Prep                  PASS      0.23 seconds
Build - Configure             PASS      8.02 seconds
Build - Make                  PASS      192.03 seconds
Make Check                    PASS      9.33 seconds
Make Distcheck                PASS      227.33 seconds
Build w/ext ELL - Configure   PASS      8.32 seconds
Build w/ext ELL - Make        PASS      181.16 seconds



---
Regards,
Linux Bluetooth


--===============8666048836220882827==--
