Return-Path: <SRS0=kXS7=33=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D36C352A6
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 11:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9709C20720
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 11:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHmdusK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgBGLjL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:39:11 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:47066 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBGLjJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Feb 2020 06:39:09 -0500
Received: by mail-qk1-f202.google.com with SMTP id y6so1177865qki.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Feb 2020 03:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=F/UrzDWpKEL/HLtJ2wEgg36VIzyPAWBZ0LSExQpUO7w=;
        b=QHmdusK38E9CSL7e/I89CCAMXdarm5PH4b9FrsxFmsgBMLueleW0/xyAThlFTfQgZY
         BqKhS7LEHTroSikt610Ez3Y4kMgXJ5RTHlpsh29LhsGY49Hy1e44LfheBWCIJXUXU5OD
         GsoXeXJBTJ5aw7ptuposNnAWWfSA9F0ixI16gTk2WkgijCwmuKDmn7GxidXruZ9N1tYW
         em0b6SZ87k7fj4GYBStC0jN6c5KBQobp8RDGJn7ewzVD65j/eHtJ/dofzPemTGuUKW8x
         jKxw4x1YymWrCc096XMUATlR8nQwVDDlRw62Pkht9QB++Xwjp1KWql+xc7byqbaxAKzn
         TX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=F/UrzDWpKEL/HLtJ2wEgg36VIzyPAWBZ0LSExQpUO7w=;
        b=SrH0u65s568xDUFzcSiyUi+Yc502ukiKy/efdyNmsZiqHGIpPSZ0HuS6uFlFP3udW1
         +f8tG20V10mC8JgDGTfawOf4gBpwz18X8jiOWSqphMs098YwLPruVRLw+B+0S32vky/Q
         G3C/8EBFlrfBafJqgZGuXjKljJpyzNHrsQACM1XuHzqzXj+ypbbHggQ0HxOGmB4wawcw
         JPA8k6ToW77nIJwC/o0mAfz/kKAxfqEIQDuLMVATwWZAMARO7W1z3FPTFVVZDA/ikWAC
         Su8mSHbBrT/bUBsK+dOsZZQ8Sa697Iz7U+DWivScK8ILljXAz1gM/Q1IN3opw9Kkx1hY
         6/bA==
X-Gm-Message-State: APjAAAVsxeEqeV4Z2whUBH5kdpTbWafeNhDA3fJgg4xh2loEfWbdPaYr
        lS2FXMQJfZox88w/PsQ/EOthEKrE2nznYjfR/ddiTerwuvLsX1KWTXn73Md6O1rNvTj4q2/JiW6
        QAznB08aG8QymtT/Y9nQ6FOK21lf8Lmj618Sk+299Kk/CTQDFvoRtyZ9nSyfZk7Se2tei9wk95z
        fkxmGB4gSNJmo=
X-Google-Smtp-Source: APXvYqyOq3gPQE9kk5+NnTg8VMC1qJu9aTtS0VqV0mm2sTXITVSfHWKkI6BdpeFvkgdPHDsxw+L94MLefoGEPh3rEg==
X-Received: by 2002:a37:801:: with SMTP id 1mr7100623qki.326.1581075548227;
 Fri, 07 Feb 2020 03:39:08 -0800 (PST)
Date:   Fri,  7 Feb 2020 19:38:06 +0800
Message-Id: <20200207193741.Bluez.v1.1.Ibaab6d18071354eb57b66a22de24d0fa995d86b8@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [Bluez PATCH v1] core: Add new policy for Just-Works repairing
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        "howardchung@google.com" <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "howardchung@google.com" <howardchung@google.com>

When kernel find out that the incoming Just-Works pairing is
initiated by a paired device, it is user space's responsibility to
decide the next action.

This patch includes the following:
- add JustWorksRepairing policy as an option in main.conf
- handle the confirmation request from kernel

---
The Just-Works repairing policy could be one of the following:
- never: default; reject the repairing immediately.
- confirm: prompt a confirmation dialog to user.
- always: always accept the repairing.

Note that the confirmation dialog is only available in command
line for now.

 client/agent.c | 22 +++++++++++++++++++
 src/adapter.c  | 13 +++++++++++
 src/agent.c    | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/agent.h    |  4 ++++
 src/device.c   | 14 +++++++++---
 src/hcid.h     |  8 +++++++
 src/main.c     | 27 +++++++++++++++++++++++
 src/main.conf  |  5 +++++
 8 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 4def1b478..544344c46 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -239,6 +239,25 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 	return NULL;
 }
 
+static DBusMessage *request_drop_old_key(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	const char *device;
+
+	bt_shell_printf("Request drop old key\n");
+
+	dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &device,
+							DBUS_TYPE_INVALID);
+
+	bt_shell_prompt_input("agent",
+			      "Drop the old key and accept pairing (yes/no):",
+			      confirm_response, conn);
+
+	pending_message = dbus_message_ref(msg);
+
+	return NULL;
+}
+
 static DBusMessage *authorize_service(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -292,6 +311,9 @@ static const GDBusMethodTable methods[] = {
 	{ GDBUS_ASYNC_METHOD("RequestAuthorization",
 			GDBUS_ARGS({ "device", "o" }),
 			NULL, request_authorization) },
+	{ GDBUS_ASYNC_METHOD("RequestDropOldKey",
+			GDBUS_ARGS({ "device", "o" }),
+			NULL, request_drop_old_key) },
 	{ GDBUS_ASYNC_METHOD("AuthorizeService",
 			GDBUS_ARGS({ "device", "o" }, { "uuid", "s" }),
 			NULL,  authorize_service) },
diff --git a/src/adapter.c b/src/adapter.c
index 329c3ae0b..cecd80ea1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6909,6 +6909,19 @@ static void user_confirm_request_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
+	/*Just-Works repairing policy*/
+	if (ev->confirm_hint == 2) {
+		if (main_opts.jw_repairing == JW_REPAIRING_NEVER) {
+			btd_adapter_confirm_reply(adapter, &ev->addr.bdaddr,
+							ev->addr.type, FALSE);
+			return;
+		} else if (main_opts.jw_repairing == JW_REPAIRING_ALWAYS) {
+			btd_adapter_confirm_reply(adapter, &ev->addr.bdaddr,
+							ev->addr.type, TRUE);
+			return;
+		}
+	}
+
 	err = device_confirm_passkey(device, ev->addr.type, btohl(ev->value),
 							ev->confirm_hint);
 	if (err < 0) {
diff --git a/src/agent.c b/src/agent.c
index e0ffcd22f..3a75e3b00 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -60,6 +60,7 @@ typedef enum {
 	AGENT_REQUEST_PASSKEY,
 	AGENT_REQUEST_CONFIRMATION,
 	AGENT_REQUEST_AUTHORIZATION,
+	AGENT_REQUEST_DROP_OLD_KEY,
 	AGENT_REQUEST_PINCODE,
 	AGENT_REQUEST_AUTHORIZE_SERVICE,
 	AGENT_REQUEST_DISPLAY_PINCODE,
@@ -239,6 +240,7 @@ void agent_unref(struct agent *agent)
 			break;
 		case AGENT_REQUEST_CONFIRMATION:
 		case AGENT_REQUEST_AUTHORIZATION:
+		case AGENT_REQUEST_DROP_OLD_KEY:
 		case AGENT_REQUEST_AUTHORIZE_SERVICE:
 		case AGENT_REQUEST_DISPLAY_PINCODE:
 		default:
@@ -798,6 +800,63 @@ failed:
 	return err;
 }
 
+static int drop_old_key_request_new(struct agent_request *req,
+						const char *device_path)
+{
+	struct agent *agent = req->agent;
+
+	req->msg = dbus_message_new_method_call(agent->owner, agent->path,
+				AGENT_INTERFACE, "RequestDropOldKey");
+	if (req->msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return -ENOMEM;
+	}
+
+	dbus_message_append_args(req->msg,
+				DBUS_TYPE_OBJECT_PATH, &device_path,
+				DBUS_TYPE_INVALID);
+
+	if (g_dbus_send_message_with_reply(btd_get_dbus_connection(), req->msg,
+				&req->call, REQUEST_TIMEOUT) == FALSE) {
+		error("D-Bus send failed");
+		return -EIO;
+	}
+
+	dbus_pending_call_set_notify(req->call, simple_agent_reply, req, NULL);
+
+	return 0;
+}
+
+int agent_request_drop_old_key(struct agent *agent, struct btd_device *device,
+						agent_cb cb, void *user_data,
+						GDestroyNotify destroy)
+{
+	struct agent_request *req;
+	const char *dev_path = device_get_path(device);
+	int err;
+
+	if (agent->request)
+		return -EBUSY;
+
+	DBG("Calling Agent.DropOldKey: name=%s, path=%s",
+						agent->owner, agent->path);
+
+	req = agent_request_new(agent, device, AGENT_REQUEST_DROP_OLD_KEY, cb,
+				user_data, destroy);
+
+	err = drop_old_key_request_new(req, dev_path);
+	if (err < 0)
+		goto failed;
+
+	agent->request = req;
+
+	return 0;
+
+failed:
+	agent_request_free(req, FALSE);
+	return err;
+}
+
 int agent_display_passkey(struct agent *agent, struct btd_device *device,
 				uint32_t passkey, uint16_t entered)
 {
diff --git a/src/agent.h b/src/agent.h
index 1438b9e6d..ccc651dba 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -65,6 +65,10 @@ int agent_request_authorization(struct agent *agent, struct btd_device *device,
 						agent_cb cb, void *user_data,
 						GDestroyNotify destroy);
 
+int agent_request_drop_old_key(struct agent *agent, struct btd_device *device,
+						agent_cb cb, void *user_data,
+						GDestroyNotify destroy);
+
 int agent_display_passkey(struct agent *agent, struct btd_device *device,
 				uint32_t passkey, uint16_t entered);
 
diff --git a/src/device.c b/src/device.c
index a4fe10980..e460e034f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6147,12 +6147,20 @@ int device_confirm_passkey(struct btd_device *device, uint8_t type,
 
 	auth->passkey = passkey;
 
-	if (confirm_hint)
+	switch (confirm_hint) {
+	case 0:
+		err = agent_request_confirmation(auth->agent, device, passkey,
+						confirm_cb, auth, NULL);
+		break;
+	case 1:
 		err = agent_request_authorization(auth->agent, device,
 						confirm_cb, auth, NULL);
-	else
-		err = agent_request_confirmation(auth->agent, device, passkey,
+		break;
+	case 2:
+		err = agent_request_drop_old_key(auth->agent, device,
 						confirm_cb, auth, NULL);
+		break;
+	}
 
 	if (err < 0) {
 		if (err == -EINPROGRESS) {
diff --git a/src/hcid.h b/src/hcid.h
index adea85ce2..bcd2b9fa1 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -35,6 +35,12 @@ typedef enum {
 	BT_GATT_CACHE_NO,
 } bt_gatt_cache_t;
 
+enum {
+	JW_REPAIRING_NEVER,
+	JW_REPAIRING_CONFIRM,
+	JW_REPAIRING_ALWAYS,
+} jw_repairing_t;
+
 struct main_opts {
 	char		*name;
 	uint32_t	class;
@@ -58,6 +64,8 @@ struct main_opts {
 	uint16_t	gatt_mtu;
 
 	uint8_t		key_size;
+
+	jw_repairing_t	jw_repairing;
 };
 
 extern struct main_opts main_opts;
diff --git a/src/main.c b/src/main.c
index 1a6ab36a3..d67f469f1 100644
--- a/src/main.c
+++ b/src/main.c
@@ -93,6 +93,7 @@ static const char *supported_options[] = {
 	"MultiProfile",
 	"FastConnectable",
 	"Privacy",
+	"JustWorksRepairing",
 	NULL
 };
 
@@ -193,6 +194,20 @@ static bt_gatt_cache_t parse_gatt_cache(const char *cache)
 	}
 }
 
+static jw_repairing_t parse_jw_repairing(const char *jw_repairing)
+{
+	if (!strcmp(jw_repairing, "never")) {
+		return JW_REPAIRING_NEVER;
+	} else if (!strcmp(jw_repairing, "confirm")) {
+		return JW_REPAIRING_CONFIRM;
+	} else if (!strcmp(jw_repairing, "always")) {
+		return JW_REPAIRING_ALWAYS;
+	} else {
+		return JW_REPAIRING_NEVER;
+	}
+}
+
+
 static void check_options(GKeyFile *config, const char *group,
 						const char **options)
 {
@@ -331,6 +346,18 @@ static void parse_config(GKeyFile *config)
 		g_free(str);
 	}
 
+	str = g_key_file_get_string(config, "General",
+						"JustWorksRepairing", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+		main_opts.jw_repairing = JW_REPAIRING_NEVER;
+	} else {
+		DBG("just_works_repairing=%s", str);
+		main_opts.jw_repairing = parse_jw_repairing(str);
+		g_free(str);
+	}
+
 	str = g_key_file_get_string(config, "General", "Name", &err);
 	if (err) {
 		DBG("%s", err->message);
diff --git a/src/main.conf b/src/main.conf
index 40687a755..bb5ff5b15 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -72,6 +72,11 @@
 # Defaults to "off"
 # Privacy = off
 
+# Specify the policy to the JUST-WORKS repairing initiated by peer
+# Possible values: "never", "confirm", "always"
+# Defaults to "never"
+#JustWorksRepairing = never
+
 [GATT]
 # GATT attribute cache.
 # Possible values:
-- 
2.25.0.341.g760bfbb309-goog

