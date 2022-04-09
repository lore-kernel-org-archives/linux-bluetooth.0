Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B652EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 Apr 2022 11:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbiDILpl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 Apr 2022 07:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDILpl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 Apr 2022 07:45:41 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7623C701
        for <linux-bluetooth@vger.kernel.org>; Sat,  9 Apr 2022 04:43:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b2-20020a17090a010200b001cb0c78db57so8846019pjb.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 09 Apr 2022 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bJSDutSW8XMrT8lUafghvujY0SpcILKy5+4Ug7LsTP8=;
        b=ctnB/biG/Dghtz4tmU9rdDii622Vb3BT4+1Qr+gr/rEWBrBG2i2H34CqCrHG7FG1Uo
         3DfvG5mxk+AjJoErh8AlREe7oKzZ8BpthobKQkiJW9kPukG3O7YApfRrsGO69I61OT0K
         JsHomuTfWaC3szgLgDmeUMr4bdlHpw6UHR0wykwW6E+dsfFPlignrQT+nIj2Drtojfrw
         9FaJntpK5s79AT7jENp00X1jSjrDPQbM2Rs4brfFNYgP2JuZMjV5echcjM5wtCF+gJJh
         9fuKkSoan49ANioWjCGgmztSib8Z+eYXhZTOLJjewJilmeqpQpi0i7mxPgnhJq4memM1
         L6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bJSDutSW8XMrT8lUafghvujY0SpcILKy5+4Ug7LsTP8=;
        b=yAMNuvoX/klFNiZw9hZW8GsaGiq/1obU7d0JLWBRaoCzUrBWNOIHAjnWHzqDmTphQS
         whMkdJ/rwsz+hBfOggWjk09xTMndb6o/eqkZADW9yOPK5SUq1gaRIIh1byeSSF0rxYB1
         UEJpZhr5k732Au647XzB3aQ5OzB/5PEQ7l/FPiGhQfk3PXsuMzZLQdR0o/RrkB8Safg2
         C3oWdFDmZy3cjwberqDwq6tGgie69kywRFQ0RmIICerTNB/OXO4H/SAAlSUxZ6dviPID
         L6lvBipr3gpXwkw93CxLYKz8ea2OhA3ePOQVFnQ3lmqyGUbuW/TrHP53xot3kvgNpXGl
         +NFw==
X-Gm-Message-State: AOAM533w7SzAuvYvo/jb1tYjNdF6SVM0YgJ1v35xQH5OkjMe90LfAx88
        k2qAQEQcauY74D2rmGPcHoSRh8bjjQQ=
X-Google-Smtp-Source: ABdhPJxUFo9pXg7UpxuRO5Ey/YCYudIWvRcIg0jZqhgLd6p94ZGRZSi+MEbbeKI5PDUoQ/p88ixc6w==
X-Received: by 2002:a17:902:7ec1:b0:156:17a4:a2f8 with SMTP id p1-20020a1709027ec100b0015617a4a2f8mr24287848plb.155.1649504614130;
        Sat, 09 Apr 2022 04:43:34 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.137.196])
        by smtp.gmail.com with ESMTPSA id k27-20020aa79d1b000000b005059ad6b943sm2212434pfp.166.2022.04.09.04.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 04:43:33 -0700 (PDT)
Message-ID: <62517165.1c69fb81.10b46.553d@mx.google.com>
Date:   Sat, 09 Apr 2022 04:43:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2201109835122149461=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jakob@hilmer.dk
Subject: RE: adapter: Fix check of DISCOVERABLE setting
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220409100130.9743-2-jakob@hilmer.dk>
References: <20220409100130.9743-2-jakob@hilmer.dk>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2201109835122149461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=630676

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.45 seconds
Prep - Setup ELL              PASS      51.55 seconds
Build - Prep                  PASS      0.63 seconds
Build - Configure             PASS      10.14 seconds
Build - Make                  PASS      1804.83 seconds
Make Check                    PASS      13.03 seconds
Make Check w/Valgrind         PASS      543.20 seconds
Make Distcheck                PASS      281.40 seconds
Build w/ext ELL - Configure   PASS      10.09 seconds
Build w/ext ELL - Make        PASS      1793.76 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============2201109835122149461==--
