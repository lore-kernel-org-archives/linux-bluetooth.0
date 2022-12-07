Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20495C352A1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Dec 2022 01:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLGBfw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Dec 2022 20:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGBfv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Dec 2022 20:35:51 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719BF4B9A1
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 17:35:50 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so78209pjo.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Dec 2022 17:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qftBlXzir3Xl0d7+B2mBUNHal8jpFXB/Q65tK01KhKc=;
        b=oCyyZt8DNn0eYBHME8SnnA1QGK14oVDCPrHygp4s2sk9G7iWgz/RO7aggHFaK60kpG
         gZ1Akimho8HXTKsdI5FhtxlPe2R/BLB8tb+9UFq6ZEBQXRILG8RsMaXe1eeUCkoW+Ark
         pDCcvGGSlBko4HFTspUZF4h56Iq1nI07xZU/0cDUtrYQnk5gEluu1raASNiOTjME35Ov
         GuG6UGTJq6wlDCI8LHABiq2dqZyoW29C9PCkfw8J6Stmv3l2ii1QHpKok+V5klso4/Wv
         LasR1oAbeA0g0nE5ndgSrv1JJFJDGtdUI0DY8DdzRecCd9JICjAG6kZjgWzj8fpfQnqw
         T4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qftBlXzir3Xl0d7+B2mBUNHal8jpFXB/Q65tK01KhKc=;
        b=eHOs55AlfN1NN712J4yzvH4QPaP/uE6IUAQh49fMSfXc/o2LtJNHQDiTLKuksBLczl
         j7NB1po1tDiBxKylF+JBdh7/o+KvgOCqrqgah0EJUdx/5K/p8u0+bl1VlIRMal7ih5XB
         zg1pseZ+l+FLo3z5z4hm7aw4r72o7DXv50uTYLk0B3VvLnx4VUjUeAZxJUzg4174eYFo
         nvH01ymrG+BGnMWWrpjvN1W9J37eIlk2xdKyMBkrPxLKn/Pl9iI+b74ROF+Utwv9ZkX8
         zf++BkbZW1AFmfm5fe9J5ReFJH24TkaMWuxt7NXxX7a9q5Ff5iNqlceKlcxaQVEoIuSW
         yfew==
X-Gm-Message-State: ANoB5pnN6hP43VbKkjx4q59hmbU0A4PvEfxRE/06XHYl0zYy2o+CQzZF
        FPPRUJH6i7J4ZEUJ6niihU06ld2JdTPZkR7C
X-Google-Smtp-Source: AA0mqf4o2wLp3CJltvr3asaIkQYGTQUL5to9CqMHdIoffs78jvTUFYKKsHE93iL+iG7xwNLOo0Sf+Q==
X-Received: by 2002:a17:90a:ae09:b0:218:ede8:694a with SMTP id t9-20020a17090aae0900b00218ede8694amr68617879pjq.67.1670376949354;
        Tue, 06 Dec 2022 17:35:49 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902780200b001869394a372sm751077pll.201.2022.12.06.17.35.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:35:48 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] iso-tester: Add test when peer rejects CIS
Date:   Tue,  6 Dec 2022 17:35:46 -0800
Message-Id: <20221207013546.4162481-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221207013546.4162481-1-luiz.dentz@gmail.com>
References: <20221207013546.4162481-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following test for testing when remote stack rejects the
CIS:
---
 tools/iso-tester.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index d29f35695a00..d790b15563a1 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -130,6 +130,7 @@ struct test_data {
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
+	uint8_t accept_reason;
 	uint16_t handle;
 	uint16_t acl_handle;
 	GIOChannel *io;
@@ -342,7 +343,7 @@ static void test_data_free(void *test_data)
 	free(data);
 }
 
-#define test_iso_full(name, data, setup, func, num) \
+#define test_iso_full(name, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
@@ -351,16 +352,20 @@ static void test_data_free(void *test_data)
 		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
 		user->test_data = data; \
 		user->client_num = num; \
+		user->accept_reason = reason; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
 				test_post_teardown, 2, user, test_data_free); \
 	} while (0)
 
 #define test_iso(name, data, setup, func) \
-	test_iso_full(name, data, setup, func, 1)
+	test_iso_full(name, data, setup, func, 1, 0x00)
 
 #define test_iso2(name, data, setup, func) \
-	test_iso_full(name, data, setup, func, 2)
+	test_iso_full(name, data, setup, func, 2, 0x00)
+
+#define test_iso_rej(name, data, setup, func, reason) \
+	test_iso_full(name, data, setup, func, 1, reason)
 
 static const struct iso_client_data connect_8_1_1 = {
 	.qos = QOS_8_1_1,
@@ -537,6 +542,11 @@ static const struct iso_client_data connect_invalid = {
 	.expect_err = -EINVAL
 };
 
+static const struct iso_client_data connect_reject = {
+	.qos = QOS_16_1_2,
+	.expect_err = -ENOSYS
+};
+
 static const uint8_t data_16_2_1[40] = { [0 ... 39] = 0xff };
 static const struct iovec send_16_2_1 = {
 	.iov_base = (void *)data_16_2_1,
@@ -714,6 +724,16 @@ static void iso_new_conn(uint16_t handle, void *user_data)
 				bthost_iso_disconnected);
 }
 
+static uint8_t iso_accept_conn(uint16_t handle, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	tester_print("Accept client connection with handle 0x%04x: 0x%02x",
+		     handle, data->accept_reason);
+
+	return data->accept_reason;
+}
+
 static void acl_new_conn(uint16_t handle, void *user_data)
 {
 	struct test_data *data = user_data;
@@ -751,8 +771,10 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 		if (!isodata)
 			continue;
 
-		if (isodata->send || isodata->recv || isodata->disconnect)
-			bthost_set_iso_cb(host, NULL, iso_new_conn, data);
+		if (isodata->send || isodata->recv || isodata->disconnect ||
+						data->accept_reason)
+			bthost_set_iso_cb(host, iso_accept_conn, iso_new_conn,
+									data);
 
 		if (isodata->bcast) {
 			bthost_set_pa_params(host);
@@ -1249,7 +1271,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 	else
 		tester_print("Successfully connected");
 
-	if (-err != isodata->expect_err) {
+	if (err != isodata->expect_err) {
 		tester_warn("Expect error: %s (%d) != %s (%d)",
 				strerror(-isodata->expect_err),
 				-isodata->expect_err, strerror(-err), -err);
@@ -1773,6 +1795,9 @@ int main(int argc, char *argv[])
 	test_iso("ISO QoS - Invalid", &connect_invalid, setup_powered,
 							test_connect);
 
+	test_iso_rej("ISO Connect - Reject", &connect_reject, setup_powered,
+			test_connect, BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
+
 	test_iso2("ISO Connect2 CIG 0x01 - Success", &connect_1_16_2_1,
 							setup_powered,
 							test_connect2);
-- 
2.37.3

