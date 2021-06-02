Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5834C47083
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Jun 2021 22:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF2C613E6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Jun 2021 22:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhFBWzw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Jun 2021 18:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFBWzw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Jun 2021 18:55:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E276BC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jun 2021 15:54:08 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t8so3530321pgb.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jun 2021 15:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JivnPwUdgtiMEUtJMjXPlP8jDXsxA2fny+NDGNihgHw=;
        b=BxTUUHMYhJYQ4dYrzEuHrOZZd36x1rNCo3Ze2HfVK7OVU514qjCwmeI3lI/mDHbQis
         X9pydEXLRVkq4eoir0wm9nkH9iVc0Fd5iUnsGE1AIr4030dvRKRMVFEKtDUThVHURjDo
         Jn2Cbj4hwegMN5V+b0H5BZuw0OakL2vavbTBaU/BsR1i/ArnAl/rX1kD3gD51Sfb0gOt
         R80iA5bL8QaKfXJnQzKh8ltO/oC0XBZ6+N7GxGBomGfO8cGRhwd4GMIZzsQROxMYWm7V
         Hh407fjPNFZql8AyglA2Ugsu6HDm7KDqy1EyN0L42h091K+oK6udCN3K4MHnJET7pk+I
         6w3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JivnPwUdgtiMEUtJMjXPlP8jDXsxA2fny+NDGNihgHw=;
        b=FukXjCNFqST1yR8VBMTTNwreVHdYO3nP+qHUZbI3q1NqS9Jf5S4sGJGnXrwuSeGjSs
         NZ9Iyx5LTbFt86pkvYhe2UZHgH0xUo2zexzNxDiMn0hOuxrcsjqfTNNoIliBHpAL2dlc
         wzXoKmQRuCm7A13uDHHTNrBbev67sqg8GR5tVwn+bRj9w47JndggDOkiu7EKeqRIgzOG
         Zclt2WQiedOAogllF+wUCBeY23YGHio3C+5NRgbOCefmttQWb7VHwH4Fu7qK119SbK0Q
         euDKi1qk9hbcdfCdYauNOovzfgSDHv58AF4EE7qIwIfGtrhL0Te7eEl+ajyiFHHh+0iY
         Ieuw==
X-Gm-Message-State: AOAM530UFkFHzCMjgAyAYJ+krkfCD3DC6X8zPIQqbWq2eKnKdmBYO1Gz
        w4mhNZDyW27C4jiwHnXUumijodHYlfk=
X-Google-Smtp-Source: ABdhPJwh841mpTS0RGwCbVzDikGn3qjol+tObySzyUTOXpAJiDVN7+/5yZZCvH0ZWWUjJ3zHHEPAiQ==
X-Received: by 2002:a63:5b21:: with SMTP id p33mr18389828pgb.402.1622674448148;
        Wed, 02 Jun 2021 15:54:08 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s3sm678578pgs.62.2021.06.02.15.54.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 15:54:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] Bluetooth: Add helper for serialized HCI command execution
Date:   Wed,  2 Jun 2021 15:54:00 -0700
Message-Id: <20210602225404.744891-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

The usage of __hci_cmd_sync() within the hdev->setup() callback allows for
a nice and simple serialized execution of HCI commands. More importantly
it allows for result processing before issueing the next command.

With the current usage of hci_req_run() it is possible to batch up
commands and execute them, but it is impossible to react to their
results or errors.

This is an attempt to generalize the hdev->setup() handling and provide
a simple way of running multiple HCI commands from a single function
context.

There are multiple struct work that are decdicated to certain tasks
already used right now. It is add a lot of bloat to hci_dev struct and
extra handling code. So it might be possible to put all of these behind
a common HCI command infrastructure and just execute the HCI commands
from the same work context in a serialized fashion.

For example updating the white list and resolving list can be done now
without having to know the list size ahead of time. Also preparing for
suspend or resume shouldn't require a state machine anymore. There are
other tasks that should be simplified as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 17 +++++++
 net/bluetooth/hci_core.c         | 82 ++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 43b08bebae74..de95c47aaf77 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -302,6 +302,17 @@ struct amp_assoc {
 
 #define HCI_MAX_PAGES	3
 
+typedef int (*cmd_sync_work_func_t)(struct hci_dev *hdev, void *data);
+typedef void (*cmd_sync_work_destroy_t)(struct hci_dev *hdev, void *data,
+					int err);
+
+struct cmd_sync_work_entry {
+	struct list_head list;
+	cmd_sync_work_func_t func;
+	void *data;
+	cmd_sync_work_destroy_t destroy;
+};
+
 struct hci_dev {
 	struct list_head list;
 	struct mutex	lock;
@@ -463,6 +474,9 @@ struct hci_dev {
 	struct work_struct	power_on;
 	struct delayed_work	power_off;
 	struct work_struct	error_reset;
+	struct work_struct	cmd_sync_work;
+	struct list_head	cmd_sync_work_list;
+	struct mutex		cmd_sync_work_lock;
 
 	__u16			discov_timeout;
 	struct delayed_work	discov_off;
@@ -1701,6 +1715,9 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			     const void *param, u32 timeout);
 
+int hci_cmd_sync_queue(struct hci_dev *hdev, cmd_sync_work_func_t func,
+		       void *data, cmd_sync_work_destroy_t destroy);
+
 u32 hci_conn_get_phy(struct hci_conn *conn);
 
 /* ----- HCI Sockets ----- */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6eedf334f943..ba407976066b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2329,6 +2329,81 @@ static void hci_error_reset(struct work_struct *work)
 	hci_dev_do_open(hdev);
 }
 
+static void hci_cmd_sync_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_sync_work);
+	struct cmd_sync_work_entry *entry;
+	cmd_sync_work_func_t func;
+	cmd_sync_work_destroy_t destroy;
+	void *data;
+
+	bt_dev_dbg(hdev, "");
+
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	entry = list_first_entry(&hdev->cmd_sync_work_list,
+				 struct cmd_sync_work_entry, list);
+	if (entry) {
+		list_del(&entry->list);
+		func = entry->func;
+		data = entry->data;
+		destroy = entry->destroy;
+		kfree(entry);
+	} else {
+		func = NULL;
+		data = NULL;
+		destroy = NULL;
+	}
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+
+	if (func) {
+		int err;
+
+		hci_req_sync_lock(hdev);
+
+		err = func(hdev, data);
+
+		if (destroy)
+			destroy(hdev, data, err);
+
+		hci_req_sync_unlock(hdev);
+	}
+}
+
+int hci_cmd_sync_queue(struct hci_dev *hdev, cmd_sync_work_func_t func,
+		       void *data, cmd_sync_work_destroy_t destroy)
+{
+	struct cmd_sync_work_entry *entry;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->func = func;
+	entry->data = data;
+	entry->destroy = destroy;
+
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	list_add_tail(&entry->list, &hdev->cmd_sync_work_list);
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+
+	queue_work(hdev->req_workqueue, &hdev->cmd_sync_work);
+
+	return 0;
+}
+
+static void hci_cmd_sync_clear(struct hci_dev *hdev)
+{
+	struct cmd_sync_work_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list) {
+		if (entry->destroy)
+			entry->destroy(hdev, entry->data, -ECANCELED);
+
+		list_del(&entry->list);
+		kfree(entry);
+	}
+}
+
 void hci_uuids_clear(struct hci_dev *hdev)
 {
 	struct bt_uuid *uuid, *tmp;
@@ -3845,6 +3920,10 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_WORK(&hdev->error_reset, hci_error_reset);
 	INIT_WORK(&hdev->suspend_prepare, hci_prepare_suspend);
 
+	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
+	INIT_LIST_HEAD(&hdev->cmd_sync_work_list);
+	mutex_init(&hdev->cmd_sync_work_lock);
+
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 
 	skb_queue_head_init(&hdev->rx_q);
@@ -4005,6 +4084,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	cancel_work_sync(&hdev->power_on);
 
+	cancel_work_sync(&hdev->cmd_sync_work);
+	hci_cmd_sync_clear(hdev);
+
 	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks)) {
 		hci_suspend_clear_tasks(hdev);
 		unregister_pm_notifier(&hdev->suspend_notifier);
-- 
2.31.1

