Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88CEC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 20:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392554AbiDUUuO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392545AbiDUUuM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 16:50:12 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9889A4E382
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 13:47:19 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r12so6613086iod.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 13:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZMg6v7mRQoQurDiSBRN8Mq5vNLxJn9BdvEQJmSGDd4I=;
        b=qaIPbW9Cu7RDdbPr+kWUPybWMx3eUHRkb1b7zq6XrZNeZpwmZhDTQbt43zSKmv+e/J
         NUVMlORXI5CoKnw32S75PX8Db6/YmVsE2EaZdQUCS6Ap77/DRWBOnFwuZ3GNn5d1N6iW
         ckHgAVasug2GJsiiMbO0+5DYMpIcGDnpQJnNkaxYbb/Dqb0xmIbvB88ANOMrap0ON42Z
         gOW+Q05Yk5VXHkoQESe/hCNWY/laCYtSnkMUpWm68LQ/ftWZXV/r1LPtanroQT3tjV+f
         zIAf7gf72LgK/pkibrvBzF5L1fW6lTDE+JdvoVZADc7H9TaqGTj3uPQVAiB6AzRTy+Hj
         S7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZMg6v7mRQoQurDiSBRN8Mq5vNLxJn9BdvEQJmSGDd4I=;
        b=5cGMwLvUam6H7OeqVjLad0T0r1OFfhyvqGpwpG/cXowUi8LW/UlREpPZKc3EXaNZQg
         CrYsK2vQOngNb6bd8X1NjFaV6wVNRz5NlBuQd65pcGmK151fDTHAVCea//UBsBXdHPD8
         KaNW87GMKTxLHnhCD+WeRQcqsL9F96YBpn25kb4tWaMwoDyB5v/0PvD8v63OvX7TU7wy
         JaK3Yh4fcbaU3K6BhbQAcFr1rr8AdO00UsmkdZO96nmN4AYxSzy//nqjA1QaJ6mCMdPK
         6ZJrYJU/G32puS7RUU/nlc8f6Jb/1yJYrOz4o0JSdigzc5p9yix1WN3spCT1NmUgYzJB
         4OXA==
X-Gm-Message-State: AOAM533io+asd0bh4LZzB9SNdYcyAxDrsgmPvElCT0Ay4FLZRwf9DSz4
        BsX/JRS0gw60eYQSo9TkWDQaJaqd3hw=
X-Google-Smtp-Source: ABdhPJyn8MFSFsg+JoqreFyLJwCmnF5WYOO4ge9ICTq4MVAByMjIdAeI6nkyTzlSKWX7OsMwMxr6oA==
X-Received: by 2002:a02:b0c3:0:b0:327:b824:b8ac with SMTP id w3-20020a02b0c3000000b00327b824b8acmr730998jah.120.1650574038678;
        Thu, 21 Apr 2022 13:47:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s21-20020a6bd315000000b006573987c4fcsm80281iob.3.2022.04.21.13.47.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 13:47:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: Fix creating hci_conn object on error status
Date:   Thu, 21 Apr 2022 13:47:15 -0700
Message-Id: <20220421204715.3268714-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421204715.3268714-1-luiz.dentz@gmail.com>
References: <20220421204715.3268714-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It is useless to create a hci_conn object if on error status as the
result would be it being freed in the process and anyway it is likely a
result of controller and host stack being out of sync for some reason.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a658aa4c7306..3002df41f16b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3074,6 +3074,12 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
 	if (!conn) {
+		/* In case of error status and there is no connection pending
+		 * just unlock as there is nothing to cleanup.
+		 */
+		if (ev->status)
+			goto unlock;
+
 		/* Connection may not exist if auto-connected. Check the bredr
 		 * allowlist to see if this device is allowed to auto connect.
 		 * If link is an ACL type, create a connection class
@@ -3120,8 +3126,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 	if (!ev->status) {
 		conn->handle = __le16_to_cpu(ev->handle);
 		if (conn->handle > HCI_CONN_HANDLE_MAX) {
-			bt_dev_err(hdev, "Invalid handle: 0x%4.4x",
-				   conn->handle);
+			bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
+				   conn->handle, HCI_CONN_HANDLE_MAX);
 			ev->status = HCI_ERROR_INVALID_PARAMETERS;
 			goto done;
 		}
@@ -4729,8 +4735,8 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 	case 0x00:
 		conn->handle = __le16_to_cpu(ev->handle);
 		if (conn->handle > HCI_CONN_HANDLE_MAX) {
-			bt_dev_err(hdev, "Invalid handle: 0x%4.4x",
-				   conn->handle);
+			bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x",
+				   conn->handle, HCI_CONN_HANDLE_MAX);
 			ev->status = HCI_ERROR_INVALID_PARAMETERS;
 			conn->state = BT_CLOSED;
 			break;
@@ -5540,6 +5546,12 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
 	conn = hci_lookup_le_connect(hdev);
 	if (!conn) {
+		/* In case of error status and there is no connection pending
+		 * just unlock as there is nothing to cleanup.
+		 */
+		if (status)
+			goto unlock;
+
 		conn = hci_conn_add(hdev, LE_LINK, bdaddr, role);
 		if (!conn) {
 			bt_dev_err(hdev, "no memory for new connection");
@@ -5603,7 +5615,8 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	conn->dst_type = ev_bdaddr_type(hdev, conn->dst_type, NULL);
 
 	if (handle > HCI_CONN_HANDLE_MAX) {
-		bt_dev_err(hdev, "Invalid handle: 0x%4.4x", conn->handle);
+		bt_dev_err(hdev, "Invalid handle: 0x%4.4x > 0x%4.4x", handle,
+			   HCI_CONN_HANDLE_MAX);
 		status = HCI_ERROR_INVALID_PARAMETERS;
 	}
 
-- 
2.35.1

