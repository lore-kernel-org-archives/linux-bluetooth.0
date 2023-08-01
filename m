Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037DCC00528
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 23:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjHAXVp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 19:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjHAXVn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 19:21:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5C426A6
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 16:21:40 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686b9920362so4478485b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Aug 2023 16:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690932099; x=1691536899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSvZQzyPYO9K+Yy/xJPLeAc8DQcrhOgj51xCbnGnWEw=;
        b=F7RhJ/foWlrk12xrL7DmCYobY2RtS7ALxIMmrpoVJVaTzNFf0g5j0svFeu3O5veTC6
         gw2N252v3xgMnvNNrZ9q7doAYIrQA3zbO+CsXZX+0VPZC3KaJ/3o7x/c16ehhog/2DzE
         6pkyN9UXmqRs/UJQO2Fc9HDMZlV8YGa8zDYxkQ/qCVcCWg/2a3iscLTnSLIxUN/bbE8R
         m+IFiPlczXS4qTVWU0yr72VS8id5+a/Fh7xJR0me/hQYMBxoE9s4Z4MioQHiQahkq9lm
         2a06n3jKNE8+ibxnNndCydMc6ojnoAxnJnf0WUpL1noAIFQihL+O8fL8cMmKPXL8jGTn
         dnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690932099; x=1691536899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSvZQzyPYO9K+Yy/xJPLeAc8DQcrhOgj51xCbnGnWEw=;
        b=NLngzsvs1ZvHy/fL7htmLeblLWqBR6nbz9u77lH0suOivw6BgwqySf1ZopGSdPixuD
         RW7DlrWae2bkEDxOo5P6wZj8pCdEs27INZy2YBZZstL46GjF0JOBS7Tu7ORZCdFV9Arj
         +oGANcA1bLsN4M3kVt6hAHVtfi4yjWsGQirdsqngYDNDz7CXwxnepQjL2ulUbVZ/BByB
         r90kUkW08VjCIk8Rn2ZvLnIIh41D7iG/dZr1AQAQD7Ss4qe74NeIOliaLEm+yJMTGK/u
         hoDvKESqENMkFClgNHd24/sPEimO3tmIYuQErtJMvxzXiGrn+VwehnXJnYGjDxrA5OaG
         ncTw==
X-Gm-Message-State: ABy/qLYNmS+IJjSieD//l8M5IAFx/GKlKqF2sNmRrMHcpoS6qRSBGSor
        Uj4z0F8SqgxZR7bXeDhAIYB83Rtd/+o=
X-Google-Smtp-Source: APBJJlEy4vlAUbzh4YUOSmuhX9XPCcbWjgIAajJm2iFdflg8lRFhivUPzdI+n3VIDJfbjNRfCsB/fQ==
X-Received: by 2002:a05:6a00:1687:b0:668:83b7:fd02 with SMTP id k7-20020a056a00168700b0066883b7fd02mr17240699pfc.31.1690932099016;
        Tue, 01 Aug 2023 16:21:39 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id fk25-20020a056a003a9900b00682a8e600f0sm9856157pfb.35.2023.08.01.16.21.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 16:21:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 2/5] monitor/analyze: Use conn_pkt_tx on acl_pkt
Date:   Tue,  1 Aug 2023 16:21:32 -0700
Message-ID: <20230801232135.535733-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801232135.535733-1-luiz.dentz@gmail.com>
References: <20230801232135.535733-1-luiz.dentz@gmail.com>
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

