Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA198C433B4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8FA61246
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Apr 2021 17:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbhDSRNa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSRN3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Apr 2021 13:13:29 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BD0C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:12:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y32so24694489pga.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Apr 2021 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xquQ1QvV7IaCOLnkBNrLlpE89q642cuKrS632vg/GkI=;
        b=dSSOD95CrfxorlbRhH6KCc0gV0EGUtcABs/5omdu5+xVPqpw9c5/T9n+hqGMOw3XHa
         WCZwK/CrAPSvJoz/uI5ig7Ccx1e/ioo8k9L+BnCthx6L/Jd/oZ48nD/a9GpDfeRPt0f+
         5/vkHeJ2hUP/t57bdeEsKHCm9Bpbalg7/zGRJe/21YUDChA3COyi30JOl/2lF2OEa2ON
         BRhPe4G9+HawZnpjXTohrh/X7wXczGSKz/CnfcxGbEiSDGyUp6SOLtvmXKEY8yQqt3ow
         1nmX0MeI9L25gMw7R46by6PwiDHSCTNDSDa059oA++/spfFdy47v798yrGU8ELt0uy5p
         a4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xquQ1QvV7IaCOLnkBNrLlpE89q642cuKrS632vg/GkI=;
        b=G0LbO+ezu6wqQEmd9h38zxQrerB22D6E2CGSx9DwEl5ymq19UgLpTHWKE7UVcQyu3m
         z7TuuJvOVRBVneV6Hq6ov/kt1rXoCP24t54/ryt+MMlCn4JDQ/LficO6chEyzyAT+VsZ
         9vROF73JQ9s2CEhBPBXztuPjD2NtWPEZCNkHPPYDTwhFM9tiR7q7jufTNpfuJsBFq1tw
         N93bcEVUWfs9NWtiDup+OKDHE5Xtmmu6nvqZ9ZKox/phtNSqCkX7LYC59KJwDdprK/yG
         3bV9GmUdLpInJVndx4dSYnIBvYW7UX9uu77HKPKleNRzInNlZNSfRDMifto/E8IQFlMt
         mKSQ==
X-Gm-Message-State: AOAM532zt8ogg04OMi0EBz/2kZ5aa07BxQvSMhFGGFpyJYPA0F2qL9y+
        gOJaPvFi0QTz7Vd1AYf+yHT35uAtO6q3fQ==
X-Google-Smtp-Source: ABdhPJxkyo4iIuYm1KKM0fVVX1PHJql8Mkai2WgbyPc6hiL4jzque8PxNMK9ObNVs/7OE3JxmTKJHw==
X-Received: by 2002:a63:70e:: with SMTP id 14mr12697192pgh.202.1618852378575;
        Mon, 19 Apr 2021 10:12:58 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d71sm7669029pfd.83.2021.04.19.10.12.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 10:12:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 00/10] Bluetooth: HCI: Use skb_pull to parse events
Date:   Mon, 19 Apr 2021 10:12:47 -0700
Message-Id: <20210419171257.3865181-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set ensures events received have the minimum required length using
skb_pull to advance on packet, it also rework some of events to take
advantage flex_array_size for events that can have variable size.

This should fix issues found by szybot like:

[syzbot] KMSAN: uninit-value in hci_event_packet

v2: Fixes issues found by CI

Luiz Augusto von Dentz (10):
  Bluetooth: HCI: Use skb_pull to parse BR/EDR events
  Bluetooth: HCI: Use skb_pull to parse Command Complete event
  Bluetooth: HCI: Use skb_pull to parse Number of Complete Packets event
  Bluetooth: HCI: Use skb_pull to parse Inquiry Result event
  Bluetooth: HCI: Use skb_pull to parse Inquiry Result with RSSI event
  Bluetooth: HCI: Use skb_pull to parse Extended Inquiry Result event
  Bluetooth: HCI: Use skb_pull to parse LE Metaevents
  Bluetooth: HCI: Use skb_pull to parse LE Advertising Report event
  Bluetooth: HCI: Use skb_pull to parse LE Extended Advertising Report
    event
  Bluetooth: HCI: Use skb_pull to parse LE Direct Advertising Report
    event

 include/net/bluetooth/hci.h |   59 +-
 net/bluetooth/hci_event.c   | 1311 +++++++++++++++++++++++++++--------
 2 files changed, 1051 insertions(+), 319 deletions(-)

-- 
2.30.2

