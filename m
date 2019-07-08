Return-Path: <SRS0=sF93=VF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA20C606BA
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 14:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001FE21670
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 14:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="VosmAvcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfGHONX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:13:23 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40458 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbfGHONX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jul 2019 10:13:23 -0400
Received: by mail-wr1-f45.google.com with SMTP id r1so10966957wrl.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2019 07:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNBBTiyJXDCqCL3nhvikdoEual2kbDBe8aidWZ7wvZk=;
        b=VosmAvcGKTeX9oDKAuUT8v5569xx/H35QO0gQqxlrSLUjNP1M70uLZzKS36KWEpBwG
         9c6RDzfzcCQ0nEIIQbK+bxQRO3N7Wty7bLV2c5zzWypTXu9Yi5RiS4hA4vwm6/Lzmwjw
         oWEhWL//pyzOisQf/loLtHkWcJwn4KBSUHRjpvZjBw07ja2gOptaqc7JoqB98YMh4fgB
         6WKGmZhXVv7Poo8KDzqZYVBU68bsRb0g+uFeWEa1sZ26ttKTXvQsbrEuQSskIR7luCYp
         GB/Qw4099zTrQrPzI13hAAe5kHb6FAP/cmk46tUX68qxU1cKCb2uedWVkCOoKy5tNz52
         nO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNBBTiyJXDCqCL3nhvikdoEual2kbDBe8aidWZ7wvZk=;
        b=BLD8PFxgzX0I5Hp47NuxYy5K5+PC34/gYYAT5ZK3BQaFG4C9iphmVaEhUHOvd9Fzwp
         tZoGaNFR78GusU8jCT+Bb3WvCufuBE3G/ycxYU0XufZg3csH0ccRIrMaIAjMijnThGnx
         Fhp/uprT/AlYXFS43mqzf1i9BBXRsL3zpgEggkII6lqXnDkxSO6m8uTG8ijAYxM3GkOc
         sjudHPzaURHhTZYofIzY3nwDnGiEBb1RiBiwls62SJvKc34J7cOftpPmN0s/m02KRv1t
         1sxwvjblGwI9JJJcmOLKNZI5qbHmmmOO38pIsArOugWNLgkbMjcI7lnXm8SsWmqYaBB2
         S7Zw==
X-Gm-Message-State: APjAAAUtSAJG8LSsXytT4/gupMmx+9apuVpH9uLskpnwV9a0b+WPF/TE
        r2ZGmj00LFh5sY4qWPdB55IVZK8V0AhzWw==
X-Google-Smtp-Source: APXvYqwjoj5V3oLn/wzZlqeBGNSqmORWK46bhJFqkTrbCm1xJrWkevTbaOWYS5OnhIQ5tUmniwKF+A==
X-Received: by 2002:a05:6000:145:: with SMTP id r5mr10045833wrx.208.1562595200864;
        Mon, 08 Jul 2019 07:13:20 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id m7sm5392574wrx.65.2019.07.08.07.13.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 07:13:20 -0700 (PDT)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Inga Stotland <inga.stotland@intel.com>
Subject: [RFC BlueZ 1/1] mesh: Validate element indexation
Date:   Mon,  8 Jul 2019 16:13:14 +0200
Message-Id: <20190708141314.13950-2-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190708141314.13950-1-jakub.witowski@silvair.com>
References: <20190708141314.13950-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implementation checks if there is no gap between given element_indexes
---
 mesh/node.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mesh/node.c b/mesh/node.c
index 1f781cfe9..35f85b0f2 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1439,6 +1439,14 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 	return true;
 }
 
+static void collect_ele_idxs(void *a, void *b)
+{
+	const struct node_element *element = a;
+	uint64_t *ele_idx_list = (uint64_t *)b;
+
+	*ele_idx_list |= (1 << element->idx);
+}
+
 static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 {
 	struct l_dbus_message_iter objects, interfaces;
@@ -1449,6 +1457,7 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 	bool have_app = false;
 	bool is_new;
 	uint8_t num_ele;
+	uint64_t ele_idx_list = 0;
 
 	is_new = (req->type != REQUEST_TYPE_ATTACH);
 
@@ -1533,6 +1542,12 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 		goto fail;
 	}
 
+	/* Check for proper element indexation */
+	l_queue_foreach(node->elements, collect_ele_idxs, &ele_idx_list);
+
+	if (((ele_idx_list + 1) & ele_idx_list) != 0)
+		goto fail;
+
 	if (req->type == REQUEST_TYPE_ATTACH) {
 		node_ready_func_t cb = req->cb;
 
-- 
2.20.1

