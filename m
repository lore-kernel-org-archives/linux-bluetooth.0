Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B77C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 23:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJGXaR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 19:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJGXaL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 19:30:11 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6325F7D4
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 16:30:06 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j21so1604435qkk.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 16:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yn7FhVHsDWVOYD5welYR4Lr2xLfLwpikjJ5Nvjebqm4=;
        b=NdT+QRrptKXzsH/GYgpFxzOe4uQwNHPFL3XDFPFmwf1vfX+brGEttoP6MqUu6EaWF4
         OVC0PuAsxZgJmzZZx8xrjwayYQR/AaLn5LaKuE7Dza5MOUvrYA4sjJTfYIZpZtsGE9L6
         +tF634O7DF8LMesFWKMSAjJp9FqtmqlLT26GS38QpMzIRrXOaJCWqsHWQOlbaKmu0SUD
         m4Ub0J8KYUyVHjAtvba3SHkiGNT0NlpH6/tHxghA2qTZ2JP1LuItR/j9SOFBq2a7Pa1O
         vGRqTyNPVbMrUDJScWbnMm4knGZfXwJDhlEBMZXQ4gdqCgnfe+22D/mtTN3NKypFW1HZ
         UuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yn7FhVHsDWVOYD5welYR4Lr2xLfLwpikjJ5Nvjebqm4=;
        b=d1+ZQlkDhJ0AKG84nTrqoFtxXatxMenzrb4Kp61mtO+7FbLa5F7jMFhNk+e/QVc1hM
         UvNQiaxeM7sH4KwmQcUINlg7WABz2Tgtn37Gjyd/AVtqV4gCnjUxnWp9pVfCYrgy+Rtu
         4FTR2AWA96KxdrFbypvaQ4Q3gKLOLBOWW78VP/0HEEcAopQfkWiUNiKcjlQg/Tio90yW
         7oAnpZHnA7xO9k4XQRE7RYP6FENk42FLGg8pjc2iHm6u/y0v/X8tf7hfzzv0Pg+FqyI8
         F6VJ6gtsZjwOpS58CtKRmqFeVaM7kYRV0Xyh3nl0O82IhING/lOU/OXtP0cV/18wany9
         uvKQ==
X-Gm-Message-State: ACrzQf2HJtfwgN4SpE2N4z7W3AX7NLAhGXAG3bcPCe/P1fexP4HUM8Sq
        vVp0Vdy93cLsQoGpLHxAJ9FNyK9CJm5tyQ==
X-Google-Smtp-Source: AMsMyM4XzSQ3QKNocV2LsGvKZjc2aVp3XMinGlRIb5HMZR9ittiWuq+9z8b8hEE3QwAICpG/pdTcCA==
X-Received: by 2002:a05:620a:290d:b0:6b6:1a92:d88a with SMTP id m13-20020a05620a290d00b006b61a92d88amr5604113qkp.58.1665185396514;
        Fri, 07 Oct 2022 16:29:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.35.174])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a40d500b006b61b2cb1d2sm3225600qko.46.2022.10.07.16.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 16:29:55 -0700 (PDT)
Message-ID: <6340b673.050a0220.ed9e2.75c5@mx.google.com>
Date:   Fri, 07 Oct 2022 16:29:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3696784273002119896=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] btdev: Add support for setting bdaddr
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221007223751.1832559-1-luiz.dentz@gmail.com>
References: <20221007223751.1832559-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3696784273002119896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683836

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
GitLint                       PASS      1.06 seconds
Prep - Setup ELL              PASS      26.83 seconds
Build - Prep                  PASS      0.85 seconds
Build - Configure             PASS      8.58 seconds
Build - Make                  PASS      925.68 seconds
Make Check                    PASS      11.96 seconds
Make Check w/Valgrind         PASS      290.02 seconds
Make Distcheck                PASS      233.17 seconds
Build w/ext ELL - Configure   PASS      8.65 seconds
Build w/ext ELL - Make        PASS      84.14 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      512.43 seconds



---
Regards,
Linux Bluetooth


--===============3696784273002119896==--
