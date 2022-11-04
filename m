Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D506C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Nov 2022 21:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiKDVg5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKDVgy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Nov 2022 17:36:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBC145EE7
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Nov 2022 14:36:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k15so5608519pfg.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Nov 2022 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQNvCYq4DWT5O6YSnww9WUDLXDRvhBKnzKNmfjCKHWI=;
        b=FuyFRIRoq70EhTgAJbJeWjgK9BvT2wa28YAobvPQkzLiYRPJStW6oy2d2ypQeXk4Yy
         jZ8LQ3yM1IOhjJo5g4olNv59dTM53Bu4D+Y+9i42ih1cHMqNm9dLB7Jf5wO8IN9vW5mU
         BmWmb80g82N1NhLsathnzpD1Mq7VQgVP9UKceMl4fRq89Egmgt/IiDv1qFu8RGWQkqtg
         bBQ6w/5CcoRA2+LXhUdLhvft44OYf4F0ZfBcDNLYg7dy2tVPdqPGSIwrG+MZaLyKSVkF
         g25857yZ0yMMOl9tzMc2oYNp2Y1TUi/LDRNs9HVSYYf7xaNTW1cBMAGsGQHeXwFIB/Es
         z56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQNvCYq4DWT5O6YSnww9WUDLXDRvhBKnzKNmfjCKHWI=;
        b=GulKUfPnM67px/kyQ7QB0DVCgmpnvho24qywrOOyWCXZC5XlRsB7k6y8cPdPibXRLr
         G2Vy4ZbsxszFsYQy/e5SD5Nm9/dBHouVFdkjaBKb2b98slhXh3bAiM/vlktOD6fXoEKX
         hG9k+nPwX71fQ0W9tDdBQgH3a+DozX5+og0Kvx/gTYnTcxEjFJhTpJikJRD7spe9fzO5
         PoH3hhbDDxtjaTmHJTDMmkogc4+p4URb9GtWV35RsEmhp6pyLBi5n49wTHXzj269lBor
         8t3+ISseGxPwa2Idf2HiJvgLAtvUB/GpNEFQ4c1RnB7bOR0R+hYNHCRf7rvcWIW4dD9U
         E+Vw==
X-Gm-Message-State: ACrzQf2K6rFt0RPoOb/wuerzTp047ioer8DgGtsA57YSuM0h7KOyanJC
        GD3t6eO9oGgWeGwOWW4BRsBUHFtMe4U=
X-Google-Smtp-Source: AMsMyM54+uznMMvE5Es5IF8kcxOFMAWz9uzo+Hvv/D2ksLZ/yrv7TeY+YRcCkOrxDUqnaaPsoAXIgA==
X-Received: by 2002:a63:5fd6:0:b0:46f:fdc1:4086 with SMTP id t205-20020a635fd6000000b0046ffdc14086mr16415064pgb.154.1667597812768;
        Fri, 04 Nov 2022 14:36:52 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a08cf00b001efa9e83927sm2041027pjn.51.2022.11.04.14.36.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:36:51 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] monitor/att: Add support for decoding Characteristic Declaration
Date:   Fri,  4 Nov 2022 14:36:49 -0700
Message-Id: <20221104213649.36925-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221104213649.36925-1-luiz.dentz@gmail.com>
References: <20221104213649.36925-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds supports for decoding the so called Characteristic
Declaration (0x2803):

> ACL Data RX: Handle 3585 flags 0x02 dlen 76
      ATT: Read By Type Response (0x09) len 71
        Attribute data length: 7
        Attribute data list: 10 entries
        Handle: 0x0002
        Value: 200300052a
            Properties: 0x20
              Indicate (0x20)
            Value Handle: 0x0003
            Value UUID: Service Changed (0x2a05)
        Handle: 0x0015
        Value: 021600002a
            Properties: 0x02
              Read (0x02)
            Value Handle: 0x0016
            Value UUID: Device Name (0x2a00)
        Handle: 0x0017
        Value: 021800012a
            Properties: 0x02
              Read (0x02)
            Value Handle: 0x0018
            Value UUID: Appearance (0x2a01)
        Handle: 0x0019
        Value: 021a00a62a
            Properties: 0x02
              Read (0x02)
            Value Handle: 0x001a
            Value UUID: Central Address Resolution (0x2aa6)
        Handle: 0x0029
        Value: 102a00372a
            Properties: 0x10
              Notify (0x10)
            Value Handle: 0x002a
            Value UUID: Heart Rate Measurement (0x2a37)
        Handle: 0x002c
        Value: 022d00382a
            Properties: 0x02
              Read (0x02)
            Value Handle: 0x002d
            Value UUID: Body Sensor Location (0x2a38)
        Handle: 0x002e
        Value: 082f00392a
            Properties: 0x08
              Write (0x08)
            Value Handle: 0x002f
            Value UUID: Heart Rate Control Point (0x2a39)
        Handle: 0x0031
        Value: 0a32008a2a
            Properties: 0x0a
              Read (0x02)
              Write (0x08)
            Value Handle: 0x0032
            Value UUID: First Name (0x2a8a)
        Handle: 0x0033
        Value: 0a3400902a
            Properties: 0x0a
              Read (0x02)
              Write (0x08)
            Value Handle: 0x0034
            Value UUID: Last Name (0x2a90)
        Handle: 0x0035
        Value: 0a36008c2a
            Properties: 0x0a
              Read (0x02)
              Write (0x08)
            Value Handle: 0x0036
            Value UUID: Gender (0x2a8c)
---
 monitor/att.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/monitor/att.c b/monitor/att.c
index 289f4fc04d9a..efd840d51961 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -273,6 +273,46 @@ static void att_error_response(const struct l2cap_frame *frame)
 	print_field("Error: %s (0x%2.2x)", str, pdu->error);
 }
 
+static const struct bitfield_data chrc_prop_table[] = {
+	{  0, "Broadcast (0x01)"		},
+	{  1, "Read (0x02)"			},
+	{  2, "Write Without Response (0x04)"	},
+	{  3, "Write (0x08)"			},
+	{  4, "Notify (0x10)"			},
+	{  5, "Indicate (0x20)"			},
+	{  6, "Authorize (0x40)"		},
+	{  6, "Extended Properties (0x80)"	},
+	{ }
+};
+
+static void print_chrc(const struct l2cap_frame *frame)
+{
+	uint8_t prop;
+	uint8_t mask;
+
+	if (!l2cap_frame_get_u8((void *)frame, &prop)) {
+		print_text(COLOR_ERROR, "Property: invalid size");
+		return;
+	}
+
+	print_field("    Properties: 0x%2.2x", prop);
+
+	mask = print_bitfield(6, prop, chrc_prop_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
+								mask);
+
+	if (!l2cap_frame_print_le16((void *)frame, "    Value Handle"))
+		return;
+
+	print_uuid("    Value UUID", frame->data, frame->size);
+}
+
+static void chrc_read(const struct l2cap_frame *frame)
+{
+	print_chrc(frame);
+}
+
 static const struct bitfield_data ccc_value_table[] = {
 	{  0, "Notification (0x01)"		},
 	{  1, "Indication (0x02)"		},
@@ -2314,6 +2354,7 @@ struct gatt_handler {
 	void (*write)(const struct l2cap_frame *frame);
 	void (*notify)(const struct l2cap_frame *frame);
 } gatt_handlers[] = {
+	GATT_HANDLER(0x2803, chrc_read, NULL, NULL),
 	GATT_HANDLER(0x2902, ccc_read, ccc_write, NULL),
 	GATT_HANDLER(0x2bc4, ase_read, NULL, ase_notify),
 	GATT_HANDLER(0x2bc5, ase_read, NULL, ase_notify),
-- 
2.37.3

