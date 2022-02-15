Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD06C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 00:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiBOAjd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 19:39:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiBOAjc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 19:39:32 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B7912D21B
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 16:39:23 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id s1so17035377qtw.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 16:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=2Z9hgTLy6w7du2aRD4JowdRwD0t7iqS9HqCC2O/Jo3c=;
        b=XLiMda9jdYHFDYNzZC9W5QRIG0fv9H2lIt2SO/XH399aigHfPYE4krgkZSpE5BFtEo
         CPulBbA3RBOUDmgYO7lOspcA/GvVpKvDVbDM7DELPqossU7Qy5yriehGAy22LWYoo9zS
         P1xPaiCfzk3MFO5zBoo+fEwypWH4GryWis42yImeilEUMlG6WXS6bkkyZByVoQZfMQD/
         ZG81vIhBk0kbo6PqStJB2PUCs8QkipIsIqnpMErWB/MkbNZb/rYIeSM+GZmGiA+pfe2w
         ALRDqJgU8mE+rgrEdqIae6fDJpzOBs3S0pWxLeb8D2j8JzAC5N7H+b5LyoQj+j8BA39X
         SN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=2Z9hgTLy6w7du2aRD4JowdRwD0t7iqS9HqCC2O/Jo3c=;
        b=RgfGwyWNMiqaSYRHrg5DJd1/RfFQei9HWA2XxBQsZVOgteeIQ6bLd8741ecf4MLwIO
         p02hEJffvNCMYePGOr+x7RD2EldE1xNPyHwWt0Qmt3QiUQzKwSk+MJVIfbbIXRvkrWW/
         vIAG2BUkEiUK5pghbtkuUuJG5EtjSfVHY4iuLy/9jUxiuiraFND7tBvG/wH82mpOlNXb
         MJN4G2vGlS4SZ+xVpe2Ml3bZIGBXhGAzfO1FDZ/lXiiZv52rhqfXWqnouCqXuLsWd9oj
         gnA4KokHVx9y3kiJlCYf4nFh6+l9CBiC8ThMsneVw0zEwE4wsTwdxl73Nz1dJwo2KaOz
         gD7Q==
X-Gm-Message-State: AOAM533qKwyC99KchGyyYvOVdsC6//gwybz6EfyC1g/hxZI7Vqcd2Hn5
        aYVZGAuQqsmfw2B3hhTreJCMNT1xJoA=
X-Google-Smtp-Source: ABdhPJy8YsxxrY3J9/glv8zDUz67E0TXV8upUNKDs90CtAPKThs8zZlFgKimsTvyr4sR129/rOPSqQ==
X-Received: by 2002:ac8:5e09:: with SMTP id h9mr1158279qtx.129.1644885562531;
        Mon, 14 Feb 2022 16:39:22 -0800 (PST)
Received: from [172.17.0.2] ([20.110.18.174])
        by smtp.gmail.com with ESMTPSA id bk19sm16172074qkb.125.2022.02.14.16.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 16:39:22 -0800 (PST)
Message-ID: <620af63a.1c69fb81.9b50a.7934@mx.google.com>
Date:   Mon, 14 Feb 2022 16:39:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4080435247427214355=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,BlueZ] obexctl: Add optional argument channel to connect command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220214231619.1873499-1-luiz.dentz@gmail.com>
References: <20220214231619.1873499-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4080435247427214355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614281

---Test result---

Test Summary:
CheckPatch                    PASS      1.51 seconds
GitLint                       PASS      0.98 seconds
Prep - Setup ELL              PASS      55.48 seconds
Build - Prep                  PASS      0.95 seconds
Build - Configure             PASS      10.18 seconds
Build - Make                  PASS      1793.79 seconds
Make Check                    PASS      12.13 seconds
Make Check w/Valgrind         PASS      533.60 seconds
Make Distcheck                PASS      293.74 seconds
Build w/ext ELL - Configure   PASS      10.75 seconds
Build w/ext ELL - Make        PASS      1791.47 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4080435247427214355==--
