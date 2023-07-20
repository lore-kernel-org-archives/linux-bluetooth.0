Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE34C001B0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jul 2023 02:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGTC1n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jul 2023 22:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGTC1m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jul 2023 22:27:42 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B6919BC
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 19:27:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b8a462e0b0so1781465ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jul 2023 19:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689820061; x=1690424861;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T3TyMU48Vr5t3ea0hymijoQ9ugxHyqXoB/GNC/gRcjE=;
        b=lZ3LdaMj0V+LNlWHi9WH2kp6577354COTUqieTSS9x0z+pT78VlUzAMzMeyIG/2Gnc
         vrB+FfeuBnLqT4Lg0CloyKuWwz+4pg7Lny0WEoNrXYJkeXs6Cr1rKl7lwW4OHmKAfgNz
         fN7obBWsstmNciuHplpCgwnPzkWb127sbaqeaNthCciwNMVbUgIO8zUFT5lX6cj0ymdF
         jQ3s5drTC8ewARTThEKjSuskewo9nG+Xe1pkLeegjrGXSQmqxkCmFl6Gl7Ylmj2j/q9H
         NZ6tgigvJoFuZv2qf52FKXsdxPYeirLKAsIakAoQx9qCo9TEO/l1zR59Gmne0N8SXiUK
         xZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689820061; x=1690424861;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3TyMU48Vr5t3ea0hymijoQ9ugxHyqXoB/GNC/gRcjE=;
        b=Lj+gdQiZQTNu2NAoocfwSSBx3FsIg0ygK5T4icI+MLcAK5JkgCLLjGThb+7qMAlmAj
         RpurVgfh3pvPEzemp8VuUMYq+LWQhms2mDuVfM1SFTdfSpe/cC2oLbeTooKTN/Iho1/y
         dyfPxgvZLPpnFtmi/s9VxAqhm8E/V1FOJkssoSkevphIrzbsgvemDrcCGGXOylidhTLF
         18hCLXN0L3OHC6ygvYV8c9nIYhvHSsWOj8wewMZ/FQdh79DG1L9MhP63+BwTXNsmb/6z
         J1NPmvNZHrRjrv5vgaSCSY9ExihCs+dczDfSP6v9gyk6C1t0QvtyxCqTlo/aEymtvijd
         ikcA==
X-Gm-Message-State: ABy/qLYptOhmSgSLPMhBNuq3hUC/AbngUTG+CznfKzSKBFjFd+uueps5
        VMTYt27Jz0rdZ9AVC/t8kxaer7aXBfQ=
X-Google-Smtp-Source: APBJJlEhurHZDdqnFs1gWe25f3hmr062FjCIzJv7Ha8tBfY/h5EDXS7BcF8akZy3yh1GHROB0Z+JeA==
X-Received: by 2002:a17:902:f681:b0:1b6:bced:1dc2 with SMTP id l1-20020a170902f68100b001b6bced1dc2mr4236679plg.0.1689820060566;
        Wed, 19 Jul 2023 19:27:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.133.129])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902d2c500b001bb0b1a93dfsm4686957plc.126.2023.07.19.19.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 19:27:39 -0700 (PDT)
Message-ID: <64b89b9b.170a0220.e3b15.aba7@mx.google.com>
Date:   Wed, 19 Jul 2023 19:27:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1448031739957187496=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v4,1/3] btmgmt: Add man page
In-Reply-To: <20230720002913.342733-1-luiz.dentz@gmail.com>
References: <20230720002913.342733-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1448031739957187496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=767584

---Test result---

Test Summary:
CheckPatch                    PASS      0.93 seconds
GitLint                       PASS      0.72 seconds
BuildEll                      PASS      26.98 seconds
BluezMake                     PASS      803.17 seconds
MakeCheck                     PASS      11.88 seconds
MakeDistcheck                 FAIL      72.98 seconds
CheckValgrind                 PASS      252.52 seconds
CheckSmatch                   PASS      341.19 seconds
bluezmakeextell               PASS      103.36 seconds
IncrementalBuild              PASS      2002.05 seconds
ScanBuild                     PASS      1045.57 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

make[2]: *** No rule to make target 'client/bluetoothctl-mgmt.1', needed by 'all-am'.  Stop.
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4536: all] Error 2
make: *** [Makefile:11795: distcheck] Error 1


---
Regards,
Linux Bluetooth


--===============1448031739957187496==--
