Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676F2C00140
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Aug 2022 10:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242214AbiHHKV4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Aug 2022 06:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiHHKVy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Aug 2022 06:21:54 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6A21277F
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Aug 2022 03:21:53 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a2so6089670qkk.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Aug 2022 03:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=j3EmpJQepYYmOqqlMI/chczI0/IItcuUV+iTIaL4OXo=;
        b=dTfxjT70au9/G7EONkGrvg29iKw5QsD8qQkJruw/z6i366af0t7r7a5UjjPAnAMQvw
         DPFaun5QkjcnVLMdkaOjVDRDyZUwh405RaS5DqgXyO7+mACShb4ZbKeYaMld2PgQxb1S
         dbrE9lf8/C6x96otD1gTxGuUUox5FiOWbGe4maxZQMn2gILHritpgagtqlNccOCL0XtV
         nfSf1j+soQ3C9ozXK8i5oN7ioAf4bOxkiV3eTl7Q+JUgZqM1gttUTK6AKZV/Q7L/HFhA
         MrXIWvs595FEwho7Dj3CtVMgVQucUhAa8TgscY9vzTFhDXqPLvXJlG2APd941sSNj+xa
         oIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=j3EmpJQepYYmOqqlMI/chczI0/IItcuUV+iTIaL4OXo=;
        b=DNeBrNFUUJW1JG3RaV1u7TIxZwtopRdXfsnFssVmM24NezDmLmUQFWklq2jrklBzVc
         FlhrYdGcu7ttYoUJwQyEzghKmGqZZ12uraVgRZYi9r3b9/OAy3pEIMVFtEMmGVXLp+JY
         wW0QOHEIYSiCnThOjvjPN29eBd2onX8bux9o5U6ViRTuREN7s1cGsugDaCQmt//ti7cL
         /hgGXhrHAQ+yrvLaI1SbFtfmytK+pVi7+Rsyo+ufNMbFB/L68/Qjz9d92soNa6E2NK30
         o/NwTFp5lZi8SNpYioyY+VIhOa9EaGDzM5zqys7gUXBqxFAAe2Ubmd82pmR2IpfegKRK
         FZUw==
X-Gm-Message-State: ACgBeo0d5oEYaNXexIaubgGKHdtg5DvFU+R/MhLpvJ1FwphFXroiLKyb
        SKAWMNu3KpP7PNheHAy9NNgOFl7MTy3gNg==
X-Google-Smtp-Source: AA6agR7Tyf3FMgGv73DuQ7mhB9Jy3jJ7P+4V7869pT/kxEt1GlnZXkiL5WDHorqFMqPt6j4gfTTk2g==
X-Received: by 2002:a37:8d44:0:b0:6b5:d6b5:54ac with SMTP id p65-20020a378d44000000b006b5d6b554acmr13103135qkd.546.1659954112319;
        Mon, 08 Aug 2022 03:21:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.12.19.35])
        by smtp.gmail.com with ESMTPSA id s6-20020a05620a29c600b006b9576cd060sm1919992qkp.21.2022.08.08.03.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:21:52 -0700 (PDT)
Message-ID: <62f0e3c0.050a0220.c943a.30a7@mx.google.com>
Date:   Mon, 08 Aug 2022 03:21:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3567802322252562477=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ntrrgc@gmail.com
Subject: RE: [BlueZ] client: Fix uninitialized read in attribute handle
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220808092206.153221-1-ntrrgc@gmail.com>
References: <20220808092206.153221-1-ntrrgc@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3567802322252562477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=666005

---Test result---

Test Summary:
CheckPatch                    PASS      2.06 seconds
GitLint                       PASS      1.07 seconds
Prep - Setup ELL              PASS      29.52 seconds
Build - Prep                  PASS      0.83 seconds
Build - Configure             PASS      8.97 seconds
Build - Make                  PASS      879.44 seconds
Make Check                    PASS      12.32 seconds
Make Check w/Valgrind         PASS      288.51 seconds
Make Distcheck                PASS      241.98 seconds
Build w/ext ELL - Configure   PASS      8.85 seconds
Build w/ext ELL - Make        PASS      82.41 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      497.89 seconds



---
Regards,
Linux Bluetooth


--===============3567802322252562477==--
