Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79BBC32792
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 22:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbiHVWAt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbiHVWAa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 18:00:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4E23DF02
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:00:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 67so3462698pfv.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=dYzd8NEDrTcViGbZChBLrmOKkaPZn79AwL2dNI2eXbM=;
        b=iv6qdkkf4Uqyn3nltbPdxKa1v3fDErh5cbSMOoFqh+/VthISHGrgMTzketesc97BAW
         KyZiW8g4ufb4SBrswZ2234Fr2ek5jAVyG/VsSQMxYkt3y8alDiTYPiGJH4RvSTTHuIvA
         ZC2DjgaqL4clUmMHM75c6iYOrdvpIfqBLm/rI2fKWeTbzcWd2vyeIJmUz5SOiHFRxOQi
         4E5zHzY0bQxVsnVVqPEdoMY8PuDw/FwBNiLoJmeCw3XQllxjSWsjnp7XevRKkUrmtMuW
         2HGAiML/z9CZKeStiifYVoCL7bCE/YiQhDCJs6XHy3zS84aQk64W5u9S1a3QybopxFPY
         Khag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=dYzd8NEDrTcViGbZChBLrmOKkaPZn79AwL2dNI2eXbM=;
        b=H55c4y/NdQdWe59czoJH2ppYzUZhmjOoWNgAnJ9j6rQQd+KITXY3mmJUY38S9utnrI
         4eWusyHqTzbAjtemFNIrBgo40UtEVVKN4v52Y6mcBACEL6IT/Wa2Eh2l0oB4Mryet0L+
         KmZTELMIZVvjaBsqYigCkP5zkP73d8Y2NwBrVdBqYR1cC+lDIRAkQOvW5hOVNNH7jhZy
         9FK7jxxJFxmgC5XOxe6cTOs3XxQN57mCpMUIMg9DAxk5plaU4shxxicWH5RZhQhRBnaB
         iUoJYOsW7gVgluyPhGwX/6E0g8KIH+baS3xK/np+2AdObapTHzXfUAdTDAJXjYjYQ6/T
         BESQ==
X-Gm-Message-State: ACgBeo2h+klA2w6bTC6z8OOxqgIRBpXeWhDCTWk5EVD8O3B8X8ybXC0z
        +KcgwbSRL1Y/jzKZnjC2tB54ckzurd4=
X-Google-Smtp-Source: AA6agR5lkYATaEm3jBGq9swnzDA2dpvkxa4PCzWbjwO9GiEch5m9UVr7LboyHCO/jNUH7URtc+hkbw==
X-Received: by 2002:a05:6a00:1995:b0:52d:5c39:3f61 with SMTP id d21-20020a056a00199500b0052d5c393f61mr22560755pfl.83.1661205628528;
        Mon, 22 Aug 2022 15:00:28 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z12-20020aa79e4c000000b00535e950aa28sm8364751pfq.131.2022.08.22.15.00.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 15:00:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] iso-tester: Make use of bthost_add_iso_hook destroy callback
Date:   Mon, 22 Aug 2022 15:00:25 -0700
Message-Id: <20220822220025.541691-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822220025.541691-1-luiz.dentz@gmail.com>
References: <20220822220025.541691-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bthost_add_iso_hook to track when an ISO connection
has been disconnected and then set its handle to 0x0000 which is then
checked when the socket HUP to confirm the remote has properly
disconnected (e.g. received Disconnected Complete).
---
 tools/iso-tester.c | 52 +++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 8c935b9220dd..269fbe2d6c62 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -676,13 +676,42 @@ static void client_connectable_complete(uint16_t opcode, uint8_t status,
 	}
 }
 
+static void bthost_recv_data(const void *buf, uint16_t len, void *user_data)
+{
+	struct test_data *data = user_data;
+	const struct iso_client_data *isodata = data->test_data;
+
+	tester_print("Client received %u bytes of data", len);
+
+	if (isodata->send && (isodata->send->iov_len != len ||
+			memcmp(isodata->send->iov_base, buf, len))) {
+		if (!isodata->recv->iov_base)
+			tester_test_failed();
+	} else
+		tester_test_passed();
+}
+
+static void bthost_iso_disconnected(void *user_data)
+{
+	struct test_data *data = user_data;
+
+	tester_print("ISO handle 0x%04x disconnected", data->handle);
+
+	data->handle = 0x0000;
+}
+
 static void iso_new_conn(uint16_t handle, void *user_data)
 {
 	struct test_data *data = user_data;
+	struct bthost *host;
 
 	tester_print("New client connection with handle 0x%04x", handle);
 
 	data->handle = handle;
+
+	host = hciemu_client_get_host(data->hciemu);
+	bthost_add_iso_hook(host, data->handle, bthost_recv_data, data,
+				bthost_iso_disconnected);
 }
 
 static void acl_new_conn(uint16_t handle, void *user_data)
@@ -722,7 +751,7 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 		if (!isodata)
 			continue;
 
-		if (isodata->send || isodata->recv)
+		if (isodata->send || isodata->recv || isodata->disconnect)
 			bthost_set_iso_cb(host, iso_new_conn, data);
 
 		if (isodata->bcast) {
@@ -1110,25 +1139,9 @@ static void iso_recv(struct test_data *data, GIOChannel *io)
 	data->io_id[0] = g_io_add_watch(io, G_IO_IN, iso_recv_data, data);
 }
 
-static void bthost_recv_data(const void *buf, uint16_t len, void *user_data)
-{
-	struct test_data *data = user_data;
-	const struct iso_client_data *isodata = data->test_data;
-
-	tester_print("Client received %u bytes of data", len);
-
-	if (isodata->send && (isodata->send->iov_len != len ||
-			memcmp(isodata->send->iov_base, buf, len))) {
-		if (!isodata->recv->iov_base)
-			tester_test_failed();
-	} else
-		tester_test_passed();
-}
-
 static void iso_send(struct test_data *data, GIOChannel *io)
 {
 	const struct iso_client_data *isodata = data->test_data;
-	struct bthost *host;
 	ssize_t ret;
 	int sk;
 
@@ -1136,9 +1149,6 @@ static void iso_send(struct test_data *data, GIOChannel *io)
 
 	tester_print("Writing %zu bytes of data", isodata->send->iov_len);
 
-	host = hciemu_client_get_host(data->hciemu);
-	bthost_add_iso_hook(host, data->handle, bthost_recv_data, data, NULL);
-
 	ret = writev(sk, isodata->send, 1);
 	if (ret < 0 || isodata->send->iov_len != (size_t) ret) {
 		tester_warn("Failed to write %zu bytes: %s (%d)",
@@ -1167,7 +1177,7 @@ static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
 
 	data->io_id[0] = 0;
 
-	if (cond & G_IO_HUP) {
+	if ((cond & G_IO_HUP) && !data->handle) {
 		tester_print("Successfully disconnected");
 
 		if (data->reconnect) {
-- 
2.37.2

