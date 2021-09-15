Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EB0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A744560EE3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhIOXDS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhIOXDR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 19:03:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE99C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:01:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d17so2566977plr.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zrI41nUAxr+exOiuaDY8CpHND39OIYNAriev2rgKss=;
        b=dy9lLH1DblXxsV8C1f8+vR+occyhmhdjBa5t3WohDFFNrUxabH05d2Ac1/FsJKZsDx
         eAjQGt2nh64ogw+3TblEapzlrHXRCpe+QbUvrHD88jBrxbhi6fVX/oAO59fbUgQJBuio
         AKhVXqP2Zxun54pQkKSs4InG/FP1wbgerJl9bTcKxD48rxTF7jjHuQo8f4bSCou4d5LR
         D+YHRP1K09F3xJlBHCyWOSB81F4OMNgRXowKARpb57zpSaIRGLKHDkoPfRow0INOIuuR
         WCMwqv14K7PjNhsaKF+oBd3OkjghFKu38OyjegM8GjI48uFEml+l9hsXLigavXfzYVNC
         maXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zrI41nUAxr+exOiuaDY8CpHND39OIYNAriev2rgKss=;
        b=i/brNe2BW/1BUdiufoAv31tV3rCLdzroAtSr8V4ALLr9AdkixUZXQ4ZbKYp39UMIaA
         usosZDUT/zk6ufmqwHn48zG6DOZDfHNuc2aeMz/g+au6bNhahQex2fNau1KQRsWajjMv
         GWv4kS4s/bYkqE2jCs0YOXsr8FHqTBmu+yOwDcKnYbEiIDGQfuZHmKbXmxjK5Jrr6ngg
         GnnqnGENEhdgQwkRrlkXHHcXMtgX87UX1ttlv7uVdsvDgyZddLjVMuheToFiXyr52csZ
         c3Ix2ESHB3krLjM5F55CrfnaJrsBkFZNKPZEIhKC/vEvOArtUqmLSlOMp2SRPPNVA5l/
         iV5w==
X-Gm-Message-State: AOAM531nb7LpKSZF0Nt1wJH6D662CWnAf2Y6wSjBdE4oJxMkZ0W9Qpji
        GoJkWYqMIteNDl7pGtVrHLOLurC0vLs=
X-Google-Smtp-Source: ABdhPJzzhRKb/5ja31hbrpVvs6P3otEXCDProixmX0XO0OdG6ZaypHP+/+Zx4lLK1Kz910G206seGQ==
X-Received: by 2002:a17:90a:a513:: with SMTP id a19mr11330684pjq.26.1631746917831;
        Wed, 15 Sep 2021 16:01:57 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z9sm850715pfa.2.2021.09.15.16.01.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 16:01:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] sco-tester: Add tests for sending data
Date:   Wed, 15 Sep 2021 16:01:56 -0700
Message-Id: <20210915230156.4107466-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds tests for sending data over the socket.
---
 tools/sco-tester.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index b341fa49f..b31fd5aac 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -43,6 +43,8 @@ struct test_data {
 
 struct sco_client_data {
 	int expect_err;
+	const uint8_t *send_data;
+	uint16_t data_len;
 };
 
 static void print_debug(const char *str, void *user_data)
@@ -248,6 +250,14 @@ static const struct sco_client_data connect_failure = {
 	.expect_err = EOPNOTSUPP
 };
 
+const uint8_t data[] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
+
+static const struct sco_client_data connect_send_success = {
+	.expect_err = 0,
+	.data_len = sizeof(data),
+	.send_data = data
+};
+
 static void client_connectable_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -600,6 +610,20 @@ static gboolean sco_connect_cb(GIOChannel *io, GIOCondition cond,
 	else
 		tester_print("Successfully connected");
 
+	if (scodata->send_data) {
+		ssize_t ret;
+
+		tester_print("Writing %u bytes of data", scodata->data_len);
+
+		ret = write(sk, scodata->send_data, scodata->data_len);
+		if (scodata->data_len != ret) {
+			tester_warn("Failed to write %u bytes: %zu %s (%d)",
+					scodata->data_len, ret, strerror(errno),
+					errno);
+			err = -errno;
+		}
+	}
+
 	if (-err != scodata->expect_err)
 		tester_test_failed();
 	else
@@ -749,6 +773,9 @@ int main(int argc, char *argv[])
 	test_sco_11("SCO mSBC 1.1 - Failure", &connect_failure, setup_powered,
 							test_connect_transp);
 
+	test_sco("SCO CVSD Send - Success", &connect_send_success,
+					setup_powered, test_connect);
+
 	test_offload_sco("Basic SCO Get Socket Option - Offload - Success",
 				NULL, setup_powered, test_codecs_getsockopt);
 
-- 
2.31.1

