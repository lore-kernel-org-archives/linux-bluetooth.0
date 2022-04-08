Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3367C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Apr 2022 03:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiDHDfp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Apr 2022 23:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiDHDfo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Apr 2022 23:35:44 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD012BEF
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Apr 2022 20:33:42 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id 10so9670419qtz.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Apr 2022 20:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=UaoGGc1xiVhsX7eqAmOBudNuAEp0feCkXF+OpFwZ5mM=;
        b=XWCCpYeGwoX2ajq2AFnaoM4kc3i+iV2n5T24QVXvezb7MzhLYBGXzmc2NX+EakwI2J
         hB0W1KH9tetra3s3p3Nvp9jQC+S3WqKMhBY8KdFwiMQTbczk2Dnd6qYn/GJb4U6oPltO
         ygQuJgKwwcdVcBs8dzVAGTYOQluz6d2yWiAIO8+4TP0eujk8X6pwdmSk9Ra6KLlA3cGe
         9YgPv+BRKGyTQYs45dvIXSFl1jiPyl4sXTKn3fzzrtCQZz+kEpObbZNCB/GSlq7WsKQj
         tdAMado4sCP/tohDvZe6swjc+2vl5JG3MXMrTVt/x/iFHrU6o1469G9ATdydYihq3E4Y
         sXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=UaoGGc1xiVhsX7eqAmOBudNuAEp0feCkXF+OpFwZ5mM=;
        b=AdDR9IR35ekZQrQyANP11+mhPHwuTuKfZrKepeehEmBywaQsetVSgGaCfI8JZR1OjK
         xH68czL5G92+SvYGxpV0XnPYxzGSQ4Ub+aNg3Gu8t9Z9rQbPe5ynsdF84J61OAK2WJ44
         hCRRdtgx6BupaIUUMBkvc5svyskfcYnLBXg5K2pmwYXWKvwIXrsTiNtQA3BsbvBvnGiQ
         +tXtJGCldudKP2F/b2fPG1WsRq8qLA0IAOgBdZUbR7d8LtF1JI41zLeoSGVYFyKsoQPd
         yKk9PLVM6bVDE9DDr3KI+BVVO6HUenKSERCElz2L+tOJddmM/B1ueMyVEYgDOITgaQkB
         iHLQ==
X-Gm-Message-State: AOAM5321/8DW6TPGMkYLcUwpTSnXQUuOJpHfkelxDVSDWyAlBFjQ+npg
        Vlk0xadggOzP5yFB85AXArLgfoQAHIDIig==
X-Google-Smtp-Source: ABdhPJx2fuZk2bsKtUJHzfLe56S4bnIRS6akUBY3Z8BQGKbpLFtlK7ehQI5OmK/lvuT45l80BOdf9g==
X-Received: by 2002:ac8:4f12:0:b0:2eb:de47:e30 with SMTP id b18-20020ac84f12000000b002ebde470e30mr2264205qte.193.1649388820997;
        Thu, 07 Apr 2022 20:33:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.150.3])
        by smtp.gmail.com with ESMTPSA id o27-20020a05620a111b00b0067d5f359007sm12122695qkk.23.2022.04.07.20.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 20:33:40 -0700 (PDT)
Message-ID: <624fad14.1c69fb81.2b333.d162@mx.google.com>
Date:   Thu, 07 Apr 2022 20:33:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2176159336167441354=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] shell: Fix not being able to auto complete submenus
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220407235949.2428708-1-luiz.dentz@gmail.com>
References: <20220407235949.2428708-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2176159336167441354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=630223

---Test result---

Test Summary:
CheckPatch                    PASS      2.86 seconds
GitLint                       PASS      1.92 seconds
Prep - Setup ELL              PASS      42.50 seconds
Build - Prep                  PASS      0.67 seconds
Build - Configure             PASS      8.50 seconds
Build - Make                  PASS      1238.33 seconds
Make Check                    PASS      11.68 seconds
Make Check w/Valgrind         PASS      437.83 seconds
Make Distcheck                PASS      225.68 seconds
Build w/ext ELL - Configure   PASS      8.59 seconds
Build w/ext ELL - Make        PASS      1239.81 seconds
Incremental Build with patchesPASS      2536.87 seconds



---
Regards,
Linux Bluetooth


--===============2176159336167441354==--
