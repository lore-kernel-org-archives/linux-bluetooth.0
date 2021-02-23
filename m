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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27DDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9290164E31
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 19:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhBWTJv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhBWTJr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 14:09:47 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D482C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 11:09:07 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id p21so12974028pgl.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 11:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bcOtQDtrOA4JVpMZPj448GSJmQCQVt5eCknACsWMe1k=;
        b=SykVyx4t/N1uKZVjUgr5D/Fr1aSj71Lk9i29hX+G36hHqeEWpyha/Sch/J6WrbamYP
         kjvGPaQyO5fCPoZMtzMMFX+TNtEo4c0aeoPG6U0YMFQuIVlRtp4PsxXlr9JLyNNwpn7/
         Gy+/DypXEj1KAA8ldiNCs7Ggip9hn46gvF4O+FvOcfTEFGmfU/GI7M8Ps+OVXwS4TIZF
         Sv6U7jpbZHWh0SFO9wa69uS+eiWeH+ZTDJSIItibY84PwNC+AZICiIXI0ZQqqTNYkDvr
         I6592gQW1EQEB/osDYnHvi2WOolruP5go1k9rsrMiCtHVxxRQrfVt7pBkK+OxsIuwFMh
         wmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bcOtQDtrOA4JVpMZPj448GSJmQCQVt5eCknACsWMe1k=;
        b=s8maqX5r/r/8B3YnZD1QzqHLnn7UPfPj9FALMYkbupDFXCWwUcm/nw6Qkip2lj5QnC
         mpk+woyw5P/VBqhXJ0bjy9DhgGuGdGUqlhxlSAPbdrz622/qcNKmLn2iJ67tWPJihjyk
         ngLTLGf5ZE86WwNpmJiV6y7WLaFU+RLqnJCD6u4W98cu0kVHKhV3WqRhqaW5V543vZ9P
         vqAhLt86d+EsokxEeOQjcLVHVGDh5mfoeBnyQkBGtqXOAClKbls649I6gT0bT2zMxfrZ
         BxnuVnDacGFl9wzH7WTFi2IEU5ub8rwhuJtLyJFSUQCNrtebwZoZLURGmzJdcxkqucIl
         cugg==
X-Gm-Message-State: AOAM531pXzO0N3JsR5JOW6FJbG0J5XYX2jj52cgKNSl1xQ37rTIUuTS8
        dLhmq5PJvEd/SXIpfNDIkk3l+TtkHsI=
X-Google-Smtp-Source: ABdhPJzWusOWl1jxzAlqnzbFSJo6aQ0+RTVOvfNYdkrCl7HxEBMuBnKtYmOhwMYxuiQMucY4sc8XsA==
X-Received: by 2002:a05:6a00:1a08:b029:1cd:404e:a70c with SMTP id g8-20020a056a001a08b02901cd404ea70cmr28118131pfv.33.1614107346875;
        Tue, 23 Feb 2021 11:09:06 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x12sm24478391pfp.214.2021.02.23.11.09.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:09:06 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] monitor: Fix handling of BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED
Date:   Tue, 23 Feb 2021 11:09:04 -0800
Message-Id: <20210223190904.1718994-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210223190904.1718994-1-luiz.dentz@gmail.com>
References: <20210223190904.1718994-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the missing fields for BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED
event.
---
 monitor/bt.h     | 6 ++++++
 monitor/packet.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 394dd7a2d..a77a2ee60 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3554,6 +3554,12 @@ struct bt_hci_evt_le_big_sync_estabilished {
 	uint8_t  status;
 	uint8_t  big_id;
 	uint8_t  latency[3];
+	uint8_t  nse;
+	uint8_t  bn;
+	uint8_t  pto;
+	uint8_t  irc;
+	uint16_t max_pdu;
+	uint16_t interval;
 	uint8_t  num_bis;
 	uint16_t handle[0];
 } __attribute__ ((packed));
diff --git a/monitor/packet.c b/monitor/packet.c
index 55ba16ccc..c07676253 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10600,6 +10600,12 @@ static void le_big_sync_estabilished_evt(const void *data, uint8_t size)
 	print_status(evt->status);
 	print_field("BIG ID: 0x%2.2x", evt->big_id);
 	print_usec_interval("Transport Latency", evt->latency);
+	print_field("NSE: %u", evt->nse);
+	print_field("BN: %u", evt->bn);
+	print_field("PTO: %u", evt->bn);
+	print_field("IRC: %u", evt->irc);
+	print_field("Maximum PDU: %u", evt->max_pdu);
+	print_slot_125("ISO Interval", evt->interval);
 	print_list(evt->handle, size, evt->num_bis, sizeof(*evt->handle),
 						print_bis_handle);
 }
-- 
2.29.2

