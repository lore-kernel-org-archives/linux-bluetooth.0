Return-Path: <SRS0=SB5R=BN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1A0C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 23:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96544206F8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Aug 2020 23:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZaIbQVT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgHCX6R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgHCX6Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Aug 2020 19:58:16 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71C5C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2020 16:58:16 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y10so1308858plp.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Aug 2020 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rUZ3X/1bYQIGZFQNZhgcWGW3ZdRY5Mhti8H9iXiM9lk=;
        b=ZaIbQVT0OomaOH01ot9u6k2tT1PDSsMQ3CCG8mgENXzzQPHa3w9Dk1QpAcdIywdQib
         r99FPVxztB2ZqU4W8m9EHdEkKNOcBZpRcO84FxX8+tDrlW5CX2vd4MTu9wNBdSbHGuyb
         ZouE+yOVfcJqTOn50MGlshHZqZrivHABic4yqiz2O4lmtPX9hXTePVHCFDGzkTXC/sn5
         Qho9/9kYOivChECaNfUDZ/h14nKuOVHbA3k+hxLP9DNJufTQWC9oROa8HuBm0J5Kd6Dx
         pPwCOj0H5OyJ4x6wsTVqUdtOylgdw+s1f6WtJ0QW3ccImb99ANm8dcpW2zP00lBsd/oY
         t/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rUZ3X/1bYQIGZFQNZhgcWGW3ZdRY5Mhti8H9iXiM9lk=;
        b=MFR1llBralqDKefbzjhzUGceVA3t7/tPgXP96WY55yUccuEEZUYmSfx3A+2YNQxLc3
         l2LrKjGiFgklixrfMCgp+JR/QYC0GT1RyyWRXYSod8gOc+us0sHCe5X4PtDbUKNfeRW+
         dNLMolrY7QCnxeDoxlxhoqkXjO48MYBD9LE3v7guyX05QOTEfl7sop/INKNIeYghbO9S
         AyOzOmn2ejkykt3aQ9u1QVkPVTWVqwQrENX0hmKGx+9gon62FVk0fibVOrukisS5uE/Q
         4nc0QXpK0oZSbKfp6oCj8zWXJ79L4aS9r/betp72AA/QXogDmEnhTCfTP/1kgbChKzNc
         QoCg==
X-Gm-Message-State: AOAM530Wzx03uzBUUju4mjCOUvy4sY5G6Km5PMlJiH/0LDdWb9ICjVQi
        hUaEW3ALTit7DDwcG3KHV25QqNeFd8C8sfK6HNTtsNZH9ixxE+T5o+W5YWLaKhIHz8wDy9YpTNx
        GqsbgrQ2WNvABCA39kiuX5k5UxecRyKX3VXM36v+HkHHkChnJUsRvHaQcmfc/Po8Av3poiFXHB7
        GL
X-Google-Smtp-Source: ABdhPJzBxgZDyH+WAccia3SJHZuVpF/2YhzWzTeeFfaUQRSJ1CZCItuMMzeggke8hYggT9k8zJLmK6DjM5/g
X-Received: by 2002:a62:206:: with SMTP id 6mr14329299pfc.228.1596499095904;
 Mon, 03 Aug 2020 16:58:15 -0700 (PDT)
Date:   Mon,  3 Aug 2020 16:58:10 -0700
Message-Id: <20200803235811.2441774-1-yudiliu@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [RFC PATCH v1 0/1] A client needs to query whether the Bluetooth
 adapter support WBS, so we
From:   Yu Liu <yudiliu@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Yu Liu <yudiliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

designed this new D-Bus API to provide a generic way to query the
adapter's capabilities. Initially this will only cover WBS capability,
but can be easily extended to support other capabilities.

Changes in v1:
- Initial change

Archie Pusaka (1):
  adapter - D-Bus API for querying the adapter's capability

 doc/adapter-api.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.28.0.163.g6104cc2f0b6-goog

