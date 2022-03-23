Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D73C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 23:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346131AbiCWXlF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346126AbiCWXlA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 19:41:00 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9194DC6C
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 16:39:29 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id f3so2495459qvz.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 16:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OmiBqg44RztiO5NAHPl9oI+858cBfTNZJkUL+kRNXWI=;
        b=keG06egt1a9qRjKuig0aYFNmosmj60Oht4+7jjrrFbFeWVQ1lJ4EC1UirBSSv3mhkG
         dU/j74tSvZc0W8J1sWkrzOv58HLlcLa7JCh27wkcM+4+z6RLBRNAbrUETBSs5+Dd6bLW
         hxSCB3kl8rfLf74QAW0ufTXtSbBEqVCw1rzMCXCiFi5ifwuTNEt1vwXK1/7jW8SwnlC/
         qr4BcuU2TlhkKLkykoXNWKhn4YlRFGiJUp3f1wEBGT1ScuafKE0tU5PQdaQjwsAvMz/o
         w4oqe5N26X3jkMJR2ouuJ2yOedz5NG/xaVpDzwudZPbCSdZOPt4QdvFgKa/Q2X6EZ4AA
         TIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OmiBqg44RztiO5NAHPl9oI+858cBfTNZJkUL+kRNXWI=;
        b=dcUQM2jWCR3vG90uPAnYHhG0zaZHG40hmTey0NBVBnMzy7w4oXX0UtQuHVskYkZJW8
         3vIoyDIG/KN9CiLfemc75Xw99xpJmSxE7SJPCEnOHloxyySFsUZYIbLx1Fgpj9qw5TwH
         mpQi7aNpZ3KV+2lGtwmoksgkW6cg88PUlKVB/3NrctzVB0VK6QyuHwKpgeEpDWNNFiHY
         rC6oMazzbn2fv4RN0/zIO+5nTGY5mJxSoK3PtJz3mHY5SBWGxhCkJxtIZ7zgNaw15PHB
         BjYGF02vtlTzzOXmzvz1Ca5Vc6qlbW/RCU0KVn1iuQSmQH8ozbmTqvO2JXh+max6TvTB
         UNow==
X-Gm-Message-State: AOAM5334DFEbuQxWXqs0eSdNL/s9Owxu/ANzjJ2OstPNsaFB2fvozCd3
        9pYvcI2Oir7dLuPKEvKtk5PgKS9p6sf20g==
X-Google-Smtp-Source: ABdhPJw/s3A/WttIZ7mCwlp9SvsUCr9bSvXALDLdEKXGyjaitUHHsNLKbSM0h87cK7zhM0hTVsnj2A==
X-Received: by 2002:a05:6214:242a:b0:441:1e13:5dcd with SMTP id gy10-20020a056214242a00b004411e135dcdmr2037049qvb.121.1648078768523;
        Wed, 23 Mar 2022 16:39:28 -0700 (PDT)
Received: from [172.17.0.2] ([40.114.12.104])
        by smtp.gmail.com with ESMTPSA id m4-20020ac85b04000000b002e1dcaed228sm1047476qtw.7.2022.03.23.16.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 16:39:28 -0700 (PDT)
Message-ID: <623bafb0.1c69fb81.caf17.82f9@mx.google.com>
Date:   Wed, 23 Mar 2022 16:39:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7318597250300641773=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v4,1/9] log: Don't log __FILE__ and __func__ with DBG_IDX
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220323224003.3736525-2-luiz.dentz@gmail.com>
References: <20220323224003.3736525-2-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7318597250300641773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=625873

---Test result---

Test Summary:
CheckPatch                    PASS      1.36 seconds
GitLint                       PASS      0.96 seconds
Prep - Setup ELL              PASS      42.81 seconds
Build - Prep                  PASS      0.72 seconds
Build - Configure             PASS      8.56 seconds
Build - Make                  PASS      1291.43 seconds
Make Check                    PASS      11.92 seconds
Make Check w/Valgrind         PASS      440.83 seconds
Make Distcheck                PASS      226.74 seconds
Build w/ext ELL - Configure   PASS      8.66 seconds
Build w/ext ELL - Make        PASS      1251.70 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============7318597250300641773==--
