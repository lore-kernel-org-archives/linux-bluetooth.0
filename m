Return-Path: <SRS0=9Smc=RV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0085CC10F00
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 16:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DD620863
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 16:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPegE9Oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCRQT6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:19:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33980 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfCRQT6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Mar 2019 12:19:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id a16so14055762edn.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2019 09:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yjo7vdn8h1SW7Fz3AKImskEcXLzSShJhoSGWMXX1nJw=;
        b=GPegE9OoIMgNYJF5fqUU9WdMHLMBXEKjjznZu181V8SyZgGDm8xppPdeGIR47+hXTx
         OnQFhp1C5jdsf+O8HwgDKTAR1ZbsSV9z/qz41RJj50QGduG+iD2y5zDuwlzEBDG7P9Bi
         6jtitkocUxVu7G51uUQk/LUMuWFRK/u0Cc7p332Zs0vjfefQ/u1f6Ovk08k1NhuD2JjR
         0/NT9pLlPArE/gLz+Dd+sRVG9D0P/NVzID3HwuAcHmgIvVo9ivI5yR0r4atwzOc8gA4f
         nyd0J+C95LUROPknm6JL45lBmOnqZzbIupqW4kY8xAMCW+4u3ZdzvY5aXnN10TkhstZt
         ygBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjo7vdn8h1SW7Fz3AKImskEcXLzSShJhoSGWMXX1nJw=;
        b=CYOGeqdDEsf02wrOHT08CyyMgtKNGxQPnyPtyAbxBFI+aDqyrb5Hl/2S28Do0JpCIM
         XUW4zZLxsWRXwtV6k0LRVuXvKX+0OJnl2gooYNY5+n/4QY/5vebmpOKrv6pp6pKivkba
         IDsnpi9Cvh73vTJAtHrI8NETydQ6Hp43n4Plg/8Y/3UVEQAFxHz2/KcH0RHDj57WMLh5
         StGuGNAE4n/s6ExYnFQBLuIdf6SLSAzv86KZ8xFBfqm6hdqRhh9CF7+V8JM5eSFhzr08
         DLQD4wjBMSgbkKbr7cBhZuQKVnVoJcN17J0L+U6BggFDZ3pNhLMGO8ze9butTfR/z8hv
         hnWQ==
X-Gm-Message-State: APjAAAXCJ+gdXx4yr5tqD4qV/30nOTRnK4lQmiC/uGyNh2mhqxAoaZM2
        IaAmuq5TSPr4weFEf+7lny3Z1G1J
X-Google-Smtp-Source: APXvYqx6wx3Wcn1EiHwCAPUuYbPwFLczi9GKePIRQ7FNd7TM95DfC5AgoAG/ul5iFANzTykobPZqBQ==
X-Received: by 2002:a50:9970:: with SMTP id l45mr11882060edb.171.1552925995904;
        Mon, 18 Mar 2019 09:19:55 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id n3sm2491210eja.56.2019.03.18.09.19.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 18 Mar 2019 09:19:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] shared/gatt-db: Remove update_attribute
Date:   Mon, 18 Mar 2019 18:19:49 +0200
Message-Id: <20190318161949.21749-3-luiz.dentz@gmail.com>
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

It is not longer needed to access the last attribute handle to figure
out its attribute since the handle is either passed directly or the
db->last_handle is used.
---
 src/shared/gatt-db.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index bdce3da47..b5f7094da 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -776,20 +776,6 @@ static uint16_t get_handle_at_index(struct gatt_db_service *service,
 	return service->attributes[index]->handle;
 }
 
-static struct gatt_db_attribute *
-attribute_update(struct gatt_db_service *service, int index)
-{
-	uint16_t previous_handle;
-
-	/* We call this function with index > 0, because index 0 is reserved
-	 * for service declaration, and is set in add_service()
-	 */
-	previous_handle = service->attributes[index - 1]->handle;
-	service->attributes[index]->handle = previous_handle + 1;
-
-	return service->attributes[index];
-}
-
 static struct gatt_db_attribute *
 service_insert_characteristic(struct gatt_db_service *service,
 					uint16_t handle,
@@ -1054,9 +1040,10 @@ service_insert_included(struct gatt_db_service *service, uint16_t handle,
 	 *
 	 * TODO handle permissions
 	 */
-	set_attribute_data(service->attributes[index], NULL, NULL, BT_ATT_PERM_READ, NULL);
+	set_attribute_data(service->attributes[index], NULL, NULL,
+					BT_ATT_PERM_READ, NULL);
 
-	return attribute_update(service, index);
+	return service->attributes[index];
 }
 
 struct gatt_db_attribute *
-- 
2.20.1

