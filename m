Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27B9C04A94
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Aug 2023 16:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjHAQi4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Aug 2023 12:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjHAQiw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Aug 2023 12:38:52 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391E81FE5
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Aug 2023 09:38:51 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RFgm670Yzz49QDC;
        Tue,  1 Aug 2023 19:38:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1690907927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aA9WBYwLW9Pq/8rjGKY9g7y1iXggWwfbmq0+4mehOSw=;
        b=eWVEfvfS2SOeEQHcMsKoLvwDahRSKau7FdFfLLsJAAf3atobl6YjfSIGqSU6J7ALu5Qg+9
        gkHa4pNHFXCGK+xHrv+I7/4wf0CkvzpR9x7UHB/VZDfXcp4NYGBZ5Pn2is3KUKkjR66ISF
        Q9BGCkRST5Ce3WbYkWyD8hl9kaAn/UZ/nNrlc/R/SnP65PaN6ZZyQHrG2J9tEvxDSCrLNl
        U3nBL19bFmmon9DxwnKxz9u5qNIvVXU2I509exvA4/+aDC6uObFcszvCOC4LxmGBx8RuZB
        PFh86HmNQ+8b9RPzKAm8ueT4iCW83lev+l2Ac496cvGd3QlFPJKnTvunGVbh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1690907927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aA9WBYwLW9Pq/8rjGKY9g7y1iXggWwfbmq0+4mehOSw=;
        b=pe0knknrRjARFbZ+xfVuS5NDd9kAQcFBRatNZix18QykZcYLmXkXJCYuIUCNjji/hhk2HR
        m8Gm4b0QWFO9KBG5gCJgqMkpicH+UaXiXymL5mOXdJdyCQfgn/hOMjDBipv8nVwSWV7ruX
        AaExaaB5n08Qqq92lmsSD8v9ZJn22epFAn1WY2CakzNyELeIf/OyQRgb0cZMZRNkHA2jY4
        W8IWzqa7hlsOErppvy5E/acvjdk1/2QvSSXxgPIB3fTMByufjju9MW16NjPL1IJQCu0LYB
        xjO3oPHblzkAlBo9KPYlsg2YtcSOHzHr1SJ6cWREyYO/ujlk3cIJ/VA/qVjjhg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1690907927; a=rsa-sha256;
        cv=none;
        b=IvAK/MERLwCNd1Qa/Bu7xDrGZjKmRCvjra+bSEBKxn7qOiOVfi9Two4HDhcGV2phP/rJzv
        ybaKMsYwWCrYsUORmzlOkquayLs3a1whUejhEZ6jojNr3ZqmpM1Oj+x8QVODFlZr0thJd8
        hJ/TTTKXHyqYgfyHcw6IAyYJCN44mP+/Ha2+lSehFhbU3SIza4FN4FHmrDJtThMZ4C3F6d
        d8XYQg0pJnPfhHs+/SKEIXjNplEhmAlp71S59f+9EUL93pQ9TN0qaZoyE69Dqfvm1+8jPC
        RiU5+aNSN+wwZqBVIgn4r/IvUFPagZkkC4F2X7cqwFCoRwIEOuT75QlDTNOgKA==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 5/5] iso-tester: add tests checking Remove CIG is emitted
Date:   Tue,  1 Aug 2023 19:38:42 +0300
Message-ID: <3b903474a8a71074f58882382065f4b695b0454e.1690907478.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690907478.git.pav@iki.fi>
References: <cover.1690907478.git.pav@iki.fi>
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

Notes:
    v2: no change

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

