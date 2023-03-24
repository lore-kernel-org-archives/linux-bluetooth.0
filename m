Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CED1C77B60
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 23:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjCXXjD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 19:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjCXXjB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 19:39:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F6F15176
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 16:39:00 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o11so3295137ple.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 16:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679701140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stLHl7pCDH1RyBPiBGqBzug135qk6M/LhP5L5oUD+CA=;
        b=B9cdJMyo5vrrxyVK1Hbr9v5ZsUFBg6wNDYHgYcN1WFoXXk3C0pRCgz/4y6On7q/Bw0
         UlU87NrCJSuLVtIqnL/3l8bvbEXVv4p4X2n3JocvKJRRDBrj9ANqTDkeD0K+8Lxhj8zo
         oEI3mIDjsenfiUWoe/QnlrA/JCWLClSKvPIq08/mGToNgaEisG7HdTH02mJ54YQFQYGE
         p83/K4caPgR383dvBVVlEjaTICkND153EhfrIE+kcSC5I1kmTjXcqitKM3saNkO/FJa0
         z3nSbiPqBni/y3QuZYU8aCQ9KmDeR28PTJkIGhS8SJLItgCOph/LRe3zEAf+kmLeo6xB
         zSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679701140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stLHl7pCDH1RyBPiBGqBzug135qk6M/LhP5L5oUD+CA=;
        b=0Q5MhV9wH9KZPBecJK2F1r52BzTjjAnHZ5zIRxcMwr7ef8wkN0LUeubh9EFKsuFm+h
         yt6AL2TEBbxmnezsvWosNdXthJ+4lYU7jBXKFH2klRQ8akM23PcdJvwC0t6TPSC5nHSj
         57e/HC72Bd4kpeNLVIt5galyC+zb5Zt3JjERa7b41+cyaj/zsfZrx92hwoDPtYWANgud
         J034wdjxwAwd0Rac6KyIHXZCwHnoF4qshghqMri4JXlry+ffnPn0eUZY3o0RXXhWSrry
         4cg6s1GMAgv/RtyPCubY8/pXWNQmN9z1sQc6frpf6qPRqwVEOAiu1yVbbvffzXCxj3wN
         8hQg==
X-Gm-Message-State: AAQBX9dF27AuGnvoObQZHxoIFj+cTa1UFniWdiXRSZA0ZuLHsveGOX5j
        t/zNIaA0gYlgRD2jqWt7TmCwGCvBj6w=
X-Google-Smtp-Source: AKy350ZF9xr0ZknptnwYGZgVBn7fw1tY0VoPqVPuZ9HCLMbf7WpEAy/PWhAxxtYUxgQ2Wl0qIORpow==
X-Received: by 2002:a17:903:6cd:b0:1a1:9787:505a with SMTP id kj13-20020a17090306cd00b001a19787505amr3763298plb.58.1679701139602;
        Fri, 24 Mar 2023 16:38:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902aa9200b001a1add0d616sm13666771plr.161.2023.03.24.16.38.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 16:38:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] monitor/att: Print value when printing descriptors
Date:   Fri, 24 Mar 2023 16:38:54 -0700
Message-Id: <20230324233856.3693370-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324233856.3693370-1-luiz.dentz@gmail.com>
References: <20230324233856.3693370-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints the value attribute information when print attribute
descriptors:

< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Write Request (0x12) len 4
        Handle: 0x002c Type: Client Characteristic Configuration (0x2902)
        Value Handle: 0x002b Type: Battery Level (0x2a19)
          Data: 0100
            Notification (0x01)
---
 monitor/att.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/monitor/att.c b/monitor/att.c
index 9f329370d698..42d1afe701a1 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -122,6 +122,56 @@ static struct att_read *att_get_read(const struct l2cap_frame *frame)
 	return queue_remove_if(data->reads, match_read_frame, (void *)frame);
 }
 
+static void print_value(struct gatt_db_attribute *attr)
+{
+	uint16_t handle;
+	struct gatt_db_attribute *val;
+	const bt_uuid_t *uuid;
+	bt_uuid_t chrc = {
+		.type = BT_UUID16,
+		.value.u16 = 0x2803,
+	};
+	char label[27];
+
+	uuid = gatt_db_attribute_get_type(attr);
+	if (!uuid)
+		return;
+
+	/* Skip in case of characteristic declaration since it already prints
+	 * the value handle and properties.
+	 */
+	if (!bt_uuid_cmp(uuid, &chrc))
+		return;
+
+	val = gatt_db_attribute_get_value(attr);
+	if (!val || val == attr)
+		return;
+
+	uuid = gatt_db_attribute_get_type(val);
+	if (!uuid)
+		return;
+
+	handle = gatt_db_attribute_get_handle(val);
+	if (!handle)
+		return;
+
+	switch (uuid->type) {
+	case BT_UUID16:
+		sprintf(label, "Value Handle: 0x%4.4x Type", handle);
+		print_field("%s: %s (0x%4.4x)", label,
+				bt_uuid16_to_str(uuid->value.u16),
+				uuid->value.u16);
+		return;
+	case BT_UUID128:
+		sprintf(label, "Value Handle: 0x%4.4x Type", handle);
+		print_uuid(label, &uuid->value.u128, 16);
+		return;
+	case BT_UUID_UNSPEC:
+	case BT_UUID32:
+		break;
+	}
+}
+
 static void print_attribute(struct gatt_db_attribute *attr)
 {
 	uint16_t handle;
@@ -142,10 +192,12 @@ static void print_attribute(struct gatt_db_attribute *attr)
 		print_field("%s: %s (0x%4.4x)", label,
 				bt_uuid16_to_str(uuid->value.u16),
 				uuid->value.u16);
+		print_value(attr);
 		return;
 	case BT_UUID128:
 		sprintf(label, "Handle: 0x%4.4x Type", handle);
 		print_uuid(label, &uuid->value.u128, 16);
+		print_value(attr);
 		return;
 	case BT_UUID_UNSPEC:
 	case BT_UUID32:
-- 
2.39.2

