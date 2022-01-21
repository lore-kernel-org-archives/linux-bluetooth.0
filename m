Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CDBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 23:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiAUXk1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 18:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiAUXkZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 18:40:25 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02473C06173B
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 15:40:25 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id q63so5836842pja.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jan 2022 15:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=QrmYYgskNVxe4+njed3Dyz6zUABTHTNn44jEf2IkdIo=;
        b=UuxmgrZ+81lfUI+Bu7WERnU+lc3uDRXDHpWBasko49Hm5n7HQSoP50jw6H/5G24lGr
         Lb3gAMxJ/MAMn86yIT/yOidhKP1Q1i39kFksdfnS+to1DgUDHC2MVEQ0WIH9MyHIE9Bb
         HiH4M05rUiqGCe1wnCjo9Dr+xfrYOpOLlADtFa7MGm6cpZIt+V8hCX+QTFi1th9P/iWv
         d7mkIq9KR4ONJqP/RXTwSh3nEay5wj7CVFKG7Y4WlCIhhbPb9sl7sDVDSsw4MLCDSxF4
         OCG729Gaq7zB2lN1oYSdrZ0arKxcUNaZsmdZiG9AAM23OQiXjnLr8wetr8si275jPRBp
         aDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=QrmYYgskNVxe4+njed3Dyz6zUABTHTNn44jEf2IkdIo=;
        b=lTLi/IvzaKRqaEUJlQTkwk1Za/AnHAXlihgZxoadwnQEA9Qr38oi3euqIpcfp20WNo
         jZ2ixdHMLsXcVI/qJjGZzwWJbTgePPxaJyke1Xt2TEA3r+BoQjybFOBC4bs8RUX6GMbn
         P/EfUcPUJ2mctIYtN3d92nfEmgEfi0mnc/Q9WSbSBPp2FkoyArRgNQjcI91VnFB88vYt
         tPhQx+dCgeGP1aPF801tBhmmfltpIW17Y7IYftBStnMN4RZw7zXjvs7qbnD1RYVg7Kmw
         1xRA5Oys1YHZjuifR699CSvh53be1YjY5aKeTeTJMl0KmQgK9XJ/w6KDWo+D/PNGoD8g
         9Q1g==
X-Gm-Message-State: AOAM5318DnVdduMmebvi9xQISm/hjj+XJpMDNm8gaZIhyNv8EJHGuEx+
        vTiwvKYbkNXgMXO0QjIE7JAe4lfDPI0=
X-Google-Smtp-Source: ABdhPJwgRZjUlwi/juFgY4nTBYu5JJ9mDS9lNWl1IlmHIXcrYnzVU+246jPCDeymz34zo8eJn6RZQw==
X-Received: by 2002:a17:90a:5d83:: with SMTP id t3mr2889041pji.159.1642808424248;
        Fri, 21 Jan 2022 15:40:24 -0800 (PST)
Received: from [172.17.0.2] ([52.137.64.229])
        by smtp.gmail.com with ESMTPSA id c5sm3025853pfc.12.2022.01.21.15.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 15:40:23 -0800 (PST)
Message-ID: <61eb4467.1c69fb81.d7452.7d3b@mx.google.com>
Date:   Fri, 21 Jan 2022 15:40:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3861990136881130459=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] shared/gatt-db: Introduce gatt_db_service_add_ccc
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220121205454.1413365-1-luiz.dentz@gmail.com>
References: <20220121205454.1413365-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3861990136881130459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=607383

---Test result---

Test Summary:
CheckPatch                    PASS      2.01 seconds
GitLint                       PASS      1.36 seconds
Prep - Setup ELL              PASS      38.22 seconds
Build - Prep                  PASS      0.41 seconds
Build - Configure             PASS      7.70 seconds
Build - Make                  PASS      1301.25 seconds
Make Check                    PASS      11.02 seconds
Make Check w/Valgrind         PASS      399.26 seconds
Make Distcheck                PASS      212.75 seconds
Build w/ext ELL - Configure   PASS      7.61 seconds
Build w/ext ELL - Make        PASS      1290.35 seconds
Incremental Build with patchesPASS      5245.61 seconds



---
Regards,
Linux Bluetooth


--===============3861990136881130459==--
