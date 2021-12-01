Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B80C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 18:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352125AbhLAS6j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 13:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbhLAS6a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 13:58:30 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D88C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 10:55:08 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r5so24510576pgi.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Dec 2021 10:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=udrJx+Qh3tZxayN1NJvUCgIu4rLRnuuu2wiCQutY5qQ=;
        b=q6V7rAYZOa+luldq1gylSZ28jAbGiqMt+NNUCIup2I7kueGy3nl/5CS0Pa5h9UpwH8
         8gcDuKfVMKkIEQxR7QSSJ+7c62V9yrGe1Ng/X8HjBFReaYr5OXwBbW0ilaG9bVpNPngY
         L5QkyVEIMtl/Er9Q8F+e+fJ0W7u0Mvi0kcDMTaoJlSJ2+sU97TgVvlGaAPdOpH1DOJe9
         4YHLVpcx5zwJXjhSnv4PD+COWMWOcmTlPGOEedIMfJ2KXNng925/BBAyglxe6+8SF1SH
         RRFC45J7wekSr/CrDBOE80fqpC60R2qRwHHSeWO4oyLEovmy9Iimyvn13J42rxmlriSu
         BqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=udrJx+Qh3tZxayN1NJvUCgIu4rLRnuuu2wiCQutY5qQ=;
        b=BzoybHOHdlZlePaN0EZ0vT7qWHzHo0+qjgtC4slOOD5SrPrb+rpKPIt1zNOG3dDuN5
         b49QVcQB0Gk/RjyYbgDJbn2/RWCQeeI548rB+Y6KYg0T/fqcLfDEAj2M9ZAS+UYU1sUA
         B89Gxf9oJdt+EKL3ik9gFiqRxBqC07cvNYRD7fQ8xGb3RpbtWa/8giV2x89V8nqUg9Wa
         yzklUdB5Kg1TJMGtLopbku/Vl8xhnae9ZHv50fWNYP3wuvO+FEzJtc7mTU8qdoAnqb9E
         1GpMxYHLBkLis23FQ7FlVhtqPPW573bjyMf/nvFZYRcy9HQ6mpr7Rz9OgN0NJU79oWz7
         t85Q==
X-Gm-Message-State: AOAM533U7NI4PrVeMFUkVXvZEU1T2qKal15FFAkOIG7Rdw1RRL3CLNtj
        /l3g/aNCdpOxBEPbw05siHKgWZlITtc=
X-Google-Smtp-Source: ABdhPJxg+zgW2YSVp1rWc1+ISlq8SeJh5scBVqv0Fyq/QlsuY+lrEVYz6iLQaeXXc570wRWj4SJMpw==
X-Received: by 2002:a05:6a00:23c4:b0:49f:e054:84cb with SMTP id g4-20020a056a0023c400b0049fe05484cbmr7757047pfc.63.1638384907778;
        Wed, 01 Dec 2021 10:55:07 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e19sm359391pgt.49.2021.12.01.10.55.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:55:07 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 00/15] Rework parsing of HCI events
Date:   Wed,  1 Dec 2021 10:54:51 -0800
Message-Id: <20211201185506.1421186-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reworks the parsing of HCI events using skb_pull_data to check
event length, in addition to that it does introduce function tables to
handle events, LE subevents, Command Complete and Command Status which
simplify the callback by adding a common code that uses skb_pull_data
when parsing such events.

v2: Fix declaration of hci_event_func.

Luiz Augusto von Dentz (15):
  skbuff: introduce skb_pull_data
  Bluetooth: HCI: Use skb_pull_data to parse BR/EDR events
  Bluetooth: HCI: Use skb_pull_data to parse Command Complete event
  Bluetooth: HCI: Use skb_pull_data to parse Number of Complete Packets
    event
  Bluetooth: HCI: Use skb_pull_data to parse Inquiry Result event
  Bluetooth: HCI: Use skb_pull_data to parse Inquiry Result with RSSI
    event
  Bluetooth: HCI: Use skb_pull_data to parse Extended Inquiry Result
    event
  Bluetooth: HCI: Use skb_pull_data to parse LE Metaevents
  Bluetooth: HCI: Use skb_pull_data to parse LE Advertising Report event
  Bluetooth: HCI: Use skb_pull_data to parse LE Ext Advertising Report
    event
  Bluetooth: HCI: Use skb_pull_data to parse LE Direct Advertising
    Report event
  Bluetooth: hci_event: Use of a function table to handle HCI events
  Bluetooth: hci_event: Use of a function table to handle LE subevents
  Bluetooth: hci_event: Use of a function table to handle Command
    Complete
  Bluetooth: hci_event: Use of a function table to handle Command Status

 include/linux/skbuff.h      |    2 +
 include/net/bluetooth/hci.h |   59 +-
 net/bluetooth/hci_event.c   | 3031 +++++++++++++++++++----------------
 net/bluetooth/msft.c        |    2 +-
 net/bluetooth/msft.h        |    2 +-
 net/core/skbuff.c           |   23 +
 6 files changed, 1689 insertions(+), 1430 deletions(-)

-- 
2.33.1

