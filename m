Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF23C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 03:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244679AbiELDGp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 May 2022 23:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbiELDGo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 May 2022 23:06:44 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A467A37A9F
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 20:06:43 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id fu47so3450426qtb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 20:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=n0bPEqKWOQs/CFdGjy9ucTDAIIxhm6jxwQomN2UC5iI=;
        b=nkZg2MG/UDXA0Y61XJXyxqWNZZxAraE2zYcOis98glJR95T0gLXx3vT1QDzXX1DmfZ
         EFYD9lH7LbkoAzMc7wE/6fdteo2Ivz+vtZoA2E/0GsLFf0JOhwP29TdjAnhsaBpgRCjq
         2qAjK5yf7jbDIpZU5x5ExDp2AZb/gQkXouhxWblzjZSrYVb7hcEz0ZXw0JMOEmF8Qgwa
         dMZR+3wf0kZ6dANu3jD69tNMO4KBEuEuSUDUcBgMfE4rWLrdL4sPo7iaUptBaxACcVMt
         OljwCWxqMLnHsxHBApnZLAzmRTTFJTpryTNBWokGlvnJakuxG2JciyBBKrIle44+1H6S
         /sOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=n0bPEqKWOQs/CFdGjy9ucTDAIIxhm6jxwQomN2UC5iI=;
        b=LJt/+TSNp4Z007uiBdkn/Wsw2mvwznKQg5xWVcsEkxcv6Srg/ySFhYGBY1XhlAOjxy
         zgiag4KFBz9Nm6ogGGj/Ij4P55Aw4NHUieOhENNJ0B7R4EHHaASLc/D0PZSWn6dXwI+k
         Ql+/Qts1qg5L+d59Pd5Op1b2AyhArihnTqE3Z/fyMeBGUkNC07/9oK+vNxaNotFu4qvx
         K2DyMYBh7C8ZVoxUc/fY5WUJH4XuOQUHSMdQDAdIeH/ZnysYpTFpaNOdMuJKGe7yvm3m
         oZdqWpOB7/zT7hyJRHFlbemimlzVTvXf+ucGW54SQhRaasufnBh1ppRM0Kd9RE+qUE4U
         QmOQ==
X-Gm-Message-State: AOAM533d1d6RICEMoo5TGJQ5gfk5gw9UPxkVTATYXKAsv5cst6Vfa5OZ
        jt6h4gYcMLAWdPw9nHKYeBZaVRMkTKmfdw==
X-Google-Smtp-Source: ABdhPJz6Wfmrl2LaWrGrhgOa2NNetzeCgDO2DXcsOHVURPwzRBh0ZHGSAaHm+rRGFKj+u49CmPbpRA==
X-Received: by 2002:a05:622a:1484:b0:2f3:c837:57a6 with SMTP id t4-20020a05622a148400b002f3c83757a6mr25909062qtx.460.1652324802658;
        Wed, 11 May 2022 20:06:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.120.6.216])
        by smtp.gmail.com with ESMTPSA id l14-20020ac8148e000000b002f39b99f68dsm2261486qtj.39.2022.05.11.20.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:06:42 -0700 (PDT)
Message-ID: <627c79c2.1c69fb81.6f854.baa3@mx.google.com>
Date:   Wed, 11 May 2022 20:06:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1634828042178469191=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] service: Add initiator argument to service_accept
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220512005515.844857-2-luiz.dentz@gmail.com>
References: <20220512005515.844857-2-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1634828042178469191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=640777

---Test result---

Test Summary:
CheckPatch                    PASS      1.53 seconds
GitLint                       PASS      0.98 seconds
Prep - Setup ELL              PASS      43.22 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      9.07 seconds
Build - Make                  PASS      1293.83 seconds
Make Check                    PASS      11.29 seconds
Make Check w/Valgrind         PASS      426.79 seconds
Make Distcheck                PASS      232.12 seconds
Build w/ext ELL - Configure   PASS      8.69 seconds
Build w/ext ELL - Make        PASS      1277.75 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1634828042178469191==--
