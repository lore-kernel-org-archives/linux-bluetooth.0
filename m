Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E10C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Oct 2022 00:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJHAKN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 20:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJHAKM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 20:10:12 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037BB46857
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 17:10:11 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r20so3264699ilt.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 17:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zIVZ8hyUjQGpKaCx4g0iEcVWQY765/9/8W10+GWIRgM=;
        b=SMRvHtMzg7gaz0bdu+dYugocyrqjJhARw4h+6s0a6MkWAHGJSNvSbRIgrTuIzSIKTp
         r8LzSK+UY3tuEm5Gd+Om6pYKOOJ/LhKL34wzhc0f6roCTcRvohZB2uYddNg3G2EoAha4
         xaS4lmPxgKL/Odtf3URQ7efbzEQi60JZTJR3YAGYmG5BkF9NIaPLq9tw5eduU0yM/+RE
         9ZXENyrqP1qtedD/yJ0++sv984D7xzuLp9pWCTEy/zEnqKiU/4FfZf6pBV/+AvLz2yBH
         Sd7tVd8yQZESRZJx5WTHM2gFDnjTCPp2T0nW2tKL5xS6nHTWwMvmtVb+Uq7eNCeFPhCU
         MYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zIVZ8hyUjQGpKaCx4g0iEcVWQY765/9/8W10+GWIRgM=;
        b=WiA7IYJJAcO4Lu2t31YZmNkhFGLuyd8Jfb16c1/J93pa694lN3kBVZRHmsYISJnrP7
         Ex54P0liuWzuis3TLwXooAo8wIpJfpCMIR470hHTfUZ+xnkvZ2X8fTg//pHeAz1uqL8x
         Gh59JBUVOmT80i4i7Q6nFmYneCmgTUr9WSQK6fP8fAEab0QInx7jNjG0aQ9AwKiWjAmH
         ujf1hutJu1oZXVSnpCLuiD/sIHfZAFYPkqsC5ykCpti66oBMmeDQlirDfFZb1fSVDe2m
         7pTu/sCBpfNoyDXOcaZnQhlkgILVFFIwqga22APrXe2zjWAl7uyEoWEcLvQXzBt6mJnI
         BedQ==
X-Gm-Message-State: ACrzQf0iYQqij/KTej4un1brgKUF8Z11pPppuv9oGXaTaaquiwkmhk2r
        dsgEHqlPRluKmAJv4qpSaD9Z0G1yJJU=
X-Google-Smtp-Source: AMsMyM5q1wwiHCIzZlpzGxy0zDc3Nr+mQnHmzg2P/WhxRDn7qDAfPxQLqNHMI/hyRzjMEtmi+jvogw==
X-Received: by 2002:a92:d686:0:b0:2fa:6226:6247 with SMTP id p6-20020a92d686000000b002fa62266247mr3708903iln.79.1665187810106;
        Fri, 07 Oct 2022 17:10:10 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.40.69])
        by smtp.gmail.com with ESMTPSA id l12-20020a92280c000000b002f611806ae9sm1366158ilf.60.2022.10.07.17.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 17:10:09 -0700 (PDT)
Message-ID: <6340bfe1.920a0220.a8770.19f7@mx.google.com>
Date:   Fri, 07 Oct 2022 17:10:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3242066050998083394=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] vhci: Add function to interact with force_static_address
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221007225527.1838767-1-luiz.dentz@gmail.com>
References: <20221007225527.1838767-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3242066050998083394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683837

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
GitLint                       PASS      0.76 seconds
Prep - Setup ELL              PASS      26.35 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      8.27 seconds
Build - Make                  PASS      743.03 seconds
Make Check                    PASS      11.88 seconds
Make Check w/Valgrind         PASS      288.41 seconds
Make Distcheck                PASS      235.27 seconds
Build w/ext ELL - Configure   PASS      8.28 seconds
Build w/ext ELL - Make        PASS      85.03 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      494.72 seconds



---
Regards,
Linux Bluetooth


--===============3242066050998083394==--
