Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399D3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 21:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiLPVGS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 16:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiLPVGQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 16:06:16 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5141209E
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 13:06:14 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id l10so3493354plb.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 13:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XTh0KiFSEyER+1gCalnZKYk/yCNIQLse+mLkM0J7Es0=;
        b=KVQAmOTaKR93YI+zNL8Og9nu8dMcLPQEbfJ7LbWh24VMc1GtkC97P4dxVfVziWh+mL
         qqTj+FC91Op9QgqReT2XtzOhwYpqVr6KbfqKqio3BJYAElbUiHFldfaMBVhj2Ux1VlmY
         aPKi+YlEDIvWbdW69BKbLKpNebNxqvSfjGvQmjAzGSRn9pF2tGldz/GcN5U+Y7ST0y8f
         mjGBuY34QSB91s8rtz/zl2HOxdkRNVRr4UJg7UzHNcvTu0848mS/Cel5556yUiZRYTzb
         SHA7VQ7MBGY5Zlequ5WaaMCcypqqzH2AkLbnP/cMygXArVLPhOyi9Y4X86DZXc+DQoS/
         wKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTh0KiFSEyER+1gCalnZKYk/yCNIQLse+mLkM0J7Es0=;
        b=3Xvdxk8jitkk7nZf7vQxmcYK93z0jp7dGXkgJ00Wet3E5L5hP5O+LTnwXTCUtd0viM
         sGAYKQGz8906PcuCKkuaLtR09RHCDUpyQvGaaYmm7q+HdTvTIRuaDIBRwyQN6qkxIzVm
         jUClL++UMVH745GoPEkObz44MDasbptUdTcBvx3yglsmDCSG3kQd2VGuLLAdI4F77w9s
         oFgl7gQLzLGtdDoSA3mBOf7/M8GrQhZ3M1iNxwcReNau7pDScGyCVAOkKjuLULLxZJ8p
         MGyEyq7AOf+7ybwxEzTGOqtMVlYsq5wnOpA/LQBQvg8rSqGrrn34VhjuIKx3u6G2kTTn
         NtIw==
X-Gm-Message-State: ANoB5plEhvyJTaCTxMUM1fOeKaFhnvX4/9mFFgB4Qgj+nO2L5nVLt239
        qzrOkKIH8LrilaEvvhooh1I5IKnHswjDYIFA
X-Google-Smtp-Source: AA0mqf5GhGuqu19Wkl13DLOe4HZSDqSZQUN8Agi7C3ErfETIkgouDxWB+xZIow4IraKdwfJbOZWarw==
X-Received: by 2002:a05:6a21:32a8:b0:9d:efbf:813b with SMTP id yt40-20020a056a2132a800b0009defbf813bmr51586444pzb.4.1671224773230;
        Fri, 16 Dec 2022 13:06:13 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e7-20020a635007000000b0046b1dabf9a8sm1893030pgb.70.2022.12.16.13.06.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:06:12 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] shared/gatt-client: Fix not marking service as active
Date:   Fri, 16 Dec 2022 13:06:11 -0800
Message-Id: <20221216210611.2990552-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there are no characteristics to discover, or for some reason
bt_gatt_discover_descriptors is skiped, or the last attribute is
actually a included service the service should be marked as
active as there will be no more attributes to be discovered.

Fixes: https://github.com/bluez/bluez/issues/438
---
 src/shared/gatt-client.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index cf0d2e2b749d..83283110b636 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -576,12 +576,28 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
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
+			gatt_db_service_set_active(attr, true);
 	}
 
 next:
 	range = queue_pop_head(op->discov_ranges);
-	if (!range)
+	if (!range) {
+		/* If there are no range to discover mark current service as
+		 * active.
+		 */
+		gatt_db_service_set_active(op->cur_svc, true);
 		goto failed;
+	}
 
 	client->discovery_req = bt_gatt_discover_characteristics(client->att,
 							range->start,
@@ -725,6 +741,9 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 		goto failed;
 	}
 
+	/* Done with the current service */
+	gatt_db_service_set_active(op->cur_svc, true);
+
 done:
 	free(chrc_data);
 	return true;
-- 
2.37.3

