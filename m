Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DD5C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 21:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbiHEV7L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 17:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241756AbiHEV6r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 17:58:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD52E7D1ED
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 14:56:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso9436534pjr.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Aug 2022 14:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9f9AWVp7VcaHr2xN9dHaI/ZYFXw1Uu6aa7/4yC21DJk=;
        b=Nx8Y/C5Dk/Nbm0JZ2GkSdnz/yiWpgl4Ymk++ZSbJNvfDG8cH3VCjHd28c1ojpHCty9
         fe+j5FOBHUMNswOu3uMWHNEzYtoZ0Pe6LcJgmBuVG6GNCz4aeGIs9v63fXfkIgOTQhSq
         ELQ1/fA/QTi7CQ15EZRCXBvaP5VklRzo/MlqjJCLFYuXh+xPLoEExTMggZqXwrmmvWgM
         6w3CYh8Ernotmh5y+o2G5/o6EzDCcMNFruNqdHANCp4jk3a4QSoT5bpHFSap7A+A8Zsj
         wQI+ZqB1OKUhYuUiswmiVLadgb0e8T8zKpS2TmFSRsZt1RrI3DFhpyeBNsYqRGDIU9YI
         OM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9f9AWVp7VcaHr2xN9dHaI/ZYFXw1Uu6aa7/4yC21DJk=;
        b=lISIxVyOJvxkeLsjnkGRVUM2qdTozuDxPu6cu7COztWMaOAwaBRBkXXtzzo1w2BJvy
         mNuHvoKrYvOQe/MI9kN5KwvmupbgwQ+T078eJgTbtsvtbfYUPlwNbOGwTMp/4OsqrUtT
         6PG3d/AhcPvxHYz4iIGBuF4HQXXkPGuptSLLEJplPGfUc40+5YvYFSCd/ktUWsJwOa3I
         FwiyUZTIkT4sl9+DvF+FQBk64pecsU6hFkJ8eoMu/XB5DT3+Z58GqXf3uGRFQtI9r4P6
         Vg5UpM+3XovFkVnXu45ovCYx9WzjiohnuDbYxDeiYrRFbc0D4pR38u4dmIhiQ5iopv9Z
         glAw==
X-Gm-Message-State: ACgBeo3qnG06/wxL0C16tE0gK7uwH4lEfvapJeU5AXlfH0MMh1HUnvMV
        KX4oohwrpegfRZ7KzS9ijtSacgbfhNqq4w==
X-Google-Smtp-Source: AA6agR5SaHANEPWLgI3LlNSr8QfBuaAoLxdQiqqNQnXgRIdwC+XY51ea3VmbR6AfITaC8pc8U2lMjQ==
X-Received: by 2002:a17:90b:1807:b0:1f5:7835:7fbc with SMTP id lw7-20020a17090b180700b001f578357fbcmr8309784pjb.170.1659736587448;
        Fri, 05 Aug 2022 14:56:27 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 13-20020a62190d000000b0052d4ffac466sm3447036pfz.188.2022.08.05.14.56.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:56:26 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] iso-tester: Add ISO 48_2_1 Defer Receive - Success
Date:   Fri,  5 Aug 2022 14:56:22 -0700
Message-Id: <20220805215622.3958723-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805215622.3958723-1-luiz.dentz@gmail.com>
References: <20220805215622.3958723-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a test to check if different QoS are properly handled when
acting as peripheral.
---
 tools/iso-tester.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 56c17b78b..df46bc953 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -541,6 +541,12 @@ static const struct iovec send_16_2_1 = {
 	.iov_len = sizeof(data_16_2_1),
 };
 
+static const uint8_t data_48_2_1[100] = { [0 ... 99] = 0xff };
+static const struct iovec send_48_2_1 = {
+	.iov_base = (void *)data_48_2_1,
+	.iov_len = sizeof(data_48_2_1),
+};
+
 static const struct iso_client_data connect_16_2_1_send = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -582,6 +588,14 @@ static const struct iso_client_data listen_16_2_1_defer_recv = {
 	.defer = true,
 };
 
+static const struct iso_client_data listen_48_2_1_defer_recv = {
+	.qos = QOS_48_2_1,
+	.expect_err = 0,
+	.recv = &send_48_2_1,
+	.server = true,
+	.defer = true,
+};
+
 static const struct iso_client_data listen_16_2_1_defer_reject = {
 	.qos = QOS_16_2_1,
 	.expect_err = -1,
@@ -973,7 +987,7 @@ static bool check_io_qos(const struct bt_iso_io_qos *io1,
 		return false;
 	}
 
-	if (io1->sdu != io2->sdu) {
+	if (io1->sdu && io2->sdu && io1->sdu != io2->sdu) {
 		tester_warn("Unexpected IO SDU: %u != %u", io1->sdu, io2->sdu);
 		return false;
 	}
@@ -1450,7 +1464,7 @@ static void setup_listen(struct test_data *data, uint8_t num, GIOFunc func)
 		client = hciemu_get_client(data->hciemu, 0);
 		host = hciemu_client_host(client);
 
-		bthost_set_cig_params(host, 0x01, 0x01);
+		bthost_set_cig_params(host, 0x01, 0x01, &isodata->qos);
 		bthost_create_cis(host, 257, data->acl_handle);
 	}
 }
@@ -1701,6 +1715,10 @@ int main(int argc, char *argv[])
 	test_iso("ISO Defer Receive - Success", &listen_16_2_1_defer_recv,
 						setup_powered, test_listen);
 
+	test_iso("ISO 48_2_1 Defer Receive - Success",
+						&listen_48_2_1_defer_recv,
+						setup_powered, test_listen);
+
 	test_iso("ISO Defer Reject - Success", &listen_16_2_1_defer_reject,
 						setup_powered, test_listen);
 
-- 
2.37.1

