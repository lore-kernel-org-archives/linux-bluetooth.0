Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C204CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Dec 2022 21:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiLSVhw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 16:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiLSVhu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 16:37:50 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5F1F580
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 13:37:49 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so10147918pjd.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 13:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEltcE3viY/1MzRx9xhY4XBdSv7mmCkv7JqRLAPFemE=;
        b=la+kXW/2wrStRmyU0WEdP3Xe8MsxuOws5yEGSJp7llA9oqU8WPAhNKvqwlqMVJ16cv
         V5u0F189lv4I7qCM/hviDekaZio8/VbYTsnccAfDMvTZPgYMgUC4Q4f1ozJYcnlAH0h4
         hC+NiSHGMhd8XKJFhuxnN4LbhbQhYwO30/44yG/cvAkmm5uOrBvS22SLZagIghNvUa0x
         c6/pIKg0oTJQVObIBbR3+OqXzuc+NS9+K21FQount0021ICAuvQh0Z8qDRTk7wA8b2db
         S8ELw/2zDK/JPJ3toLY6QmlI8VOLkSvnWExOol/WIL81NPfOtY5T001e/2gXTTNlSM12
         33Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEltcE3viY/1MzRx9xhY4XBdSv7mmCkv7JqRLAPFemE=;
        b=ORE9S7AHVztsZQZ5ySuIfrXlam5/pElIUIQY9LCLuTChBYX+UW7Z0EomCOLfF3R4aO
         nG0jqgaQglS8LYyaw+3iV1stNi84MzQeoEEWDhcPADxXu9lVdeqBl/nySr25inhDFyGJ
         cDdL5Hi7OsncAtbJP/r+HOb3MQtqQFXBdpZ+dPR6jRAmWxp6G/boBfz9QVxz51WStUiz
         1KiPwiwhFLVyT0CwzFn8ytKs5GKMiXQ/+1PjqLXdYP6GLzykwD0Wdk30klF6R1l8K1KN
         YiZuFV7nmrYuBBfc8dyPeevoQeOcuBM2qNsOhoXvX05yrlbiAkXMkraVMZt4bhSinkZM
         eK6g==
X-Gm-Message-State: AFqh2kpqJPJXjaFxubA4CeJgOCsLr3jZbJpUpGzO5DfVqdyjUuL2btg7
        +we/4NUyBu3oNKn0ARTLKtGneolnxEp3RA==
X-Google-Smtp-Source: AMrXdXvmrIvLtDQgigf/GoK6mNGxT6ueK3zoR2rcgA4sTOJHMHXNz7kaeG80BfzeXyO07IhK5n2uUg==
X-Received: by 2002:a17:902:c153:b0:189:f390:a227 with SMTP id 19-20020a170902c15300b00189f390a227mr10601429plj.56.1671485868903;
        Mon, 19 Dec 2022 13:37:48 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b0017c37a5a2fdsm7642762plg.216.2022.12.19.13.37.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 13:37:48 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Fix use HCI_OP_LE_READ_BUFFER_SIZE_V2
Date:   Mon, 19 Dec 2022 13:37:47 -0800
Message-Id: <20221219213747.3659867-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Don't try to use HCI_OP_LE_READ_BUFFER_SIZE_V2 if controller don't
support ISO channels.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216817
Fixes: c1631dbc00c1 ("Bluetooth: hci_sync: Fix hci_read_buffer_size_sync")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5220bfd75b00..b3676b899647 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3572,7 +3572,7 @@ static const struct hci_init_stage hci_init2[] = {
 static int hci_le_read_buffer_size_sync(struct hci_dev *hdev)
 {
 	/* Use Read LE Buffer Size V2 if supported */
-	if (hdev->commands[41] & 0x20)
+	if (iso_capable(hdev) && hdev->commands[41] & 0x20)
 		return __hci_cmd_sync_status(hdev,
 					     HCI_OP_LE_READ_BUFFER_SIZE_V2,
 					     0, NULL, HCI_CMD_TIMEOUT);
-- 
2.37.3

