Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465E1C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 19:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0BE2245C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jan 2021 19:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbhASTgU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389910AbhASTf4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jan 2021 14:35:56 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D677C0613C1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 11:35:15 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id t6so11123886plq.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jan 2021 11:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4A6cq+Co4HtvMuCte5UD8xUQrWa+XGNWgXNCMGrw3sg=;
        b=aCHvB0mMU+OGODH6SBLkXMlkGbIdWxhJSFN5DHq42v5UhaLKSXoF2Pyse9D9ILlNAT
         c6vy+VS5OrD5BsCBgvF9yZlqaDls8wdgUQuBWmtHZ/Tsqvm60/+Sr6kzVn5K4HBXV2gD
         GGqn8nFfoJqH1qUxeCLmRt4Rs1EVC+YprJwjdJ1yiFylHgQUTxifcnTCtsNjFp8fNGl+
         5AOLZiZjjiMV+JRx3Xs0Jdi7b6Uoq8WWxphGaY6emCUEZZBTAAqNqy4wbiy1oLE6JiXF
         +B+x/hrGnLWnMTH3AHr7r9av/s9MGZfYiYDLcAjMN87XUyMMiQH2K2q5mwcbvQLRJHEE
         LWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4A6cq+Co4HtvMuCte5UD8xUQrWa+XGNWgXNCMGrw3sg=;
        b=WHmjQ9O1uW7H6/jXd1QXxAtIwU1pBa+FL97MJPt+3zq5Jv8vKMIdPKgP5HMamSDAY+
         Ppafb6UqIgFkdUndSE09VfyyfQDzQc0mAUdLuSOszKFpZbhr0/cW+kG8cOF+jYv2luLu
         kxf+VjwBAFP7Y+9Guc5MhUkyF/Oy4SejJl6Lt+Gh4NTIJAYoFZrT5YFwsUMdAOKedip7
         Yh8Is57uuehuaxDwadDFZYdguDltrTPPvnbRpdmCy8yPxlvfEdviioSwjcHR2jCR9MrX
         1jDs8u/ndZvQzOaM9zJoUGTZ6Z7+oycab+izvmPmqI4MYL5pwGhGAZPSy94xeUsxK4Gk
         fvog==
X-Gm-Message-State: AOAM531d8shWvaToOQkNuy6zM4JYZxJ4d7r0LX3QXHW+I2VWoka5lHul
        j7fEJfNhJ0zzhn4OOUVVW43cPvfhfYAWlg==
X-Google-Smtp-Source: ABdhPJyXduPHsNV4zHUrEMd9o1B5yeXRvG6ZlVZJofqxtSRfM9JSKQ0XORq+fl/zNxktzKD4vFlgrw==
X-Received: by 2002:a17:90a:4598:: with SMTP id v24mr1320168pjg.135.1611084914415;
        Tue, 19 Jan 2021 11:35:14 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 141sm8438467pfa.65.2021.01.19.11.35.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:35:13 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Fix crash when a device is removed
Date:   Tue, 19 Jan 2021 11:35:12 -0800
Message-Id: <20210119193512.821918-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a device is removed with notifications enabled that would lead to
device_state being freed while att_disconnected has not been called
yet.

gh-issue: https://github.com/bluez/bluez/issues/82
---
 src/gatt-database.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index d99604826..d635c3214 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1350,11 +1350,17 @@ static void send_notification_to_device(void *data, void *user_data)
 	if (!ccc->value || (notify->conf && !(ccc->value & 0x0002)))
 		return;
 
-	device = btd_adapter_get_device(notify->database->adapter,
+	device = btd_adapter_find_device(notify->database->adapter,
 						&device_state->bdaddr,
 						device_state->bdaddr_type);
-	if (!device)
+	if (!device) {
+		/* If ATT has not disconnect yet don't remove the state as it
+		 * will eventually be removed when att_disconnected is called.
+		 */
+		if (device_state->disc_id)
+			return;
 		goto remove;
+	}
 
 	server = btd_device_get_gatt_server(device);
 	if (!server) {
-- 
2.26.2

