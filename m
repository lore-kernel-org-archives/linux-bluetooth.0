Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B838AC04A95
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Oct 2022 04:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJVEuC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Oct 2022 00:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJVEuA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Oct 2022 00:50:00 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87458E97
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 21:49:57 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id g10so5416245oif.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 21:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SJxDTv98wzoURDxuMr6Wxhc8ZEa70x0WNxy3NL9w0BI=;
        b=JLgGJ5UQxMjYUDbaISCud5RAgRuZArECdGjTUK/FQh7qnegpw8W2bEGwS6k2E63aGo
         r5MryuwfnnyYez0QJ04jlGJoGy4rKaGDopQufOnI2hf4D9W6jqWmnZcCH6zPFvXFVhOW
         fgISDChoZ5OT0eo8secNuIUjFrG4rTa6p08M2pQBmgL1yxqmEiSmP4RIOtEY87eJPYdX
         fGALOQDgQviiUbj59NsuQtiJdeBZObAoLWAl4wd3clIpVGG4UoUDiTSgJ9Q3xHNEFDGz
         7KgyRqwupdsDeGnay9tQ1xVpgZK4LBFqZxErsGcOLAMODfISNGLIMBDvzY+GXhQRwgnb
         Xhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJxDTv98wzoURDxuMr6Wxhc8ZEa70x0WNxy3NL9w0BI=;
        b=R6Tj4G9No6CylS593jzSWAiBxUQwOCHufdQcFbbSQd+2PhJ2z6KqCXOdFXSfsAtJcr
         v41gfmUFGYdRNgy+Ss4IYomgQ7AOWqWnUc8Ai2KO9VoTc0xMPDvwkqUWz/X+Ja42SwdA
         I5q5FqqXKSxnlQ7bBC2JhoNsihZuOjiCQEP5z/ZF/UyJ8+kCf464nWq6Ul1Fl0WpFpoa
         AFdEpyPLYF4HE2It9Q/4Exb4zk3BAjtAock+pul7clrSTLY8A1OPw4C0Y32hzq0dndNg
         f6EsuelnKfx7Fdf3mUqnFlhkEszm9FBQe/YvakSCmMf0m4HKjGWBV4in4q9UB8RbQmm8
         IZAQ==
X-Gm-Message-State: ACrzQf0gGjXJi1sGzk0eCQCultjZvArMyom34pj8uOpMkk+MmUT6n+RB
        lisH6fQQ4dLneMat0+/k8M8XAaZoOkw=
X-Google-Smtp-Source: AMsMyM5EBdlex089mFkCn4ZWUBMRNf2x9i1oWMVL464jDaVRwz2woB46Kj2cQDtTLial/yLGK3DDJg==
X-Received: by 2002:a05:6808:1294:b0:355:3ddb:4dc0 with SMTP id a20-20020a056808129400b003553ddb4dc0mr11712336oiw.21.1666414197080;
        Fri, 21 Oct 2022 21:49:57 -0700 (PDT)
Received: from [172.17.0.2] ([13.65.102.21])
        by smtp.gmail.com with ESMTPSA id 123-20020aca0781000000b00354b7120d60sm1873239oih.52.2022.10.21.21.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 21:49:56 -0700 (PDT)
Message-ID: <63537674.ca0a0220.d6add.8fe5@mx.google.com>
Date:   Fri, 21 Oct 2022 21:49:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7299820192075589441=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, xiaokeqinhealth@126.com
Subject: RE: [BlueZ,1/1] monitor: Ellisys: Add iso packet support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221022031333.4333-1-xiaokeqinhealth@126.com>
References: <20221022031333.4333-1-xiaokeqinhealth@126.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7299820192075589441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=687755

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       PASS      0.71 seconds
Prep - Setup ELL              PASS      27.39 seconds
Build - Prep                  PASS      0.82 seconds
Build - Configure             PASS      8.49 seconds
Build - Make                  PASS      1010.70 seconds
Make Check                    PASS      11.85 seconds
Make Check w/Valgrind         PASS      298.46 seconds
Make Distcheck                PASS      260.13 seconds
Build w/ext ELL - Configure   PASS      9.76 seconds
Build w/ext ELL - Make        PASS      101.79 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      555.57 seconds



---
Regards,
Linux Bluetooth


--===============7299820192075589441==--
