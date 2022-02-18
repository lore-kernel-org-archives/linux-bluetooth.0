Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2DEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 03:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiBRD1a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 22:27:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiBRD13 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 22:27:29 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378B72E08D
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 19:27:14 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id n185so6755820qke.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 19:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=S4LMLwn4In1DLjaVZ0nTYlkc7sWlKXcP/yjWEiCLlvI=;
        b=VdiXmytj+VjhlLSE9audXUDSD4YjBglI6uNj+Rs+Rlb/L74zP/w2gZWUreWdrAOxsj
         IUeO/QHG456UHG6VGHR4dq/uS8Oi77yDKvSJmSLspFk1a7GYYkyOmkBdrGlsVwXeimh0
         O72TY5koK7GfPTYz00N4kyP+/vX7HmnN/jEqVXzb0168BpyS+nfrnrtLJ8RhQ7EXTWNO
         FXgwakBJz6S1tUVtAiALrlqCRqP/E1utMQeIVMw5ResFHoT+eeMVpT1rRtsu4LIsIurZ
         y4Oc6M/iZTwrVwXmwX1rX1YQoUufHSAI9W36Kei9xMwX52dwFH/xd8Cn5rsG4/LUr8lo
         ai5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=S4LMLwn4In1DLjaVZ0nTYlkc7sWlKXcP/yjWEiCLlvI=;
        b=oZ4J/9FSuH6U9ZdOLLNfOtA8HO8u1XvPIEkL//VYnYjh9lye/ry6JUehu3zTluQh4W
         gI0XuT2UaeMTAssy5dbul1A0wjYzDgWcIyaJPIoeP21D/vU2cCQfQE2ZFsSkOnzbPmL0
         /UN178gk7jNpw7V08yhIBEcxn78r8NxXsho6lj4tqDoF61URxhZxcQE6IPtTLvqKey7y
         CCWeKilV7mf5OIVQXJNZ0YaBGpO7Rckn6u7RGbbd/ZsU37c9sZgAul6ZnTRM7Rcat9wv
         KSy+5s/YN2yyU2m9OCM3/IwJzhX35Z0EYo2rzyCYzN6V5R+opPmErKdEgxMbOjXi8CkZ
         dMDA==
X-Gm-Message-State: AOAM5327dNJ2xKg7V+ltEJ/1zcNV0wZMuY3yMd2urhOqLObzWuI1ehV8
        clEwNmZxf1P4nkSVAgMFksN/qYC29is=
X-Google-Smtp-Source: ABdhPJzY82y37ns8m/rhjyc3H5mo6vfNu1tgVj6Gu0BM36fU46G07bj0++cjsGBuJekRnAVkOe6Tpg==
X-Received: by 2002:a05:620a:1506:b0:47c:fd66:7053 with SMTP id i6-20020a05620a150600b0047cfd667053mr3554848qkk.322.1645154833207;
        Thu, 17 Feb 2022 19:27:13 -0800 (PST)
Received: from [172.17.0.2] ([20.186.108.193])
        by smtp.gmail.com with ESMTPSA id y5sm21169847qkp.37.2022.02.17.19.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 19:27:12 -0800 (PST)
Message-ID: <620f1210.1c69fb81.e1488.8904@mx.google.com>
Date:   Thu, 17 Feb 2022 19:27:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3331223056590492256=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] main.conf: Fix parsing of mode options
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220218021605.3126182-1-luiz.dentz@gmail.com>
References: <20220218021605.3126182-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3331223056590492256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=615612

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
GitLint                       PASS      0.99 seconds
Prep - Setup ELL              PASS      52.63 seconds
Build - Prep                  PASS      0.81 seconds
Build - Configure             PASS      10.55 seconds
Build - Make                  PASS      1511.36 seconds
Make Check                    PASS      12.99 seconds
Make Check w/Valgrind         PASS      545.06 seconds
Make Distcheck                PASS      281.59 seconds
Build w/ext ELL - Configure   PASS      10.64 seconds
Build w/ext ELL - Make        PASS      1467.66 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============3331223056590492256==--
