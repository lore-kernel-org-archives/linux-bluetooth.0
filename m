Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B07C00528
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jul 2023 08:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjG1I4x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jul 2023 04:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjG1I4f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jul 2023 04:56:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB410EC
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 01:56:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-986d8332f50so258826866b.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jul 2023 01:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1690534592; x=1691139392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VaL2DgaNC+1z327qtfZ1KrQuYZxhQvPHWnqk5Q87V8k=;
        b=hnOx51w5MpC+QnIOP4rvYl7zv9T4MydlAj7u9Hm0KSHXD/74DOvc1s99S/+0hG/W/5
         z3qmRS43ge9Lz729QY/bhSmN4UON0jfga7e4cA494ngvlONGAv5iwrlMKMwMQSdhzfFA
         vkBm8am9V6+Ny+eKy7q6sifHsjyFw4p04vHpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690534592; x=1691139392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VaL2DgaNC+1z327qtfZ1KrQuYZxhQvPHWnqk5Q87V8k=;
        b=WRmb9N5HX6FiHS+sg2VnfPAckW2HOYxCe11Me+i524Xv0WRSlH9r3nFMivZvhIFPjB
         0Nka1weXdp5OZeaq1cVYoWqVtj/aQCJMujfRhYGfms1LlC1lYot0ElXIrKzUhfLlkdwJ
         JTbFlIegPKDvUViVnXHax8OTkwVRbaDuxAMZNawuxQwIRyRgK/tIKanQ71ANRak1Wc2N
         kMTEvxKYe4sJtXgWuumyABthbUkbJQ9sAdpOagmJjopVEeG3a1DXwehJs8y0Zt9jSWqV
         mTD57OWkYbrai3D00gMTF7I9ZE7okQsa9AElEnmojMPQj+yUtwOFfuTxRdckQn4kpto7
         EOBg==
X-Gm-Message-State: ABy/qLaLa3InKHr74pN4rH2MHN03WOtd2+xw6h8fJf+04IvkLHl3CkJZ
        q5qXNUvyR4z542JCR1iKWlHtB/L03R2GehYP+bI=
X-Google-Smtp-Source: APBJJlFmf8LiSOBmoxihWI677nCvhtmMHzpqJT8uNyrxvNDY1AMRE2E+J4HBQInX9U7Fh9XJtxagSg==
X-Received: by 2002:a17:906:d9:b0:997:eab5:f1c3 with SMTP id 25-20020a17090600d900b00997eab5f1c3mr1138410eji.73.1690534592358;
        Fri, 28 Jul 2023 01:56:32 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:353d:c2fa:e0df:3251])
        by smtp.gmail.com with ESMTPSA id o12-20020a1709061b0c00b0097073f1ed84sm1828994ejg.4.2023.07.28.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:56:31 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] advertising: Fix setting "BR/EDR not supported" flag
Date:   Fri, 28 Jul 2023 10:56:27 +0200
Message-Id: <20230728085627.683418-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We need to check if adapter is connectable since remote device can connect
to our device even when we are not discoverable according to advertised
MAC address.
---
 src/advertising.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index d959bf38f..b50900029 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -95,6 +95,8 @@ struct dbus_obj_match {
 	const char *path;
 };
 
+static int get_adv_flags(struct btd_adv_client *client);
+
 static bool match_client(const void *a, const void *b)
 {
 	const struct btd_adv_client *client = a;
@@ -736,11 +738,11 @@ static bool set_flags(struct btd_adv_client *client, uint8_t flags)
 	if (!btd_adapter_get_bredr(client->manager->adapter))
 		flags |= BT_AD_FLAG_NO_BREDR;
 
-	/* Set BR/EDR Not Supported if adapter is not discoverable but the
+	/* Set BR/EDR Not Supported if adapter is not connectable but the
 	 * instance is.
 	 */
-	if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
-			!btd_adapter_get_discoverable(client->manager->adapter))
+	if ((get_adv_flags(client) & MGMT_ADV_FLAG_CONNECTABLE) &&
+			!btd_adapter_get_connectable(client->manager->adapter))
 		flags |= BT_AD_FLAG_NO_BREDR;
 
 	if (!bt_ad_add_flags(client->data, &flags, 1))
-- 
2.34.1

