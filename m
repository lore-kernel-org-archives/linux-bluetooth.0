Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A4BC43466
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44CBA21D7F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jb7aqUoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIRWOV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgIRWOU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 18:14:20 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC6C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:20 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id m203so5816433qke.16
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=91Zt9XP6Cj93+SBnN9YBrF7r0PR5X/CwV84AXjpBNuM=;
        b=Jb7aqUoKUmL8q5P7PCLnJOqU4JDR1t3xlCubss7xuiXoxa/7F6ceIDdbobl1zFPWok
         h1Yl2EQCkw3KjyDUSFgypen67KhwTWt7qTMV+9Z6nKJe0RHhMnIU1CHPTHrcNa1KQfgH
         xiOfSvyDwR+HivpcfTvJe0D0uO3A/XLOJyLzhkOXVv1aGy0Ukc8/tIx6crkVYs5aHXkr
         07Y7Dzn6T/7/zwpQ/mWGeG38NqaKNJ8E7jErD8DMxSu0ctTeKXdMBDnaNEf2GK429A4s
         It6FyFmTDahFDoSXvKKfO84Vod1MgWuOAxO7hC/GCXGtGBH0oEtoa76LPSNsF5FNghSU
         XULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=91Zt9XP6Cj93+SBnN9YBrF7r0PR5X/CwV84AXjpBNuM=;
        b=jjv6ZmyK5R3EzCFUl9lN5zX8QqV5BZPlmxDRDrfwsoVSGK4xwtvwEKWyZABVLGBr2w
         12eQoVgELEN1f8Sj9G4OcwasPIosmNCSq67gxNEe0JQPC9N4p48YaTMHp4ZoDjl1iOlL
         iApcj+JiQfzUWcsfFggJGGw8DdJSnVm0n/caMzrYOg/pWsC2ktEzbXwuF4SOaVSOVhVw
         5C9870swDLIpyCxjP0NDy6pPnJ/OR2thgCrrNW9LP9HInb+i/QQclf7KrrV83Bhf/yOw
         YUNr6u+t9I+AC0uQoEYOoPKcNZr5fz7BjvpUnJC+1bpuo1ZCWsR0wGr0E0EnCDoW92ni
         f/Ew==
X-Gm-Message-State: AOAM530MbK2idoYKQMGkQ1cR3hFHIKqWixwVjCVmr09STeNJD00LCZvz
        Qqv8cjcoX6W0cv6Rkfl2/n+UIMYamSTI+bbm59P+
X-Google-Smtp-Source: ABdhPJyTE5ZqE2PBK8RXIbQZxL+nb4DoIbFYGtICCSYdAOtXzJkK2BAb4eOxZGzjB6egYKfg14I/C1qUbjj11AWiBfk2
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:5a0e:: with SMTP id
 ei14mr21140751qvb.15.1600467259757; Fri, 18 Sep 2020 15:14:19 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:13:53 -0700
In-Reply-To: <20200918221357.3436905-1-danielwinkler@google.com>
Message-Id: <20200918151041.Bluez.v2.6.Ia7689bc6f45cf6b8e13a95cd1da4f96fbfc3ac14@changeid>
Mime-Version: 1.0
References: <20200918221357.3436905-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [Bluez PATCH v2 06/10] advertising: Catch tx power selected event and
 handle it
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The new Tx Power Selected MGMT event will alert bluetoothd that an
advertising instance has been assigned a tx power. This is intended to
be used to then update the client of their instance's tx power.

Towards this goal, this patch does the following:
- When adv manager is created, register a handler for tx selected event
- On callback, identify the relevant advertising instance, and call for
  a property set with the new value. If the client exposes this method,
  it will be called with the new value selected by the controller.

To test, I modified the example-advertisement python script to implement
the Set dbus method, and verified that it is called after advertisement
registration on a device with extended advertising.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v2: None

 lib/mgmt.h        |  6 ++++++
 src/advertising.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 9874be004..56f46ce93 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1002,6 +1002,12 @@ struct mgmt_ev_controller_resume {
 	uint8_t wake_reason;
 } __packed;
 
+#define MGMT_EV_ADV_TX_POWER_SELECTED	0x002f
+struct mgmt_ev_adv_tx_power_selected {
+	uint8_t	instance;
+	int8_t	tx_power;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
diff --git a/src/advertising.c b/src/advertising.c
index cab0b79de..c7deda1ad 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -113,6 +113,17 @@ static bool match_client(const void *a, const void *b)
 	return true;
 }
 
+static bool match_client_by_instance(const void *a, const void *b)
+{
+	const struct btd_adv_client *client = a;
+	const uint8_t *instance = b;
+
+	if (client && client->instance == *instance)
+		return true;
+
+	return false;
+}
+
 static void client_free(void *data)
 {
 	struct btd_adv_client *client = data;
@@ -1681,6 +1692,22 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 		remove_advertising(manager, 0);
 }
 
+static void tx_power_selected(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_adv_tx_power_selected *ev = param;
+	struct btd_adv_client *client;
+	struct btd_adv_manager *manager = user_data;
+	dbus_int16_t tx_power = ev->tx_power;
+
+	client = queue_find(manager->clients, match_client_by_instance,
+			&ev->instance);
+
+	if (client)
+		g_dbus_proxy_set_property_basic(client->proxy, "TxPower",
+				DBUS_TYPE_INT16, &tx_power, NULL, NULL, NULL);
+}
+
 static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 						struct mgmt *mgmt)
 {
@@ -1718,6 +1745,11 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 		goto fail;
 	}
 
+	if (manager->extended_add_cmds)
+		mgmt_register(manager->mgmt, MGMT_EV_ADV_TX_POWER_SELECTED,
+			      manager->mgmt_index, tx_power_selected,
+			      manager, NULL);
+
 	return manager;
 
 fail:
-- 
2.28.0.681.g6f77f65b4e-goog

