Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F98C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 06:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiFWGeS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jun 2022 02:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiFWGeR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jun 2022 02:34:17 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889D839146
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 23:34:16 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id q11so24100731oih.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 23:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lJuzOPaVbfy/55Jj0uhbcbGQjep7zPyz73SCSRt4rXU=;
        b=VKXIsKvSO37vrYHi0NaOPi6O4YtEqKYBF2WY6MiEYmfeWFPRrADjJTA9b4CpxDrSlf
         HKhlKNFOfv2XLJCJcYHyqGdr4GpWIfAySbA+LdZg8DQ1mbdxNJDhVQNL+Go+dlw5kvro
         21f4wz7GmXpXAHYp+IMUboPQRA4eModbdiZ+Ivx8lPPsCg0iKI4nsuaMzKxo8PFxeaKF
         Vl5blp8ge/NjwBcaN04yMlVaidlXERN6l49joTOZgiWHA8wORGn5l/a5O2JeM/FJ9YqU
         RzoRtezmzeKWRg1299n/GsjDsQp15eEAUgnywdpXzIwDdOx2d0XxD/2nZ8vrjOvzGTq5
         aKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lJuzOPaVbfy/55Jj0uhbcbGQjep7zPyz73SCSRt4rXU=;
        b=7bSm7zoP/rT/1ysdqeK1ZtWgGSpyCRms4lbLxKQrhuCTZcqPfGZs2Ycaj8P5TycOqK
         l6GcwGKtFrl8xIwLVJvNxTLpeEHReSzYo5gCZ9/jR/6qUv/2QFwrykQnlERxmS2J/mk8
         LVE2ldfCAHnpkWJCvohyj0GwpcJ03MBcITt9TuSQMGEZzojAqBYNhPui41o5o7nqRkKg
         4s0C+bWQO+zXhxz7ulf5PHujOXs8psfHDq0V/FQpI300t9ApY+CXKei6vC99yK98ye8M
         ypWw47CRzdQBVIRzoeQ0PIuxoP4KRW3dShiI3+9IcXs5eRJCpTxvC40ErFKeDFxheRH+
         ou5g==
X-Gm-Message-State: AJIora+6rjjJSmoUoK2A50zFszQOi0wTr7jXtGnW6JFWmewrf4OjE6he
        BWS7g/LkSTjlzvvYRzP54SqBqQni7CI=
X-Google-Smtp-Source: AGRyM1uHkSZGp6ShKZVKYxrbUHF2AIvoYYnrdmNkzszxqDR7Ewvbrty2pMZdtIUQlP0aZBkI9NTfAA==
X-Received: by 2002:a05:6808:1aa6:b0:335:1bd1:ebc6 with SMTP id bm38-20020a0568081aa600b003351bd1ebc6mr1378513oib.242.1655966055712;
        Wed, 22 Jun 2022 23:34:15 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.187.36])
        by smtp.gmail.com with ESMTPSA id d27-20020a056870d29b00b000f33ff285d8sm1275821oae.31.2022.06.22.23.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 23:34:15 -0700 (PDT)
Message-ID: <62b40967.1c69fb81.8c4a5.37e3@mx.google.com>
Date:   Wed, 22 Jun 2022 23:34:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4317286548027526480=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] mgmt-tester: Fix null dereference issue reported by scan-build
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220623044520.458626-1-hj.tedd.an@gmail.com>
References: <20220623044520.458626-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4317286548027526480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=653027

---Test result---

Test Summary:
CheckPatch                    PASS      1.04 seconds
GitLint                       PASS      0.74 seconds
Prep - Setup ELL              PASS      50.02 seconds
Build - Prep                  PASS      0.61 seconds
Build - Configure             PASS      9.94 seconds
Build - Make                  PASS      1476.84 seconds
Make Check                    PASS      12.26 seconds
Make Check w/Valgrind         PASS      531.33 seconds
Make Distcheck                PASS      274.83 seconds
Build w/ext ELL - Configure   PASS      10.00 seconds
Build w/ext ELL - Make        PASS      1453.92 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4317286548027526480==--
