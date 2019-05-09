Return-Path: <SRS0=Q31N=TJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E54FC04AB1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 17:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543282085A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 May 2019 17:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEIR6R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 May 2019 13:58:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:65363 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfEIR6Q (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 May 2019 13:58:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 10:58:16 -0700
X-ExtLoop1: 1
Received: from bgix-dell-lap.sea.intel.com ([10.251.10.18])
  by fmsmga004.fm.intel.com with ESMTP; 09 May 2019 10:58:16 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com
Subject: [PATCH BlueZ v5 2/2] mesh: Add key storage
Date:   Thu,  9 May 2019 10:57:39 -0700
Message-Id: <20190509175739.16891-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190509175739.16891-1-brian.gix@intel.com>
References: <20190509175739.16891-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This implements internal key storage add/delete/fetch for the three
basic key types managed in Mesh: Network, Application and Device.

This key storage is separate from keys assigned to nodes within the
mesh, and are used to support Configuration Client functionality.
---
 Makefile.mesh  |   1 +
 mesh/keyring.c | 297 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mesh/keyring.h |  49 ++++++++++
 3 files changed, 347 insertions(+)
 create mode 100644 mesh/keyring.c
 create mode 100644 mesh/keyring.h

diff --git a/Makefile.mesh b/Makefile.mesh
index 76e424b92..bccd4d946 100644
--- a/Makefile.mesh
+++ b/Makefile.mesh
@@ -25,6 +25,7 @@ mesh_sources = mesh/mesh.h mesh/mesh.c \
 				mesh/agent.h mesh/agent.c \
 				mesh/prov-acceptor.c mesh/prov-initiator.c \
 				mesh/pb-adv.h mesh/pb-adv.c \
+				mesh/keyring.h mesh/keyring.c \
 				mesh/mesh-defs.h
 libexec_PROGRAMS += mesh/bluetooth-meshd
 
diff --git a/mesh/keyring.c b/mesh/keyring.c
new file mode 100644
index 000000000..0ca53b0f8
--- /dev/null
+++ b/mesh/keyring.c
@@ -0,0 +1,297 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <dirent.h>
+#include <libgen.h>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+
+#include <ell/ell.h>
+
+#include "mesh/mesh-defs.h"
+
+#include "mesh/net.h"
+#include "mesh/keyring.h"
+#include "mesh/mesh.h"
+#include "mesh/node.h"
+
+const char *dev_key_dir = "/dev_keys";
+const char *app_key_dir = "/app_keys";
+const char *net_key_dir = "/net_keys";
+
+bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
+						struct keyring_net_key *key)
+{
+	char *node_path;
+	char key_file[PATH_MAX];
+	bool result = false;
+	int fd;
+
+	if (!node || !key)
+		return false;
+
+	node_path = node_path_get(node);
+
+	if (strlen(node_path) + strlen(net_key_dir) + 1 + 3 >= PATH_MAX)
+		return false;
+
+	snprintf(key_file, PATH_MAX, "%s%s", node_path, net_key_dir);
+	mkdir(key_file, 0755);
+	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, net_key_dir,
+								net_idx);
+	l_debug("Put Net Key %s", key_file);
+
+	fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC);
+	if (fd > 0) {
+		if (write(fd, key, sizeof(*key)) == sizeof(*key))
+			result = true;
+
+		close(fd);
+	}
+
+	return result;
+}
+
+bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
+				uint16_t net_idx, struct keyring_app_key *key)
+{
+	char *node_path;
+	char key_file[PATH_MAX];
+	bool result = false;
+	int fd;
+
+	if (!node || !key)
+		return false;
+
+	node_path = node_path_get(node);
+
+	if (strlen(node_path) + strlen(app_key_dir) + 1 + 3 >= PATH_MAX)
+		return false;
+
+	snprintf(key_file, PATH_MAX, "%s%s", node_path, app_key_dir);
+	mkdir(key_file, 0755);
+	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, app_key_dir,
+								app_idx);
+	l_debug("Put App Key %s", key_file);
+
+	fd = open(key_file, O_RDONLY);
+	if (fd > 0) {
+		struct keyring_app_key old_key;
+
+		if (read(fd, &old_key, sizeof(old_key)) == sizeof(old_key)) {
+			if (old_key.net_idx != net_idx) {
+				close(fd);
+				return false;
+			}
+		}
+		close(fd);
+	}
+
+	fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC);
+	if (fd > 0) {
+		if (write(fd, key, sizeof(*key)) == sizeof(*key))
+			result = true;
+	}
+	close(fd);
+
+	return result;
+}
+
+bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+					uint8_t count, uint8_t dev_key[16])
+{
+	char *node_path;
+	char key_file[PATH_MAX];
+	bool result = true;
+	int fd, i;
+
+	if (!node)
+		return false;
+
+	node_path = node_path_get(node);
+
+	if (strlen(node_path) + strlen(dev_key_dir) + 1 + 4 >= PATH_MAX)
+		return false;
+
+	snprintf(key_file, PATH_MAX, "%s%s", node_path, dev_key_dir);
+	mkdir(key_file, 0755);
+
+	for (i = 0; i < count; i++) {
+		snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
+						dev_key_dir, unicast + i);
+		l_debug("Put Dev Key %s", key_file);
+
+		fd = open(key_file, O_WRONLY | O_CREAT | O_TRUNC);
+		if (fd > 0) {
+			if (write(fd, dev_key, 16) != 16)
+				result = false;
+
+			close(fd);
+		} else
+			result = false;
+	}
+
+	return result;
+}
+
+bool keyring_get_net_key(struct mesh_node *node, uint16_t net_idx,
+						struct keyring_net_key *key)
+{
+	char *node_path;
+	char key_file[PATH_MAX];
+	bool result = false;
+	int fd;
+
+	if (!node || !key)
+		return false;
+
+	node_path = node_path_get(node);
+	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, net_key_dir,
+								net_idx);
+
+	fd = open(key_file, O_RDONLY);
+	if (fd > 0) {
+		if (read(fd, key, sizeof(*key)) == sizeof(*key))
+			result = true;
+
+		close(fd);
+	}
+
+	return result;
+}
+
+bool keyring_get_app_key(struct mesh_node *node, uint16_t app_idx,
+						struct keyring_app_key *key)
+{
+	char *node_path;
+	char key_file[PATH_MAX];
+	bool result = false;
+	int fd;
+
+	if (!node || !key)
+		return false;
+
+	node_path = node_path_get(node);
+	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, app_key_dir,
+								app_idx);
+
+	fd = open(key_file, O_RDONLY);
+	if (fd > 0) {
+		if (read(fd, key, sizeof(*key)) == sizeof(*key))
+			result = true;
+
+		close(fd);
+	}
+
+	return result;
+}
+
+bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+							uint8_t dev_key[16])
+{
+	char *node_path;
+	char key_file[PATH_MAX];
+	bool result = false;
+	int fd;
+
+	if (!node)
+		return false;
+
+	node_path = node_path_get(node);
+	snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path, dev_key_dir,
+								unicast);
+
+	fd = open(key_file, O_RDONLY);
+	if (fd > 0) {
+		if (read(fd, dev_key, 16) == 16)
+			result = true;
+
+		close(fd);
+	}
+
+	return result;
+}
+
+bool keyring_del_net_key(struct mesh_node *node, uint16_t net_idx)
+{
+	char *node_path;
+	char key_file[PATH_MAX];
+
+	if (!node)
+		return false;
+
+	node_path = node_path_get(node);
+	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, net_key_dir,
+								net_idx);
+	l_debug("RM Net Key %s", key_file);
+	remove(key_file);
+
+	/* TODO: See if it is easiest to delete all bound App keys here */
+	/* TODO: see nftw() */
+
+	return true;
+}
+
+bool keyring_del_app_key(struct mesh_node *node, uint16_t app_idx)
+{
+	char *node_path;
+	char key_file[PATH_MAX];
+
+	if (!node)
+		return false;
+
+	node_path = node_path_get(node);
+	snprintf(key_file, PATH_MAX, "%s%s/%3.3x", node_path, app_key_dir,
+								app_idx);
+	l_debug("RM App Key %s", key_file);
+	remove(key_file);
+
+	return true;
+}
+
+bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+								uint8_t count)
+{
+	char *node_path;
+	char key_file[PATH_MAX];
+	int i;
+
+	if (!node)
+		return false;
+
+	node_path = node_path_get(node);
+	for (i = 0; i < count; i++) {
+		snprintf(key_file, PATH_MAX, "%s%s/%4.4x", node_path,
+						dev_key_dir, unicast + i);
+		l_debug("RM Dev Key %s", key_file);
+		remove(key_file);
+	}
+
+	return true;
+}
diff --git a/mesh/keyring.h b/mesh/keyring.h
new file mode 100644
index 000000000..167191013
--- /dev/null
+++ b/mesh/keyring.h
@@ -0,0 +1,49 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+struct keyring_net_key {
+	uint16_t net_idx;
+	uint8_t phase;
+	uint8_t old_key[16];
+	uint8_t new_key[16];
+};
+
+struct keyring_app_key {
+	uint16_t app_idx;
+	uint16_t net_idx;
+	uint8_t old_key[16];
+	uint8_t new_key[16];
+};
+
+bool keyring_put_net_key(struct mesh_node *node, uint16_t net_idx,
+						struct keyring_net_key *key);
+bool keyring_get_net_key(struct mesh_node *node, uint16_t net_idx,
+						struct keyring_net_key *key);
+bool keyring_del_net_key(struct mesh_node *node, uint16_t net_idx);
+bool keyring_put_app_key(struct mesh_node *node, uint16_t app_idx,
+				uint16_t net_idx, struct keyring_app_key *key);
+bool keyring_get_app_key(struct mesh_node *node, uint16_t app_idx,
+						struct keyring_app_key *key);
+bool keyring_del_app_key(struct mesh_node *node, uint16_t app_idx);
+bool keyring_get_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+							uint8_t dev_key[16]);
+bool keyring_put_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+					uint8_t count, uint8_t dev_key[16]);
+bool keyring_del_remote_dev_key(struct mesh_node *node, uint16_t unicast,
+								uint8_t count);
-- 
2.14.5

