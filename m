Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8A2EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 23:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjHAXbw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 19:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjHAXbr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 19:31:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D56268C
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 16:31:40 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-790ab117bd5so98276239f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 16:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690932699; x=1691537499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSvZQzyPYO9K+Yy/xJPLeAc8DQcrhOgj51xCbnGnWEw=;
        b=PKMvEr+weBIjOiZaDQ0u5XiuMoTcE9fcjfSgPOBk8t/4bniW5N8/Glk0vf3B4MVUOx
         27olflpkJCn/a68Gl8U34aiwJdgUsgtKDKPX81GIzqzib0n/80oeJci+1H4rheaSMVcd
         gRET73hsJZZ5r42IVoVxuhNuz+uCB7olCCJ1AhFd+anvw6OHW80DJ9L/KAtXWclJTPAi
         +XdjECt7eCn+ba4PKZlllQdc6VM/OnAior44Vo8F3LG0zisq8uIM7aBm3B6/JnFNrFZg
         x43EBuOqP69IFuk6zSeg1p+DDjeznZ2gVkjrLKoQ90rap8HbNnTE8eukq0DL0JdKh2ng
         3gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932699; x=1691537499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSvZQzyPYO9K+Yy/xJPLeAc8DQcrhOgj51xCbnGnWEw=;
        b=ci2Easptcc9tlODUqqMgl07jRsHdKLk3U0UGuYQ4L6OezzkfnRHs866Knuq2oChPQc
         6dDzUty8UXS1yXWTvwfEq7dN1/KEixdtNmM17P28ikK6K0EV9s01/QNymc/mESukhbf+
         blWb9XSYPKyjrWmgjr8hCKwhh9h9s5fBZxk0TLt8FYbVWNlcoytcxlIKQ/Ntv8XU3vHi
         PxpV6Ef2SGyp0PIHC5MIuOsgHpvtEg/2ss+OrVykHD+Irx5m/COBgzrfWYGrL0W8uM8W
         ZJgFqaZgCqn4LqZi4mQQcI8uORdL/Qr6Fx5kkCQF5nDbnDafWWMIFu7pvcSiFuuAZgwK
         b2zw==
X-Gm-Message-State: ABy/qLZtqjvD9Eo7q51jvWKqxkX2Fh3sycdZq/fK0L53i9GCKCCEip5r
        pG/vaKd11nVLYIdgFkHEjwW86Eqc6Co=
X-Google-Smtp-Source: APBJJlG1SrkSFdKKSW1/GOvYcbTpnBRxY/iSSl24PEysXvri2yKB7+tyYPKv8+1BJb2NwwrDU82Pbw==
X-Received: by 2002:a6b:fd06:0:b0:790:b033:6ffc with SMTP id c6-20020a6bfd06000000b00790b0336ffcmr5438361ioi.20.1690932699483;
        Tue, 01 Aug 2023 16:31:39 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id d20-20020a5d9bd4000000b00790af7745b1sm1286269ion.20.2023.08.01.16.31.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:31:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 2/5] monitor/analyze: Use conn_pkt_tx on acl_pkt
Date:   Tue,  1 Aug 2023 16:31:32 -0700
Message-ID: <20230801233135.537864-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801233135.537864-1-luiz.dentz@gmail.com>
References: <20230801233135.537864-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of conn_pkt_tx also on acl_pkt like other connections.
---
 monitor/analyze.c | 49 ++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index db026190701d..a016e26e31ac 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -600,6 +600,24 @@ static void event_pkt(struct timeval *tv, uint16_t index,
 	}
 }
 
+static void conn_pkt_tx(struct hci_conn *conn, struct timeval *tv,
+					uint16_t size)
+{
+	struct timeval *last_tx;
+
+	conn->tx_num++;
+
+	last_tx = new0(struct timeval, 1);
+	memcpy(last_tx, tv, sizeof(*tv));
+	queue_push_tail(conn->tx_queue, last_tx);
+	conn->tx_bytes += size;
+
+	if (!conn->tx_pkt_min || size < conn->tx_pkt_min)
+		conn->tx_pkt_min = size;
+	if (!conn->tx_pkt_max || size > conn->tx_pkt_max)
+		conn->tx_pkt_max = size;
+}
+
 static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
 					const void *data, uint16_t size)
 {
@@ -637,39 +655,12 @@ static void acl_pkt(struct timeval *tv, uint16_t index, bool out,
 	}
 
 	if (out) {
-		struct timeval *last_tx;
-
-		conn->tx_num++;
-		last_tx = new0(struct timeval, 1);
-		memcpy(last_tx, tv, sizeof(*tv));
-		queue_push_tail(conn->tx_queue, last_tx);
-		conn->tx_bytes += size;
-
-		if (!conn->tx_pkt_min || size < conn->tx_pkt_min)
-			conn->tx_pkt_min = size;
-		if (!conn->tx_pkt_max || size > conn->tx_pkt_max)
-			conn->tx_pkt_max = size;
+		conn_pkt_tx(conn, tv, size);
 	} else {
 		conn->rx_num++;
 	}
 }
 
-static void conn_pkt_tx(struct hci_conn *conn, struct timeval *tv,
-					uint16_t size)
-{
-	struct timeval *last_tx;
-
-	last_tx = new0(struct timeval, 1);
-	memcpy(last_tx, tv, sizeof(*tv));
-	queue_push_tail(conn->tx_queue, last_tx);
-	conn->tx_bytes += size;
-
-	if (!conn->tx_pkt_min || size < conn->tx_pkt_min)
-		conn->tx_pkt_min = size;
-	if (!conn->tx_pkt_max || size > conn->tx_pkt_max)
-		conn->tx_pkt_max = size;
-}
-
 static void sco_pkt(struct timeval *tv, uint16_t index, bool out,
 					const void *data, uint16_t size)
 {
@@ -690,7 +681,6 @@ static void sco_pkt(struct timeval *tv, uint16_t index, bool out,
 		return;
 
 	if (out) {
-		conn->tx_num++;
 		conn_pkt_tx(conn, tv, size - sizeof(*hdr));
 	} else {
 		conn->rx_num++;
@@ -778,7 +768,6 @@ static void iso_pkt(struct timeval *tv, uint16_t index, bool out,
 		return;
 
 	if (out) {
-		conn->tx_num++;
 		conn_pkt_tx(conn, tv, size - sizeof(*hdr));
 	} else {
 		conn->rx_num++;
-- 
2.41.0

