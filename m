Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21638C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 09:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiF3Jhk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 05:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbiF3Jhi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 05:37:38 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D344433A9
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 02:37:37 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z7so13957730qko.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 02:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6Kk/z88UnX2YKJB59FB69slbPvCFaRQjne6XoFsyjCA=;
        b=FWykSB0GgcayMnM+Ur5e/35ACJNLYuORpiut8i0/g/UHSWn7cUMpHaBhnOHRctSRJL
         LbebQCaW/Gb3Nf8NtFAl/su7aKmjy6urNBf56Nq/apO/0t2L/J0ryjjfE+Y2M3dpgi6Z
         B2gtlF50J9/kiY9mjpNqD/02cjpUvfdjo3wA6Uy5nE3l+tbSFMGc4h3IbJvOCVIGE494
         yYzxZNxyF/PiK/bMUiKuYPzO6melK7PRXyUwRm/o7NcmO2kIKvzDAwEyM+Fqv6Gm+4zI
         /6nDcBqFTtKZAzUaCaLGRHGY5pxi01+44SGNei29dCpJWlVhpvHkvrf/h5x/tRgxS6+0
         OTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6Kk/z88UnX2YKJB59FB69slbPvCFaRQjne6XoFsyjCA=;
        b=7GNx5JZF5ncsVWzcJMSyVcKa4QQ1sM8fxxDHaw5PFVnsT5fH+bz6dhvd6WkM/zAI2C
         d6G6hWX6OeFC2G5XsZISffOyN3il3O5SReMMirfT/kDis0BaegYWVC8lAdR33xjF/+iR
         9oPAIKRxlaLX5tXKV4VmJwrbbe2wA0tolSeb2HeckNuo7mbMjtUe6wTak/DYUvaspmU3
         /O5KVUpjX5xdUDKAYwXk4U8sJspPerZY23HC+9Lb2bYAVWkCXFbSSKNk8Ni1MkyvwGLX
         In4s/pt3iBoiJWvEHU0vfvF5r9BTJDyT5ura/ysEjY3rDGAh7Hh3JBhABW4eR6tiRxLS
         ZA+Q==
X-Gm-Message-State: AJIora/1pxOTID3gx6EzCGs0pffEk+aG98BQvbzRQXBwcZnWEtV8rjCN
        JZ6tP+br3NenKphnG1219vGVq8SL8puNhg==
X-Google-Smtp-Source: AGRyM1u9545VulHDHu7e4mhpy7wjfB+TeDLx9pjRFctOmP/6MEn4V9Ib6v87NtqjTrxTV8y/sf6DKg==
X-Received: by 2002:a05:620a:130e:b0:6ae:e56a:f90b with SMTP id o14-20020a05620a130e00b006aee56af90bmr5289134qkj.137.1656581856048;
        Thu, 30 Jun 2022 02:37:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.113.196])
        by smtp.gmail.com with ESMTPSA id cb24-20020a05622a1f9800b003187c484027sm6849190qtb.73.2022.06.30.02.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 02:37:35 -0700 (PDT)
Message-ID: <62bd6edf.1c69fb81.7c418.0d04@mx.google.com>
Date:   Thu, 30 Jun 2022 02:37:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2218364102184982669=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, adrake@adrake.org
Subject: RE: [BlueZ] adapter: Fix advertising monitor on Linux 5.12-5.17
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220630073958.34468-1-adrake@adrake.org>
References: <20220630073958.34468-1-adrake@adrake.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2218364102184982669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655292

---Test result---

Test Summary:
CheckPatch                    PASS      1.45 seconds
GitLint                       PASS      1.01 seconds
Prep - Setup ELL              PASS      43.79 seconds
Build - Prep                  PASS      0.66 seconds
Build - Configure             PASS      8.75 seconds
Build - Make                  PASS      1446.34 seconds
Make Check                    PASS      11.94 seconds
Make Check w/Valgrind         PASS      451.64 seconds
Make Distcheck                PASS      238.86 seconds
Build w/ext ELL - Configure   PASS      8.74 seconds
Build w/ext ELL - Make        PASS      1428.94 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============2218364102184982669==--
