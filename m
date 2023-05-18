Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86345C77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 23:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjERXUz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 19:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjERXUy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 19:20:54 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692AAE49
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 16:20:53 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so177883b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 16:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684452052; x=1687044052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HmisroU8fdM2kRonVoSx6KAHWRO5YgGqd9NTVomyq8c=;
        b=JyDE3UzY/UQv+LpsE2l23f1Q4j4IehUJSaBv0vTieBSb+fGAjYvi/z2Ce6BS8zpeM/
         nUVI0toBjy98J+vu24mMPyBuuhw69mTfPjFLksBbMaghpQpVw5uhfQO7aWlCJdq4qbZc
         iCctgFNKIUVptUzHOzOrtGD8jo3O4FVg92EhLje7UqsTkBGs8k7dmdOYjwKRav7ChhOr
         7vvm0HXkH38pLd628t+XaOE7rXcgwxXMrITB0pGl/BK4UIUFJticvM/jb/dDC41bY5vR
         6G1sbbeSmmqBOaY2lOmdiUCh17lBi43b2ltaznJKgqA1gsW8CuLKpAQmERZNd8DsI3F8
         1S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684452052; x=1687044052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmisroU8fdM2kRonVoSx6KAHWRO5YgGqd9NTVomyq8c=;
        b=REyGfs5BiHzJAI1YOxGZD9pGx+Tt0e9J6GrW/05Czi180rqxt+CMVhhRXkk4ZGWJ2F
         0sEzK6iQ4nEhd57KBpL5IOC+C8bY/w3kiEupWksghozTRQMWI4gIXRghbYQKA5kY2zK0
         G8ol0Hip03pHzA3sgQE4p7IN/fmGJzwh+q/gzNjdwrNc4C4Dwgr1yJ39VDFbPfgIVwiI
         nolskj7K012vtoPahH70Agr12tczPVm3BhfBIGY5a3WjJX7Bf9Dv7Yteo+S3bq2VR3yD
         xqsBG8fjumqJTQoLu/RaociRBZdT8AKLKtOb7Mb4f3gC15/2DhiacUStM2vwb395SbYK
         oGKg==
X-Gm-Message-State: AC+VfDwA29/7ZCgaM1fe/HXVG8Nj743XNts0yCIfXBDlrpBXOKYhkR7l
        tm6GzLDmME4Bn1yLlM+hlZ3P79MJFm0=
X-Google-Smtp-Source: ACHHUZ7cYyXD9pz16i5Id80kDRTIyJfCQNYSGZC+vXhqgvcSSnaZW/iOC1IOijeD2YC9noC80XZ2Ng==
X-Received: by 2002:a05:6a21:6d98:b0:102:c96b:f147 with SMTP id wl24-20020a056a216d9800b00102c96bf147mr819657pzb.17.1684452051946;
        Thu, 18 May 2023 16:20:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id q23-20020a62ae17000000b0062dbafced27sm62129pff.27.2023.05.18.16.20.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 16:20:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] monitor: Fix not parsing BT_HCI_EVT_NUM_COMPLETED_PACKETS properly
Date:   Thu, 18 May 2023 16:20:48 -0700
Message-Id: <20230518232049.1656554-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BT_HCI_EVT_NUM_COMPLETED_PACKETS may contain multiple handles but the
code was just parsing the very first one.
---
 monitor/packet.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index aafb81eefb13..39d1f70310e4 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10293,14 +10293,31 @@ static void role_change_evt(uint16_t index, const void *data, uint8_t size)
 static void num_completed_packets_evt(uint16_t index, const void *data,
 							uint8_t size)
 {
+	struct iovec iov = { (void *)data, size};
 	const struct bt_hci_evt_num_completed_packets *evt = data;
+	int i;
+
+	iov_pull(&iov, 1);
 
 	print_field("Num handles: %d", evt->num_handles);
-	print_handle(evt->handle);
-	print_field("Count: %d", le16_to_cpu(evt->count));
 
-	if (size > sizeof(*evt))
-		packet_hexdump(data + sizeof(*evt), size - sizeof(*evt));
+	for (i = 0; i < evt->num_handles; i++) {
+		uint16_t handle;
+		uint16_t count;
+
+		if (!util_iov_pull_le16(&iov, &handle))
+			break;
+
+		print_handle_native(handle);
+
+		if (!util_iov_pull_le16(&iov, &count))
+			break;
+
+		print_field("Count: %d", le16_to_cpu(evt->count));
+	}
+
+	if (iov.iov_len)
+		packet_hexdump(iov.iov_base, iov.iov_len);
 }
 
 static void mode_change_evt(uint16_t index, const void *data, uint8_t size)
-- 
2.40.1

