Return-Path: <SRS0=Cjqc=2H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D38CC43603
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 14:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B48206B7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Dec 2019 14:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="LUVxm3Va"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLQOyw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:54:52 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:40669 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLQOyw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 09:54:52 -0500
Received: by mail-wr1-f49.google.com with SMTP id c14so11629120wrn.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2019 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LIkUfwhOC8Hp+ksoerRTbQMCqK2PhHk2rDRnMwJqV8=;
        b=LUVxm3Va1+x4NciS3jya6nGVnrDnQHuQlL/h25ZO1jNgJes7LFXLjD2UAYRvN2L2rt
         jaWjG9uP7VDlDFTzYk182DA3pw6pe9vB6aOilYqXXbg+YnwIzIILQifGdl8Ww9Vs8iPq
         ctVGQQYGDrPaK7C30Y4AhBc7SY9UComt1oigMQRMGIcSOe697C36wCVt2thRaHYNkkuR
         aLCk/IwSDyhxHBPcvQF6/QrbSLNGO/v79jJRhPtMBx86f+1v4+cBKpunFVQgzbcWUWMi
         N7Ia03QEEGn5uZqc9JhPhlAcGAJLg5mDYufewhbAPI4r776xlWfcn6lQOlbAGPSh5B6+
         sM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4LIkUfwhOC8Hp+ksoerRTbQMCqK2PhHk2rDRnMwJqV8=;
        b=Y9w+NSp0u3YWPTi/nQ7Uyfv63R5YknXfEUVSamgDy3MfbxZ0euOoXWPNlGDOW8vUB5
         2Oo7fVJwfmqvEo8/HzAWcABmheboCL5zuGS+kCzpR+bejLsYUSykEcg4D22d4vd5GgbZ
         6H5PDsRebbPBhqoJzF8LK6d3QZhe2FYsAZyPT3w40fOrYEhd2mHmrrksRWTSgw8g39fX
         X5xdagM1xRbOxY61Bb++XZ8JlD771F1lJNbuM5D/5bjtxykz/x6H6+oY/3M36Im3VGR5
         JzTEsFsSzbn0yoFNJJwGQs9FspSwMpNJW+wWPr0H1rHcw6eVXCsoCsWg5LS4euqpZVWi
         GkIQ==
X-Gm-Message-State: APjAAAVtJAeIGy6nYRhkcnthmD+kMtqVO6SuGyNhpo57KIIervXkfj1H
        /hw5Sy0rgBkDLdaXCK8G6pTCir65Yk33cg==
X-Google-Smtp-Source: APXvYqzu6/rGbm2Zt/i32IT1bclcAMDgeE+huwjLa0Z0XjBl1K2gEmKW0hI94EU6q9qTyO5kT7HIKg==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr39432917wrx.304.1576594488362;
        Tue, 17 Dec 2019 06:54:48 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id o129sm1633712wmb.1.2019.12.17.06.54.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:54:47 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix getting managed objects from ObjectManager
Date:   Tue, 17 Dec 2019 15:54:42 +0100
Message-Id: <20191217145442.29783-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

D-Bus spec mandates that GetManagedObjects method of
org.freedesktop.DBus.ObjectManager interface returns *children* only:

https://dbus.freedesktop.org/doc/dbus-specification.html
> All returned object paths are children of the object path implementing
> this interface, i.e. their object paths start with the ObjectManager's
> object path plus '/'

Both test scripts and ELL abuse this by returning application interfaces
via ObjectManager attached to the same path, but other D-Bus
implementations do not, making Attach() fail because mandatory
interfaces cannot be found.

This patch fixes the issue by scanning hierarchy returned by
GetManagedObjects for object implementing org.bluez.mesh.Application1
interface and keeping that as node's app_path.
---
 doc/mesh-api.txt | 52 ++++++++++++++++++++++++++----------------------
 mesh/node.c      | 22 +++++++++++---------
 mesh/node.h      |  8 ++++----
 3 files changed, 45 insertions(+), 37 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 30b7452e2..ebff8492a 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -8,13 +8,13 @@ Interface	org.bluez.mesh.Network1
 Object path	/org/bluez/mesh
 
 Methods:
-	void Join(object app_defined_root, array{byte}[16] uuid)
+	void Join(object app_root, array{byte}[16] uuid)
 
 		This is the first method that an application has to call to
 		become a provisioned node on a mesh network. The call will
 		initiate broadcasting of Unprovisioned Device Beacon.
 
-		The app_defined_root parameter is a D-Bus object root path of
+		The app_root parameter is a D-Bus object root path of
 		the application that implements org.bluez.mesh.Application1
 		interface. The application represents a node where child mesh
 		elements have their own objects that implement
@@ -22,7 +22,7 @@ Methods:
 		also contains a provision agent object that implements
 		org.bluez.mesh.ProvisionAgent1 interface. The standard
 		DBus.ObjectManager interface must be available on the
-		app_defined_root path.
+		app_root path.
 
 		The uuid parameter is a 16-byte array that contains Device UUID.
 		This UUID must be unique (at least from the daemon perspective),
@@ -39,18 +39,18 @@ Methods:
 		method.
 
 	object node, array{byte, array{(uint16, dict)}} configuration
-			Attach(object app_defined_root, uint64 token)
+			Attach(object app_root, uint64 token)
 
 		This is the first method that an application must call to get
 		access to mesh node functionalities.
 
-		The app_defined_root parameter is a D-Bus object root path of
+		The app_root parameter is a D-Bus object root path of
 		the application that implements org.bluez.mesh.Application1
 		interface. The application represents a node where child mesh
 		elements have their own objects that implement
 		org.bluez.mesh.Element1 interface. The standard
 		DBus.ObjectManager interface must be available on the
-		app_defined_root path.
+		app_root path.
 
 		The token parameter is a 64-bit number that has been assigned to
 		the application when it first got provisioned/joined mesh
@@ -701,30 +701,34 @@ Mesh Application Hierarchy
 ==========================
 Service		unique name
 Interface	org.bluez.mesh.Application1
-Object path	<app_defined_root>
+Object path	<app_root>
 
 An application is a collection of elements that host SIG defined and vendor
 specific models. It is expected that an application implements
-org.freedesktop.DBus.ObjectManager interface.
+org.freedesktop.DBus.ObjectManager interface at app_root path.
 
 An example mesh application hierarchy may look like this:
 
-		-> /com/example
-			|   - org.freedesktop.DBus.ObjectManager
-			|   - org.bluez.mesh.Application1
-			|   - org.bluez.mesh.Attention1 (optional)
-			|   - org.bluez.mesh.Provisioner1 (optional,Provisioner)
-			|
-			-> /com/example/agent
-			| |   - org.bluez.mesh.ProvisionAgent1
-			|
-			-> /com/example/ele00
-			| |   - org.bluez.mesh.Element1
-			-> /com/example/ele01
-			| |   - org.bluez.mesh.Element1
-			...
-			-> /com/example/elexx
-			| |   - org.bluez.mesh.Element1
+-> /com/example
+  |   - org.freedesktop.DBus.ObjectManager
+  |
+  -> /com/example/application
+  |   - org.bluez.mesh.Application1
+  |   - org.bluez.mesh.Attention1 (optional)
+  |   - org.bluez.mesh.Provisioner1 (optional,Provisioner)
+  |
+  -> /com/example/agent
+  |   - org.bluez.mesh.ProvisionAgent1
+  |
+  -> /com/example/ele00
+  |   - org.bluez.mesh.Element1
+  |
+  -> /com/example/ele01
+  |   - org.bluez.mesh.Element1
+  |
+  ...
+  -> /com/example/elexx
+      - org.bluez.mesh.Element1
 
 Methods:
 	void JoinComplete(uint64 token)
diff --git a/mesh/node.c b/mesh/node.c
index c8a1dae78..28afe608f 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1522,6 +1522,11 @@ static void get_managed_objects_cb(struct l_dbus_message *msg, void *user_data)
 					goto fail;
 			} else if (!strcmp(MESH_APPLICATION_INTERFACE,
 								interface)) {
+				if (have_app)
+					goto fail;
+
+				req->node->app_path = l_strdup(path);
+
 				res = get_app_properties(node, path,
 								&properties);
 				if (!res)
@@ -1665,7 +1670,7 @@ fail:
 }
 
 /* Establish relationship between application and mesh node */
-int node_attach(const char *app_path, const char *sender, uint64_t token,
+int node_attach(const char *app_root, const char *sender, uint64_t token,
 					node_ready_func_t cb, void *user_data)
 {
 	struct managed_obj_request *req;
@@ -1688,14 +1693,13 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 	 * application. Existing node is passed in req->attach.
 	 */
 	req->node = node_new(node->uuid);
-	req->node->app_path = l_strdup(app_path);
 	req->node->owner = l_strdup(sender);
 	req->ready_cb = cb;
 	req->pending_msg = user_data;
 	req->attach = node;
 	req->type = REQUEST_TYPE_ATTACH;
 
-	l_dbus_method_call(dbus_get_bus(), sender, app_path,
+	l_dbus_method_call(dbus_get_bus(), sender, app_root,
 					L_DBUS_INTERFACE_OBJECT_MANAGER,
 					"GetManagedObjects", NULL,
 					get_managed_objects_cb,
@@ -1706,7 +1710,7 @@ int node_attach(const char *app_path, const char *sender, uint64_t token,
 
 
 /* Create a temporary pre-provisioned node */
-void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
+void node_join(const char *app_root, const char *sender, const uint8_t *uuid,
 						node_join_ready_func_t cb)
 {
 	struct managed_obj_request *req;
@@ -1718,14 +1722,14 @@ void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
 	req->join_ready_cb = cb;
 	req->type = REQUEST_TYPE_JOIN;
 
-	l_dbus_method_call(dbus_get_bus(), sender, app_path,
+	l_dbus_method_call(dbus_get_bus(), sender, app_root,
 					L_DBUS_INTERFACE_OBJECT_MANAGER,
 					"GetManagedObjects", NULL,
 					get_managed_objects_cb,
 					req, l_free);
 }
 
-bool node_import(const char *app_path, const char *sender, const uint8_t *uuid,
+bool node_import(const char *app_root, const char *sender, const uint8_t *uuid,
 			const uint8_t dev_key[16], const uint8_t net_key[16],
 			uint16_t net_idx, bool kr, bool ivu,
 			uint32_t iv_index, uint16_t unicast,
@@ -1752,7 +1756,7 @@ bool node_import(const char *app_path, const char *sender, const uint8_t *uuid,
 
 	req->type = REQUEST_TYPE_IMPORT;
 
-	l_dbus_method_call(dbus_get_bus(), sender, app_path,
+	l_dbus_method_call(dbus_get_bus(), sender, app_root,
 						L_DBUS_INTERFACE_OBJECT_MANAGER,
 						"GetManagedObjects", NULL,
 						get_managed_objects_cb,
@@ -1760,7 +1764,7 @@ bool node_import(const char *app_path, const char *sender, const uint8_t *uuid,
 	return true;
 }
 
-void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
+void node_create(const char *app_root, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data)
 {
 	struct managed_obj_request *req;
@@ -1773,7 +1777,7 @@ void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
 	req->pending_msg = user_data;
 	req->type = REQUEST_TYPE_CREATE;
 
-	l_dbus_method_call(dbus_get_bus(), sender, app_path,
+	l_dbus_method_call(dbus_get_bus(), sender, app_root,
 					L_DBUS_INTERFACE_OBJECT_MANAGER,
 					"GetManagedObjects", NULL,
 					get_managed_objects_cb,
diff --git a/mesh/node.h b/mesh/node.h
index 7448756ae..c718c038d 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -31,7 +31,7 @@ typedef void (*node_join_ready_func_t) (struct mesh_node *node,
 						struct mesh_agent *agent);
 
 void node_remove(struct mesh_node *node);
-void node_join(const char *app_path, const char *sender, const uint8_t *uuid,
+void node_join(const char *app_root, const char *sender, const uint8_t *uuid,
 						node_join_ready_func_t cb);
 uint8_t *node_uuid_get(struct mesh_node *node);
 struct mesh_net *node_get_net(struct mesh_node *node);
@@ -82,13 +82,13 @@ const char *node_get_app_path(struct mesh_node *node);
 bool node_add_pending_local(struct mesh_node *node, void *info);
 void node_attach_io_all(struct mesh_io *io);
 void node_attach_io(struct mesh_node *node, struct mesh_io *io);
-int node_attach(const char *app_path, const char *sender, uint64_t token,
+int node_attach(const char *app_root, const char *sender, uint64_t token,
 					node_ready_func_t cb, void *user_data);
 void node_build_attach_reply(struct mesh_node *node,
 						struct l_dbus_message *reply);
-void node_create(const char *app_path, const char *sender, const uint8_t *uuid,
+void node_create(const char *app_root, const char *sender, const uint8_t *uuid,
 					node_ready_func_t cb, void *user_data);
-bool node_import(const char *app_path, const char *sender, const uint8_t *uuid,
+bool node_import(const char *app_root, const char *sender, const uint8_t *uuid,
 			const uint8_t dev_key[16], const uint8_t net_key[16],
 			uint16_t net_idx, bool kr, bool ivu,
 			uint32_t iv_index, uint16_t unicast,
-- 
2.19.1

