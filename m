Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDC6C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78078610E9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbhHMMVJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240293AbhHMMVJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:09 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61A9C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:42 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id a12-20020a17090aa50cb0290178fef5c227so5192550pjq.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tA769l60HUHyo6fM7OVi5B5wDNo4DDO5JlDqM1bdQgA=;
        b=cErS8Nnd/RnOgq3XkBHZCmi5DxllX3JwuuJFvkxgZW+zmW2MPv2t2nnHrTRnNl/Vkc
         knN7jVPZ4FmlltzJlzJKrqYo/td1ARCGC0jT2iyrrQ6vK3yn28Ai+R3DEvTeph0SrLNA
         uYxkAk89bon90t04rUG9vZGtDuGN345lpSsTzoXNx1qdqaeple4tS8a5EAPdb02DmxQC
         ZDAjwUR0p7Z9MQDqacHgNRVQkX+C22nPe0PwEhNhvw3fK0a/fBkKIn5nK5AnlHq8d2Uu
         JuQ5cP78EHHRBxUmMP6T4Lx4riW8/Zoap7M+pcZ6SOTgD5D308r3F5KhO008op3VmtVT
         OsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tA769l60HUHyo6fM7OVi5B5wDNo4DDO5JlDqM1bdQgA=;
        b=QXceJqW5COL57kqc3E0nyViKfl5aYBebj+5gtNDCYqcoljZDZfAK1U/Z9IsSPf8Vy0
         Efy/iCjEpqTlh/wGLJJ4h/czDZEnUBtHvMJu1P1ga38vkyImbFwFvRpKti77nAap39bl
         afLrInq27e4xQ7ww5SiogexOCeCpkDuVnYTAH/sHVwuqkH6XZLI2Lu2TpgprYlayDrQJ
         q/856RXgwMIcpzUPBS8er5zqBlrEfcuyuw/uwgtzFDYiS06He96vRZd3WK657if2Dk3o
         Frb7vLlQsbpNhjkfbuKPqf3UsoPxsWHHRc9IvDrTicmTaaeTzeDBuDEgWLHrRGtLEfhq
         NDOA==
X-Gm-Message-State: AOAM530v0rvsh5yJQdyuiyIrqbsvf5UJSho+wHKlhORSt9lUOaOaRUTy
        Arb7SVZ8UhxzIflFsG3lnkywFjey+V1KKe40KQsqrxcKZZE4etOHyZshgREFwvPdOxM/QXWVhQh
        Wh7GrKV4zkfBwhQRGwyvNsmngPstTzrXz/gYvx8nrhMtrlUtRQvioL4zJpj/zGGvRvXccaKlUbO
        Yq
X-Google-Smtp-Source: ABdhPJwuA6jNzd4C6moCos6T8+l8bfbp74xxMuXDcpATpLPvv6QRZVd9qA4dt5YlDRksMvUxTFMV9ew8m7Ub
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:aa7:80d9:0:b029:2ed:49fa:6dc5 with SMTP id
 a25-20020aa780d90000b02902ed49fa6dc5mr2153648pfn.3.1628857242107; Fri, 13 Aug
 2021 05:20:42 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:03 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.18.I459ed503caa6f462dc67f27296d57889af13a864@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 18/62] monitor: Inclusive language in peripheral page
 response timeout
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"peripheral" is preferred, as reflected in the BT core spec 5.3.
---

 monitor/bt.h     | 2 +-
 monitor/packet.c | 8 ++++----
 tools/3dsp.c     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index 4aa11e53a5..3144c25ff0 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3348,7 +3348,7 @@ struct bt_hci_evt_truncated_page_complete {
 	uint8_t  bdaddr[6];
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_SLAVE_PAGE_RESPONSE_TIMEOUT	0x54
+#define BT_HCI_EVT_PERIPHERAL_PAGE_RESPONSE_TIMEOUT	0x54
 
 #define BT_HCI_EVT_PERIPHERAL_BROADCAST_CHANNEL_MAP_CHANGE	0x55
 struct bt_hci_evt_peripheral_broadcast_channel_map_change {
diff --git a/monitor/packet.c b/monitor/packet.c
index a787cb2854..55f275ab3a 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2985,7 +2985,7 @@ static const struct bitfield_data events_page2_table[] = {
 	{ 17, "Connectionless Peripheral Broadcast Receive"		},
 	{ 18, "Connectionless Peripheral Broadcast Timeout"		},
 	{ 19, "Truncated Page Complete"					},
-	{ 20, "Slave Page Response Timeout"				},
+	{ 20, "Peripheral Page Response Timeout"			},
 	{ 21, "Connectionless Peripheral Broadcast Channel Map Change"	},
 	{ 22, "Inquiry Response Notification"				},
 	{ 23, "Authenticated Payload Timeout Expired"			},
@@ -10238,7 +10238,7 @@ static void truncated_page_complete_evt(const void *data, uint8_t size)
 	print_bdaddr(evt->bdaddr);
 }
 
-static void slave_page_response_timeout_evt(const void *data, uint8_t size)
+static void peripheral_page_response_timeout_evt(const void *data, uint8_t size)
 {
 }
 
@@ -11197,8 +11197,8 @@ static const struct event_data event_table[] = {
 				peripheral_broadcast_timeout_evt, 7, true },
 	{ 0x53, "Truncated Page Complete",
 				truncated_page_complete_evt, 7, true },
-	{ 0x54, "Slave Page Response Timeout",
-				slave_page_response_timeout_evt, 0, true },
+	{ 0x54, "Peripheral Page Response Timeout",
+				peripheral_page_response_timeout_evt, 0, true },
 	{ 0x55, "Connectionless Peripheral Broadcast Channel Map Change",
 			peripheral_broadcast_channel_map_change_evt, 10, true },
 	{ 0x56, "Inquiry Response Notification",
diff --git a/tools/3dsp.c b/tools/3dsp.c
index 4dd53478e1..5227c30b63 100644
--- a/tools/3dsp.c
+++ b/tools/3dsp.c
@@ -492,7 +492,7 @@ static void start_display(void)
 	bt_hci_register(hci_dev, BT_HCI_EVT_CONN_REQUEST,
 						conn_request, NULL, NULL);
 
-	bt_hci_register(hci_dev, BT_HCI_EVT_SLAVE_PAGE_RESPONSE_TIMEOUT,
+	bt_hci_register(hci_dev, BT_HCI_EVT_PERIPHERAL_PAGE_RESPONSE_TIMEOUT,
 				slave_page_response_timeout, NULL, NULL);
 	bt_hci_register(hci_dev,
 			BT_HCI_EVT_PERIPHERAL_BROADCAST_CHANNEL_MAP_CHANGE,
-- 
2.33.0.rc1.237.g0d66db33f3-goog

