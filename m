Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09990C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 23:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiFNX5b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 19:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiFNX53 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 19:57:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D802DC
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 16:57:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d123so11054143iof.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 16:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6fliBuTpe343Dll7hYjwXImUB9c34AME6Lb07FBV8io=;
        b=RAeEw4aQjl9azed4BvSrV00Ew3fR/PVlj5rBbE1SUZLwkOQk8ZqeTlEfDjh4fOKPaf
         q9BZjdm7L/X8dqswdWW0wGr33TAGykcgd00OyfCS91RIwTqNgoc6EyvWG3XZ55WCgrfz
         JfcybI0nFjikAFdXfFJ6GLAxq4yKKHp2cFODKomKpOeHD8MZid/6Pq9ewlylXtayoUDq
         LcuLXP6oFfP1Lg501JKet3KbUV2pTEmroCV+GQCZC9vmcum3BqFF5F4ofKXKL7RnV7UI
         24/VnuEKYzL1NN94lv+p05mfTg00b8xQObQQ30Fk2xxaAADhI5qIk7n3JXy8MxHb98NC
         xEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6fliBuTpe343Dll7hYjwXImUB9c34AME6Lb07FBV8io=;
        b=7xL0Vq1ZHFfQ/LYCpcGRa9petBnKZw+l+uWQaH6/NWZEc4EVuzLiHX++oWIUz+iqaS
         Nr+BQsa/SqFb2uLhRrG4MOZ+qmownxB2G3IX0gM7lZcg77CTBNcALdHgQiXWb+eBoPcT
         XQ6SfHNLGud9Hc7gURnuX/4SDKwchzF0rdoP6AQPH7pnbEXhDDeQLTiLVEo1mzg/wvui
         NMaGzF9VVNC5Y9govsQpSlQ2vLZDbIwCU1Sl6voCaEOdmMBCG10++g1Ngm6c+VK2breq
         3MoHGl8ilN+/IqUKoy4kxfQjmjJ/IesrBZkLlbTCl/tWSwu7FUU5eDNWod0dEfa6WFq/
         SJhw==
X-Gm-Message-State: AOAM533n0+wJ1Qf3iAhp81SmLP67Ot7sDQ1HnQhbx6sDojyJLjfwANHG
        brTU7UZrPd8FezagbVaElX6KGSWrKeU=
X-Google-Smtp-Source: ABdhPJy18hT9pzCp1URW9I/hkYTq31bwC1xWrhBOKAoZImIrQsebVUY+vteorGeMyWOXegGsHGH51Q==
X-Received: by 2002:a05:6638:238c:b0:333:ebba:879d with SMTP id q12-20020a056638238c00b00333ebba879dmr4329289jat.36.1655251045619;
        Tue, 14 Jun 2022 16:57:25 -0700 (PDT)
Received: from [172.17.0.2] ([104.208.24.14])
        by smtp.gmail.com with ESMTPSA id g11-20020a02b70b000000b003318614511bsm5424218jam.161.2022.06.14.16.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 16:57:25 -0700 (PDT)
Message-ID: <62a92065.1c69fb81.f862c.6307@mx.google.com>
Date:   Tue, 14 Jun 2022 16:57:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7239504280235197298=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] main.conf: Split Kernel Experimental UUIDs from Experimental
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220614215609.596687-1-luiz.dentz@gmail.com>
References: <20220614215609.596687-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7239504280235197298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650352

---Test result---

Test Summary:
CheckPatch                    PASS      2.32 seconds
GitLint                       PASS      1.58 seconds
Prep - Setup ELL              PASS      41.64 seconds
Build - Prep                  PASS      0.59 seconds
Build - Configure             PASS      8.10 seconds
Build - Make                  PASS      1198.21 seconds
Make Check                    PASS      11.70 seconds
Make Check w/Valgrind         PASS      441.76 seconds
Make Distcheck                PASS      228.39 seconds
Build w/ext ELL - Configure   PASS      8.13 seconds
Build w/ext ELL - Make        PASS      1183.39 seconds
Incremental Build with patchesPASS      2414.49 seconds



---
Regards,
Linux Bluetooth


--===============7239504280235197298==--
