Return-Path: <SRS0=7F+K=5F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F482C4332B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E32320724
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Mar 2020 20:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDr09+qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgCTUkq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:40:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46925 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbgCTUkq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Mar 2020 16:40:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id c19so3877570pfo.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2020 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Lg7nkN4mkSlGzt343AERUU8DxSDQ1y02ISUsPdPcwHY=;
        b=JDr09+qgAwdLFj2T6sh0P+qQ8UbSUb5l50rRpYhaEZ88Q3waPqPUWPbxkzAvWkfbvn
         s4sdT18B247xW6aHOOAcQt2W7tWwBLZmDtUY//N8DdpBYFjlPRtmGKLUeCw7eHjmciGS
         RMFQPEuaen6UtI/qzAF97FrIAoDtnEypPq9JFKPYf+Dr7bqcRDNVftHjktIk6gKGqsv5
         YOhKO7WWtCjeOg6G2Z26zxEQeQPoX8K6uaqOEtIWeXVuPBhgTwxB+od2KIZ9Jq/oH0dw
         i/fcVmjBG78/4ddwJJEtPHmdeCAV9oRBx3U/PbtP51uQHtQ8cJB99PqoNP2fRCknSyt3
         c1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lg7nkN4mkSlGzt343AERUU8DxSDQ1y02ISUsPdPcwHY=;
        b=TgAdPnIjoRd7EDIltunZsHPBldYeq1PO6APvb/Jlq2DdC/2QyaD0Ynu6fCgLjhBpTC
         6r4FINZ9amMwmrEtBW1EYKbG5owwhbMR4l2QZO3uwCO/3AI50fz+qATYrA0SGDyZ1R4u
         AXsqvPT63n5SlUqt5m1O5nZo66rfH3JjNuESaXORkyXxlTbTtoU61fgeY6h65ogOna2D
         2VyIQb5jk1zlgsqktf0xd14oAt8GuSGxdtgodIxgNrg6SYSqSBlmriHPyAMb2WFd06lA
         KckdEPAPcsrCvDsPGxQnz2tnSTMiF6M0KGz9E11Gi0QOMCkWb0QZRUYwULXog8ukYpfX
         DXFw==
X-Gm-Message-State: ANhLgQ19/MwItUoxGy8g89ySUf3CF+vhpnxgnhv9UZvRugwXsJsCyqZZ
        PmkVDlZmIlLgLkXmJFjmqIrEpNvy
X-Google-Smtp-Source: ADFU+vumt7+/h/Zzfq4LXl1plEGJp22zEkGfiF1jTTD/If0SpD/NuwqADJPtZX/sCnD+KaNocdc5/Q==
X-Received: by 2002:a63:e053:: with SMTP id n19mr10839766pgj.64.1584736844835;
        Fri, 20 Mar 2020 13:40:44 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d5sm6219522pga.36.2020.03.20.13.40.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 13:40:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 6/6] gatt: Enable connecting to EATT channel using Ext-Flowctl mode
Date:   Fri, 20 Mar 2020 13:40:38 -0700
Message-Id: <20200320204038.11799-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320204038.11799-1-luiz.dentz@gmail.com>
References: <20200320204038.11799-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of BT_IO_MODE_EXT_FLOWCTL to connect to EATT channels.
---
 src/gatt-client.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 20efb7ae9..a9bfc2802 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -2182,9 +2182,13 @@ static void eatt_connect(struct btd_gatt_client *client)
 
 	ba2str(device_get_address(dev), addr);
 
-	DBG("Connection attempt to: %s", addr);
-
 	for (i = bt_att_get_channels(att); i < main_opts.gatt_channels; i++) {
+		int defer_timeout = i + 1 < main_opts.gatt_channels ? 1 : 0;
+
+		DBG("Connection attempt to: %s defer %s", addr,
+					defer_timeout ? "true" : "false");
+
+		/* Attempt to connect using the Ext-Flowctl */
 		io = bt_io_connect(eatt_connect_cb, client, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR,
 					btd_adapter_get_address(adapter),
@@ -2194,15 +2198,35 @@ static void eatt_connect(struct btd_gatt_client *client)
 					device_get_address(dev),
 					BT_IO_OPT_DEST_TYPE,
 					device_get_le_address_type(dev),
+					BT_IO_OPT_MODE, BT_IO_MODE_EXT_FLOWCTL,
 					BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
 					BT_IO_OPT_MTU, main_opts.gatt_mtu,
+					BT_IO_OPT_DEFER_TIMEOUT, defer_timeout,
 					BT_IO_OPT_INVALID);
 		if (!io) {
-			error("EATT bt_io_connect(%s): %s", addr,
-							gerr->message);
 			g_error_free(gerr);
-			return;
+			gerr = NULL;
+			/* Fallback to legacy LE Mode */
+			io = bt_io_connect(eatt_connect_cb, client, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR,
+					btd_adapter_get_address(adapter),
+					BT_IO_OPT_SOURCE_TYPE,
+					btd_adapter_get_address_type(adapter),
+					BT_IO_OPT_DEST_BDADDR,
+					device_get_address(dev),
+					BT_IO_OPT_DEST_TYPE,
+					device_get_le_address_type(dev),
+					BT_IO_OPT_PSM, BT_ATT_EATT_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_MTU, main_opts.gatt_mtu,
+					BT_IO_OPT_INVALID);
+			if (!io) {
+				error("EATT bt_io_connect(%s): %s", addr,
+							gerr->message);
+				g_error_free(gerr);
+				return;
+			}
 		}
 
 		g_io_channel_unref(io);
-- 
2.21.1

