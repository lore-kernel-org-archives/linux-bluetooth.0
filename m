Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC23C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jan 2022 04:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbiA1EJI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jan 2022 23:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiA1EJH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jan 2022 23:09:07 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B30C061714
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 20:09:07 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id b35so4045311qkp.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 20:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nwQ4QDr5ajnunGA6Y+ig6nZEGFrYegjR0CO3vkhdzmQ=;
        b=NmrpjWTpPyOxMvCegEq2Vd/TYWUlwuuD5c03K3+64YD97a5ANDXIH3JkxshqFVeH6p
         rg2GEF25q0WHgjqAiz+aOXf6z+OySMrs5s65MMa6DB8RzLF/Ntx5//X7aS5GUj0rqn1Q
         s0a/+J4YYgpwyLJO/foliOmLNzbtTEcU3dP7J4RkZyFF+uCdaIgRaND67UBBcJLXR+y3
         dRYj1ETjCV49OOSyGMxZNj27oZTD6D+7W1kj+IAtrH75XZ0Sjf3qk5qjdOUHNdSRXlBj
         UkiXFvD+NvFbK5AJLoXzDIFmoJlLrxU1Q2lRkcAZmZk7ncKSxQip1xLY0HNcrkvL8DC4
         Zqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nwQ4QDr5ajnunGA6Y+ig6nZEGFrYegjR0CO3vkhdzmQ=;
        b=RCYaHhzEbg3cxtf24mJIp2YLKNCurx61pbYhR6gnNoRuAtmqrdhuw3Ea7ajL7B4YX5
         FnVs/vcrc7i2/Dyda7Mbe+NUPBhMM3584kwr2WEmXLqSW2rsUCSeTqCXEjLAl3dQSBJu
         ufHZ7d9EAT8u/HxwaILF/pnNUJiou/s89DKT44Pc05LsS3D17p0yQFbWDXK81jDW9mQU
         qoWZk8AUz+ER1wNF0sh3bMsTEb3WN4WnS5AN9g3FmqLm5X3JiiP/nUG7YrOisETJ4cX0
         XvH59rsde4kS/bzn/xOPuqOOfx1ShiPbLeke224zWqV7Ji7jQE9lCq3b5z+Z4kec4LVZ
         ii/w==
X-Gm-Message-State: AOAM531fQavjtQaPGRv7/jNZgmoFtJYH/OIUKMDqeqyAUcwhO44ft1v/
        3WWGEfszCIguTh93T1ddFKQ6EQxuSWU5Zw==
X-Google-Smtp-Source: ABdhPJwcLm2z0Cq/zak/byW4btCwuSIJgPm2gnm2pkz+rUCYucQIUV7RaaSlNf33VMlkyhiiGB80nQ==
X-Received: by 2002:a05:620a:4415:: with SMTP id v21mr2089129qkp.706.1643342944348;
        Thu, 27 Jan 2022 20:09:04 -0800 (PST)
Received: from [172.17.0.2] ([20.122.144.107])
        by smtp.gmail.com with ESMTPSA id e9sm1603502qtx.37.2022.01.27.20.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 20:09:04 -0800 (PST)
Message-ID: <61f36c60.1c69fb81.ea015.7b79@mx.google.com>
Date:   Thu, 27 Jan 2022 20:09:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2022111172287411316=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] shared/mgmt: Add request timeout handling
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220128020735.3779202-1-luiz.dentz@gmail.com>
References: <20220128020735.3779202-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2022111172287411316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=609321

---Test result---

Test Summary:
CheckPatch                    PASS      3.07 seconds
GitLint                       PASS      2.06 seconds
Prep - Setup ELL              PASS      49.45 seconds
Build - Prep                  PASS      0.80 seconds
Build - Configure             PASS      9.73 seconds
Build - Make                  PASS      1439.59 seconds
Make Check                    PASS      12.59 seconds
Make Check w/Valgrind         PASS      510.88 seconds
Make Distcheck                PASS      265.99 seconds
Build w/ext ELL - Configure   PASS      9.90 seconds
Build w/ext ELL - Make        PASS      1417.04 seconds
Incremental Build with patchesPASS      2901.91 seconds



---
Regards,
Linux Bluetooth


--===============2022111172287411316==--
