Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F74C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Feb 2022 03:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiBODSd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 22:18:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiBODSb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 22:18:31 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A4020187
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 19:18:21 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id o5so16518833qvm.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 19:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Q2QXowt5WMUpEdR3NxwogsyekDhdksA+Fd+1cFCrzP0=;
        b=CiqUIhK+s1Us0VT0MouGB4I5bfYmCpes94HFjeZW5cPb1P1DiuwG12aniPUrnYA9tY
         DHoG9Z4ooj0LyUEJ3s9EOJ/cMBu3rOCoMnEZkDei/w/c4RqfFc171E6VVf9EdfUmlDru
         D/BkE3wt3ct3wCrPFd4FJ3eKSHpJPyBy7TfAX8N7qu2L/0/1CqtJc24Iu6hvRezbaPgq
         tyoGqp/QRz+DloOAEB1Z/6nDkq1AarH8Q38Pt+L6eUM+bDfk8umwTygcIfW9Lp4UqiHy
         O7fiPinxoOVDWX49XzwwHJZxzfI4+T733X3iffuS+K0IuO36NuXIS1RTqSHvTckTCrOO
         GYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Q2QXowt5WMUpEdR3NxwogsyekDhdksA+Fd+1cFCrzP0=;
        b=dSFd/0I0dvp5xv0AyzEHN6A0quIqOHCoehOsvEcUT9CpfzJHizhnKuykrJwxU8dhtQ
         XPWtB0rO4jCJBC+JzpwwpvIN/1YUERKv544EN4OjpVx2wybRiEXBG3LOqAJL9tdKx+uH
         NX2FupDBAUbI9E3uF0omFU9GM8XTiP4Meh8IcTJ3zZmKTZsCsSPTUjXu0st9lpJ4IuvJ
         TxB5J6rbfKrL8Pdp0B+msaArxNXKKWZg6ug3zMQ16UY0jKt3MC+vvQ730IlGMX+pcDzl
         mGBMEKWGmDeVOTuETgkOIRp2t1cti8YCtSHShqybkJ3/psHCsfY3/pxBazm+dWHDEwV7
         9Qjg==
X-Gm-Message-State: AOAM533qx5xTJCFw/kruy9BYWfKpU9XbwROVI/yoDnNXGfmaPHG12cl8
        RXqqXggICRJJi+QEe+rI5x6CD4lgdoAL/Q==
X-Google-Smtp-Source: ABdhPJwoUN41S/MscsGk4ZCjgO4tDK+AAtfFHvnanhV+SGcjU4F4P7NUTnwkgYX4ngRPUsCeCC88vg==
X-Received: by 2002:a05:6214:d2:: with SMTP id f18mr1163479qvs.130.1644895100870;
        Mon, 14 Feb 2022 19:18:20 -0800 (PST)
Received: from [172.17.0.2] ([20.41.11.221])
        by smtp.gmail.com with ESMTPSA id j13sm17192633qko.46.2022.02.14.19.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 19:18:20 -0800 (PST)
Message-ID: <620b1b7c.1c69fb81.6c718.cf49@mx.google.com>
Date:   Mon, 14 Feb 2022 19:18:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4557676580251910805=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] rfcomm-tester: Increase amount of data from 8k to 32k
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220215015136.1948793-1-luiz.dentz@gmail.com>
References: <20220215015136.1948793-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4557676580251910805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614322

---Test result---

Test Summary:
CheckPatch                    PASS      1.46 seconds
GitLint                       PASS      0.98 seconds
Prep - Setup ELL              PASS      41.39 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      8.35 seconds
Build - Make                  PASS      1247.51 seconds
Make Check                    PASS      11.71 seconds
Make Check w/Valgrind         PASS      434.73 seconds
Make Distcheck                PASS      223.30 seconds
Build w/ext ELL - Configure   PASS      8.39 seconds
Build w/ext ELL - Make        PASS      1234.66 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4557676580251910805==--
