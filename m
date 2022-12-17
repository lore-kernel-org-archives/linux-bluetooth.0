Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAB2C4167B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Dec 2022 01:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLQBLP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 20:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiLQBLJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 20:11:09 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D9DDC0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 17:11:05 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso9551625pjb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 17:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPD3Q6BhEPi4/yZF2rSoj/c/AnGD9vGyBerqU/bDmIU=;
        b=Oin3HkvfH2BOItI9NQd5gtf+SpfFAob/0nR2/rToWO7k+SCgRS3+MACqMi3q9XJdgI
         emk6jTX50z4BIYEuJhekAlcqqf4BDRQ7ILlWLM520dZOJYngaC2koaqrPahW0n+lXQFH
         qOOMOWc+fDqSi12b+UcljQEVjM0DDS8hx4YEkQvJw/JM23QLbvqFiWQ2jQ+BeGaVFyeL
         Y6j2mner1njYRwYfRtFUPagDFSqkjOWjaFiY4yxRWrzXxKjg9h33cv1MNP2bLv9jz8oI
         sYKrQ/ct8MSF5IcbmYOKOqvo41FKfdk3CdTD+Y/feHnLZtj0ZuQfoeUFDlHbaBF4C5Lo
         x+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPD3Q6BhEPi4/yZF2rSoj/c/AnGD9vGyBerqU/bDmIU=;
        b=DSy7plP18TUKaQH7bQt/VIqolNabY2SNIDOpMAG6rAa8IQmU8Lj8mSv6TNCp+NAMF6
         IpoKpHIGzPpFYXxImAstyParj2PZPL+rA+2VR04Wl/b/aqAn26yaIpkTqI9sfkpY+YG4
         wGlPUSPpKYKu84L3bYq6+EU2e0uhFgXbIzjFjKcGTO1KGzukXjixER9EsyXvoebLa2RM
         AqrYKeJ+G0FVn7DAmyH2S78LINjgb+jkAPOpsybOGqrdr0rL9uY1Q2vKoBQbtu4bx2qQ
         aUBybvgW+Oh2twxj1RFL6+mHomNNnUd6N8VMOAVYgqhcUx2UqZQ5qf1cqBg736bR5sBT
         FKxA==
X-Gm-Message-State: ANoB5pnNAl1RNLW/ScgMEkqxTP2/zgOhmp16lW87Wn53li7uDAiEeBzw
        5BLTMsp8QX2X/sKS9sUKGksCSAERrFOjFQ==
X-Google-Smtp-Source: AA0mqf6FLvdtrOJyqKSC6Jd+XClebC3P7hP8PLAn+ty0y2AjC2z77WgWa5PA0AKXupRc+pL8/bNxQA==
X-Received: by 2002:a17:903:24a:b0:189:760d:c5da with SMTP id j10-20020a170903024a00b00189760dc5damr39279273plh.17.1671239464349;
        Fri, 16 Dec 2022 17:11:04 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b00188f07c10c9sm2232781plx.192.2022.12.16.17.11.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 17:11:03 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 2/2] shared/gatt-client: Fix not removing pending services
Date:   Fri, 16 Dec 2022 17:10:59 -0800
Message-Id: <20221217011059.3087848-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221217011059.3087848-1-luiz.dentz@gmail.com>
References: <20221217011059.3087848-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there are no characteristics to discover, or for some reason
bt_gatt_discover_descriptors is skiped, or the last attribute is
actually a included service the service should be removed from
pending list as there will be no more attributes to be discovered.

Fixes: https://github.com/bluez/bluez/issues/438
---
 src/shared/gatt-client.c | 46 +++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index cf0d2e2b749d..cb2e64b6cc6b 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -500,6 +500,24 @@ static void discovery_req_clear(struct bt_gatt_client *client)
 	client->discovery_req = NULL;
 }
 
+static void discover_remove_pending(struct discovery_op *op,
+					struct gatt_db_attribute *attr)
+{
+	struct gatt_db_attribute *svc;
+
+	svc = gatt_db_attribute_get_service(attr);
+	if (!svc)
+		return;
+
+	if (!queue_remove(op->pending_svcs, svc))
+		return;
+
+	gatt_db_service_set_active(svc, true);
+
+	if (op->cur_svc == svc)
+		op->cur_svc = NULL;
+}
+
 static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data);
@@ -576,12 +594,26 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 				gatt_db_attribute_get_handle(attr), handle);
 			goto failed;
 		}
+
+		if (!gatt_db_attribute_get_service_data(attr, NULL, &end,
+							NULL, NULL)) {
+			DBG(client, "Unable to get service data at 0x%04x",
+								handle);
+			goto failed;
+		}
+
+		/* Skip if there are no attributes */
+		if (handle == end)
+			discover_remove_pending(op, attr);
 	}
 
 next:
 	range = queue_pop_head(op->discov_ranges);
-	if (!range)
+	if (!range) {
+		/* Skip if there are no attributes */
+		discover_remove_pending(op, op->cur_svc);
 		goto failed;
+	}
 
 	client->discovery_req = bt_gatt_discover_characteristics(client->att,
 							range->start,
@@ -725,6 +757,9 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 		goto failed;
 	}
 
+	/* Done with the current service */
+	discover_remove_pending(op, op->cur_svc);
+
 done:
 	free(chrc_data);
 	return true;
@@ -798,9 +833,6 @@ static void ext_prop_read_cb(bool success, uint8_t att_ecode,
 	if (discovering)
 		return;
 
-	/* Done with the current service */
-	gatt_db_service_set_active(op->cur_svc, true);
-
 	goto done;
 
 failed:
@@ -888,9 +920,6 @@ next:
 	if (discovering)
 		return;
 
-	/* Done with the current service */
-	gatt_db_service_set_active(op->cur_svc, true);
-
 	goto done;
 
 failed:
@@ -997,9 +1026,6 @@ next:
 	if (discovering)
 		return;
 
-	/* Done with the current service */
-	gatt_db_service_set_active(op->cur_svc, true);
-
 	goto done;
 
 failed:
-- 
2.37.3

