Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23436C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 May 2023 20:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjEKU2i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 May 2023 16:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbjEKU2d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 May 2023 16:28:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92788A6F
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 May 2023 13:28:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64389a44895so7359079b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 May 2023 13:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683836907; x=1686428907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LpzUOM7Ff2iDt/BIpy7qB4J4jd23xXMR7oT7W/ai9xo=;
        b=B+N/4IIl2bTwB9FKAm72gPkJb4EIL0QoljrI9zyIWXOyGbmYiD0FZsyDQVLYlxwp5m
         jMBSx8hmxyOgXiHRGP68XwuRwsCOqYTII6JnKsigOm8sA4RX7D7lumfI30z7iPEUzhmO
         p41aFoDUYmZ5cO5hQHqIPZS6OqKxLHHI8v7hXuCHBQbfbGIhexKUStSkJ6lPjzYE5wej
         bqgiFC2Cux5o5J82eHR3mwGmGEciN1iga2AHXmMGb1jHyFeNbloJ+a5k9cXX+hxhD/OD
         hBWdJgPKuv4B4v5hR+zVb7l7QUvzF2UTsBJzd4ObKahgU2Awk5JglPLBVuNXeYZIWK5D
         6Tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683836907; x=1686428907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpzUOM7Ff2iDt/BIpy7qB4J4jd23xXMR7oT7W/ai9xo=;
        b=eTFSniyT+J6eXd0pdTSj9lV/nqLWXCjY+n3FNwFCALw4qyk5C6Gvg4A2oN+DRQz+gj
         Vqf8VVKqnKJXaMnqOprUJu7wAVt/xp6TLHRYy7LbAXQztJl/AwucioHmCXbtH5jZsIPS
         ES6A+iw8xWf3UhEa4rLZAKL4at19MZsYPYxoMKaspVFG48FxyHgJs1DG0NxU/lVsMwwp
         D81PTC5G62VZ1Bnvpt/IeRAEC8eHRY2xVQw5ORU2ImO7mzv1hJu4dXcQ+zTL27gB0Tn9
         EuhTZtMa9RGQAROnXQ/awgCu0eHY4Lku0ez0/u0zD+UGPaDLUvVev/MnL2g2+3hK7Ltn
         ilGw==
X-Gm-Message-State: AC+VfDzg6lSNxrqlOoxmAQqp604T+jlb19q3M8pJ++d+xgrmkpHZ3Lym
        PYtAZlv1D2EcJcq1d5yv66O/Gq1lyeg=
X-Google-Smtp-Source: ACHHUZ7SXp5VzTYI4YqGdlaBmwVXzobaDi8mywV9xm0hmZjRDByHgjoGkWBOI2g4T+gXI+n4nAZPEg==
X-Received: by 2002:a05:6a20:7491:b0:f5:ae09:ce02 with SMTP id p17-20020a056a20749100b000f5ae09ce02mr30612543pzd.18.1683836907320;
        Thu, 11 May 2023 13:28:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b0062a7462d398sm5864529pfm.170.2023.05.11.13.28.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 13:28:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/player: Add support to Max Transports in endpoint.register
Date:   Thu, 11 May 2023 13:28:24 -0700
Message-Id: <20230511202825.3983806-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): 1
[/local/endpoint/ep0] CIG (auto/value): a
[/local/endpoint/ep0] CIS (auto/value): a
---
 client/player.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index 2880c5ffe140..f055ff941569 100644
--- a/client/player.c
+++ b/client/player.c
@@ -73,6 +73,7 @@ struct endpoint {
 	struct iovec *meta;
 	bool auto_accept;
 	bool acquiring;
+	uint8_t max_transports;
 	uint8_t cig;
 	uint8_t cis;
 	char *transport;
@@ -1056,6 +1057,16 @@ static DBusMessage *endpoint_set_configuration(DBusConnection *conn,
 	print_iter("\t", "Properties", &props);
 
 	free(ep->transport);
+
+	if (!ep->max_transports) {
+		bt_shell_printf("Maximum transports reached: rejecting\n");
+		return g_dbus_create_error(msg,
+					 "org.bluez.Error.Rejected",
+					 "Maximum transports reached");
+	}
+
+	ep->max_transports--;
+
 	ep->transport = strdup(path);
 
 	if (ep->auto_accept) {
@@ -1672,6 +1683,13 @@ static DBusMessage *endpoint_select_configuration(DBusConnection *conn,
 	bt_shell_printf("Endpoint: SelectConfiguration\n");
 	print_iter("\t", "Capabilities", &args);
 
+	if (!ep->max_transports) {
+		bt_shell_printf("Maximum transports reached: rejecting\n");
+		return g_dbus_create_error(msg,
+					 "org.bluez.Error.Rejected",
+					 "Maximum transports reached");
+	}
+
 	if (!ep->auto_accept) {
 		ep->msg = dbus_message_ref(msg);
 		bt_shell_prompt_input("Endpoint", "Enter preset/configuration:",
@@ -1688,8 +1706,11 @@ static DBusMessage *endpoint_select_configuration(DBusConnection *conn,
 
 	reply = endpoint_select_config_reply(msg, p->data.iov_base,
 						p->data.iov_len);
-	if (!reply)
-		return NULL;
+	if (!reply) {
+		reply = g_dbus_create_error(msg, "org.bluez.Error.Rejected",
+								NULL);
+		return reply;
+	}
 
 	bt_shell_printf("Auto Accepting using %s...\n", p->name);
 
@@ -1878,6 +1899,13 @@ static DBusMessage *endpoint_select_properties(DBusConnection *conn,
 	bt_shell_printf("Endpoint: SelectProperties\n");
 	print_iter("\t", "Properties", &args);
 
+	if (!ep->max_transports) {
+		bt_shell_printf("Maximum transports reached: rejecting\n");
+		return g_dbus_create_error(msg,
+					 "org.bluez.Error.Rejected",
+					 "Maximum transports reached");
+	}
+
 	if (!ep->auto_accept) {
 		ep->msg = dbus_message_ref(msg);
 		bt_shell_prompt_input("Endpoint", "Enter preset/configuration:",
@@ -1903,6 +1931,9 @@ static DBusMessage *endpoint_clear_configuration(DBusConnection *conn,
 {
 	struct endpoint *ep = user_data;
 
+	if (ep->max_transports != UINT8_MAX)
+		ep->max_transports++;
+
 	free(ep->transport);
 	ep->transport = NULL;
 
@@ -2234,12 +2265,37 @@ static void endpoint_cig(const char *input, void *user_data)
 	bt_shell_prompt_input(ep->path, "CIS (auto/value):", endpoint_cis, ep);
 }
 
+static void endpoint_max_transports(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	char *endptr = NULL;
+	int value;
+
+	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
+		ep->max_transports = UINT8_MAX;
+	} else {
+		value = strtol(input, &endptr, 0);
+
+		if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+			bt_shell_printf("Invalid argument: %s\n", input);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		ep->max_transports = value;
+	}
+
+	bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig, ep);
+}
+
 static void endpoint_auto_accept(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 
 	if (!strcasecmp(input, "y") || !strcasecmp(input, "yes")) {
 		ep->auto_accept = true;
+		bt_shell_prompt_input(ep->path, "Max Transports (auto/value):",
+						endpoint_max_transports, ep);
+		return;
 	} else if (!strcasecmp(input, "n") || !strcasecmp(input, "no")) {
 		ep->auto_accept = false;
 	} else {
@@ -2977,6 +3033,7 @@ static void register_endpoints(GDBusProxy *proxy)
 				continue;
 
 			ep = endpoint_new(cap);
+			ep->max_transports = UINT8_MAX;
 			ep->auto_accept = true;
 			ep->cig = BT_ISO_QOS_CIG_UNSET;
 			ep->cis = BT_ISO_QOS_CIS_UNSET;
-- 
2.40.0

