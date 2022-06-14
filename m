Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BB8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 18:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242921AbiFNSXk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 14:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356689AbiFNSXd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 14:23:33 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3A51C93E
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 11:23:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x16so6686560qtw.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=b3sJKSTDqwSz+tCTjs0fyIkjxhGswR1wimuHe/EBEXE=;
        b=fzlq69rAgUw1tETeMdggEHEgIGpTEQFntjSZH8Ysd8/52VDlpSUMtbLzMXAL6hhjoE
         nzcBL9+HcLvM2YrjKXChFXmM5E6R4h5u0vFWr23gntrx2InKHEYcHAnrE+Yuq0QGaTSA
         5PJrmbVq05fFwFmT4iJiPlbwLnm+Vtgze+irOZc5jnZgJdCQHN65RzybvuIqYSKXSMmb
         7HAKgL4/2PpWePmYPZxcaXYL3fNlXdY0uTPjRta+//nezvIuDWRAWuFc+esfyaGzYTG3
         Yjc6LxhrUaSCcBlrrtWuRB6NWuPqPkbH6I2O4NlwYKqZA/CZunhjhwX6Cl6IVicyLbdJ
         xI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=b3sJKSTDqwSz+tCTjs0fyIkjxhGswR1wimuHe/EBEXE=;
        b=TL/j+8/Bu8BCMvCYUONuu4gEGFJLxhdL+ga+SXYlUPSf/U4/eoKgtRdm5Z5ZIucx6i
         BFBoiRRm1DxexP8WWbTNN6Xa38MKJ8v16kwBThJsMosAcHSX5OHxOa0rHCsW8IX1yjzB
         glsR8F6HWHLnDx2K2tMzFXGn1hFUEW5rrBK7ITFQqLK1R+duD8rLM+wOyahIywyFKwmY
         nEvutfkqPxOrANwCF+YRZd8YI8Fjvx+x7R5ylU/zLAebh0aBV42QLTgU7+2r0dZ6ilhp
         tA9V0xFST0HS9XuSigZxRCfqwdyLd3HQywxNlJWomti3JlGNytNZMo5NM2fbhxowNVEl
         JGVA==
X-Gm-Message-State: AOAM532TaDa45gEqqZaaaXxlk+fRePjesCizsnxrKUACLQhBcfyG1DjX
        43/QdrildTP0c/QVzVmyv2sXtaFwlyf7Yw==
X-Google-Smtp-Source: ABdhPJzecS85amLaoa79yjgMww21pgVjQ42nB3oVj6WW/EPff5n4NbWQ+/ErQ9Xo6v5PBXlf+oDtHQ==
X-Received: by 2002:ac8:5d87:0:b0:305:2c76:9dee with SMTP id d7-20020ac85d87000000b003052c769deemr5399226qtx.372.1655231011580;
        Tue, 14 Jun 2022 11:23:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.246.9.14])
        by smtp.gmail.com with ESMTPSA id s19-20020a05620a29d300b006a6d3fa430csm10793824qkp.58.2022.06.14.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 11:23:31 -0700 (PDT)
Message-ID: <62a8d223.1c69fb81.2d1ae.477f@mx.google.com>
Date:   Tue, 14 Jun 2022 11:23:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0897932017569002460=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] mesh: Fix keyring snprintf usage range checking
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220614171338.177983-1-brian.gix@intel.com>
References: <20220614171338.177983-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0897932017569002460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650293

---Test result---

Test Summary:
CheckPatch                    PASS      1.66 seconds
GitLint                       PASS      1.09 seconds
Prep - Setup ELL              PASS      41.51 seconds
Build - Prep                  PASS      0.63 seconds
Build - Configure             PASS      8.40 seconds
Build - Make                  PASS      1203.66 seconds
Make Check                    PASS      11.51 seconds
Make Check w/Valgrind         PASS      438.58 seconds
Make Distcheck                PASS      228.44 seconds
Build w/ext ELL - Configure   PASS      8.35 seconds
Build w/ext ELL - Make        PASS      1177.97 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============0897932017569002460==--
