Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F69AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 00:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378463AbiEGA2c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 20:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiEGA2b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 20:28:31 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D867F3D1FB
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 17:24:46 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id o18so7184389qtk.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 17:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=D86PNfew+Fuy70c3JAsfzG0W6ft4HADsrsjqOlI+IeQ=;
        b=Ojl6J0MAq9OABm/5FZiF0POVMq5jsgjfngR+jwUUQsI11GuWzdrddAQhItPVpV8Z4U
         uJSx9VrSZbe+JpzqZiIiSVq3l3OyYuTcE+7mXP5Ga35JyKZcR6dDN8PDPr33QKnfetra
         Efc1V3NYt04S6eN2DEKa10ZC595cwLqlGz0q8fT0a0gkS4WF6lexklYtZSKiRF99BzQS
         87WpQ89Yy6a1v3p31RKu1zsj7OBfGWq60XoM/FeuIA6wW70aeJ+HMrmwBDwu71H8A82R
         IBNWpVjyzEfoQU3ZMd8eNSNPuJYpl1TTMAo6TxbIJcKMe6yk+NZZBJsDa3xlhWkwoRoH
         ACqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=D86PNfew+Fuy70c3JAsfzG0W6ft4HADsrsjqOlI+IeQ=;
        b=NeSLd6mcZsmJQS+CvpS2R2ptngo/YGizuTUwd+99VeumjYahMIxxiGB9N88ImWhTfP
         GtNMJh9Kaf8+1U4uHlAljcJAfU0VM41H5HiaTO0UvYX/EBQvBMHH8cQNY5GzL/tnI2nI
         f3bu6WB6LkmmO6DEC3G29rUncdj1t4ZZc9hTevPaPPxIutu961YoWqJmUxXLFOcOod0Q
         Et2KIDT1y+F7MmunNgFIvJ81vx4hDU99gjdmxeA4l4GQpGSqCCV4oa7fZR5+nU9gmm1n
         cNMaJlTHk6WcwtN9PhHHLWt1XLXcveJyFvnjNfK7AFBnyYKHilf0DiqJ2/DgzfJk9hbj
         n0qw==
X-Gm-Message-State: AOAM53108q/kETJTMI5jI+G08LwIEMRcl5mktST9aJiNy2y6uhj29f9N
        bSsZsI7FhWmfSTgLhMFDVstkZDb9yDk=
X-Google-Smtp-Source: ABdhPJz2eTrjz0VDlZVebTjoUMcgj+iKu7e3Msq3yle9Sm3jVFXNQBYcvOcvEN3wQ0zH973Rj7yNLA==
X-Received: by 2002:ac8:5f0a:0:b0:2f3:b18d:bad1 with SMTP id x10-20020ac85f0a000000b002f3b18dbad1mr5307842qta.150.1651883085777;
        Fri, 06 May 2022 17:24:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.150.88])
        by smtp.gmail.com with ESMTPSA id cm11-20020a05622a250b00b002f39b99f66fsm3520087qtb.9.2022.05.06.17.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 17:24:45 -0700 (PDT)
Message-ID: <6275bc4d.1c69fb81.806af.3b3f@mx.google.com>
Date:   Fri, 06 May 2022 17:24:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5781425365377913083=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] advertising: Treat empty LocalName the same as omitting it
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220506230819.3954905-1-luiz.dentz@gmail.com>
References: <20220506230819.3954905-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5781425365377913083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639269

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      1.00 seconds
Prep - Setup ELL              PASS      39.50 seconds
Build - Prep                  PASS      0.67 seconds
Build - Configure             PASS      8.10 seconds
Build - Make                  PASS      1368.00 seconds
Make Check                    PASS      11.37 seconds
Make Check w/Valgrind         PASS      405.40 seconds
Make Distcheck                PASS      213.47 seconds
Build w/ext ELL - Configure   PASS      7.93 seconds
Build w/ext ELL - Make        PASS      1380.64 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============5781425365377913083==--
