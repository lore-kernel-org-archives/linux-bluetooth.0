Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708CEC001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 23:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjHIXAC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 19:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjHIXAB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 19:00:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2651FD2
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 16:00:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc6624623cso3540615ad.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 16:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691622000; x=1692226800;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=APvpg5ijkiJo9wS2UFhWC/su6kpw08piZMtsptGl5Fg=;
        b=SrJaQLllOmTdW/+2wJtTBW5MIQXSloD9I9djJb9t3slQylyAwUQ46Pb38S7qPUBfFb
         Na2ASe/PdlqMyTZ1KN08CAev65Pi2m5i68F+si233xRneMqbpz1vmYCysdDFWvUqJeah
         GVmqRtgHO8Y5RZ4Dg/JIo9mfyvaufVpGkj0U5HsMwClxE2MmjxTICPDNMbzopaYqqEFd
         gDn49YA+8twOz7Ys5sbV28pczq7jb1IWtapY+KrT2lAMPwhRprFYAyZQvVlj6XLXOjaf
         +SMFO0cXrJkWa84b9ihZkqAgpI32D2kneDjQQ48myIQGYlLIZ5T5NFJpuHKEoHD1ydas
         HWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691622000; x=1692226800;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APvpg5ijkiJo9wS2UFhWC/su6kpw08piZMtsptGl5Fg=;
        b=Sdy0CyPx+DkvdpU1QspH18Z19HcilZZXCBtTLY9FTTEO0+XP8LCnINaGYdDs2hHp9n
         GsMz5zDnb4oIaNqSY7WD4Pf8u5ubosDSNKokvzt2z6J+s2Uo2uyd4LmhzohnGAPUJF1g
         SbLAh7GO2SDNjmDmKwmKrzEYlp3l8q1Q7qajVDL4RGI51AT1vMJGAFnIEXYEevZgyL1b
         6cg+LHI4gKYHh35DDVCVTjcVSQBBVYPa/dvDPQTva1fT+iQoLIfRCjxfKZ0Pnk6z4YW3
         U9JP2ylYxzMVzyK/um2SZPQBzV4FiiWjUlQnGy2dVHUWogR3aiWfN27Ruurkuw7EWKjp
         fcvg==
X-Gm-Message-State: AOJu0YxayzvsQZSXMLTpPk/jf9WJRvBxk65HId6+QVqJtlc1j66tYb5j
        6FwLJJVmSGdCSDrKowty4pqbHjzxY2o=
X-Google-Smtp-Source: AGHT+IF70zG2qJ9QwuCiy8gWHRvyf5FfZM6dAnBh7yJW5GyC37XYh0yJxd7kcD8LcKZRk6Yd4KuawA==
X-Received: by 2002:a17:902:a98c:b0:1bb:a4e4:54b6 with SMTP id bh12-20020a170902a98c00b001bba4e454b6mr496047plb.62.1691622000306;
        Wed, 09 Aug 2023 16:00:00 -0700 (PDT)
Received: from [172.17.0.2] ([4.155.128.248])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b001b890b3bbb1sm63892plg.211.2023.08.09.15.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:00:00 -0700 (PDT)
Message-ID: <64d41a70.170a0220.3233.024b@mx.google.com>
Date:   Wed, 09 Aug 2023 16:00:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8863004565864390008=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bartphilips1@gmail.com
Subject: RE: fix writes to attributes of size 512
In-Reply-To: <20230809202724.15429-2-bart.philips@inspiro.nl>
References: <20230809202724.15429-2-bart.philips@inspiro.nl>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8863004565864390008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774683

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      35.08 seconds
BluezMake                     PASS      1243.06 seconds
MakeCheck                     PASS      13.84 seconds
MakeDistcheck                 PASS      204.06 seconds
CheckValgrind                 PASS      330.63 seconds
CheckSmatch                   WARNING   454.78 seconds
bluezmakeextell               PASS      135.61 seconds
IncrementalBuild              PASS      1067.75 seconds
ScanBuild                     PASS      1450.74 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:276:25: warning: Variable length array is used.src/shared/gatt-server.c:619:25: warning: Variable length array is used.src/shared/gatt-server.c:718:25: warning: Variable length array is used.src/shared/gatt-server.c:276:25: warning: Variable length array is used.src/shared/gatt-server.c:619:25: warning: Variable length array is used.src/shared/gatt-server.c:718:25: warning: Variable length array is used.src/shared/gatt-server.c:276:25: warning: Variable length array is used.src/shared/gatt-server.c:619:25: warning: Variable length array is used.src/shared/gatt-server.c:718:25: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============8863004565864390008==--
