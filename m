Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DE8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 08:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiF3IhE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 04:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiF3IhC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 04:37:02 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DEC205F7
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 01:37:00 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id q4so28646328qvq.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 01:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=a67MMKc0cCaYJ0r07Ipb4KTN7jNCQeuGH8/jZqYO5RM=;
        b=MthkAjEnVYyH7NZW0aKffP+ZQ5gtAr/4VHHKF15QO9RP0/VoYNvYJzDRl2s0KrDR8g
         Cuj5teDM3Zuext79+hZ7iT40PyoyNGQGcEAjFkUjrAaxe/ia/dwI38XgRZbTqYbcDHev
         Y0BJG78kvb9x2lTzIi8srSRD5zNr8v0aUm3w53OlL9wToVCjfo+zpvUSuoEd4vrc3ad+
         RF8J8KNQttLiJV9CZfNISb8RbV9V9deor7z2hwBMRq2+76HumPKeC5vH/15iLBfYRI3l
         TPWBjQTIpq+WOd4U4DtD33zUHh6t9LyOc+YqKbl1cozFdWyklGwe/4XlDz3VPhDfNHDj
         U7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=a67MMKc0cCaYJ0r07Ipb4KTN7jNCQeuGH8/jZqYO5RM=;
        b=A53aDcYMQ8WMXlCPXh3ZwSDBdUQwiLSfedru+YJLB8pu3SFXThgQwFt0ryMHA6ePk3
         y+MhQgHIMtxyjXlmg01gsal/oflI7g8VPHgZfmRRIJhaTqsKhVb1Y/FA+Qq2yvfLbzTb
         U4yqPgRfOnGik9835hXMqZtG79S0UKSgLsVRfCi5Rc3smfZDbRocDqPTM4PMKCNX3qEj
         s+WbTAYSmNepNpaX9jngAReMlDKLkTHA0a75m7xIuLU0kIQ4JJC/UwaXRzW4Hi6E1IOX
         jXNFUuHfnq8z9zhsL/ubB+AoVBP0Lx1EVKiSKNv6L3t08sGZA2jMKsO84YY73DPtOTgd
         Sj0A==
X-Gm-Message-State: AJIora83K6UX+++ke2bgXjqsKjK9ioo91QTnL6aWT4JYPYXMxNFnfFfE
        E5lnfxyZz11DySmNuh17FdAbM3+HGICPNg==
X-Google-Smtp-Source: AGRyM1vk6lSSAEE0S8g/OOgTFtORujaS4nCZED43/iO+1ikzionYy9IbZcYky3W7cmEgxt4v/VSAmA==
X-Received: by 2002:ac8:5f10:0:b0:31d:2a6a:76d1 with SMTP id x16-20020ac85f10000000b0031d2a6a76d1mr2550287qta.317.1656578219829;
        Thu, 30 Jun 2022 01:36:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.203.97])
        by smtp.gmail.com with ESMTPSA id c190-20020ae9edc7000000b006a743b360bcsm14215274qkg.136.2022.06.30.01.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 01:36:59 -0700 (PDT)
Message-ID: <62bd60ab.1c69fb81.c8494.e6ab@mx.google.com>
Date:   Thu, 30 Jun 2022 01:36:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2480083096961125774=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, isak.westin@hotmail.com
Subject: RE: mesh: Use correct net_id in ctl_received
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <VI1PR09MB423902850B3FAEAAC0190EE3E3BA9@VI1PR09MB4239.eurprd09.prod.outlook.com>
References: <VI1PR09MB423902850B3FAEAAC0190EE3E3BA9@VI1PR09MB4239.eurprd09.prod.outlook.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2480083096961125774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655288

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
GitLint                       PASS      1.07 seconds
Prep - Setup ELL              PASS      42.45 seconds
Build - Prep                  PASS      0.67 seconds
Build - Configure             PASS      8.46 seconds
Build - Make                  PASS      1263.52 seconds
Make Check                    PASS      11.28 seconds
Make Check w/Valgrind         PASS      442.87 seconds
Make Distcheck                PASS      220.49 seconds
Build w/ext ELL - Configure   PASS      8.13 seconds
Build w/ext ELL - Make        PASS      1219.91 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============2480083096961125774==--
