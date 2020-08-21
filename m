Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2344FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6602078D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 07:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X7y9Y/AN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHUHpR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgHUHpQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 03:45:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2837C061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:45:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so617725pgm.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 00:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ahNzFwqsXNzsJ6fzog/DY5DWWrZLWO8A13L3oZbfyg8=;
        b=X7y9Y/AN/biKpTBgZSJBaxsFJAYgnfRDFH6DvAqxyp/vs9MS8VM0tATkIeoz0ntKYY
         k5JI4rp5GaOWQ2Xg38/I5nYfCNCrUV05+xV8pRPDAH3Nj2MMG4JgSRnXMi1KpFXsS0lm
         95EYdzLICPpRv5dYmJWT0+2MzythZHCw35KfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ahNzFwqsXNzsJ6fzog/DY5DWWrZLWO8A13L3oZbfyg8=;
        b=ENI4Y4f2ygUpQWftCSO0+R8naX4zwz7APPc/TZ8eFFDZlXR9qu9VA6WyJM8J3LeuDv
         p2JIakOtmxbxZHmLaKkY9kMM/W1YkzBaeChY6k9b+S1RyA81VdXDCUXhQrT7IdAan4sb
         G8b7B4zZCc0g/vZAC03JGdGh5A7RmwYfjX4VXqgLpN4iMOVqRSqh9+E0mvFAsL8ZUU+x
         9WXIMi6g8wUOZcub7shWzs6Dfs5tx+8J/HIiQGe5kKQuK/kGxjO3QHNKnQ9dZXP5M8IU
         H8xmDJ4/qewAEDmNt0IYq6j8Pw7Ta/T39cjQcgU9ds4YIDv2/1oMYn7tFs8ASTk4Opo4
         K5Uw==
X-Gm-Message-State: AOAM531j7LuZ56lSIy2zjF1+7gMnHyIHcx11m5Hc9BAyZjD9ATTqxsXR
        qPbMBLe40xZEQRhGUGOCgfjruZ7FiAL03A==
X-Google-Smtp-Source: ABdhPJwZgs15uFYMeynHzgtBUTSG141REStkT1pHWE8rSqsPE0hItxdojYPOboeSEpuMtMxib37d3Q==
X-Received: by 2002:a63:3710:: with SMTP id e16mr1454661pga.140.1597995915145;
        Fri, 21 Aug 2020 00:45:15 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id w14sm1628078pfj.220.2020.08.21.00.45.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 00:45:14 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ] device: Fix race condition between device connection and disconnection
Date:   Fri, 21 Aug 2020 00:45:12 -0700
Message-Id: <20200821074512.19985-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When Connect() is called and waiting for return, dev_disconnected may be
called due to MGMT_EV_DEVICE_DISCONNECTED event from kernel. In that
case reply to client that the connection failed otherwise the dbus
method will timeout because bluetoothd never replies.

Tested with simulation of a lot of Connect() to bluetooth devices and
check that error is returned from bluetoothd rather than dbus timeout
when this race condition happens.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---
 src/device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/device.c b/src/device.c
index 7b7808405..55e7b4042 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3006,6 +3006,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
 void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 {
 	struct bearer_state *state = get_state(device, bdaddr_type);
+	DBusMessage *reply;
 
 	if (!state->connected)
 		return;
@@ -3020,6 +3021,17 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 		device->disconn_timer = 0;
 	}
 
+	// This could be executed while the client is waiting for Connect() but
+	// att_connect_cb has not been invoked.
+	// In that case reply the client that the connection failed.
+	if (device->connect) {
+		DBG("connection removed while Connect() is waiting reply");
+		reply = btd_error_failed(device->connect, "Disconnected early");
+		g_dbus_send_message(dbus_conn, reply);
+		dbus_message_unref(device->connect);
+		device->connect = NULL;
+	}
+
 	while (device->disconnects) {
 		DBusMessage *msg = device->disconnects->data;
 
-- 
2.26.2

