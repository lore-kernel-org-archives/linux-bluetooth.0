Return-Path: <SRS0=9Smc=RV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BEEC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 16:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2396A20989
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 16:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No/HxWEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCRQT5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:19:57 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:43414 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCRQT4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Mar 2019 12:19:56 -0400
Received: by mail-ed1-f46.google.com with SMTP id m35so14033505ede.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2019 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Y8e0RIGQvz2HVsknyyZEjooMhzIm3KO/xj947cdhBWo=;
        b=No/HxWElFumJcPPedNHVRE+pECuuNlM7h5fKsXnIR6aezmyN3gtJE9YLu5Fy33RMO1
         Sn0eDvMypw5bv02SxBzaXhL8i2hoRvN8MpXby0PZxOQKkH4/m7I+bQIIsZ27u4RPxTfQ
         jAjikeG5amucj2MdnURA76LsvuJB0snPY1b6DGN7bZr9QMZLy0Wtqun4u+WN5c8RtQnJ
         dqtShAkqnwtrzHLHyHZOqCveUF8yXi4VkKdLphv8cRT3UTbXD+B5hMA8gLR0WThJR65c
         9zNihCaRei9KN4fkAI1bNhfrCvjW7weLq4xLQ7jH6eAJnhfN+97o9znFLrUXhZQTp29Q
         kIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8e0RIGQvz2HVsknyyZEjooMhzIm3KO/xj947cdhBWo=;
        b=h5AcAU+x3i9b+Y8YSFrhMKwLPJ1asboErGrWlIOZCKxn5UakcvQormnJyo5tOZ+BM0
         tJpOeupNT6GGwI80VgKlRjBOeJJEP8gDuOwyjCXN6Sd6YjWjplp0zMQoPbRbn1BG6btl
         1rFZmc79wmJKi+jkWIy9czZqYMJchPxhwKm0PRwPgMZcso+9KtCnYl+xASOX5DTpSPeq
         dzAi3q44Z0X/EJQkB1jkrmpW4Pc7WPR7yTHAs/OiO9bsok3WBCuF5CackU3AesQQiuLt
         fk6FGg3iggRF8SQ9KWm6VfWh3enumaqrtQgEmgnj0ZmOsMCjiRqPs9O4VfGH6dEPH7s5
         evhA==
X-Gm-Message-State: APjAAAVNVNEtc/tGL8R50BU1C3o7iKMrWJ7CeoXDgV+SZNJkqNDkEPh8
        ++Mo1itP0GduD82Ea5yX459KIRSt
X-Google-Smtp-Source: APXvYqzKAU9qcPpKSX3SvbtRfWXgjYFV9XkfxolbD4TsuWDFHK8jZJM8756Xm/QIYOwAnPlI+8LFyw==
X-Received: by 2002:a17:906:1e51:: with SMTP id i17mr11689043ejj.195.1552925994279;
        Mon, 18 Mar 2019 09:19:54 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id n3sm2491210eja.56.2019.03.18.09.19.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 18 Mar 2019 09:19:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] shared/gatt-client: Fix failing to discover included attributes
Date:   Mon, 18 Mar 2019 18:19:48 +0200
Message-Id: <20190318161949.21749-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318161949.21749-1-luiz.dentz@gmail.com>
References: <20190318161949.21749-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When there exists a included service a descriptor may already exists in
the handle location so instead of failing check if the UUID matches and
then skip to the next descriptor.
---
 src/shared/gatt-client.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index ec1041f66..858209c24 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -815,6 +815,11 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 							&uuid, 0, NULL, NULL,
 							NULL);
 		if (!attr) {
+			attr = gatt_db_get_attribute(client->db, handle);
+			if (attr && !bt_uuid_cmp(&uuid,
+					gatt_db_attribute_get_type(attr)))
+				continue;
+
 			util_debug(client->debug_callback, client->debug_data,
 				"Failed to insert descriptor at 0x%04x",
 				handle);
-- 
2.20.1

