Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B608C04A6A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jul 2023 21:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjGZVZj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjGZVZe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jul 2023 17:25:34 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0E3269E
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 14:25:27 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RB6Pd06gsz49QBX;
        Thu, 27 Jul 2023 00:25:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1690406725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tW2+2BLo8vtYy6DNWxtLOfiMpuLTNkMKEjYi/wSjFvI=;
        b=mO4cVkwMkGVTjXqtYw1FibEUH8kQfBT1UNJ6oY0EbnfEVA/pUXG/LV9Wq/aHaVLYnmHwB6
        U6wwaveaQVhLaxT5FBh7hNhfN+xRCio0r17Tu/7t7xfmU4Xif+K9czUXIBN27hHJ2XDfTQ
        fMTXkHxo13V2MJ68Jlseiid12+HTbKu1HpTe3f2n8DmA1VbcIc0y2Ey8+IPVq+OS2ETER4
        JhvujoEXEXOgTUO13uhyiri/IomJAOZHygi+ypKfDyFLVKJsDe/zxlAUxNuA9H7C4SDY1e
        Ta7E2McH8omwMcPPd723wQ2X59IHjCBfY4WywR26wjl01YdTanAPU3hhmvUUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1690406725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tW2+2BLo8vtYy6DNWxtLOfiMpuLTNkMKEjYi/wSjFvI=;
        b=UvJKrou4fweS5uLOuUAQAjRSoTe0kcT0ZfoozffHvUUqBSUJrMuaF/Mso5pAwt9QH9TtPf
        nvd/mK7tLh4k9Owg4iDME0upCYVViYWTyHtWLAjv1aLVVojaMdSQbAsZK6zarEPQENcqZx
        rqCHEIw0Ad0SQ0J0bpsWBfaodZjnlJBMeNRnL68b2YInIKMl0mll7kQmVclw4jD6RzXdX+
        9pMiSN51m7nxRBgcmfThu2BeOYoZZka3ixxI9guPARe2kIwV4rT2J1YWzjPWEayGdSt1YT
        bl7D5+zQHv/e6ZPBwPB0A8xhuuE2ZSKyV08hHcbizOtiTs1FWtiosIx+Va73gg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1690406725; a=rsa-sha256;
        cv=none;
        b=d/XQX4Ij2GCTD1hr1588vXpq1uL85700ILEDanMDUjjacKbJEx3ohD0rEGsK9CmzjkAJqY
        Zme53wPORXLxeO89YE9iv1TBFaflJuQ53pEN08XxuCJyMekEZ/SYx9k4BPa0GOTXY4VTds
        p8pGCtK5BUWi5r/10/Yg26EJh2jiiwj5sv0YmwwcfVpG1ClynnXH05+GXeWNU1+6FItOPV
        v6n5+QcEmqmY4GRSkDAJinoK/ksKs+z8Ru6LfGC1Zw0rFtRsXheQgSmp0tNPhBtr/MeooE
        b6vGzYinVXqMMLthDdL5E32ofEz/8IDHsO3z2/SUrORJx4XaW9vr2tDPPOpe2w==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/5] iso-tester: add tests checking Remove CIG is emitted
Date:   Thu, 27 Jul 2023 00:25:18 +0300
Message-ID: <357f1735cf611bc23d422a8b3cdd777dabababc9.1690405564.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690405564.git.pav@iki.fi>
References: <cover.1690405564.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Kernel should send LE Remove CIG after all CIS are shut down.  Add tests
checking this, closing either immediately or after waiting connection to
complete.

ISO Defer Close - Success
ISO Connect Close - Success
ISO Defer Wait Close - Success
ISO Connect Wait Close - Success
---
 tools/iso-tester.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 9f853a0f9..bbf959420 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -2425,6 +2425,90 @@ static void test_connect2_nodefer(const void *test_data)
 	close(sk);
 }
 
+static gboolean iso_connect_close_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = user_data;
+
+	data->io_id[0] = 0;
+
+	tester_print("Disconnected");
+
+	--data->step;
+	if (!data->step)
+		tester_test_passed();
+
+	return FALSE;
+}
+
+static bool hook_remove_cig(const void *msg, uint16_t len, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	tester_print("Remove CIG");
+
+	--data->step;
+	if (!data->step)
+		tester_test_passed();
+
+	return true;
+}
+
+static void test_connect_close(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	int sk;
+	GIOChannel *io;
+
+	data->step = 2;
+
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_CMD,
+					BT_HCI_CMD_LE_REMOVE_CIG,
+					hook_remove_cig, data);
+
+	sk = setup_sock(data, 0);
+	if (sk < 0)
+		return;
+
+	io = g_io_channel_unix_new(sk);
+	g_io_channel_set_close_on_unref(io, TRUE);
+	data->io_id[0] = g_io_add_watch(io, G_IO_HUP, iso_connect_close_cb,
+									data);
+
+	shutdown(sk, SHUT_RDWR);
+}
+
+static gboolean iso_connect_wait_close_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	int sk;
+
+	tester_print("Connected");
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	data->io_id[0] = g_io_add_watch(io, G_IO_HUP, iso_connect_close_cb,
+									data);
+
+	shutdown(sk, SHUT_RDWR);
+
+	return FALSE;
+}
+
+static void test_connect_wait_close(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->step = 1;
+
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_CMD,
+					BT_HCI_CMD_LE_REMOVE_CIG,
+					hook_remove_cig, data);
+
+	setup_connect(data, 0, iso_connect_wait_close_cb);
+}
+
 static void test_bcast(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -2601,6 +2685,18 @@ int main(int argc, char *argv[])
 	test_iso("ISO Defer Connect - Success", &defer_16_2_1, setup_powered,
 							test_connect);
 
+	test_iso("ISO Defer Close - Success", &defer_16_2_1, setup_powered,
+							test_connect_close);
+
+	test_iso("ISO Connect Close - Success", &connect_16_2_1, setup_powered,
+							test_connect_close);
+
+	test_iso("ISO Defer Wait Close - Success", &defer_16_2_1,
+					setup_powered, test_connect_wait_close);
+
+	test_iso("ISO Connect Wait Close - Success", &connect_16_2_1,
+					setup_powered, test_connect_wait_close);
+
 	test_iso2("ISO Defer Connect2 CIG 0x01 - Success", &defer_1_16_2_1,
 							setup_powered,
 							test_connect2);
-- 
2.41.0

