Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A6BC169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3252148E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYipawT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfA2N07 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:59 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38665 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfA2N07 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:59 -0500
Received: by mail-ed1-f49.google.com with SMTP id h50so15945347ede.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=UdVznjOhqvbKIgdZZkI075oATltCLZYiOAg3rWnupfg=;
        b=EYipawT0yTsI/lRuqABtXf2uXrTujI3AAtbU7iPRfjS4U1dvrDa2vKrqPtuIX4xKGQ
         OM3SehWj4XS+CG3Ky9zj2BTHzwOwvLUHuT3p1+bLpmcQ0rSu9qMGCFh+fGEcV/0+8mpN
         VXg5TtHsfKMncZ5T77V7zi0w5Kx6PXONmfesSS+wUsqVRYgCGucExNcBTTMm4ZAfl4x6
         lexEwpE/afsbc3J7MyGzpLavQiRWoUjoCy50jP4j2fxWV7RuHzpzoKjy2MPSHdns1gtx
         v6HfqK6m4mnjuCybWJnzvz99bxSUdrSrKrwEErx7NYnV9Iwulc+VC6Ix2nJ029daieAO
         jvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=UdVznjOhqvbKIgdZZkI075oATltCLZYiOAg3rWnupfg=;
        b=eSfvvyoiIFiRPAkg3lg2+SZnW0cIDLa0Aed7+fNC1Pa1qp4XAWeYsO5oX8cl1fjYZp
         KntyoYof8qZBbrb6+dPn/9RcA7V20Rgu74I/2TZPG6dFL2wQ2qlNK635hDwnT2u3m72p
         YiCRFnEkkYToC2fMYjHCB2uwxagj88p/UjzW2A+DV0Mq42pW1ugxsUC8Z94/aB1RmjjF
         os0KtSUel2nzjd51kqGfHva8TCzaYyMGkjQkMt/YeUHg4ygPMo2IuNhAlt/2dU0yQBpB
         oXXIVmqwWMsz9D4+7QWXmfoezGaicNGL3jWl9KuArns+pJNx3sbH1wL2fzciWPkLFq9u
         l2uw==
X-Gm-Message-State: AJcUukca+91gSo1Cgpjbl1iazC4zvt10meLyvTj0qw7IhceUbTRs4LE9
        C9A6OtCNOcJJ934LW6NKktY6euZB
X-Google-Smtp-Source: ALg8bN7o57/9bwL1TnVaVOGfwfETm2a3qtkFgRM7JMcprSLOGZckX2kU+bF9d79DSsV58w5cfHD04w==
X-Received: by 2002:a50:a395:: with SMTP id s21mr26204069edb.1.1548768416827;
        Tue, 29 Jan 2019 05:26:56 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:55 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 14/15] shared/gatt-client: Write Client Features
Date:   Tue, 29 Jan 2019 15:26:33 +0200
Message-Id: <20190129132634.28786-14-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This writes the supported client features setting Robust Caching bit.
---
 src/shared/gatt-client.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index d5f9b1294..1119d1a34 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1798,6 +1798,27 @@ static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 	queue_push_tail(client->svc_chngd_queue, op);
 }
 
+static void write_client_features(struct bt_gatt_client *client)
+{
+	bt_uuid_t uuid;
+	struct gatt_db_attribute *attr = NULL;
+	uint16_t handle;
+	uint8_t value;
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_CLI_FEAT);
+
+	gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
+						get_first_attribute, &attr);
+	if (!attr)
+		return;
+
+	handle = gatt_db_attribute_get_handle(attr);
+	value = BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING;
+
+	bt_gatt_client_write_value(client, handle, &value, sizeof(value), NULL,
+								NULL, NULL);
+}
+
 static void init_complete(struct discovery_op *op, bool success,
 							uint8_t att_ecode)
 {
@@ -1808,6 +1829,8 @@ static void init_complete(struct discovery_op *op, bool success,
 	if (!success)
 		goto fail;
 
+	write_client_features(client);
+
 	if (register_service_changed(client))
 		goto done;
 
-- 
2.17.2

