Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC977EE49A5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Aug 2023 13:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjHSNdj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Aug 2023 09:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHSNdi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Aug 2023 09:33:38 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E381A2B6
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Aug 2023 06:31:34 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RSflg1CmHzyd2;
        Sat, 19 Aug 2023 16:31:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1692451887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wBO73R9ff7gSKgLy3qUisXiLGhrcRmdpR547QojgoA=;
        b=iP8hssisP/DndwDrJRwS3Q2MEyunAp7eIUWkz2xjmGcB0yOi9ewsWZW+OyWbaTQMCAEqM2
        bTCc8kzeylD4AGuEau1rh8DqI8eUdccw88d8qM/OlB801MlowWaHpKgxyCFEasQobocux8
        ZUVuFnQIR1HFCfqX7Yvi9cn45+8Ak6g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1692451887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wBO73R9ff7gSKgLy3qUisXiLGhrcRmdpR547QojgoA=;
        b=IXgKYnUA9aXp0RrVRmKiBD+sfSXbFzvu89rgJaOojKw7B0zHLTxYICsNuNChbOUdffxSIf
        vP/w91Cgydiypd3y2+BzCQzemgMqWUwDumcSBPSKqi04HYNDelVSvtEBZPUWsrg5LY5ZDN
        Khp3O+r2cCLJmehFboBdT8fExpmu6RU=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1692451887; a=rsa-sha256; cv=none;
        b=SVScu7nbldfmyl7YKkQ7JloFQMmmSkgsDO8HdU1OfpPS91nd0Ealj2WTS2f6+VBx3EySQy
        YOVU42aOdNz1AAVOlxGAjrpnzkSuh8N3E2rg8ezgDUeltWEsJ7uLfpc3t/2QtXcBSdMGE0
        eqSsfbpdhc/nzfZ0xNtTYmKL/n+DhPc=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/4] hciemu: Add hciemu_flush_client_events for ordering VHCI vs bthost
Date:   Sat, 19 Aug 2023 16:31:21 +0300
Message-ID: <70e5ea48b34f3fdb339e92faf4ceb0fefff91f53.1692451184.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <feaee15ebafa76155f6c1a91755d6d5ba054d451.1692451184.git.pav@iki.fi>
References: <feaee15ebafa76155f6c1a91755d6d5ba054d451.1692451184.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

bthost commands execute with a delay because events may be sitting in
the socketpair queues.  This makes it difficult to ensure, when writing
tests, that certain bthost commands have been handled, before any new
events from VHCI are processed.

To make event ordering possible, add a function that flushes client
bthost/btdev socketpair queues, before processing any new VHCI events.
This is done by pausing VHCI input processing until the kernel
socketpair queues are empty.
---
 emulator/hciemu.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 emulator/hciemu.h |  3 +++
 2 files changed, 57 insertions(+)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index dcfed9be7..0b5847c27 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -21,6 +21,7 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <sys/socket.h>
+#include <sys/ioctl.h>
 
 #include <glib.h>
 
@@ -41,6 +42,7 @@ struct hciemu_client {
 	guint start_source;
 	guint host_source;
 	guint source;
+	int sock[2];
 };
 
 struct hciemu {
@@ -54,6 +56,8 @@ struct hciemu {
 	hciemu_debug_func_t debug_callback;
 	hciemu_destroy_func_t debug_destroy;
 	void *debug_data;
+
+	unsigned int flush_id;
 };
 
 struct hciemu_command_hook {
@@ -338,6 +342,9 @@ static struct hciemu_client *hciemu_client_new(struct hciemu *hciemu,
 		return NULL;
 	}
 
+	client->sock[0] = sv[0];
+	client->sock[1] = sv[1];
+
 	client->source = create_source_btdev(sv[0], client->dev);
 	client->host_source = create_source_bthost(sv[1], client->host);
 	client->start_source = g_idle_add(start_host, client);
@@ -435,6 +442,9 @@ void hciemu_unref(struct hciemu *hciemu)
 	queue_destroy(hciemu->post_command_hooks, destroy_command_hook);
 	queue_destroy(hciemu->clients, hciemu_client_destroy);
 
+	if (hciemu->flush_id)
+		g_source_remove(hciemu->flush_id);
+
 	vhci_close(hciemu->vhci);
 
 	free(hciemu);
@@ -744,3 +754,47 @@ bool hciemu_del_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 
 	return btdev_del_hook(dev, hook_type, opcode);
 }
+
+static bool client_is_pending(const void *data, const void *match_data)
+{
+	struct hciemu_client *client = (struct hciemu_client *)data;
+	int used, i;
+
+	if (!client->source || !client->host_source)
+		return false;
+
+	for (i = 0; i < 2; ++i) {
+		if (!ioctl(client->sock[i], TIOCOUTQ, &used) && used > 0)
+			return true;
+		if (!ioctl(client->sock[i], TIOCINQ, &used) && used > 0)
+			return true;
+	}
+
+	return false;
+}
+
+static gboolean flush_client_events(gpointer user_data)
+{
+	struct hciemu *hciemu = user_data;
+
+	if (queue_find(hciemu->clients, client_is_pending, NULL))
+		return TRUE;
+
+	hciemu->flush_id = 0;
+
+	util_debug(hciemu->debug_callback, hciemu->debug_data, "vhci: resume");
+	if (hciemu->vhci)
+		vhci_pause_input(hciemu->vhci, false);
+
+	return FALSE;
+}
+
+void hciemu_flush_client_events(struct hciemu *hciemu)
+{
+	if (hciemu->flush_id || !hciemu->vhci)
+		return;
+
+	util_debug(hciemu->debug_callback, hciemu->debug_data, "vhci: pause");
+	vhci_pause_input(hciemu->vhci, true);
+	hciemu->flush_id = g_idle_add(flush_client_events, hciemu);
+}
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 3a06ca578..3449eae41 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -48,6 +48,9 @@ bool hciemu_set_debug(struct hciemu *hciemu, hciemu_debug_func_t callback,
 struct vhci *hciemu_get_vhci(struct hciemu *hciemu);
 struct bthost *hciemu_client_get_host(struct hciemu *hciemu);
 
+/* Process pending client events before new VHCI events */
+void hciemu_flush_client_events(struct hciemu *hciemu);
+
 const char *hciemu_get_address(struct hciemu *hciemu);
 uint8_t *hciemu_get_features(struct hciemu *hciemu);
 
-- 
2.41.0

