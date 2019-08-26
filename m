Return-Path: <SRS0=PESP=WW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14DEC3A5A6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Aug 2019 12:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A563F21881
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Aug 2019 12:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYykanSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbfHZMGX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:06:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40462 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731208AbfHZMGT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Aug 2019 08:06:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id c5so15384391wmb.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2019 05:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQcKkNiJdQMqBVQSQobnRS74DuuSkOIfJDwvEN2rbRo=;
        b=uYykanSvrtJpx8iAJVbFquuxC6ZTS9UDJzXTfVAvGiexVlbcqjeI/e30uZRbMgANIc
         FrLdCwi8t4fBtzceCQORoRzZMi6FGr3naxcSm0xqkMS2GFKat88hSbIdtppjTeF8kBex
         W6RaViOGd+NsCfmYFUi0kx4RsYuCdfUDzOev7yVCFKC7ajTpbmjhDL2qHmrvygmd2uDt
         olFWrasoXwDnWl+6OlmSFnqdwtCfdfOKd30297ylREVkf/QRLvIkn5Rn/LiGyAPTykiO
         ZOQ8SR42JJclBz4NZt5Vyz4cLrV7gO4HEfwozjEvACs7MSkpmmjrsqipRFvdavdUXQ81
         8UzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQcKkNiJdQMqBVQSQobnRS74DuuSkOIfJDwvEN2rbRo=;
        b=Z0na/zSkYuayeLOyWxGtzxL2Jv+U4DtUuimGkaC79ak6Kx+vKSx+BZhmyrhuVycFcD
         2yfuCuq9KXSq9O1DyZ/j2jhpcNwrJPk6g0XTAZ70VpYHl1W7SRhKal/e2fA+vC1e/x8p
         Ei8aADxTfwZ3UcX3Bwe5yIiVL2pSwbmx2AzwxlT5LKZx1MxBg1mGGEvm9aP5khOrf30a
         BHtB2t4hTqgRstA68b7nY6Euk4GPj8DcGTx+E2CWh65VVadgD7L2lOuOdOBAwinDZYzB
         LpZbkiFHDOVPGkxzrB+YW/9MJ3dkeMYBVb6FTsfRpa1136tme9VuuY547UYRn8C5OznD
         lGvw==
X-Gm-Message-State: APjAAAUy/OUeGZWT99aE/MUDW7LJLKRKNfiKjxPaUZs/sNhBHOQbwKYK
        JTSTWKDQJ+R/EcJEqtvJZ02rvxSo
X-Google-Smtp-Source: APXvYqyelUlGn+EPI8BroTpJG/a9s1ZcMyNPj2IpxwEe8qpLPKyUagSwq+ZNza9bKBJgVuNsa/B4fQ==
X-Received: by 2002:a1c:7619:: with SMTP id r25mr21891697wmc.153.1566821176606;
        Mon, 26 Aug 2019 05:06:16 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id l5sm9909055wmj.4.2019.08.26.05.06.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 05:06:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Automatically add CCC when discovering
Date:   Mon, 26 Aug 2019 15:06:13 +0300
Message-Id: <20190826120613.23233-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The spec mandates that a CCC exists if either notify or indicate
property is marked:

BLUETOOTH CORE SPECIFICATION Version 5.1 | Vol 3, Part G page 2357

  "If set, the Client Characteristic Configuration Descriptor shall
  exist."
---
 src/shared/gatt-client.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 225915d43..38a416ed3 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -659,6 +659,31 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 
 		desc_start = chrc_data->value_handle + 1;
 
+		if (desc_start == chrc_data->end_handle &&
+			(chrc_data->properties & BT_GATT_CHRC_PROP_NOTIFY ||
+			 chrc_data->properties & BT_GATT_CHRC_PROP_INDICATE)) {
+			bt_uuid_t ccc_uuid;
+
+			/* If there is only one descriptor that must be the CCC
+			 * in case either notify or indicate are supported.
+			 */
+			bt_uuid16_create(&ccc_uuid,
+					GATT_CLIENT_CHARAC_CFG_UUID);
+			attr = gatt_db_insert_descriptor(client->db, desc_start,
+							&ccc_uuid, 0, NULL,
+							NULL, NULL);
+			if (attr) {
+				free(chrc_data);
+				continue;
+			}
+		}
+
+		/* Check if the start range is within characteristic range */
+		if (desc_start > chrc_data->end_handle) {
+			free(chrc_data);
+			continue;
+		}
+
 		client->discovery_req = bt_gatt_discover_descriptors(
 							client->att, desc_start,
 							chrc_data->end_handle,
-- 
2.21.0

