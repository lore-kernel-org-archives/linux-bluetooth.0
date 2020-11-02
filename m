Return-Path: <SRS0=F55x=EI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B39BC00A89
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 22:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FC42225B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 22:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gWPAnYP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgKBWaN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKBWaM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 17:30:12 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D8BC0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 14:30:12 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id g12so12021395pgm.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 14:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pj78WrGr3/4UlO9pAlH1ppOr/3eTM+kiKeyp4vq2TZ0=;
        b=gWPAnYP5GabzPSAOt2NC0IKnO35o+AKOIxxEsAvQnSWlCHtjBNTBV56OuSiERwHtRu
         MtAj+714t5o917tMeexWjNnhbiQzyVGFK5k3mGdHdvykNCfAXLs7ab0AZOc7b0+ItmJL
         7vhjopFyZz4hasalhafyn/6rulKne5a+Z9DUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pj78WrGr3/4UlO9pAlH1ppOr/3eTM+kiKeyp4vq2TZ0=;
        b=GdTbLND2WoKh1ckK8XDW2Zq4mawY7kBTunjbVlpO8Ybcq4ayFENWk9WhozrZzUjjQ3
         4/rDi6imRLSc76ywQ4UE7WsvgM87kY2NJCu8yLiuiPFjFrUQWbq/yrf56TEqeYuwQ7+1
         9osC/KoEXhsH62jnJBqurX5aq/gmmdxmeFa1D/f0covef9nGTam+emqDk3o93EV/7DGn
         5lSnMdGPvtiHHw4BRNGU80aA1RKWPOa9UU/dUP62wdUArZLfnnETlrlcGbgbLkSPyhk2
         9K8Q/3xJyrxwSVTpder0hHZrlRwYwo4iaZYdJ0gu4WlS61BAQWC9cK6toN/3Cc7XcJR+
         muSw==
X-Gm-Message-State: AOAM5330Wk1EIkzFuz+trvQeYMdoXHnOjxxeEpqucvxg+rgUX1BP9sQ4
        iMvaeoOFbt/sFQYlO9TmVqc0xzDuc9xK/Q==
X-Google-Smtp-Source: ABdhPJzoL8afg0Zt+UUDmIaP99J96JX9TxKXH4p6Y888mPYsxi5d8lotiVwDKOZCceAwAY2V0VB+Pw==
X-Received: by 2002:a17:90a:4749:: with SMTP id y9mr357699pjg.229.1604356211856;
        Mon, 02 Nov 2020 14:30:11 -0800 (PST)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:de4a:3eff:fe75:1314])
        by smtp.gmail.com with ESMTPSA id n5sm13522644pgm.82.2020.11.02.14.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 14:30:10 -0800 (PST)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        chromeos-bluetooth-upstreaming@chromium.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [BlueZ PATCH v2] adapter: Fix a crash caused by lingering discovery client pointer
Date:   Mon,  2 Nov 2020 14:30:03 -0800
Message-Id: <20201102142933.BlueZ.v2.1.I474ca6a46b5ae198462df03d23f46dee652f74bb@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This cleans up the lingering pointer, adapter->client, during powering
off the adapter. The crash occurs when a D-Bus client set Powered
property to false and immediately calls StopDiscovery() when there is
ongoing discovery. As a part of powering off the adapter,
adapter->discovery_list gets cleared, and given that adapter->client
refers to one of the clients in adapter->discovery_list, adapter->client
should be cleared along with it.

(1) Connect to a BT audio device from BT system tray.
(2) Once the audio device is connected, power off BT and immediately
power off the audio device.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

Changes in v2:
- Move the D-Bus method call clean-up to discovery_free()

 src/adapter.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index c0053000a..f02ab799d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1496,6 +1496,7 @@ static void discovery_cleanup(struct btd_adapter *adapter, int timeout)
 static void discovery_free(void *user_data)
 {
 	struct discovery_client *client = user_data;
+	struct btd_adapter *adapter = client->adapter;
 
 	DBG("%p", client);
 
@@ -1507,8 +1508,14 @@ static void discovery_free(void *user_data)
 		client->discovery_filter = NULL;
 	}
 
-	if (client->msg)
+	if (client->msg) {
+		if (client == adapter->client) {
+			g_dbus_send_message(dbus_conn,
+						btd_error_busy(client->msg));
+			adapter->client = NULL;
+		}
 		dbus_message_unref(client->msg);
+	}
 
 	g_free(client->owner);
 	g_free(client);
-- 
2.26.2

