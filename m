Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB08C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 21:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D35C611CA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 21:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbhIVVfi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbhIVVfg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 17:35:36 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1258C061756
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 14:34:06 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t1so4191083pgv.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Sep 2021 14:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9OxrZIWGpEmRGj6uQ1qyfI73FR4n2zyX+n1QWCYZ1sw=;
        b=WTZLQeeLQg5LmVTFoEhouWVOdP7JXv4zwn+wySpIr04gAFIbddFxU5y/LZHTos3t42
         lemcuJPS0yo6rt+2Ek2ms9guzZlrz2NybYhGkv34bYwyRRfZj+ZgR3WnXG23LN6fcua/
         MtRezdIR1WF/y3q6UoI89KHHE1omeSsvISC7PwC+wSPbx+uOgqeZoPq2kLH/lW1IVe1X
         lXEQ7wpgl4PIm2POMf9OVYv8Y3QEATm44pcNbK1ryh+vVeujrx3ckpKQJdyXMO8Wqxiy
         3G4cGOSnkgYHgAmtDQms4Zv/hCo9VZpkch/i8zpicWIeOClhDC6tEswJOoxLocZepBgH
         PpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9OxrZIWGpEmRGj6uQ1qyfI73FR4n2zyX+n1QWCYZ1sw=;
        b=ylATuVfmTKrjDqY+YuuQDwAg1/JjpIc96JPDn3/QWKMo4ZdbXwF+Cg8tmwjCKHy/FS
         0aAMYyhZZKw67OWpJ+WIJ7UzqpJTAyVlvOoz4NOzTQyYJu1qDDTsqoOjHZg6TThsxT75
         +WSmf2gmzHU8KzNLPJqMuLE0HXz+oe64Z9H2agij7HmwEhqKiS2Zx4gSBt7Ti70g8PWc
         PNc0ryJyewa2AQWhTMpmVQLx/U/1qVYUoE4tqcjzCImlNxwmJtVZ57K7QUA9E41kyDOf
         OUH0fcTKugpID3boRL2lMSE3eVJTXM3qYtMy/20IGX4lw0A36uDP0+zussT9nJ98TP+0
         hrFQ==
X-Gm-Message-State: AOAM531O0syULGFRZ0kCmYE/4GZpE00aEH77tzVoZ2Jkr/R5idZuRxWp
        sBKEpoEAaNGAHeRLU6yLW0C69SGaJVE=
X-Google-Smtp-Source: ABdhPJxbjHTzysem1eA01hjsf3TykPsDDFauhYY02D/n0cC2oKfK3kUwg2osTNrKz3VPKcCoGq5wuw==
X-Received: by 2002:a63:590e:: with SMTP id n14mr954385pgb.434.1632346445868;
        Wed, 22 Sep 2021 14:34:05 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i12sm6378596pjv.19.2021.09.22.14.34.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:34:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] adapter: Truncate number of LTKs loaded if over MGMT MTU
Date:   Wed, 22 Sep 2021 14:34:02 -0700
Message-Id: <20210922213402.1978215-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210922213402.1978215-1-luiz.dentz@gmail.com>
References: <20210922213402.1978215-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If MGMT MTU cannot accomodate all the existing LTKs only send the ones
that fit in the MTU and leave the remaining as unpaired.
---
 src/adapter.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 45c187a18..5846f0396 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4163,8 +4163,9 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 {
 	struct mgmt_cp_load_long_term_keys *cp;
 	struct mgmt_ltk_info *key;
-	size_t key_count, cp_size;
+	size_t key_count, max_key_count, cp_size;
 	GSList *l;
+	uint16_t mtu;
 
 	/*
 	 * If the controller does not support Low Energy operation,
@@ -4180,6 +4181,9 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 		return;
 
 	key_count = g_slist_length(keys);
+	mtu = mgmt_get_mtu(adapter->mgmt);
+	max_key_count = (mtu - sizeof(*cp)) / sizeof(*key);
+	key_count = MIN(max_key_count, key_count);
 
 	DBG("hci%u keys %zu", adapter->dev_id, key_count);
 
@@ -4199,8 +4203,10 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 	 */
 	cp->key_count = htobs(key_count);
 
-	for (l = keys, key = cp->keys; l != NULL; l = g_slist_next(l), key++) {
+	for (l = keys, key = cp->keys; l && key_count;
+			l = g_slist_next(l), key++, key_count--) {
 		struct smp_ltk_info *info = l->data;
+		struct btd_device *dev;
 
 		bacpy(&key->addr.bdaddr, &info->bdaddr);
 		key->addr.type = info->bdaddr_type;
@@ -4210,6 +4216,16 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 		key->type = info->authenticated;
 		key->central = info->central;
 		key->enc_size = info->enc_size;
+
+		/* Mark device as paired as their LTKs can be loaded. */
+		dev = btd_adapter_find_device(adapter, &info->bdaddr,
+							info->bdaddr_type);
+		if (dev) {
+			device_set_paired(dev, info->bdaddr_type);
+			device_set_bonded(dev, info->bdaddr_type);
+			device_set_ltk_enc_size(dev, info->enc_size);
+			device_set_ltk_enc_size(dev, info->enc_size);
+		}
 	}
 
 	adapter->load_ltks_id = mgmt_send(adapter->mgmt,
@@ -4769,18 +4785,6 @@ device_exist:
 			device_set_bonded(device, BDADDR_BREDR);
 		}
 
-		if (ltk_info || peripheral_ltk_info) {
-			device_set_paired(device, bdaddr_type);
-			device_set_bonded(device, bdaddr_type);
-
-			if (ltk_info)
-				device_set_ltk_enc_size(device,
-							ltk_info->enc_size);
-			else if (peripheral_ltk_info)
-				device_set_ltk_enc_size(device,
-						peripheral_ltk_info->enc_size);
-		}
-
 free:
 		g_key_file_free(key_file);
 	}
-- 
2.31.1

