Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D07C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjCWKl4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjCWKla (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:41:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71963609B
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w9so84434301edc.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDpTmnFPgLCUUWvLBnYjiNs0oMm44vUfcnwVasp4Px4=;
        b=vx9OK/COmF1WomGouYbeE8+sW2zI3CWPBGxZjXhaBijLl3DXDgZJEYQcwTnjpvOB/z
         /TuVEltl2vKmZGq3TD3k8ZMReb8VlyRKkNOu1v8XHZFeGL+cNgnmg/AtzjxSfykt/MFV
         JaPxpoXvBOmS/1bVktVoin4uegcYzFzIUqOik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDpTmnFPgLCUUWvLBnYjiNs0oMm44vUfcnwVasp4Px4=;
        b=lI2sQEiBv2GMEZcYZxAevyRUKHgkFCBwRGwol+wjFpiw7dvHiiWRPm3cZLX7Wnh64p
         Q0Lm4MVvBZGrv5sK42NKL/a1cQAXPTpTt8IeOk/iamdMHokCcjm6P13hHZqAaAKg7rmc
         RNyjPYKGn+GOCSVWE7Q6wvY0mPTcZkjUMaD5XeProuVbobAOjSmezTevJ2c9QEKYeUmM
         T83Npj5eZPPW+yrZmXwTWy7Dhiuhq+y2cvCj2CvMpKmWdGbuUmNxyn68RAwz71922yGf
         ZfNZXyHvboWSkSA1JRftEJwdH7xPVhVtnxQAKWAbu5f49AdjlSoQM2mOtHCtKJYR5Y7n
         FxFA==
X-Gm-Message-State: AO0yUKU8UbvjkjLQID0zGlAuWaQC7pN6cxQGN1SWQXf7gtOoWdCF1teA
        n0vIqIwAMHdoN7SJj/0hqTeBdM3YCZI/PFJlWUg=
X-Google-Smtp-Source: AK7set+/LSsdFUMO3x9R6S/hHeBCr9mqx0uIITLrGEGeI8s1VNuOKil/QT4E1pNzsvqpNINBsJrrYQ==
X-Received: by 2002:a17:906:7008:b0:8b1:32b0:2a24 with SMTP id n8-20020a170906700800b008b132b02a24mr10932009ejj.47.1679567918855;
        Thu, 23 Mar 2023 03:38:38 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id bv1-20020a170906b1c100b00939e76a0cabsm3513208ejb.111.2023.03.23.03.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:38:38 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 1/9] gatt-db: Fix crash during calculating hash from ATT handles
Date:   Thu, 23 Mar 2023 11:38:27 +0100
Message-Id: <20230323103835.571037-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
References: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It happens when next_handle is lower that discovered number of handles.
Found by PTS test case: GATT/CL/GAD/BC-01-C
---
 src/shared/gatt-db.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b696fe33d..c9ffbfeed 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -297,6 +297,7 @@ static void handle_notify(void *data, void *user_data)
 struct hash_data {
 	struct iovec *iov;
 	uint16_t i;
+	size_t size;
 };
 
 static void gen_hash_m(struct gatt_db_attribute *attr, void *user_data)
@@ -327,7 +328,7 @@ static void gen_hash_m(struct gatt_db_attribute *attr, void *user_data)
 	case GATT_CHARAC_AGREG_FMT_UUID:
 		/* Allocate space for handle + type  */
 		len = 2 + 2;
-		data = malloc(2 + 2 + attr->value_len);
+		data = malloc(2 + 2);
 		put_le16(attr->handle, data);
 		bt_uuid_to_le(&attr->uuid, data + 2);
 		break;
@@ -335,6 +336,13 @@ static void gen_hash_m(struct gatt_db_attribute *attr, void *user_data)
 		return;
 	}
 
+	if (hash->i >= hash->size) {
+		/* double the size of iov if we've run out of space */
+		hash->iov = realloc(hash->iov, 2 * hash->size * sizeof(struct iovec));
+		memset(hash->iov + hash->size, 0, hash->size * sizeof(struct iovec));
+		hash->size *= 2;
+	}
+
 	hash->iov[hash->i].iov_base = data;
 	hash->iov[hash->i].iov_len = len;
 
@@ -361,9 +369,10 @@ static bool db_hash_update(void *user_data)
 
 	hash.iov = new0(struct iovec, db->next_handle);
 	hash.i = 0;
+	hash.size = db->next_handle;
 
 	gatt_db_foreach_service(db, NULL, service_gen_hash_m, &hash);
-	bt_crypto_gatt_hash(db->crypto, hash.iov, db->next_handle, db->hash);
+	bt_crypto_gatt_hash(db->crypto, hash.iov, hash.i, db->hash);
 
 	for (i = 0; i < hash.i; i++)
 		free(hash.iov[i].iov_base);
-- 
2.34.1

