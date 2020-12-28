Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273ABC433E6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 06:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFEA207C9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 06:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgL1Go6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 01:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgL1Go5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 01:44:57 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1DDC061795
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 22:44:17 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y5so8571601iow.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 22:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VAQJQZU3kcJlIP3mD28vmhk0mOQmzVlSdckfRM97Aa4=;
        b=bK3hulrCrLaMUiC703zJNixs3u+qgJGhxI8HJuXD8wqcODmOPXAnk2DMkXwxqvtRoe
         qHSRC/EgO6ontbhfqUe/sCDax/y5Xa90RiCEbFvkRiPwVwEPRrywKLlog1Bj1St+pXPP
         RF+Kvk2HDumMXn+T3r/MXWdKBu3EXctRi/eWP0jPsi4j84zWV9zWFMmavSLP9KScg2iu
         X1zvk9Zz0P1ANzoZsbMVdv6jc0+UC2O9jJ5e9TiHWDxOibEt/puRt9/Fi6b0HGdy5KVo
         4vZOVR0NjXlcI5sSdiMWplSkvq9Lx7tFc6nOgimyR3UQTr2aukCPyZUMXr8G9zgDfYAh
         colw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VAQJQZU3kcJlIP3mD28vmhk0mOQmzVlSdckfRM97Aa4=;
        b=UbEomu4j0f+aNAu/kpE3ogI5B2Yvii0wbrG6Yg4MEbIuOtPF70ZK+ZIFuVlp38L5ol
         0ZvuZB8STmY+r/JY1kwXqMpDkry0p0E4Ab52UmjWbqjxb2tMZyQ1i8sRN4todNjBQAIc
         y64jrFiPqGmu8O20PkmuetZNi9OOpeA6Wqya3luboaXwiU0V6hQWEYIGYe8+JFx1Vbdk
         bJ5BWJeDB7srZGVJgeOEQwxq9r2e9Ouxg2k+dFbYJiWBo44bdSe8bUTjLu0vUhHhV4Mm
         e4UiTIv3DMo4QBsgx+/rOTcnluv0VSo0ghCnUWVrjoshZhDUQ1Ue2dR3rJBc3OrRoYrB
         yNow==
X-Gm-Message-State: AOAM531zOmGHlzlAwT5ydslP/OR458QiIDaukRQ7XirY15VSXndAYO/6
        hjiZR7Jfb9l3J4qCTKFQEs5zYEUwsVA=
X-Google-Smtp-Source: ABdhPJwQ2pZM1elxDrZ/ghAA8Ma5CGyUjV4pEO3LxkEv5ES/RpbBYv35/Ha3wBOmmcsnAigJwbc4wQ==
X-Received: by 2002:a05:6638:5b2:: with SMTP id b18mr37857766jar.69.1609137856644;
        Sun, 27 Dec 2020 22:44:16 -0800 (PST)
Received: from [172.17.0.2] ([40.75.84.5])
        by smtp.gmail.com with ESMTPSA id t26sm31029587ioi.11.2020.12.27.22.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 22:44:16 -0800 (PST)
Message-ID: <5fe97ec0.1c69fb81.1099f.c502@mx.google.com>
Date:   Sun, 27 Dec 2020 22:44:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5894756658137645569=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez,v1] shared/gatt-client: Fix GATT client attribute read with offset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201228142224.Bluez.v1.1.I89c3c683e3dec6439f3b0d2c00da86a2107019af@changeid>
References: <20201228142224.Bluez.v1.1.I89c3c683e3dec6439f3b0d2c00da86a2107019af@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5894756658137645569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=406657

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============5894756658137645569==--
