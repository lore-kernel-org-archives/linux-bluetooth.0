Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B01C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 12:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiI2MSU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiI2MSS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 08:18:18 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67199128A10
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 05:18:18 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d82so1275080pfd.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 05:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=7KA+vb3ZPKImTRT1uNmpOkER0qziNNTwNkHKutNfAoI=;
        b=DglFdOJw4ODWR1XZKgkGBv0Gy/xDi36ZaAK9aTZKUhOpGqzqPFcWTLlCOCvlyvzsyb
         16ns4N7qLlZdOAW8JKNDp+Ro47z/rC9qI5IMwqlQEr1zS3NNV632MJBsLLVNOnLPFi+k
         8Wz2hA1kUhc47SeuNqjQpHVAZ7KWLgjY4dw6gpc00gqqYOGXhYmf6bg98pU0vjQIpGuT
         Vzkk+pGAhtZ1bOibfUTdljQWQHNuFnotNacjJBZ/JUWtdq7MPoe+pm4KbrxhsOcWWP++
         bitjpnAm/YVEXmixdC0D+a8Km9GCQ8BawVf6MnrhKAOzv8lQmHp77cgy99PhrEurMez9
         a6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=7KA+vb3ZPKImTRT1uNmpOkER0qziNNTwNkHKutNfAoI=;
        b=gEzQy01foVgpHQOgPHPp6aEuxQ2qx7FxdOJw2jDLSAJ9l93XHnXqTCgpkQhPZPfJMn
         Rg4dtkiZlN/8T1JlO0wq2hkRrxokuLkU5eIlojl8V0XgAYUo7TY06pax5M+IxIibSUwd
         VDvI2j9NmNvn0RfUDngqNkQ3ZWrW/tLoam0noyhq4w2pBdynrSkxaEtwmFPD7Q9pQD2j
         dD31oHFq8HfzO4n7HYT71WlnAgf6mJ03QZGca379Ht/4axXdrfH0FjNsTSJJw2jtKtos
         FtYimscIOUWmuhfqtHEN5IT4l6Ne5xWRi2Lf14N37ys36uEw+tHCybOak0nQAwKJ4S9c
         Wv5A==
X-Gm-Message-State: ACrzQf0HRhhKBTtTxt3RxAsStEaWNon/UDGsO9mcc7XgCc/MgFNcH20s
        fTbHmZBhFVsY9DSOfpNhVAtTyG28D2w=
X-Google-Smtp-Source: AMsMyM73icqbhbAtNZchqxwt5a8ljRy7rly4YEZKvEFaP/XmgBrBM4KTAx0LjXJqtP3odjaxRKSl8Q==
X-Received: by 2002:a63:87c2:0:b0:43c:a09d:1a60 with SMTP id i185-20020a6387c2000000b0043ca09d1a60mr2798321pge.292.1664453897557;
        Thu, 29 Sep 2022 05:18:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.113.185])
        by smtp.gmail.com with ESMTPSA id i1-20020aa796e1000000b00540c3b6f32fsm5922060pfq.49.2022.09.29.05.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 05:18:17 -0700 (PDT)
Message-ID: <63358d09.a70a0220.3af7e.a2f9@mx.google.com>
Date:   Thu, 29 Sep 2022 05:18:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4342506818214397955=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, isak.westin@loytec.com
Subject: RE: Mesh: Fix IV update and KeyRefresh procedures
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220929110344.26130-2-isak.westin@loytec.com>
References: <20220929110344.26130-2-isak.westin@loytec.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4342506818214397955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=681871

---Test result---

Test Summary:
CheckPatch                    PASS      2.64 seconds
GitLint                       PASS      1.80 seconds
Prep - Setup ELL              PASS      31.47 seconds
Build - Prep                  PASS      0.79 seconds
Build - Configure             PASS      9.77 seconds
Build - Make                  PASS      1043.24 seconds
Make Check                    PASS      12.14 seconds
Make Check w/Valgrind         PASS      339.70 seconds
Make Distcheck                PASS      276.83 seconds
Build w/ext ELL - Configure   PASS      9.53 seconds
Build w/ext ELL - Make        PASS      102.83 seconds
Incremental Build w/ patches  PASS      483.15 seconds
Scan Build                    PASS      617.89 seconds



---
Regards,
Linux Bluetooth


--===============4342506818214397955==--
