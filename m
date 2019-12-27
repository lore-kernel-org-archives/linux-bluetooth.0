Return-Path: <SRS0=NQWU=2R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDB3C2D0C6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Dec 2019 18:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CDF20722
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Dec 2019 18:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkcWHmnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfL0Smq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:42:46 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37705 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfL0Smq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Dec 2019 13:42:46 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so5273676pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Dec 2019 10:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ynMHK9KwHiJ00o0bsZuS1cPFG73MG+Ysg6etroDRYA=;
        b=UkcWHmnw/9vqR1WqVimhZb8O/MEk+vS2aFuntw+GqMBLtNHdv3T8dYs7lG+2Id3Dho
         q23ODKGICjjs0adlT3oZIxVZBqMhUN3p7MMkMDTZ5ogDn9oXtTDazzzy6d634Crg/zMb
         kNZRQyxSvaTleLv3cJBeF128T6kIztcIVxS5fQVcEeD02usXdej39ZeHzbjdFdsDQDoZ
         9GhA6NPpoXl30yGMsiwQoUxAaA1DCCdlg1m704S3mkLvMtnGOBA8b9Dy1MNFsJgIOy0i
         tgxgxBDTVTOlCB0Z4UZ0qcPmP38Zv7+2mPxYLt4sNCXE5ij63TjGrG0BxFiFjuaPCmCP
         qvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ynMHK9KwHiJ00o0bsZuS1cPFG73MG+Ysg6etroDRYA=;
        b=K4J9CLuDskBm5FW4q8atpA9AtFlvWqMgUe98tngHtdzvMIM617Racd+NQoatYJB1JT
         s9vOi7b+uGuVKbLYR8Voy+WlI/Hm5DbjE4Fn9wG0PD7o77mKOH6oLL9RyuAmoFXZDatj
         jqtU2EaGmqhUdE7Rhw0KzKn3tIED+DzC6UwzXwheGV1MpfUgZ20VLqzGbqCT2ERQNeEw
         yBsW/Gl+yvUwzuFKiBuDvTZ1j5QYxpoHa5RpiUaRz7fIfKrw8h84evnxZXWxHOnorR3I
         VDYYgCdIo0fcYe71RbECCcy+OqL1tDVhQqonKTv6ILEKeIiK3x8eSCsFD4CijcmB2rq0
         ohvA==
X-Gm-Message-State: APjAAAUaR9oGhfj1B8g3DDEsEO+iMXKZuXsO92V7oG4eh1n+TXf0lLnK
        TJzkf92dap4XbvyDvslrF2+/jhd55SE=
X-Google-Smtp-Source: APXvYqwMpZzTR6LTQbWQmGvvIAwrk3494k5h0tb/zVGqQnH4LB5QHYzwfKFxzTOB4u1MCVHmMoK99A==
X-Received: by 2002:a17:902:8ec4:: with SMTP id x4mr38382339plo.234.1577472164864;
        Fri, 27 Dec 2019 10:42:44 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id 5sm10663192pjt.28.2019.12.27.10.42.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 10:42:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] agent: Detect when ongoing request is already in progress
Date:   Fri, 27 Dec 2019 10:42:42 -0800
Message-Id: <20191227184242.9983-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This detects when a agent request is already pending for the same device
which could happen when there are 2 or more adapters in the system and
they are trying to pair with each other.
---
 src/adapter.c |   5 +-
 src/agent.c   | 128 ++++++++++++++++++++++++++++++++------------------
 src/agent.h   |   2 +-
 src/device.c  |  12 +++++
 4 files changed, 97 insertions(+), 50 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index cef25616f..63cc5c576 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6454,7 +6454,6 @@ static gboolean process_auth_queue(gpointer user_data)
 	while (!g_queue_is_empty(adapter->auths)) {
 		struct service_auth *auth = adapter->auths->head->data;
 		struct btd_device *device = auth->device;
-		const char *dev_path;
 
 		/* Wait services to be resolved before asking authorization */
 		if (auth->svc_id > 0)
@@ -6477,9 +6476,7 @@ static gboolean process_auth_queue(gpointer user_data)
 			goto next;
 		}
 
-		dev_path = device_get_path(device);
-
-		if (agent_authorize_service(auth->agent, dev_path, auth->uuid,
+		if (agent_authorize_service(auth->agent, device, auth->uuid,
 					agent_auth_cb, adapter, NULL) < 0) {
 			auth->cb(&err, auth->user_data);
 			goto next;
diff --git a/src/agent.c b/src/agent.c
index 183e2f190..e0ffcd22f 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -76,6 +76,7 @@ struct agent {
 
 struct agent_request {
 	agent_request_type_t type;
+	struct btd_device *device; /* Weak reference */
 	struct agent *agent;
 	DBusMessage *msg;
 	DBusPendingCall *call;
@@ -296,6 +297,7 @@ static struct agent *agent_create( const char *name, const char *path,
 }
 
 static struct agent_request *agent_request_new(struct agent *agent,
+						struct btd_device *device,
 						agent_request_type_t type,
 						void *cb,
 						void *user_data,
@@ -306,6 +308,7 @@ static struct agent_request *agent_request_new(struct agent *agent,
 	req = g_new0(struct agent_request, 1);
 
 	req->agent = agent;
+	req->device = device;
 	req->type = type;
 	req->cb = cb;
 	req->user_data = user_data;
@@ -381,10 +384,10 @@ done:
 }
 
 static int agent_call_authorize_service(struct agent_request *req,
-						const char *device_path,
 						const char *uuid)
 {
 	struct agent *agent = req->agent;
+	const char *path;
 
 	req->msg = dbus_message_new_method_call(agent->owner, agent->path,
 					AGENT_INTERFACE, "AuthorizeService");
@@ -393,8 +396,10 @@ static int agent_call_authorize_service(struct agent_request *req,
 		return -ENOMEM;
 	}
 
+	path = device_get_path(req->device);
+
 	dbus_message_append_args(req->msg,
-				DBUS_TYPE_OBJECT_PATH, &device_path,
+				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_STRING, &uuid,
 				DBUS_TYPE_INVALID);
 
@@ -406,23 +411,50 @@ static int agent_call_authorize_service(struct agent_request *req,
 	}
 
 	dbus_pending_call_set_notify(req->call, simple_agent_reply, req, NULL);
+
+	DBG("authorize service request was sent for %s", path);
+
 	return 0;
 }
 
-int agent_authorize_service(struct agent *agent, const char *path,
+static int agent_has_request(struct agent *agent, struct btd_device *device,
+						agent_request_type_t type)
+{
+	if (!agent->request)
+		return 0;
+
+	if (agent->request->type != type)
+		return -EBUSY;
+
+	/* Check if request pending is for the same address */
+	if (bacmp(device_get_address(agent->request->device),
+			btd_adapter_get_address(device_get_adapter(device))))
+		return -EBUSY;
+
+	/* It must match in either direction */
+	if (bacmp(device_get_address(device),
+			btd_adapter_get_address(
+			device_get_adapter(agent->request->device))))
+		return -EBUSY;
+
+	return -EINPROGRESS;
+}
+
+int agent_authorize_service(struct agent *agent, struct btd_device *device,
 				const char *uuid, agent_cb cb,
 				void *user_data, GDestroyNotify destroy)
 {
 	struct agent_request *req;
 	int err;
 
-	if (agent->request)
-		return -EBUSY;
+	err = agent_has_request(agent, device, AGENT_REQUEST_AUTHORIZE_SERVICE);
+	if (err)
+		return err;
 
-	req = agent_request_new(agent, AGENT_REQUEST_AUTHORIZE_SERVICE, cb,
-							user_data, destroy);
+	req = agent_request_new(agent, device, AGENT_REQUEST_AUTHORIZE_SERVICE,
+						cb, user_data, destroy);
 
-	err = agent_call_authorize_service(req, path, uuid);
+	err = agent_call_authorize_service(req, uuid);
 	if (err < 0) {
 		agent_request_free(req, FALSE);
 		return -ENOMEM;
@@ -430,8 +462,6 @@ int agent_authorize_service(struct agent *agent, const char *path,
 
 	agent->request = req;
 
-	DBG("authorize service request was sent for %s", path);
-
 	return 0;
 }
 
@@ -494,10 +524,10 @@ done:
 	agent_unref(agent);
 }
 
-static int pincode_request_new(struct agent_request *req, const char *device_path,
-				dbus_bool_t secure)
+static int pincode_request_new(struct agent_request *req, dbus_bool_t secure)
 {
 	struct agent *agent = req->agent;
+	const char *path;
 
 	/* TODO: Add a new method or a new param to Agent interface to request
 		secure pin. */
@@ -509,7 +539,9 @@ static int pincode_request_new(struct agent_request *req, const char *device_pat
 		return -ENOMEM;
 	}
 
-	dbus_message_append_args(req->msg, DBUS_TYPE_OBJECT_PATH, &device_path,
+	path = device_get_path(req->device);
+
+	dbus_message_append_args(req->msg, DBUS_TYPE_OBJECT_PATH, &path,
 					DBUS_TYPE_INVALID);
 
 	if (g_dbus_send_message_with_reply(btd_get_dbus_connection(), req->msg,
@@ -527,16 +559,15 @@ int agent_request_pincode(struct agent *agent, struct btd_device *device,
 				void *user_data, GDestroyNotify destroy)
 {
 	struct agent_request *req;
-	const char *dev_path = device_get_path(device);
 	int err;
 
 	if (agent->request)
 		return -EBUSY;
 
-	req = agent_request_new(agent, AGENT_REQUEST_PINCODE, cb,
+	req = agent_request_new(agent, device, AGENT_REQUEST_PINCODE, cb,
 							user_data, destroy);
 
-	err = pincode_request_new(req, dev_path, secure);
+	err = pincode_request_new(req, secure);
 	if (err < 0)
 		goto failed;
 
@@ -591,10 +622,10 @@ done:
 	agent_request_free(req, TRUE);
 }
 
-static int passkey_request_new(struct agent_request *req,
-				const char *device_path)
+static int passkey_request_new(struct agent_request *req)
 {
 	struct agent *agent = req->agent;
+	const char *path;
 
 	req->msg = dbus_message_new_method_call(agent->owner, agent->path,
 					AGENT_INTERFACE, "RequestPasskey");
@@ -603,7 +634,9 @@ static int passkey_request_new(struct agent_request *req,
 		return -ENOMEM;
 	}
 
-	dbus_message_append_args(req->msg, DBUS_TYPE_OBJECT_PATH, &device_path,
+	path = device_get_path(req->device);
+
+	dbus_message_append_args(req->msg, DBUS_TYPE_OBJECT_PATH, &path,
 					DBUS_TYPE_INVALID);
 
 	if (g_dbus_send_message_with_reply(btd_get_dbus_connection(), req->msg,
@@ -621,7 +654,6 @@ int agent_request_passkey(struct agent *agent, struct btd_device *device,
 				GDestroyNotify destroy)
 {
 	struct agent_request *req;
-	const char *dev_path = device_get_path(device);
 	int err;
 
 	if (agent->request)
@@ -630,10 +662,10 @@ int agent_request_passkey(struct agent *agent, struct btd_device *device,
 	DBG("Calling Agent.RequestPasskey: name=%s, path=%s",
 			agent->owner, agent->path);
 
-	req = agent_request_new(agent, AGENT_REQUEST_PASSKEY, cb,
+	req = agent_request_new(agent, device, AGENT_REQUEST_PASSKEY, cb,
 							user_data, destroy);
 
-	err = passkey_request_new(req, dev_path);
+	err = passkey_request_new(req);
 	if (err < 0)
 		goto failed;
 
@@ -647,10 +679,10 @@ failed:
 }
 
 static int confirmation_request_new(struct agent_request *req,
-					const char *device_path,
 					uint32_t passkey)
 {
 	struct agent *agent = req->agent;
+	const char *path;
 
 	req->msg = dbus_message_new_method_call(agent->owner, agent->path,
 				AGENT_INTERFACE, "RequestConfirmation");
@@ -659,8 +691,10 @@ static int confirmation_request_new(struct agent_request *req,
 		return -ENOMEM;
 	}
 
+	path = device_get_path(req->device);
+
 	dbus_message_append_args(req->msg,
-				DBUS_TYPE_OBJECT_PATH, &device_path,
+				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_UINT32, &passkey,
 				DBUS_TYPE_INVALID);
 
@@ -680,19 +714,19 @@ int agent_request_confirmation(struct agent *agent, struct btd_device *device,
 				void *user_data, GDestroyNotify destroy)
 {
 	struct agent_request *req;
-	const char *dev_path = device_get_path(device);
 	int err;
 
-	if (agent->request)
-		return -EBUSY;
+	err = agent_has_request(agent, device, AGENT_REQUEST_CONFIRMATION);
+	if (err)
+		return err;
 
 	DBG("Calling Agent.RequestConfirmation: name=%s, path=%s, passkey=%06u",
 			agent->owner, agent->path, passkey);
 
-	req = agent_request_new(agent, AGENT_REQUEST_CONFIRMATION, cb,
+	req = agent_request_new(agent, device, AGENT_REQUEST_CONFIRMATION, cb,
 				user_data, destroy);
 
-	err = confirmation_request_new(req, dev_path, passkey);
+	err = confirmation_request_new(req, passkey);
 	if (err < 0)
 		goto failed;
 
@@ -705,10 +739,10 @@ failed:
 	return err;
 }
 
-static int authorization_request_new(struct agent_request *req,
-						const char *device_path)
+static int authorization_request_new(struct agent_request *req)
 {
 	struct agent *agent = req->agent;
+	const char *path;
 
 	req->msg = dbus_message_new_method_call(agent->owner, agent->path,
 				AGENT_INTERFACE, "RequestAuthorization");
@@ -717,8 +751,10 @@ static int authorization_request_new(struct agent_request *req,
 		return -ENOMEM;
 	}
 
+	path = device_get_path(req->device);
+
 	dbus_message_append_args(req->msg,
-				DBUS_TYPE_OBJECT_PATH, &device_path,
+				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
 
 	if (g_dbus_send_message_with_reply(btd_get_dbus_connection(), req->msg,
@@ -737,19 +773,19 @@ int agent_request_authorization(struct agent *agent, struct btd_device *device,
 						GDestroyNotify destroy)
 {
 	struct agent_request *req;
-	const char *dev_path = device_get_path(device);
 	int err;
 
-	if (agent->request)
-		return -EBUSY;
+	err = agent_has_request(agent, device, AGENT_REQUEST_AUTHORIZATION);
+	if (err)
+		return err;
 
 	DBG("Calling Agent.RequestAuthorization: name=%s, path=%s",
 						agent->owner, agent->path);
 
-	req = agent_request_new(agent, AGENT_REQUEST_AUTHORIZATION, cb,
+	req = agent_request_new(agent, device, AGENT_REQUEST_AUTHORIZATION, cb,
 				user_data, destroy);
 
-	err = authorization_request_new(req, dev_path);
+	err = authorization_request_new(req);
 	if (err < 0)
 		goto failed;
 
@@ -838,10 +874,10 @@ done:
 }
 
 static int display_pincode_request_new(struct agent_request *req,
-					const char *device_path,
 					const char *pincode)
 {
 	struct agent *agent = req->agent;
+	const char *path;
 
 	req->msg = dbus_message_new_method_call(agent->owner, agent->path,
 					AGENT_INTERFACE, "DisplayPinCode");
@@ -850,8 +886,10 @@ static int display_pincode_request_new(struct agent_request *req,
 		return -ENOMEM;
 	}
 
+	path = device_get_path(req->device);
+
 	dbus_message_append_args(req->msg,
-					DBUS_TYPE_OBJECT_PATH, &device_path,
+					DBUS_TYPE_OBJECT_PATH, &path,
 					DBUS_TYPE_STRING, &pincode,
 					DBUS_TYPE_INVALID);
 
@@ -872,19 +910,19 @@ int agent_display_pincode(struct agent *agent, struct btd_device *device,
 				void *user_data, GDestroyNotify destroy)
 {
 	struct agent_request *req;
-	const char *dev_path = device_get_path(device);
 	int err;
 
-	if (agent->request)
-		return -EBUSY;
+	err = agent_has_request(agent, device, AGENT_REQUEST_DISPLAY_PINCODE);
+	if (err)
+		return err;
 
 	DBG("Calling Agent.DisplayPinCode: name=%s, path=%s, pincode=%s",
 					agent->owner, agent->path, pincode);
 
-	req = agent_request_new(agent, AGENT_REQUEST_DISPLAY_PINCODE, cb,
-							user_data, destroy);
+	req = agent_request_new(agent, device, AGENT_REQUEST_DISPLAY_PINCODE,
+				cb, user_data, destroy);
 
-	err = display_pincode_request_new(req, dev_path, pincode);
+	err = display_pincode_request_new(req, pincode);
 	if (err < 0)
 		goto failed;
 
diff --git a/src/agent.h b/src/agent.h
index f14d14325..1438b9e6d 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -45,7 +45,7 @@ void agent_unref(struct agent *agent);
 
 struct agent *agent_get(const char *owner);
 
-int agent_authorize_service(struct agent *agent, const char *path,
+int agent_authorize_service(struct agent *agent, struct btd_device *device,
 				const char *uuid, agent_cb cb,
 				void *user_data, GDestroyNotify destroy);
 
diff --git a/src/device.c b/src/device.c
index 0eec7c922..f7f0bc789 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6166,6 +6166,12 @@ int device_confirm_passkey(struct btd_device *device, uint8_t type,
 						confirm_cb, auth, NULL);
 
 	if (err < 0) {
+		if (err == -EINPROGRESS) {
+			/* Already in progress */
+			confirm_cb(auth->agent, NULL, auth);
+			return 0;
+		}
+
 		error("Failed requesting authentication");
 		device_auth_req_free(device);
 	}
@@ -6213,6 +6219,12 @@ int device_notify_pincode(struct btd_device *device, gboolean secure,
 	err = agent_display_pincode(auth->agent, device, pincode,
 					display_pincode_cb, auth, NULL);
 	if (err < 0) {
+		if (err == -EINPROGRESS) {
+			/* Already in progress */
+			display_pincode_cb(auth->agent, NULL, auth);
+			return 0;
+		}
+
 		error("Failed requesting authentication");
 		device_auth_req_free(device);
 	}
-- 
2.21.0

