Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2E7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 21:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DADB61354
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 21:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhJUVkt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 17:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhJUVks (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 17:40:48 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E66C061764
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 14:38:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id om14so1459709pjb.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nRBd89abiHyv8Q7c6u6FDPeyIm3Axv3Ygh1u96rwE0=;
        b=axxsVeP1UcGvSTXKCCs09K/iy1Wklm+MGU0Z6DCiLY7/QMTFpdxnU1Lw3FtJ0YST7l
         d7T0eEwydi8NZS0NoA+FMz0AaLRycT5jg/GX94X0NG0KKmoYlKgAGApS/4usXXtGretv
         b7d0yXKbuzssE4RQO1IDA6BPmv1jnmZ/Qp8ppAE4SkkPa30Ch2km6QMy+lQWrBgzkPs2
         LycLh83jMuFOfNNAoNXOkZjUBiABzWRmPCbjHZCBc1fXqYal9FLf5sBD8tLAtNzSxfka
         7fvwa19hIAvIsfZHxg4V8x0XkL9qR+kTaANOiHJYxYipTSUsa1h0bVuNYdeGv7O4jTJY
         S6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nRBd89abiHyv8Q7c6u6FDPeyIm3Axv3Ygh1u96rwE0=;
        b=IEwhL2hSuMYqTp9tTx6k6kTljeePgi1ElTuiXwE2ukom75fpIdo71PNLInY1xJTjZc
         2WLRmQXCS4AoV3SesujRv1rQTAo8/DEAXEWfH7Cvzy85G7MCrj+Egza5sZeI9PWFQs1L
         c9uTsXtWRbzv0TiSrU9qlQZKEjtGOjjuTkxFBhJ64UcwZzE9qGM63CwEuFJN8V55IcSS
         ZoM7zaT1gIY2Em6+l3MycHB5gLjN40ATiclVg1aolZ5TeMj4tGr/8MzRwllSPk4Eo2ZG
         /zHmtZAbmNqqyFHuIylqRVwEOqBogFtemyLbKlStm0nZCZgIof8YDU9X0E11wSjaZj20
         n1UQ==
X-Gm-Message-State: AOAM531s2d5JsTyOnLdxlZ9rCLujcb4mThcLEP2vhPqH76vhbGVy5lCh
        435cbC67FvGJPvdD7UDXFwxZHUkstiM=
X-Google-Smtp-Source: ABdhPJzYBu5VAboVPhyX4uZUryGYoJEuOE9eccnuHCzVcvRL1giwr4b9LQCD0UyJzX037LOGsY/mcw==
X-Received: by 2002:a17:902:b188:b029:11b:1549:da31 with SMTP id s8-20020a170902b188b029011b1549da31mr7440521plr.7.1634852310801;
        Thu, 21 Oct 2021 14:38:30 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 66sm6818473pfu.185.2021.10.21.14.38.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 14:38:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] mgmt-tester: Fix expected manufacturer
Date:   Thu, 21 Oct 2021 14:38:27 -0700
Message-Id: <20211021213828.640557-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The emulator is now using Linux Foundation manufacturer ID.
---
 tools/mgmt-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 8f6549d0b..67c77efe2 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -478,7 +478,7 @@ static void test_condition_complete(struct test_data *data)
 		user->test_setup = setup; \
 		user->test_data = data; \
 		user->expected_version = version; \
-		user->expected_manufacturer = 0x003f; \
+		user->expected_manufacturer = 0x05f1; \
 		user->expected_supported_settings = expected_settings; \
 		user->initial_settings = settings; \
 		tester_add_full(name, data, \
-- 
2.31.1

