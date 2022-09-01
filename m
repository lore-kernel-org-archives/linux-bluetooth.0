Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226E9ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 21:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiIAV6o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 17:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbiIAV6l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 17:58:41 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A3564E5
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 14:58:41 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id s22so434074qkj.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Sep 2022 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=jsS8RJRk+GqHOl9m3jQL6qAhGn8pJOagtzTks0ddgBk=;
        b=IevoUArbX6rr0auNNYGO+zvKQ/t4UKYfExb0UE0aKw1pJCZfaWyYDCiXrX165N8GDG
         mh+oS032GharHB29W5bMvK/GIQkS3/jLw/JLk6H+b8O5dffV4Z0cchi3KXQkUbUO+bfy
         EdZQSMwsj7FLyWYJGJhxuHSER8o4fmzd2Q/GKqi9uu0GaaR3rgjqWP8jdWjt4mqXNXX1
         my/sqs3MzLVyYF+TFZZGXsDEpikHRtu53oRTDGpl+8ohrgqfXQ2AUwDlICJaeqd0BLOP
         fUUXnoJ801tDOkP8m3NMH/cu2HfOCex+GAX8ywb6Q1O2op84SjaH3cl3/6m91rFYON3Q
         8Y8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=jsS8RJRk+GqHOl9m3jQL6qAhGn8pJOagtzTks0ddgBk=;
        b=jehkMtuc9wMcWvV/BqwD4j9NkPieLk3Wvsy8WgFNDcFjB9SsU1fD8jmAkhOMX/YmQ3
         fXiofYvEj56RmGdleVjIOa7wIU0tvxvLSGEm08gWzcoQpzpLZJSMEO136OuEzIQz0sV9
         V9hjD/ZUO8WmYOmYldhdVY4qIaeDdnDClMg+yTAcpu6nDbv7Km2d/w0XcpYJAxJ2TpcQ
         FrI0NzAene4CtiWy3/Ase8u5MX+GRE1tp2diLiuk9MCM0lpa0Mk/rSE9pCFa1U3LjUf/
         OJyRytJbKbNxTE6XN6A7ORtgSqlnvthghfsipVpuRhjkxOQj6G6UwopWla4Bcz5MnaN3
         2M5A==
X-Gm-Message-State: ACgBeo1JdL2yAj95hIERlfvvb3OMRpZRn1XlEZpGpQ11Uwz64zLzXLZ/
        jch9WrIZ3Cu70TBpI093edYfRsflQ+tr+A==
X-Google-Smtp-Source: AA6agR6T8PDUaEF7LcLTmsvgevxVUnmMowmi4aE2Q6u8CRcm6RZxXwYw27n43Eqt2YftmPENG13mwQ==
X-Received: by 2002:a05:620a:170d:b0:6bb:3f82:6a7d with SMTP id az13-20020a05620a170d00b006bb3f826a7dmr20660670qkb.166.1662069519665;
        Thu, 01 Sep 2022 14:58:39 -0700 (PDT)
Received: from [172.17.0.2] ([13.77.107.211])
        by smtp.gmail.com with ESMTPSA id bp44-20020a05622a1bac00b0034355a352d1sm10694987qtb.92.2022.09.01.14.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 14:58:39 -0700 (PDT)
Message-ID: <63112b0f.050a0220.66f83.4103@mx.google.com>
Date:   Thu, 01 Sep 2022 14:58:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5655225613556905290=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ,v2] mgmt-tester: Adds turning on Mesh Experimental feature
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220901210722.73044-1-brian.gix@intel.com>
References: <20220901210722.73044-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5655225613556905290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=673392

---Test result---

Test Summary:
CheckPatch                    PASS      1.46 seconds
GitLint                       PASS      1.20 seconds
Prep - Setup ELL              PASS      26.84 seconds
Build - Prep                  PASS      0.78 seconds
Build - Configure             PASS      8.37 seconds
Build - Make                  PASS      745.75 seconds
Make Check                    PASS      11.95 seconds
Make Check w/Valgrind         PASS      287.36 seconds
Make Distcheck                PASS      238.73 seconds
Build w/ext ELL - Configure   PASS      8.61 seconds
Build w/ext ELL - Make        PASS      83.06 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      490.05 seconds



---
Regards,
Linux Bluetooth


--===============5655225613556905290==--
