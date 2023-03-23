Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A00C761AF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjCWKmG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjCWKlp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:41:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03B8367E1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eh3so84363845edb.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTiNn5ElAqSIAm568k6v0bazI47/CuUlIG5hKkmFQbE=;
        b=PPnXU9P0ZKmXfN17axYUb+xWhSjqik3AHPGvbND3tcf5hr0mjIBZnuH5YDVKPC4GeT
         6mqie7P6JnDduouaHDusHW8eakANhIVk8X3Yzjih+uFmkh06yaVBF4BpYFRVa2957kXr
         MbVrpV1jIRpENZg+fybLA8Q4Ep1jrtsUSARzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTiNn5ElAqSIAm568k6v0bazI47/CuUlIG5hKkmFQbE=;
        b=Rch8sSJfWi3EC72Kk63zww5bb2Hstropzqejaa5sMT/7OkCqCFxIL8zwyoiAa+UE34
         d3GXbDT0jbmk+g2YCcrZEuupocYLrgFnUVqZuwvxlrOyldDrcM5j9O6I0DVTYx0r891y
         Ty5POMsF/wUGVKl5k/UUmjAqaVuf4dDopDxwdGXyDZApk2Hfmg+Xkqe++9s87fA4B2Gl
         9rcXulth+5TlJ+XZ5lbdnNEJZ46/GLDFXqOkWJMos9cldu0JbQBCfDy19n5RdxnMmiV/
         mk4Hb/eV46HBR/bHfERGJHB8gqfQuz7rg+nZurR6Wte1KSun1LxK/c8JgxEHUj66XgfK
         39qg==
X-Gm-Message-State: AO0yUKU2sLhVsDAFMow9obFcv8MXePt2YmFjSehq6djJN1fa3IQ7Cypb
        6DmpgAmRIozfMmyV/P3OJvaPT+6KFd+D6WUwNco=
X-Google-Smtp-Source: AK7set+9xomHPozhhDGz6bkEKNxGqxkxVJ3r+6E7SUWBzWKFGFdYO3/z8AJgUv7pfFwqUUgncCCPyg==
X-Received: by 2002:a17:906:a4b:b0:92b:2389:46bd with SMTP id x11-20020a1709060a4b00b0092b238946bdmr10239655ejf.21.1679567924329;
        Thu, 23 Mar 2023 03:38:44 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id bv1-20020a170906b1c100b00939e76a0cabsm3513208ejb.111.2023.03.23.03.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:38:44 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 9/9] btgatt-client: Implement filter service by start handle
Date:   Thu, 23 Mar 2023 11:38:35 +0100
Message-Id: <20230323103835.571037-10-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
References: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 tools/btgatt-client.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index b7a23ac9b..629063d5c 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -377,8 +377,13 @@ static void print_services_by_uuid(const bt_uuid_t *uuid)
 
 static void print_services_by_handle(uint16_t handle)
 {
-	/* TODO: Filter by handle */
-	gatt_db_foreach_service(cli->db, NULL, print_service, cli);
+	uint16_t start = 0x0001, end = 0xFFFF;
+	if (handle) {
+		start = handle;
+		end = handle;
+	}
+	gatt_db_foreach_service_in_range(cli->db, NULL, print_service, NULL,
+			start, end);
 }
 
 static void ready_cb(bool success, uint8_t att_ecode, void *user_data)
-- 
2.34.1

