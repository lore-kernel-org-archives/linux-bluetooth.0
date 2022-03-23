Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A39BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 06:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbiCWGtL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 02:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiCWGtK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 02:49:10 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EF670CF0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 23:47:41 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id t19so451507qtc.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 23:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=yViYbfhpYkPrrmci0+v/URRWTk9NFf9WYr9k7gnnUak=;
        b=CmMuO2/YJ0rJ0y0z3Ii13g9aOKvXMWiFFJaqagZH49Id6ZbonHKWs1bG89E7qHQw84
         7OTZRffrDL65hmHMO2CW07inQjzdgC4mCwDadj8jLzsd4jacOKJ7Bnl7g97ob9OWXgGp
         T5egcjY7i5esmqDKvxQLs+OU1PSYfnHV2YJJseoEkrCmuH0wSpcCSIJzjU5TpPca3V1t
         RGfAA0dStJOGo5YDYLKc0Mx3KP8ABxQ1N6ji7a6bo8G3vUPJ93yBwaU+0vo6rMUplo44
         +jNWN0a3K9IBd4x9SLkJRv0gL7tuPZnQOj4cIr1uq2Bunk25DnoMoRyt1lkk14tKcg78
         aXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=yViYbfhpYkPrrmci0+v/URRWTk9NFf9WYr9k7gnnUak=;
        b=KKVMGUMr87db3w2hRZ4vi0bFI9orD9tHmic+D4vtWbl2eYiA34iUTlo/g4M7b3/uYA
         FTWVsRLqPYKRQsqKlljPi/HUWskefuzsFS4vBZfi829boZyplrkYnt8ac3qsijzOSBrW
         aB4HyS6OTPWLLbi9q58ZW6udS64TX1zZ1rW9v4UjprZTXAiyT3dVVua+zwjOMa5VZ+GV
         9EeOL8GJP6p5+OWcVueuG9yqGWZS7wliPKZKwke1PEu0GrJmsv16fVqUcnB1HDDqVNEf
         9O+v8oe0DFxdpD3kpUd6IpedkWcKIFccJBPiTlKr6VTkOUaunzO8OtNql+DHuxF3wlwl
         1bLw==
X-Gm-Message-State: AOAM533egmxH8JncMrWtdEYDcrLPJFUBS+XP2szNUIcgzoP0QGyvCEwN
        di1dxG7m8Igqa6FEvHhK4953GY7d4Jw0oA==
X-Google-Smtp-Source: ABdhPJzrWPghaOHrG4PFHVRUlnxqdSXHc4ClDimSV+pA9i5k6B/PFXvFmxQdGefoqq1OOXGr13oGjw==
X-Received: by 2002:a05:622a:18a5:b0:2e1:920b:8b92 with SMTP id v37-20020a05622a18a500b002e1920b8b92mr22473855qtc.559.1648018060876;
        Tue, 22 Mar 2022 23:47:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.230.15.117])
        by smtp.gmail.com with ESMTPSA id n7-20020a05622a040700b002e1b8be0985sm14785456qtx.35.2022.03.22.23.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 23:47:40 -0700 (PDT)
Message-ID: <623ac28c.1c69fb81.35df6.ec11@mx.google.com>
Date:   Tue, 22 Mar 2022 23:47:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2171993096974048555=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangxinpeng@uniontech.com
Subject: RE: obexd: Fix can't receive small files sent by windows
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220323052149.28674-1-wangxinpeng@uniontech.com>
References: <20220323052149.28674-1-wangxinpeng@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2171993096974048555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=625643

---Test result---

Test Summary:
CheckPatch                    PASS      1.48 seconds
GitLint                       PASS      0.92 seconds
Prep - Setup ELL              PASS      52.57 seconds
Build - Prep                  PASS      0.81 seconds
Build - Configure             PASS      10.33 seconds
Build - Make                  PASS      1493.17 seconds
Make Check                    PASS      12.78 seconds
Make Check w/Valgrind         PASS      538.63 seconds
Make Distcheck                PASS      280.99 seconds
Build w/ext ELL - Configure   PASS      10.66 seconds
Build w/ext ELL - Make        PASS      1479.03 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============2171993096974048555==--
