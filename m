Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24C6C55185
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 22:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79284206E9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 22:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es7lMe5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDUWZ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgDUWZZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 18:25:25 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C7BC0610D5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 15:25:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w3so86383plz.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 15:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yAXh3xoOECbXXgj+ID5ZQOMf1h0nrGV0PRZjaNZf1ig=;
        b=Es7lMe5NOHfHewwIPgNulkRBX3yA05iPSX6XR1AXPxm3RQF9YH+NNc78nNTjMfa5C1
         QEWMx+1oFjfDgzPDKTZl458QPjP+snAIyMYJCkbAxPTZNoD4O+vIDnaHzQKo1ptSi2pV
         p3fDGbExEHwxVLhh+cBYTxYRr8A3Pj/Lj5++5lXBt+h6Od8ZqCq2O8ysMAFls+rMtjNs
         /MdX5y/Yx+AeNyzMQSi7SKnas1FoXO18/OAnPuyFDYukgVhh11UXsPifPaMNfxqJir9I
         nFeHHiR9Pq6gWidoy+z2A9/C3YgxVhejhjAf7w4o5xYzbfD+wIgVQwHvHTzQbZUuLC9g
         hWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAXh3xoOECbXXgj+ID5ZQOMf1h0nrGV0PRZjaNZf1ig=;
        b=UB7feOwq/eAl0tnGxeGTNeFW29HnDDpGOEK11dKykv9WnxAxm7wocYvqekTerJ3E4D
         W3ZxN5/5gf7owyNDCmyYZR+o0WRfFiV+4RoGgs5bF79H+Vd8UUHzWq8HdDEsKh48O0af
         Kf3lH0hTVoB79s7MpBpKqYE6MhSzu8/fAmNviX8KJMaVT940+uAehJUAbbJbRam+smxA
         yo9lSqTwnxZ4RXFy3VDABOCcs5sP9ZlPeBX9PihneWf28UKg5YDsDnBubPwdcVWU22d7
         Ur2jFnm24nCwSiun/fKC5V/Ldj9C48NDj2RjuHXT9XbgXGLsWg1WM3nYKmxHimUbiKh7
         TJfw==
X-Gm-Message-State: AGi0Pubn3EqBeiS5HacSBdPgfW1dyEo9WijCnv1umilGcYpKTd9HsP8r
        oKNm0D8qfEi1/G2o/S4a30cSIzPvpv4=
X-Google-Smtp-Source: APiQypIOSND4+wp1PLp7kShHdlxvRcBObZAVCRPQNJaFsm5P45xJIpPUrA6VTpbv2ewcKCLZ4R1LWQ==
X-Received: by 2002:a17:90b:14ce:: with SMTP id jz14mr108468pjb.30.1587507924668;
        Tue, 21 Apr 2020 15:25:24 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e196sm3384040pfh.43.2020.04.21.15.25.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 15:25:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] monitor: Add decoding support for HCI LE Set Host Feature
Date:   Tue, 21 Apr 2020 15:25:19 -0700
Message-Id: <20200421222521.226385-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200421222521.226385-1-luiz.dentz@gmail.com>
References: <20200421222521.226385-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds decoding support for LE Set Host Feature.
---
 monitor/packet.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 038dd6d17..777a52205 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8128,6 +8128,21 @@ static void le_req_peer_sca_cmd(const void *data, uint8_t size)
 	print_field("Connection Handle: %d", le16_to_cpu(cmd->handle));
 }
 
+static void le_set_host_feature_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_host_feature *cmd = data;
+	uint64_t mask;
+
+	print_field("Bit Number:");
+
+	mask = print_bitfield(2, cmd->bit_number, features_le);
+	if (mask)
+		print_text(COLOR_UNKNOWN_FEATURE_BIT, "  Unknown features "
+						"(0x%16.16" PRIx64 ")", mask);
+
+	print_field("Bit Value: %u", cmd->bit_value);
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -9041,6 +9056,10 @@ static const struct opcode_data opcode_table[] = {
 	{ BT_HCI_CMD_LE_ISO_TEST_END, BT_HCI_BIT_LE_ISO_TEST_END,
 				"LE Isochronous Read Test Counters", NULL, 0,
 				false },
+	{ BT_HCI_CMD_LE_SET_HOST_FEATURE, BT_HCI_BIT_LE_SET_HOST_FEATURE,
+				"LE Set Host Feature", le_set_host_feature_cmd,
+				sizeof(struct bt_hci_cmd_le_set_host_feature),
+				true, status_rsp, 1, true },
 	{ }
 };
 
-- 
2.25.3

