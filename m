Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323DEC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 05:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344804AbiFUF7j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 01:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbiFUF7c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 01:59:32 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E149220C6
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jun 2022 22:59:31 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id j10so10117oih.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jun 2022 22:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3Vsf3RGFHWXEYZaqcAqV/CnpmNdx66mZqeUvbavLKO8=;
        b=MF1j9hoGXrhIfB1TotBNYdvDwlZW6piiMDbadpPCFxp/PMqL+jUgR0zDdUozgesksl
         T5VLIHHpHxO9kRLtMZeACgT7jr07zL/chaUr8Dub9UT06Ph4LOzZFBgUn3f3FQ+gl5bb
         aSge/dtvl3ZDM80dyT7tRpIkJ8LdeUwVnHIU/GsFt0geN2UOXvd9O2y6xrgc0zX6NxXr
         XPi3UbCzr8x6uLfujNzJQ3pq9C8DpYp9lmccD5uz+crjlG4Qe8cx0vZuxZDCjcfeYCkj
         s+4RvtYSL1migZcvObz86Xrh0CcitqUuYXWl2CQBPqYcGcI+hNesy13VCuHQL8M8M99G
         0HSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3Vsf3RGFHWXEYZaqcAqV/CnpmNdx66mZqeUvbavLKO8=;
        b=Zt1AgDzA1INJJTnUQQ7ULIL9qURynNyNhiEk2sworck1+dqycfajoXpx1wGpyfBnOl
         S2l47/zL6w/mwhAt0VYril5APGJJhoFHkq44GAmU6wNMpGmuKLv3T33TNM3V/6WdKnBk
         GR2ETFLDOn/F+ZXpP4a2UH01qe8FAPnHEn0rrII3WjZzdGfNBqaY6slCx67m9XmJIzwO
         prmJXPF+fgYgHi2Cpxa+PF6VYDhpm2QbIqvSbEqFg5hMp8kX7R/bPS/AJa5z6PzNh6jo
         shZb/ETxlpp022Uwvj2KVWcXfa6A/1YorCABM4vmsGd5DqaeUzNA41gNRiHnDPqrumpI
         1V1g==
X-Gm-Message-State: AOAM530LW0LWh3+xnGe4FJQ2ntgcPexJJa9yEF5cUw+1tfyR3R49Yi63
        Y4IZ011S5zfKFbsE6/itFC/1e4MDoaZ+9w==
X-Google-Smtp-Source: ABdhPJxBcmXCc3cmcOeRQUaCXZ8jLY0CrfsHEM3Gbi8Y61k1ZIE5++piJBvR4uVSYkR7etWrt8qrFQ==
X-Received: by 2002:aca:da85:0:b0:32e:b063:2451 with SMTP id r127-20020acada85000000b0032eb0632451mr17190748oig.159.1655791170368;
        Mon, 20 Jun 2022 22:59:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.248.15])
        by smtp.gmail.com with ESMTPSA id 97-20020a9d04ea000000b0060c1798849dsm8868306otm.73.2022.06.20.22.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 22:59:30 -0700 (PDT)
Message-ID: <62b15e42.1c69fb81.f4b69.1a1e@mx.google.com>
Date:   Mon, 20 Jun 2022 22:59:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9157124559411884977=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zhaochengyi@uniontech.com
Subject: RE: avdtp: Free discover when send_request returns error
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220621043133.7720-2-zhaochengyi@uniontech.com>
References: <20220621043133.7720-2-zhaochengyi@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9157124559411884977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=652185

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       PASS      0.70 seconds
Prep - Setup ELL              PASS      49.02 seconds
Build - Prep                  PASS      0.69 seconds
Build - Configure             PASS      9.57 seconds
Build - Make                  PASS      1701.01 seconds
Make Check                    PASS      11.90 seconds
Make Check w/Valgrind         PASS      510.19 seconds
Make Distcheck                PASS      271.21 seconds
Build w/ext ELL - Configure   PASS      9.61 seconds
Build w/ext ELL - Make        PASS      1674.08 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============9157124559411884977==--
