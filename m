Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3C9C04A94
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Aug 2023 12:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHEM3Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Aug 2023 08:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHEM3P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Aug 2023 08:29:15 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1722D44BE
        for <linux-bluetooth@vger.kernel.org>; Sat,  5 Aug 2023 05:29:13 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RJ22H3LS9z49QDY;
        Sat,  5 Aug 2023 15:29:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691238551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6p/eY8ZiJZCTVIgdFf+d3LFmvIBSfdQ2sPHZzcmxOao=;
        b=kThWTktWiBFDzp5V8VwowVN3lYkeowM8sdrl8HZyb5J5ET9dwag+6lm3lpoQ6t2VObcbtI
        c+zJYdtSHzD9PddiRhQOULsxKIIoKRCE5M43iXodVxSGgRobdwLrI0DpX9fCGrFE19XGOf
        Lxr9whm/MgniVbTwLl18mJFITE52X0awR6h3NSqBHTnyBqRMTVf8GEhO6N3Mk7qN6fR/Yz
        ZCTzMCKNSJMgxRurMXzWUMlksLBu2+33BO37gwOsbSf0OgrdM0I3y7lW7x9KaeYcJPGYK0
        RUh3c6yX0Yv6XaxPo2TQKAi76BpzX3yKJ9swm6o7k6yCIhjnCunUaXJoG6QHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691238551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6p/eY8ZiJZCTVIgdFf+d3LFmvIBSfdQ2sPHZzcmxOao=;
        b=JWRJEH458k2Xa7LhM3eX9Y89FYJVWnbjGvPMtxzbIxVeM7J34n+Li5lTnddDtq1NujU3Qm
        MnDMw+G9qlxqPUVUdjVV0K/aRY1NrCXEitVSQju+TJtjvoHwvNEq9lK8UF4W4ReFIy44+T
        iE8OEb0yYokyLerz8KlhoFjlGK5wVw8NkhND2+u9qWd43qqHrU3VkB6Sj0lZG25MZs16Tb
        wgVJfh5XcOOp3mk7lklxFoBed7D4qRlgM3ovFqSO4NAfKd9yHIrTaIGjEsAj4WY69wOITA
        8IJ97A0q90oIyUFlbv7CU9IQ6lorTzsTBAz0iV8M0YAP1t+vLH44jBrcLn7ZkQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691238551; a=rsa-sha256;
        cv=none;
        b=tUnDy0cIBP2bMppUyDlgj2o1wiTVGcHk/pJpYQ2ekaugmIl7z0I7RU3y5RQcggZ9aRY5Pg
        umrNApyCkJbS0yAZThE+UI4sMVr0HqM8cp9R6Nq08Dh0FmFI7VuLvpkX/tg3NKavTR84Ry
        wv25N9oj3ROUXwe0hQgFAe4v9dNb4WQgk3/HF8K8URRXCg2YlP9PWMyXrcYFR/fFobVG7Q
        rs9wRY7EXVm1+TrRaMfXmVkxQC45Fkl6u+I0SLWebkmf5hERq1eCwLrMxTleQwbsCJ2HjL
        F9N1IGWTYbdcV5VV69yPxjM6CCdYZmnRte3OQjU4Yw9uXwOXAwwRTdQh1ROl0w==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] iso-tester: test busy CIG error does not drop existing connections
Date:   Sat,  5 Aug 2023 15:29:07 +0300
Message-ID: <5f173b905f8e1cc755cd53d89481c011e3c4cf48.1691238245.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <570f7e0427b35925c741118d397eb8bcbcb51efe.1691238245.git.pav@iki.fi>
References: <570f7e0427b35925c741118d397eb8bcbcb51efe.1691238245.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A second connection made with same CIG while the CIG is busy, shall not
disconnect the first already existing connection.

Add test for this:

ISO Connect2 Busy CIG 0x01 - Success/Invalid

This was the original intent of "ISO Connect2 CIG 0x01 -
Success/Invalid", but the busy check should not be made synchronously in
connect() (to maintain ordering with Remove CIG etc), but must be done
in hci_sync. So the test needs to check the error async and explictly
that the first conn is not dropped.
---
 tools/iso-tester.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 9b9716e06..5a8b1fe68 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -2402,6 +2402,87 @@ static void test_connect2_seq(const void *test_data)
 	setup_connect(data, 0, iso_connect2_seq_cb);
 }
 
+static gboolean test_connect2_busy_done(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	if (data->io_id[0] > 0) {
+		/* First connection still exists */
+		g_source_remove(data->io_id[0]);
+		data->io_id[0] = 0;
+		tester_test_passed();
+	} else {
+		tester_test_failed();
+	}
+
+	return FALSE;
+}
+
+static gboolean iso_connect_cb_busy_disc(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->io_id[0] = 0;
+
+	tester_print("Disconnected 1");
+	tester_test_failed();
+	return FALSE;
+}
+
+static gboolean iso_connect_cb_busy_2(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	int err, sk_err, sk;
+	socklen_t len;
+
+	data->io_id[1] = 0;
+
+	sk = g_io_channel_unix_get_fd(io);
+
+	len = sizeof(sk_err);
+
+	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
+		err = -errno;
+	else
+		err = -sk_err;
+
+	tester_print("Connected 2: %d", err);
+
+	if (err == -EBUSY && data->io_id[0] > 0) {
+		/* Wait in case first connection still gets disconnected */
+		data->io_id[1] = g_timeout_add(250, test_connect2_busy_done,
+									data);
+	} else {
+		tester_test_failed();
+	}
+
+	return FALSE;
+}
+
+static gboolean iso_connect_cb_busy(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	/* First connection shall not be disconnected */
+	data->io_id[0] = g_io_add_watch(io, G_IO_ERR | G_IO_HUP,
+						iso_connect_cb_busy_disc, data);
+
+	/* Second connect shall fail since CIG is now busy */
+	setup_connect(data, 1, iso_connect_cb_busy_2);
+
+	return iso_connect(io, cond, user_data);
+}
+
+static void test_connect2_busy(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	setup_connect(data, 0, iso_connect_cb_busy);
+}
+
 static gboolean iso_connect_close_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -2678,6 +2759,10 @@ int main(int argc, char *argv[])
 							setup_powered,
 							test_connect2);
 
+	test_iso2("ISO Connect2 Busy CIG 0x01 - Success/Invalid",
+					&connect_1_16_2_1, setup_powered,
+					test_connect2_busy);
+
 	test_iso2("ISO Defer Connect2 CIG 0x01 - Success", &defer_1_16_2_1,
 							setup_powered,
 							test_connect2);
-- 
2.41.0

