Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44844C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 07:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiCAHgt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 02:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiCAHgs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 02:36:48 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0707E08A
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 23:36:07 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id z7so15546882oid.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 23:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wdQCU33s4HAT/YtC9B5AWOpwceRKYRgJj/CuGNe/CDE=;
        b=EDCJeNs80S3r5nkgLUMPcQq3YTmV9AlV47AA3QpUwikwcA22Kd4DifFoZyQ/9Er7yN
         66z2lG0zi4R7T7SkFcYFBrW12ryeum9WCxmVeYZKmIzTAnFfCcST+LDZgZlsX6sZ9asj
         lSia5o+WINM+26jTtRSKbYqOvCCN6V4/Rt4orCneklkZH5kUnJ8emKp6XiVjJC47YuEH
         dPiM5D7UaxOZk3NNTPoVOzX5+KYzBdvej9hlZrTp6kzUTnNObbagQTWYQhuHKGt2qWsX
         N6IOTV6lYiYcRWAT9Lb8Ip4VsYguv14yJA6GjaFLUa8ucotSMN+GpsAxm77ID+kYHqH4
         mLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wdQCU33s4HAT/YtC9B5AWOpwceRKYRgJj/CuGNe/CDE=;
        b=V/rgXaKzM0shHe+s3oNqAMlCM637GULm0YTTslTshKYZGixg+vAVbBFoCnQBZ8Efug
         MRHB2LqIv2J72SyDviSunAyObeAJ2UWdxPifdOyTNbVpp25PDUTx8rdOXe9N70ETcVhg
         vKswApjEGj9a9PkUklUcDR83UxnEasn33941JZTfGR+MIvko4e3e668r9WnybeZ9W2fd
         iaIZTLBW3/sk6Eu/O99Js1EU/dlImGxN6bbJDYnNevGDql8s9G1yI8KY6tdcShHufoaT
         F9OYuRfOibwOOvVfz1JTSr2MlTDq+4zL73XdRvMfEwNddxSEKbUYcDd0zLBQ2QvgY241
         qoZA==
X-Gm-Message-State: AOAM531HR72L2mZRkiWn47Z78Oor2ujVyOrQF9E5RagxVDS6uHs038bi
        Hfdu8DGX+YhFlgJ933cVQm4EiyqG5pY=
X-Google-Smtp-Source: ABdhPJwaYfElcsVfo8udQX2nh4XVRXxpGcs06/FGD3hHERo5N1xSFZPYtnxJZr5dxbRwIs9Igs2cww==
X-Received: by 2002:a05:6808:d4a:b0:2d7:29f2:bd00 with SMTP id w10-20020a0568080d4a00b002d729f2bd00mr12339512oik.78.1646120167142;
        Mon, 28 Feb 2022 23:36:07 -0800 (PST)
Received: from [172.17.0.2] ([13.66.71.80])
        by smtp.gmail.com with ESMTPSA id gz3-20020a056870280300b000c2e2d0a326sm5511655oab.38.2022.02.28.23.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 23:36:06 -0800 (PST)
Message-ID: <621dcce6.1c69fb81.1eb90.2b23@mx.google.com>
Date:   Mon, 28 Feb 2022 23:36:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3264018931325376000=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ihsinme@gmail.com
Subject: RE: fix writing out of bounds array
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220301061445.7626-2-ihsinme@gmail.com>
References: <20220301061445.7626-2-ihsinme@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3264018931325376000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619033

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.74 seconds
Prep - Setup ELL              PASS      39.91 seconds
Build - Prep                  PASS      0.59 seconds
Build - Configure             PASS      7.79 seconds
Build - Make                  PASS      1335.50 seconds
Make Check                    PASS      11.51 seconds
Make Check w/Valgrind         PASS      408.47 seconds
Make Distcheck                PASS      216.86 seconds
Build w/ext ELL - Configure   PASS      8.18 seconds
Build w/ext ELL - Make        PASS      1339.21 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============3264018931325376000==--
