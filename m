Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C52C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 00:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiFQAuC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFQAuB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 20:50:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B2F61636
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 17:50:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so1644292pjm.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 17:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G9oieWRgAMAuM4l/LZD5hLljgu0Jll3/4JXTYS8AOqs=;
        b=KDuXlmBRKFQLY+EP+L+C+EVf/tP92F17XG3lO3/AnGA0gyOnvbuphQ1V0v+aqqXtoa
         cnclYGryu1oN/ELK4gzT/+4WEO+paLvyP8z2lAcrw4sX4IP2zkNaCZ0kXvcYTnOumk/P
         IKt5I7bIAX4oCKutCXtfVgC0LUZ5xOwZbqhq/C8uIU31GUwxmtpX31bQYthmv4rjDHmD
         LF1TjqAyO0uTTL4N9Pfv9yckAA8AByCpda56uZNGUghHfKhYNe4gMktW3hf6mb2uq0q+
         yp0Tdcesk/HF6cUxDiEgPT+rwfpp5/nRPj/jGXnhoU69a0hX6GgQRA382D1K9Ca4T1wI
         3vQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G9oieWRgAMAuM4l/LZD5hLljgu0Jll3/4JXTYS8AOqs=;
        b=flauQHTP1trNnldcVLWzpNbW+DqegQ4XxZhNtY/zBLEktUJt5CxrZ7sYh+f2E8MpAx
         JrVVkFJeblA+vjfwf2L8pUE2q8SarXTQbVt9lR6kXkBhveUyIpCE59w1Jpc2m6K7BmB4
         Z/2WKd3q3cVZ7fw6jT05Boxm8MvUjWfQ4Eg3WcnUhvjZ5cU6RIt3n8EYGSxHxnJ2cWZV
         p+eiPY9HJb12tBna7koZqBvm3W+4NOhyl7lK4Ho8pxr0Up4GGCzWlpqbfGCKCtXPQaQI
         kGIVI8/bkXQm/pNp4z3XDMGnBRO2aNuklQ2+l/tOe7KJWK8Ipxlz/n0CpQUmFTLJbxS9
         bJgQ==
X-Gm-Message-State: AJIora++rW4DHk9WcZtVtVRus5i4382WL1U6qVlcO76JH1FESbVz9t9t
        +UEO4D3YyX6PQa/yx4F3XP9TLYsHELQ=
X-Google-Smtp-Source: AGRyM1tdEFJ727Olc95ciGixXINdYZ27LdnxBbo5RhQFlxmBz0CuYUhRANWtqUwQe6PCIGE4dLfDuw==
X-Received: by 2002:a17:902:728d:b0:168:d0cf:2246 with SMTP id d13-20020a170902728d00b00168d0cf2246mr6947778pll.74.1655426999174;
        Thu, 16 Jun 2022 17:49:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u23-20020a170902a61700b0015e8d4eb25asm338996plq.164.2022.06.16.17.49.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 17:49:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] monitor/att: Print attribute information on ATT_REQ_RSP
Date:   Thu, 16 Jun 2022 17:49:54 -0700
Message-Id: <20220617004957.1148939-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints the attribute information on ATT_REQ_RSP to make it easier
to identify to which handle the response is for:

> ACL Data RX: Handle 42 flags 0x02 dlen 9
      Channel: 65 len 5 sdu 3 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Read Response (0x0b) len 2
        Value: 0300
        Handle: 0x0030 Type: Source ASE (0x2bc5)
            ASE ID: 3
            State: Idle (0x00)
---
 monitor/att.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index de70a9dc4..34babac6b 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -1290,17 +1290,12 @@ static struct gatt_db_attribute *get_attribute(const struct l2cap_frame *frame,
 	return gatt_db_get_attribute(db, handle);
 }
 
-static void print_handle(const struct l2cap_frame *frame, uint16_t handle,
-								bool rsp)
+static void print_attribute(struct gatt_db_attribute *attr)
 {
-	struct gatt_db_attribute *attr;
+	uint16_t handle = gatt_db_attribute_get_handle(attr);
 	const bt_uuid_t *uuid;
 	char label[21];
 
-	attr = get_attribute(frame, handle, rsp);
-	if (!attr)
-		goto done;
-
 	uuid = gatt_db_attribute_get_type(attr);
 	if (!uuid)
 		goto done;
@@ -1323,6 +1318,20 @@ done:
 	print_field("Handle: 0x%4.4x", handle);
 }
 
+static void print_handle(const struct l2cap_frame *frame, uint16_t handle,
+								bool rsp)
+{
+	struct gatt_db_attribute *attr;
+
+	attr = get_attribute(frame, handle, rsp);
+	if (!attr) {
+		print_field("Handle: 0x%4.4x", handle);
+		return;
+	}
+
+	print_attribute(attr);
+}
+
 static void att_read_req(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_att_read_req *pdu = frame->data;
@@ -1393,6 +1402,8 @@ static void att_read_rsp(const struct l2cap_frame *frame)
 	if (!read)
 		return;
 
+	print_attribute(read->attr);
+
 	read->func(frame);
 
 	free(read);
-- 
2.35.3

