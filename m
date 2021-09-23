Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5FEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 08:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3980561216
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 08:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbhIWIn3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Sep 2021 04:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbhIWIn2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Sep 2021 04:43:28 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6074C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 01:41:57 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r1so5433434qta.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IUBkcHaejs0yZhUvMbi5vNC3WTc9FKZzzNYi7dkAzmM=;
        b=ILXgsiCTl0qQ3WPSsdvVJ2doqVeWqC53r1xQ/7WPmi9YPzOVUVJAqA00upHOtB49Uo
         dGJwF2pHC0Fj4c6muChf6+yJ32BTyLx7kOJL1h67PMat9JY6C7n9PRIAemNwPmZzzOrR
         33qvBBzCT+aHWFIAqzpGbJhm1NQfeWbeg/Rf8uVM/5zlhbCldet7da6gg9SMxdJ08ZaX
         pQhY0/9eCNFSD00PtjsvrrqB81FIt5iXToNY7YVYrH3iaLQnZVmMipgAXTLqEKSG50mt
         E2J4I2gtYlO1YV0iOUZ8LrXUXsr9uyt948hkr9rAV+cMLL8HnvGaFJo+WgXBOt3gRd+8
         JdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IUBkcHaejs0yZhUvMbi5vNC3WTc9FKZzzNYi7dkAzmM=;
        b=GM5yhvXTKOVMKNEcIVCetbe3l4DoWIDcQSuZJqfpupnADg6/LaJJYJgDRwHIL2Hodz
         Ljiu2G8n7KMvxXFsCDcAuKZ6cWKQgAmTUmhgCTxkQFUc/sZMb3A4uSuJmp+Lytu6AB7B
         382J84JwhDj1ZGehfqBN6/DaEfN8p2jJcsEXwoEVXvwj+CF30FGOxauNgwRueuEkqSME
         9cV9HO3/1lRuWErgdPwVxUN0AMR1h0hmK3FNZ70lawqEqIKab1rFT/6Go7opUu9tEEE/
         6x3L3nahjYVnDJT31BNxRMqGuJ5yaQQRokEUH3DuKvc3k9bZdVS/8FmQxizc5RONdz4v
         eGEQ==
X-Gm-Message-State: AOAM531MuJjep7P71qpIigA3ZEaH4hXjnjN76ntGyku7ht3AYzfrepUm
        j+e4Ch0DF7BUMElXfRNncS+qlgIV9XBk0g==
X-Google-Smtp-Source: ABdhPJwuxdHq2USkwMW+okkXyNb8zZg5oWMr/2lVL3B15LRcrNBAJgSPEds1gLLLp++NYsL3Ja2wmA==
X-Received: by 2002:ac8:7765:: with SMTP id h5mr3456321qtu.328.1632386516625;
        Thu, 23 Sep 2021 01:41:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.123.150])
        by smtp.gmail.com with ESMTPSA id h2sm541431qkk.10.2021.09.23.01.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 01:41:56 -0700 (PDT)
Message-ID: <614c3dd4.1c69fb81.97ea4.30cf@mx.google.com>
Date:   Thu, 23 Sep 2021 01:41:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0503017727000306455=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez] device: Check both bearers's paired status upon removal of connection
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210923161816.Bluez.1.I2d4be6229452939310ccd165bc949c0f6708dd20@changeid>
References: <20210923161816.Bluez.1.I2d4be6229452939310ccd165bc949c0f6708dd20@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0503017727000306455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=551527

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       PASS      0.95 seconds
Prep - Setup ELL              PASS      52.48 seconds
Build - Prep                  PASS      0.47 seconds
Build - Configure             PASS      9.60 seconds
Build - Make                  PASS      221.38 seconds
Make Check                    PASS      10.32 seconds
Make Distcheck                PASS      263.71 seconds
Build w/ext ELL - Configure   PASS      9.62 seconds
Build w/ext ELL - Make        PASS      208.63 seconds



---
Regards,
Linux Bluetooth


--===============0503017727000306455==--
