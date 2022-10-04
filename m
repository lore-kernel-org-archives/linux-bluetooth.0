Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E167C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 00:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJDA0f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 20:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJDA0d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 20:26:33 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6763215700
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 17:26:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a26so2651141pfg.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Oct 2022 17:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=tGFaxaLOgON2C/8OIdnJ7Khk4e1F56wlK8Pr6wedxRU=;
        b=Zv2zyJf17gP7ceWVDtfIqDY3OW2Vy3iehggzIwNBggOCGlYxWQhC2WKMftG1jW5snR
         T7NJWRUUawN7KOHQlRmFqEkO0GLKOO3m1Z7565ZJX1lZPgb5k8/mnX7sxw152iwoOU0T
         jXsehTpgyzpdRrkzpJZvA19MbyWG7psY4hXC5TFMI4J0z6Vxr3nnY+Yj8JRC8TDjxAuW
         npPthVCnnolF2JvMhC6f2J+rOaXJgHugJEOGqDJO3wABJ7hGFOc+O+p2QPBPBKUIqtCD
         PrSsHKCsSDlVxHh8N7eBt3PgpZap450dJjjm14Tug729oU5Xu5WixQXVNfOWk1tPI3oA
         d/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=tGFaxaLOgON2C/8OIdnJ7Khk4e1F56wlK8Pr6wedxRU=;
        b=FkrcNsUReNKtHPoT+XuXtLWrN/dkHEjhhG+hgtUN58TDlC835E8gFTARJOfyLrjKEb
         5BSqg4uBDODkhaAshil8n9a4AY1cdDageaK10hWZuAaiT3e9iDVvb2r1Jmdf6+juybwu
         I/m3SKkFEIPtyKcP+JRP8E2CUO9MF3WknuSzBfz29Ii4hrI4jtM+NZjAuV0RgJpuc7YP
         1Mfga+XoZsJRkpxUwNUVRSZhdwT/yB5ouULWkhj9VHckR3zYZx1AbCuitAaxwnC/0vHF
         mxkL6p+INNSIxkpft4PEmgzi6l8y1SgptfKDYC1K/O/qEoJbUvizWnqOG4vCvAh0kkgR
         YqMQ==
X-Gm-Message-State: ACrzQf02x7DjXQJ1dakw7dqaFv3Lm5r8Uac6Nb4i/Xa97Tt/ZcBleqwC
        aTu9YjyWbCcPVuT4qHAiknZO+J7EVVg=
X-Google-Smtp-Source: AMsMyM5CqCcGTcmjz3RVoO+7ORTF4dCs0SJ30D3wMDYMKA/11/yYihf3oHWfC9xAd9470F0pU6cEfw==
X-Received: by 2002:aa7:88c7:0:b0:542:3229:8d11 with SMTP id k7-20020aa788c7000000b0054232298d11mr24975854pff.41.1664843191419;
        Mon, 03 Oct 2022 17:26:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.148.155])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ab8d00b001782aab6318sm7784829plr.68.2022.10.03.17.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 17:26:30 -0700 (PDT)
Message-ID: <633b7db6.170a0220.cb742.d2e4@mx.google.com>
Date:   Mon, 03 Oct 2022 17:26:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0787597908217668457=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] build: Deprecate meshctl tool
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221003230642.164327-1-inga.stotland@intel.com>
References: <20221003230642.164327-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0787597908217668457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=682871

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.51 seconds
Prep - Setup ELL              PASS      34.38 seconds
Build - Prep                  PASS      0.87 seconds
Build - Configure             PASS      10.92 seconds
Build - Make                  PASS      1221.48 seconds
Make Check                    PASS      12.43 seconds
Make Check w/Valgrind         PASS      371.68 seconds
Make Distcheck                PASS      317.23 seconds
Build w/ext ELL - Configure   PASS      11.13 seconds
Build w/ext ELL - Make        PASS      115.12 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      799.02 seconds



---
Regards,
Linux Bluetooth


--===============0787597908217668457==--
