Return-Path: <SRS0=ITyu=7V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8489AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 20:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6E220760
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jun 2020 20:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odpUJ5YO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgFHU0c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgFHU0b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jun 2020 16:26:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66923C08C5C2
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2020 13:26:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so8150159pfw.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2020 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bOhI1SBTamVD3niivD5lV9rZhqVw5pQJyfhJ2WHVZe8=;
        b=odpUJ5YOgnuy82sNDaaQd3HHydcQcGOPe1sr7N4ao+NVp+rZZY91YWCKChlkXmBGDW
         js3u6xQrRsZwiU6x4ssZoX3fO4hmOvZPu4Vb2H04DKZ6QRiETPqJQXRvQSn49zbO3lAu
         Owku1ipw7clIAdSsQIspM1jAZDZxA4BU9t7zQnGdmS4YuYviF7SL1epMIdV/8811FBnw
         6xgfQOWqUFPHxIoH8jZRgsaqRkvhCHNVPyE+lYeM3hwarsouVAdhwYFT5MXYi6QlBKn6
         zV0+X+joALkjeS1dwnkYMyc+dpt0Lc8feYN5NoLK2C0UdxNAKcYLfxxyCmvJskU0xyld
         L8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bOhI1SBTamVD3niivD5lV9rZhqVw5pQJyfhJ2WHVZe8=;
        b=mK8nqfccxP8hL3y5fNwxL4HW/Oakq0EncJg6mspe5asoVR2tGOY+dj8Uv4mNenjRxp
         u04MRpNPWpcG5g5CfH2urg93tBEaoQLlLybiYi6nG9obsPcDpfXfPEGRZzlE5kspwn9z
         hw1THy7K5DUpVFQcmymk4XtMWRCPtqPCDlEY3ItJbtn2C1DIo1lWXEgP92EiIp/y3i7F
         3mKschWT3j+8v8sUU0k2VnGMCRyruwu74FigCAIoGbzA+dvWXkfm0CZyf0qsZD4+1zsi
         sxuNjTE9P2sJwPSMzaT7S+2XOOCxHUYSDTGnNmUY/KBvZOowER5ju0o/EkmWHIYrw7pX
         k7Hw==
X-Gm-Message-State: AOAM530uYrMd/Xg6CBYRHsSwhAF+vI+y6YqJLLSsAc2hDOBTTtPuDsHr
        JGV56iPFOy64gNpDl702HBOcZBXK
X-Google-Smtp-Source: ABdhPJxqK6+HxDfgO5DKnO43ydMcyMeqC5Ut9TU65g65gzMcX5L/0aCx3DrZmkEavmKr2h6UF8rOgQ==
X-Received: by 2002:a63:1a42:: with SMTP id a2mr21894819pgm.269.1591647990181;
        Mon, 08 Jun 2020 13:26:30 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u19sm8446574pfk.98.2020.06.08.13.26.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 13:26:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Use streaming mode when MPS is enabled
Date:   Mon,  8 Jun 2020 13:26:28 -0700
Message-Id: <20200608202628.875833-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If MPS is enabled use L2CAP streaming mode for AVDTP channels.
---
 profiles/audio/a2dp.c  |  8 ++++++++
 profiles/audio/avdtp.c |  9 +++++++++
 src/hcid.h             |  7 +++++++
 src/main.c             | 16 ++++++----------
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 0a66589b0..f00e5c923 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -43,6 +43,7 @@
 
 #include "gdbus/gdbus.h"
 
+#include "src/hcid.h"
 #include "src/plugin.h"
 #include "src/adapter.h"
 #include "src/device.h"
@@ -2331,14 +2332,21 @@ drop:
 static bool a2dp_server_listen(struct a2dp_server *server)
 {
 	GError *err = NULL;
+	BtIOMode mode;
 
 	if (server->io)
 		return true;
 
+	if (main_opts.mps == MPS_OFF)
+		mode = BT_IO_MODE_BASIC;
+	else
+		mode = BT_IO_MODE_STREAMING;
+
 	server->io = bt_io_listen(NULL, confirm_cb, server, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR,
 				btd_adapter_get_address(server->adapter),
 				BT_IO_OPT_PSM, AVDTP_PSM,
+				BT_IO_OPT_MODE, mode,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_MASTER, true,
 				BT_IO_OPT_INVALID);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 45727f01e..e5193f79b 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -42,6 +42,7 @@
 #include "lib/uuid.h"
 
 #include "btio/btio.h"
+#include "src/hcid.h"
 #include "src/log.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
@@ -2406,9 +2407,15 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
 	GError *err = NULL;
 	GIOChannel *io;
 	const bdaddr_t *src;
+	BtIOMode mode;
 
 	src = btd_adapter_get_address(device_get_adapter(session->device));
 
+	if (main_opts.mps == MPS_OFF)
+		mode = BT_IO_MODE_BASIC;
+	else
+		mode = BT_IO_MODE_STREAMING;
+
 	if (session->phy)
 		io = bt_io_connect(avdtp_connect_cb, session,
 					NULL, &err,
@@ -2416,6 +2423,7 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
 					BT_IO_OPT_DEST_BDADDR,
 					device_get_address(session->device),
 					BT_IO_OPT_PSM, AVDTP_PSM,
+					BT_IO_OPT_MODE, mode,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					/* Set Input MTU to 0 to auto-tune */
 					BT_IO_OPT_IMTU, 0,
@@ -2427,6 +2435,7 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
 					BT_IO_OPT_DEST_BDADDR,
 					device_get_address(session->device),
 					BT_IO_OPT_PSM, AVDTP_PSM,
+					BT_IO_OPT_MODE, mode,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_INVALID);
 	if (!io) {
diff --git a/src/hcid.h b/src/hcid.h
index 56e2b4f31..1b2714b1d 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -41,6 +41,12 @@ enum jw_repairing_t {
 	JW_REPAIRING_ALWAYS,
 };
 
+enum mps_mode_t {
+	MPS_OFF,
+	MPS_SINGLE,
+	MPS_MULTIPLE,
+};
+
 struct main_opts {
 	char		*name;
 	uint32_t	class;
@@ -102,6 +108,7 @@ struct main_opts {
 	bt_gatt_cache_t gatt_cache;
 	uint16_t	gatt_mtu;
 	uint8_t		gatt_channels;
+	enum mps_mode_t	mps;
 
 	uint8_t		key_size;
 
diff --git a/src/main.c b/src/main.c
index 50e37e57a..e51f614b3 100644
--- a/src/main.c
+++ b/src/main.c
@@ -74,12 +74,6 @@ struct main_opts main_opts;
 static GKeyFile *main_conf;
 static char *main_conf_file_path;
 
-static enum {
-	MPS_OFF,
-	MPS_SINGLE,
-	MPS_MULTIPLE,
-} mps = MPS_OFF;
-
 static const char *supported_options[] = {
 	"Name",
 	"Class",
@@ -583,9 +577,11 @@ static void parse_config(GKeyFile *config)
 		DBG("MultiProfile=%s", str);
 
 		if (!strcmp(str, "single"))
-			mps = MPS_SINGLE;
+			main_opts.mps = MPS_SINGLE;
 		else if (!strcmp(str, "multiple"))
-			mps = MPS_MULTIPLE;
+			main_opts.mps = MPS_MULTIPLE;
+		else
+			main_opts.mps = MPS_OFF;
 
 		g_free(str);
 	}
@@ -910,8 +906,8 @@ int main(int argc, char *argv[])
 						main_opts.did_version);
 	}
 
-	if (mps != MPS_OFF)
-		register_mps(mps == MPS_MULTIPLE);
+	if (main_opts.mps != MPS_OFF)
+		register_mps(main_opts.mps == MPS_MULTIPLE);
 
 	/* Loading plugins has to be done after D-Bus has been setup since
 	 * the plugins might wanna expose some paths on the bus. However the
-- 
2.25.3

