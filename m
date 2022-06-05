Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855E3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jun 2022 14:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbiFEOVa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Jun 2022 10:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbiFEOV2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Jun 2022 10:21:28 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C1D4889F
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jun 2022 07:21:25 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id j2so8769579qvp.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jun 2022 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5rb1V9K0n9E+icb1CaQbnvv1HkmwsdjKly1i12KGywc=;
        b=HePcYgK+aPmdm83QnEQsElwAScLoJNxgd8wWF6/CA4SKcRiwO/1gcxqD1sJ0F8XVCN
         gMUKezAEYhov+Lz0yRQ7LkHVBRjh5Iz4knkS+bXQ59zdZrDh/Mc3gGWhx7mnfrLSLn4M
         nBZezpYFwh7IK6/MFXOBMLfYishuoIIlQZvTrfa+RsvGuXKblNbqLoMUjwjt7SZ830sm
         mZVezT88vc2o2GgnK66IRxTK/IGo5V+7gWz9/zo6gpI0dHcJq3QXRJLFB8pqac+NJTER
         GtyDBMfO5hm4paCyqXEshIyzZ+oqPxW+lSpMPravZsstzq+K4Vbu8S9rjJey0i2wFABk
         LDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5rb1V9K0n9E+icb1CaQbnvv1HkmwsdjKly1i12KGywc=;
        b=k02TgPmHO3E5p+BWKkt0fpMtxgNkftm5CsclEMOnwdxO/skz6uRb0DuefrF9mcQRct
         C7RjDtEAYXgIF9JkUjDI8Fdc40iDOKK4InASlhwOD6vI1O78yyU8VvvgDoq3sFMVxXAO
         muVUIj1H/WzFE9TwMVPR6oNe0HrslQea6WScQiM33oaGnUnVi1eRDgU5ApPQ6o9Zu/GT
         hlLi8obKrT8aS0lqe0LBzF7LPSi32uAuTWiwjAsFA8oY95IxBIEnWcvxNq0jKcSNwQaD
         NHl3X34tTwu0N0zv0BmIEu4aAvwXB9NeSsJwOG0qwoilNfFIS1Og50eOP2TiA9+ilP3/
         yv0g==
X-Gm-Message-State: AOAM531mMrWrlHGMf96RaUaC/vaCLKVpGVYHBHYBzClqVrwhR00I05oK
        GuzpnaupZDkAUlWUk6oNrmmnaljLSIg=
X-Google-Smtp-Source: ABdhPJx0ylZy1cCHEgGoExh7TPbNQFLvGEX8qrNKsH1kOBw/TA0Gg4IjUsL4haOEb/lQTzaqBC3hAA==
X-Received: by 2002:ad4:5447:0:b0:461:d7a7:f0ec with SMTP id h7-20020ad45447000000b00461d7a7f0ecmr69499348qvt.21.1654438884930;
        Sun, 05 Jun 2022 07:21:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.121.215.143])
        by smtp.gmail.com with ESMTPSA id w19-20020a05620a445300b006a6b794dbc0sm1178551qkp.87.2022.06.05.07.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 07:21:24 -0700 (PDT)
Message-ID: <629cbbe4.1c69fb81.c63d3.3037@mx.google.com>
Date:   Sun, 05 Jun 2022 07:21:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8327341362679233533=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] a2dp: disallow multiple SetConfiguration to same local SEP
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220605122927.110627-1-pav@iki.fi>
References: <20220605122927.110627-1-pav@iki.fi>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8327341362679233533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=647442

---Test result---

Test Summary:
CheckPatch                    PASS      2.91 seconds
GitLint                       PASS      1.84 seconds
Prep - Setup ELL              PASS      43.36 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      8.69 seconds
Build - Make                  PASS      1280.99 seconds
Make Check                    PASS      11.99 seconds
Make Check w/Valgrind         PASS      445.82 seconds
Make Distcheck                PASS      233.21 seconds
Build w/ext ELL - Configure   PASS      8.80 seconds
Build w/ext ELL - Make        PASS      1287.67 seconds
Incremental Build with patchesPASS      2641.51 seconds



---
Regards,
Linux Bluetooth


--===============8327341362679233533==--
