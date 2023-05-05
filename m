Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18EEC77B7C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 May 2023 19:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjEETkG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 May 2023 15:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjEETkC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 May 2023 15:40:02 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D835C4C19
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 May 2023 12:39:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64115eef620so22025727b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 May 2023 12:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683315599; x=1685907599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhQNBWqC9lqK4IiI6j/CljW1RluY+lMC35YxnIdFeQs=;
        b=C1znX96vq2D6zsGiCDdHB+tkXRrYdsBeWp/G6KOgex9O31MwkSQ9ShRdIPImidoqCz
         wsFFtGwT9r9+dZH9Z8Ws/dFwW/MADKcT756QtmNVa+5K4JBFnpOjTzzK2ywJtPtvX3ti
         BgKtl00bz45CAXP2q1y2erGcK3o1oYkXReQ67wyM8q6z4GJ95yDqGIVrNa3u+igeYJS/
         Wn2vMAiR8jFKRyMUFbDz8YUM9EVFDaX6hSo24Pur5Kyp79RfMLnLvHQ4FFuZQj6FgeBG
         v3XYrzg2Y5p4tO1g/AOHdF5ElrH1f4CRwGjSnCZdFZFlOpIzoNgdim3vJmfWZ5L3v6lK
         5dxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683315599; x=1685907599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhQNBWqC9lqK4IiI6j/CljW1RluY+lMC35YxnIdFeQs=;
        b=cpj6o6WeMjB9vqNVpmawvW+Q4wfDlxjTDVS5CDcvLHBSRURz6AGjDOlKYrzAoo6buo
         dd7Dwy0qdZOxa/R1AN8WThr0ob+RYLhRLCo74DlmbZCcvKdxOjZcgS2RM1qLm96ah9Ad
         g0S/84DMemrvKBf1MYDLbvC+z3qHou4oRvuq2hNksZpYo6s9ubrigzrOS9cbGV5jOtiV
         6g9Zet1t0pjjcFUtN0Ym3Lw0x0LmLWYvolJ1vc4e4zo8GHgmv8kZiV9we7IOr7tSAIVR
         3l1LA0EO95g9FQ/9gNpEOhzQgTsfI/Iu0ZRNgrJj6XpkhdJvtmO0tknBBrakxQMUWJrV
         4vXA==
X-Gm-Message-State: AC+VfDwp8bydD9SK7DWOqDKiRDp9f+oZawbw1Y3hZymGY86xNbubUByI
        lXTVClmsq4aqd/hLtyWVS1KZheEejZxpvw==
X-Google-Smtp-Source: ACHHUZ6dYYqCW2b83O4lgEpH5fX1O9v8WPXx/GWZJxRsItNdE3Ha2J0ytB3WbrDD/gCRruyPJpZxdg==
X-Received: by 2002:a17:902:d505:b0:1a6:f93a:a136 with SMTP id b5-20020a170902d50500b001a6f93aa136mr9771664plg.22.1683315598938;
        Fri, 05 May 2023 12:39:58 -0700 (PDT)
Received: from fedora.. ([2601:601:a480:c78::1000])
        by smtp.googlemail.com with ESMTPSA id jk1-20020a170903330100b0019e60c645b1sm2140801plb.305.2023.05.05.12.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:39:58 -0700 (PDT)
From:   Inga Stotland <inga.stotland@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@gmail.com, Inga Stotland <inga.stotland@gmail.com>
Subject: [PATCH BlueZ] mesh: Update the behavior of --io option
Date:   Fri,  5 May 2023 12:39:31 -0700
Message-Id: <20230505193931.106760-1-inga.stotland@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This aligns the behavior of command line option --io to
add new "auto" value and modify the behavior of "generic"
value:

*auto* - Use first available controller: via MGMT interface
if kernel supports it, otherwise, via raw HCI socket (i.e.,
default to *generic*).

*generic:[hci]<index>* - Use generic HCI io on interface hci<index>

The default value is now *auto*, whereas *generic* is used
only if the specific HCI controller is explicitly specified.
---
 mesh/bluetooth-meshd.rst.in | 11 ++++++----
 mesh/main.c                 | 40 +++++++++++--------------------------
 mesh/mesh-io-generic.c      |  3 +++
 mesh/mesh-io.c              | 17 +++++++++++-----
 mesh/mesh-mgmt.c            |  5 +++++
 mesh/mesh-mgmt.h            |  1 +
 6 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/mesh/bluetooth-meshd.rst.in b/mesh/bluetooth-meshd.rst.in
index 06cdb69da..761536711 100644
--- a/mesh/bluetooth-meshd.rst.in
+++ b/mesh/bluetooth-meshd.rst.in
@@ -36,14 +36,17 @@ OPTIONS
 -i <type>, --io <type>
     Specifies I/O interface type:
 
-    *hci<index>* - Use generic HCI io on interface hci<index>,
-    or, if no idex is specified, the first available one.
+    *auto* - Use first available controller: via MGMT interface
+    if kernel supports it, otherwise, via raw HCI socket.
+
+    *generic:[hci]<index>* - Use generic HCI io on interface
+    hci<index>.
 
     *unit:<fd_path>*- Specifies open file descriptor for
     daemon testing.
 
-    By default, if no type is specified, uses generic I/O
-    on the first available HCI interface.
+    By default, if no type is specified, uses auto I/O
+    on the first available controller.
 
 -c <file>, --config <file>
     Specifies an explicit config file path instead of relying on the
diff --git a/mesh/main.c b/mesh/main.c
index 3bca020a0..145bcfa98 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -48,6 +48,12 @@ static const struct option main_options[] = {
 	{ }
 };
 
+static const char *io_usage =
+	       "\t(auto | generic:[hci]<index> | unit:<fd_path>)\n"
+	       "\t\tauto - Use first available controller (MGMT or raw HCI)\n"
+	       "\t\tgeneric - Use raw HCI io on interface hci<index>\n"
+	       "\t\tunit - Use test IO (for automatic testing only)\n";
+
 static void usage(void)
 {
 	fprintf(stderr,
@@ -55,18 +61,14 @@ static void usage(void)
 	       "\tbluetooth-meshd [options]\n");
 	fprintf(stderr,
 		"Options:\n"
-	       "\t--io <io>         Use specified io (default: generic)\n"
+	       "\t--io <io>         Use specified io (default: auto)\n"
 	       "\t--config          Daemon configuration directory\n"
 	       "\t--storage         Mesh node(s) configuration directory\n"
 	       "\t--nodetach        Run in foreground\n"
 	       "\t--debug           Enable debug output\n"
 	       "\t--dbus-debug      Enable D-Bus debugging\n"
 	       "\t--help            Show %s information\n", __func__);
-	fprintf(stderr,
-	       "io:\n"
-	       "\t([hci]<index> | generic[:[hci]<index>] | unit:<fd_path>)\n"
-	       "\t\tUse generic HCI io on interface hci<index>, or the first\n"
-	       "\t\tavailable one\n");
+	fprintf(stderr, "\n\t io: %s", io_usage);
 }
 
 static void do_debug(const char *str, void *user_data)
@@ -157,21 +159,8 @@ static bool parse_io(const char *optarg, enum mesh_io_type *type, void **opts)
 		*opts = index;
 
 		optarg += strlen("auto");
-		if (!*optarg) {
-			*index = MGMT_INDEX_NONE;
-			return true;
-		}
-
-		if (*optarg != ':')
-			return false;
-
-		optarg++;
-
-		if (sscanf(optarg, "hci%d", index) == 1)
-			return true;
-
-		if (sscanf(optarg, "%d", index) == 1)
-			return true;
+		*index = MGMT_INDEX_NONE;
+		return true;
 
 		return false;
 	} else if (strstr(optarg, "generic") == optarg) {
@@ -181,12 +170,7 @@ static bool parse_io(const char *optarg, enum mesh_io_type *type, void **opts)
 		*opts = index;
 
 		optarg += strlen("generic");
-		if (!*optarg) {
-			*index = MGMT_INDEX_NONE;
-			return true;
-		}
-
-		if (*optarg != ':')
+		if (!*optarg || *optarg != ':')
 			return false;
 
 		optarg++;
@@ -291,7 +275,7 @@ int main(int argc, char *argv[])
 		io = l_strdup_printf("auto");
 
 	if (!parse_io(io, &io_type, &io_opts)) {
-		l_error("Invalid io: %s", io);
+		l_error("Invalid io: %s\n%s", io, io_usage);
 		status = EXIT_FAILURE;
 		goto done;
 	}
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 93a56275b..00932ade7 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -380,6 +380,9 @@ static void hci_init(void *user_data)
 	if (io->pvt->hci)
 		bt_hci_unref(io->pvt->hci);
 
+	/* Clear controller HCI list to suppress mgmt interface warnings */
+	mesh_mgmt_clear();
+
 	io->pvt->hci = bt_hci_new_user_channel(io->index);
 	if (!io->pvt->hci) {
 		l_error("Failed to start mesh io (hci %u): %s", io->index,
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 48e3f4226..b953bf4cf 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -72,12 +72,20 @@ static void ctl_alert(int index, bool up, bool pwr, bool mesh, void *user_data)
 	enum mesh_io_type type = L_PTR_TO_UINT(user_data);
 	const struct mesh_io_api *api = NULL;
 
-	l_warn("up:%d pwr: %d mesh: %d", up, pwr, mesh);
+	l_warn("index %u up:%d pwr: %d mesh: %d", index, up, pwr, mesh);
 
 	/* If specific IO controller requested, honor it */
-	if (default_io->favored_index != MGMT_INDEX_NONE &&
-					default_io->favored_index != index)
-		return;
+	if (default_io->favored_index != MGMT_INDEX_NONE) {
+		if (default_io->favored_index != index)
+			return;
+
+		if (!up | pwr) {
+			l_warn("HCI%u failed to start generic IO %s",
+				index, pwr ? ": already powered on" : "");
+			if (default_io->ready)
+				default_io->ready(default_io->user_data, false);
+		}
+	}
 
 	if (!up && default_io->index == index) {
 		/* Our controller has disappeared */
@@ -104,7 +112,6 @@ static void ctl_alert(int index, bool up, bool pwr, bool mesh, void *user_data)
 		default_io->index = index;
 		default_io->api = api;
 		api->init(default_io, &index, default_io->user_data);
-
 		l_queue_foreach(default_io->rx_regs, refresh_rx, default_io);
 	}
 }
diff --git a/mesh/mesh-mgmt.c b/mesh/mesh-mgmt.c
index d37aeb5ac..fd21a168a 100644
--- a/mesh/mesh-mgmt.c
+++ b/mesh/mesh-mgmt.c
@@ -271,3 +271,8 @@ bool mesh_mgmt_unregister(unsigned int id)
 {
 	return mgmt_unregister(mgmt_mesh, id);
 }
+
+void mesh_mgmt_clear(void)
+{
+	l_queue_clear(ctl_list, l_free);
+}
diff --git a/mesh/mesh-mgmt.h b/mesh/mesh-mgmt.h
index a3cd72faf..570282297 100644
--- a/mesh/mesh-mgmt.h
+++ b/mesh/mesh-mgmt.h
@@ -22,3 +22,4 @@ unsigned int mesh_mgmt_register(uint16_t event, uint16_t index,
 				void *user_data, mgmt_destroy_func_t destroy);
 bool mesh_mgmt_unregister(unsigned int id);
 void mesh_mgmt_destroy(void);
+void mesh_mgmt_clear(void);
-- 
2.40.1

