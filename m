Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A478BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 23:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiBNXmM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 18:42:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiBNXmL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 18:42:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EE3117C94
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 15:42:02 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso901429pjg.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 15:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEO2Nh8WWeWWAhDMtmbJWw0IAbjtkHzwvaVxBdHNduM=;
        b=XAtoeBGUAQlfrqUX90n1h993kd8r4XiB1FJNaVRiiO5ASvn+XgahRtqR+FztRcKuwx
         h3WXPu+JrRzTEijw7nB+vdMqJ95F4IZEvetEA1c702ZsLem7FO3n++3qcMK/VYtFH9E1
         PpFWJDCE3jUFb1XKtbjaO7g5wgh+OkWaj2dkwaX98b+/WMC9T/LRgVZ1BrtclFxzavRE
         TAbBFvzXboYJ3IKGQqQ6hKqceVZ/ouVPYuCQ8dsDP7p91uySAVRigvlvpoOVD0p/d8tG
         BaIg2uGTm3WVdL0J+l78F52cJAMcuCcBvzFGoWb1TcLsvDMQddg8BjI9nB2nEGNsTqrB
         pO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEO2Nh8WWeWWAhDMtmbJWw0IAbjtkHzwvaVxBdHNduM=;
        b=ue61FmVkuKEWsRycw47poAWegML6DySW+PK2A2ec7kts5HJd/ZAPkw3BPYuegUIAsW
         s6PnKZE7qrVrT7UQkDa3lTjZl1q+W2p5Kx1jenrghgflRqTwUjd8EW7pI2UO2deankue
         NQoFQ6Hi1fkxzDjF7Tl+E0jM1VviI6EAkD3ud4y057WyXOGKDt68IqHmw7qnLYX9YiBl
         gTfa6JvjhtznmcrXuM5YvOcU2K7mimNRhW4+KK7eDr5nfi2PPSdQ0+/ScDyQyTjIVuM+
         R2L2nrKs1uS+0+3Iyx+hnlStxDMZExI2eII4qLNsN6pYI5FjtfPxjDf7f9a3ZioWPDZF
         rh/g==
X-Gm-Message-State: AOAM533x/ImL9ELOvZlv9nwLGP1TjKzeN0R7v4bn2Hno/EqBxgpwnpCX
        SOhBitftTkGV28Gu/N5u0HzIUplJQoS8IQ==
X-Google-Smtp-Source: ABdhPJz5/9nCsrhCmHid6dEG1+hsKMZ+RNi8z2oRXngjlylBaMHuhhxGfWCAAKONtcYamobJVq/Vzw==
X-Received: by 2002:a17:90b:3b81:: with SMTP id pc1mr1202883pjb.71.1644882121985;
        Mon, 14 Feb 2022 15:42:01 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z13sm535493pga.84.2022.02.14.15.42.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 15:42:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gobex: Print error if data cannot be written
Date:   Mon, 14 Feb 2022 15:42:00 -0800
Message-Id: <20220214234200.1881712-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure that if the data cannot be written it fails and the
error is properly printed.
---
 gobex/gobex.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 54e3b0814..185eed4d7 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -419,6 +419,8 @@ static gboolean write_data(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	GObex *obex = user_data;
+	struct pending_pkt *p = NULL;
+	GError *err = NULL;
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -427,9 +429,9 @@ static gboolean write_data(GIOChannel *io, GIOCondition cond,
 		goto stop_tx;
 
 	if (obex->tx_data == 0) {
-		struct pending_pkt *p = g_queue_pop_head(obex->tx_queue);
 		ssize_t len;
 
+		p = g_queue_pop_head(obex->tx_queue);
 		if (p == NULL)
 			goto stop_tx;
 
@@ -480,8 +482,19 @@ encode:
 		return FALSE;
 	}
 
-	if (!obex->write(obex, NULL))
+	if (!obex->write(obex, &err)) {
+		g_obex_debug(G_OBEX_DEBUG_ERROR, "%s", err->message);
+
+		if (p) {
+			if (p->rsp_func)
+				p->rsp_func(obex, err, NULL, p->rsp_data);
+
+			pending_pkt_free(p);
+		}
+
+		g_error_free(err);
 		goto stop_tx;
+	}
 
 done:
 	if (obex->tx_data > 0 || g_queue_get_length(obex->tx_queue) > 0)
-- 
2.34.1

