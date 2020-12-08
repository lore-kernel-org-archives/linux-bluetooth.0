Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99422C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 01:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5392F238E8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 01:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgLHBtA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 20:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgLHBtA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 20:49:00 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35739C061749
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 17:48:20 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id p12so10984735qtp.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 17:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=9IC/MJ/t5dM2rOQCb+YBniXB+RRfClJy6lJbR7rr6lo=;
        b=m5xZ5ymljVAAYhkcg+iPe/8BiV+OO0YOn5rM6kSMTGN9cQcG0NJD/Xj9qgYDpmV5aR
         UbXCH9fII6xgXrw30Xi+5dPzccrUJRk/GViT/BfqZJskqLhSlFOYA/I8GtS1t4OOPKMQ
         gydg5/6tCj850OmlblpfHJrVOLuoyy9veO1ga+9wMZGD9eACDe1gqGFUn1mEwqe6YQMN
         8MUKk3mMWcUxHUeWiLlKRBCbaw51Lyik7sjgSnknwkUV9Ro38X2yDfFyN0bfaiDjVUpX
         dfX6tLDf7ZHr8bzDhATMY/SHy3d9o5JStPjaZPVUmuq++sThe7a7ZxHLpraRa/LYHiIp
         6nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=9IC/MJ/t5dM2rOQCb+YBniXB+RRfClJy6lJbR7rr6lo=;
        b=FaeZ3iYC6AUS1DQR8Wk+2c2FXepbdZM7T5TlUMJbaOcp5yKoYAVrJoTl4AdfFX5WTU
         goHtu8g4hx0wWQdC+aFV1t/abSyw/s+0V77YM6aH4lt99F6M/a3qumkxAiT05v2kZmgS
         KuPFlPV2jG7GV4iu5Ytib9sGqOX8Bts7nUjsQ9RSfRI/AI69w0cSxAxi1oXo0oZBCdgP
         7KoHxFR0iQBOwGJdlme+/4sHnheyaqzF5nWLDFfKnTNvxHUtdTnDhGOsyzkPSucstMYA
         KGLuRJTuvpsqr5NXkZE8HirO60LKkbJ+Jl+TXWjCqJPsCi9QiMUzPyR9BQV6vvSTO/tR
         ZzuA==
X-Gm-Message-State: AOAM533cEPxYOq3/liYdCsot/9eABbwrDXrvR7r4elTb9CrhH8u2rdX6
        vIsSgxzutBZ7VaXpuk/qixx1x/1jQVMhkg==
X-Google-Smtp-Source: ABdhPJybt4ysASGSZLKvlyFEyNwMgeolrYjY4oIW7RTmJgTj+sFyddnCJ/q7fOB1mhzEi5CnaRvrvA==
X-Received: by 2002:ac8:5c0e:: with SMTP id i14mr26514778qti.328.1607392099189;
        Mon, 07 Dec 2020 17:48:19 -0800 (PST)
Received: from [172.17.0.2] ([20.44.106.121])
        by smtp.gmail.com with ESMTPSA id c2sm8065729qke.109.2020.12.07.17.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 17:48:18 -0800 (PST)
Message-ID: <5fcedb62.1c69fb81.84ef5.8db3@mx.google.com>
Date:   Mon, 07 Dec 2020 17:48:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1834006635260734638=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@chromium.org
Subject: RE: Bluetooth: Further improvements for suspend tasks
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201207161221.1.I94feef9a75a69b0d0c7038d975239ef3b1b93ee6@changeid>
References: <20201207161221.1.I94feef9a75a69b0d0c7038d975239ef3b1b93ee6@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1834006635260734638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=397879

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============1834006635260734638==--
