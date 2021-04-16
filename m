Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB65C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DFB613C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 21:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344228AbhDPVVs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 17:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbhDPVSx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 17:18:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21821C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso15279218pjh.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IaP6gIlhGGnZpJ4dGsc+u+0E9N7C4OzApJiMiPzKla0=;
        b=mLR+mrUbiMBSaHYTI3mS68131m/Z3b75GwlCiqAJ6fbLs4gYDnCRaHlMD3ubKOkjjz
         gI9jIPnmNOwcwZUpXMmikkXWUKQG/qscPaiT+MIA2t69Rwh1Xm5up157NEEoJatHe78k
         IXCQP56iIn9TqoGoCZQsSBBRMyM7hIc9PeZ3xs75aGgB2GGDJBxqokDAQ5oJ7g4fcn3Z
         hwf5Wrv/vgL/QUFvkYikMHvynfWxUWN9qtl4MPn8NNZdjI95SmG+fep+X+vSWvPRli2E
         or88ymYp2DW8F9+hm4omauTWPQvLGjRQIcCWioQAVdjkBK+1U+J7HXhhhhB9IheQQS4t
         8oMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IaP6gIlhGGnZpJ4dGsc+u+0E9N7C4OzApJiMiPzKla0=;
        b=LFkQbtI/RftT5sO26J3W8kUEoOKEXsPz+hVC7kHwsG3l228CcVrEIc85R4REeoy1iu
         2PdAVApn9oKx8PGGe6dDfWNWtk/NGd6Xp2czd0FTH9kXOwJ8P/rwgz6NXaTJpnQFeZek
         eN9ERYXe8RTQ45VF/6RdgF/nIZT09H3lPYTTCMuWlHdF/3SKvVlWWe88guIAYNHASxgy
         0tnCpVWpg6bhqYke/DgOEamUg2FvgQZno46dzrLQ/+IdR99C+ON1U0P1NwD5A3J0dw5X
         bNUs3UT2MinDyo6RMK8ML62iuLqa8gDeVwmB99XL4Ux0W4mavd3AvVEfDuz9Lv+EqyTI
         2dcw==
X-Gm-Message-State: AOAM531CXXLVRSR8DXHndBCO6k/v0PyhrI4uqbiCFKIBg0fxp767VxcU
        AJwy1J6+j+p84tR4iG1MK+3WPXHbTx8HcQ==
X-Google-Smtp-Source: ABdhPJyIPXGAFiQ6IOuluajW02HV1L2i9U0uc21FIqi49sd23FPLjFHB9qlB/vY6rzDDyqOw+UarRw==
X-Received: by 2002:a17:902:9f94:b029:e9:68a3:8551 with SMTP id g20-20020a1709029f94b02900e968a38551mr10924152plq.35.1618607906443;
        Fri, 16 Apr 2021 14:18:26 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z29sm5829843pga.52.2021.04.16.14.18.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 14:18:25 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/10] Bluetooth: HCI: Use skb_pull to parse events
Date:   Fri, 16 Apr 2021 14:18:13 -0700
Message-Id: <20210416211823.3776677-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_event.c   | 1312 +++++++++++++++++++++++++++--------
 2 files changed, 1052 insertions(+), 319 deletions(-)

-- 
2.30.2

