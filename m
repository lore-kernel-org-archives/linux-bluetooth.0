Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1BDC7619A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Apr 2023 23:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDKXTh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Apr 2023 19:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDKXTf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Apr 2023 19:19:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AC130EB
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Apr 2023 16:19:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y6so8372670plp.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Apr 2023 16:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681255169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWZGyUIe8vDHexeKos2oNQ+poJ0+KHtIaTu1usVgnDI=;
        b=WepGbX97QEbFL1Ugw0UI0tK1TkuElQelTGDxqRibhKnRcfRNQ7rjwtkBNx2cUfDWL9
         2K23H+3RmVuYEpL2b3Ta3FCXwQtye3wvWsfijBJAUTvuXmW67/k8L5iXSDt4bzoYYeXs
         DWlzY+iVcPf5uKM6fGxE2iB7yPSIgRvwvimIbuYbRB/39aBY/wVwJ7nXKTJ3giVjh1gj
         /AZK1g+Jop2XvPw6LA3tb54vR/uwNferjilQRiCFqhQsAf3WqdHbvx5ebSmvIlas7EGi
         87/dzY+tID890nTWUJPPwT85tm3Zak9tZuTxAxSXNEHdUdAPdhOclFnEYh2OEeyGXVyE
         eDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681255169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWZGyUIe8vDHexeKos2oNQ+poJ0+KHtIaTu1usVgnDI=;
        b=ymdKMCE1/eHHJfFO8R/epGEpn9vF6SVH6AiuzAKjdDG8Hx3Fe4g55mdbBP2WaRZOuv
         dQsDRq2jyd0jYAA2N3k7W5IIoBlhsdfY3Rv11DmHvWHei1P7bxGMlSUq6z1pG1taqSWw
         Iz0XPOdrXggwVrkViJKYzgVnKfRhB5AtkH2ytKuxKEE3q7moQfqIE9WUF9NWe9dpg4lz
         U6eOY6RIw1owGa0auzph+uxprINXFs8Jwq8BIcuVMOVCqMYAoLz/vUeC33MG9oTvLGbc
         874vy6h33qViyNqoXCoEh60XX8l6m/Kus8tOgVcaQNR1U9qvxTbiwKX+nDlT5axu7DpH
         7OxQ==
X-Gm-Message-State: AAQBX9drqG7IAcdk+IhY0CP+yOMr0uXAV4lCyA9YizLhNveOl10lyjMM
        brG/kZCuKGScqFA3qfjgG5ABI2mtX5Y=
X-Google-Smtp-Source: AKy350aOL58F5wkW5Zs2qtEqXWJsBt1EFgm7GRHD6d/ENhDVnn9ziQuYxi/50mdBDt8DBWcHTcyFag==
X-Received: by 2002:a17:90b:1c06:b0:240:9e3d:d532 with SMTP id oc6-20020a17090b1c0600b002409e3dd532mr6079394pjb.8.1681255169488;
        Tue, 11 Apr 2023 16:19:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id em3-20020a17090b014300b00246b7b8b43asm112556pjb.49.2023.04.11.16.19.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 16:19:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] Bluetooth: hci_conn: Fix not matching by CIS ID
Date:   Tue, 11 Apr 2023 16:19:25 -0700
Message-Id: <20230411231925.361066-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411231925.361066-1-luiz.dentz@gmail.com>
References: <20230411231925.361066-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes only matching CIS by address which prevents creating new hcon
if upper layer is requesting a specific CIS ID.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 7 ++++++-
 net/bluetooth/hci_conn.c         | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4fe1e71cb9d8..6f5e8594ff2d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1180,7 +1180,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 
 static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 							bdaddr_t *ba,
-							__u8 ba_type)
+							__u8 ba_type,
+							__u8 id)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
@@ -1191,6 +1192,10 @@ static inline struct hci_conn *hci_conn_hash_lookup_cis(struct hci_dev *hdev,
 		if (c->type != ISO_LINK)
 			continue;
 
+		/* Match CIS ID if set */
+		if (id != BT_ISO_QOS_CIS_UNSET && id != c->iso_qos.ucast.cis)
+			continue;
+
 		if (ba_type == c->dst_type && !bacmp(&c->dst, ba)) {
 			rcu_read_unlock();
 			return c;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8b8ebd3e2585..5524f08b91ae 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1842,7 +1842,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *cis;
 
-	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type);
+	cis = hci_conn_hash_lookup_cis(hdev, dst, dst_type, qos->ucast.cis);
 	if (!cis) {
 		cis = hci_conn_add(hdev, ISO_LINK, dst, HCI_ROLE_MASTER);
 		if (!cis)
-- 
2.39.2

