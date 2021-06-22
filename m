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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285CEC4743C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 00:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06968610EA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 00:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFVAnW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFVAnV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 20:43:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30AFC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 17:41:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bb10-20020a17090b008ab029016eef083425so650263pjb.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 17:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=29CZpLoK6nPZvYor9his0scdmxoyTQJ8HNnJMA8OXho=;
        b=Uje1w098j7hnkMZ+4BgMSuhlUUQxGOKZvFJliXmshjis87y8DfaeZCSjkKle7hx44p
         N5w58gJF1vjBNe9Gn/pqFrOGJLz1A2A+6JbxNKgAs8A+A23UvaWm+ORsJG7N9YMaEl8k
         TnZqzHRUdMwRuJoS1ICZoIP0ow8KqyFwKEFF+ij8S8NOLQcF4QI8bymnaAePEmX4g7Ci
         fJlNN8aumsXH2W4MpJSPVNH+qdiB9513V6CujC+gNOR97yBknMiQjfRi4ZtBJCge79Lj
         SMLTeHXrc0YtMy+bvNWpCvC04Vxo9nvuUlee0M+jeU11W8U5CIfUjcFySAOEkACrNWhd
         SkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=29CZpLoK6nPZvYor9his0scdmxoyTQJ8HNnJMA8OXho=;
        b=orr3UDJpLcMhfmc7fPaeyVAwgZbUGOCr4zgElK1SGxll0gb8QV3WD+pMN9BmMerAWv
         kZcZ9jXMoIsaWirAez8C5SxwDFutOOlbswrM3wxlGjB41BTQTCc3sVvBR/jBn21DvHOt
         oThX0FLRuuBCC7CLEW7kU5t/d+bMi+doureQJISxobUs2mzJ9J30OlrKtQwEEqMCWl3j
         vvFTwIEYWPLKJwWJnJi62QNgNcYQBR9u31ZCkt6N/xK4ZC6bz8uP3MSOl5Q+Y9/sDPrg
         7lLHtHrh1IfHSkd20VA0YDPyAwUPPUTgOwC5fmHXkvdOZynoYg9juhQYzgVJET+o42QF
         3iPw==
X-Gm-Message-State: AOAM531Pz/2r7ngr+sAdFSzz9b0S7U9eIFnbgcpb6905LnpQvTqFeo22
        Yt91U1V3YBTDaiqMFNaLZfZF3CkMnv2ijw==
X-Google-Smtp-Source: ABdhPJy3XwTYpKcRFiGxHaejc+o/xcmZK6hx67SK6PWMDg9WfeFvWxPaj9n+ug9T53ThCA0tOngdqA==
X-Received: by 2002:a17:90b:23c5:: with SMTP id md5mr787904pjb.93.1624322465876;
        Mon, 21 Jun 2021 17:41:05 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h22sm6491985pfc.21.2021.06.21.17.41.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:41:05 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/7] Bluetooth: Add helper for serialized HCI command execution
Date:   Mon, 21 Jun 2021 17:40:58 -0700
Message-Id: <20210622004104.3179217-1-luiz.dentz@gmail.com>
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
index a53e94459ecd..7b8dac2131e7 100644
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
index 1eb7ffd0dd29..8100a3a1ae13 100644
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

