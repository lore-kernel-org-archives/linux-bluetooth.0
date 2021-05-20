Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62B1C43460
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 16:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E5F60FDC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 May 2021 16:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhETQnj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 May 2021 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhETQni (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 May 2021 12:43:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423E7C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 May 2021 09:42:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q6so9429414pjj.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 May 2021 09:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIQ9n3w46Zlxh87BsNw2rK8BVXbgKhwqqQZRZNOIOW8=;
        b=E2/dYMnG7QkgFBCcoaG/VYmolutAUzfoLe5CdiELPKmqC70fFSu4nYe7C8G9V0Wr+e
         Qd61shaFNaiBrOrIPPnCte5czMh9iZP2wt5v42D1CdkG3rlxvOXFHYctV2/QglA5rcV+
         BvtSkq78hHX3NB0vqu5BYXY7eJUaJ7c0f7Q2inMihmHeD0niL2UdBeF07x6BAHn+JDkx
         J+nmH8KkUOm2XFaFCNc7XdmdSpxVeFuCarFA043zAsUWmaudqIpXoV3WO2xkuXb1NWgS
         YdDSfFtawXM5/BFW2bU4fsJrufuAk0+X9cUmqdITXDTxqK8s8gAbuwLCgifq/Eu4TIn3
         F/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BIQ9n3w46Zlxh87BsNw2rK8BVXbgKhwqqQZRZNOIOW8=;
        b=XOaXOhNthsvZWEdaMB7AqP/zeVPaTm+7LqTAR+0gk+DMvOMVnYnmllM5GFQm1avrwG
         s/BDErqdhxjHbn3JA1GrjgmKiL6lkbUkW8QBjoK7T9PbTvybPiwDIN0vG1hfw+Q/Mw2J
         9RxcErJwzLJqsXsIxS/8ogHdD1scL6p6807QFjOMT56WOLrTG5/10eibLGerLo3KNQib
         RJBBu/XqJ7pG+lzdG6ocu9yOqUAY1lJ9IZFa516KzWGBXfmGNMFIGHm6JTTZUF17ba9d
         1gz6cwhla5qCxOtwx1LpfnxjFSPQv9GfyqDGkUatlIdqoCi25hMxhehf5oWrpphK8MJZ
         dqDQ==
X-Gm-Message-State: AOAM533cxU+I1gQ5Wgvbof+9DzlOquEDJ99WEhwfDUDRnscObuK+Z7OQ
        sd83Vy3OYZ0Mf3GOEinBYjwB6k0OsTo=
X-Google-Smtp-Source: ABdhPJzFJxOUaADrqMbnwTpyg62303vBSTCFFGPUqT5WX/Oo2UPsTQpbhhdm/kt4CJ+8jabxXpijDg==
X-Received: by 2002:a17:902:7444:b029:ef:80f4:67e4 with SMTP id e4-20020a1709027444b02900ef80f467e4mr6943986plt.66.1621528935548;
        Thu, 20 May 2021 09:42:15 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z5sm2254834pfa.172.2021.05.20.09.42.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 09:42:15 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add helper for serialized HCI command execution
Date:   Thu, 20 May 2021 09:42:12 -0700
Message-Id: <20210520164213.1381518-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci_core.h | 14 +++++++
 net/bluetooth/hci_core.c         | 68 ++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 43b08bebae74..aecbdf99c216 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -302,6 +302,14 @@ struct amp_assoc {
 
 #define HCI_MAX_PAGES	3
 
+typedef void (*cmd_sync_work_func_t)(struct hci_dev *hdev, void *data);
+
+struct cmd_sync_work_entry {
+	struct list_head list;
+	cmd_sync_work_func_t func;
+	void *data;
+};
+
 struct hci_dev {
 	struct list_head list;
 	struct mutex	lock;
@@ -463,6 +471,9 @@ struct hci_dev {
 	struct work_struct	power_on;
 	struct delayed_work	power_off;
 	struct work_struct	error_reset;
+	struct work_struct	cmd_sync_work;
+	struct list_head	cmd_sync_work_list;
+	struct mutex		cmd_sync_work_lock;
 
 	__u16			discov_timeout;
 	struct delayed_work	discov_off;
@@ -1701,6 +1712,9 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
 struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
 			     const void *param, u32 timeout);
 
+int hci_cmd_sync_queue(struct hci_dev *hdev, cmd_sync_work_func_t func,
+		       void *data);
+
 u32 hci_conn_get_phy(struct hci_conn *conn);
 
 /* ----- HCI Sockets ----- */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7baf93eda936..5fb0079f64c1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2329,6 +2329,67 @@ static void hci_error_reset(struct work_struct *work)
 	hci_dev_do_open(hdev);
 }
 
+static void hci_cmd_sync_work(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_sync_work);
+	struct cmd_sync_work_entry *entry;
+	cmd_sync_work_func_t func;
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
+		kfree(entry);
+	} else {
+		func = NULL;
+		data = NULL;
+	}
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+
+	if (func) {
+		hci_req_sync_lock(hdev);
+		func(hdev, data);
+		hci_req_sync_unlock(hdev);
+	}
+}
+
+int hci_cmd_sync_queue(struct hci_dev *hdev, cmd_sync_work_func_t func,
+		       void *data)
+{
+	struct cmd_sync_work_entry *entry;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->func = func;
+	entry->data = data;
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
+		list_del(&entry->list);
+		kfree(entry);
+	}
+}
+
 void hci_uuids_clear(struct hci_dev *hdev)
 {
 	struct bt_uuid *uuid, *tmp;
@@ -3845,6 +3906,10 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_WORK(&hdev->error_reset, hci_error_reset);
 	INIT_WORK(&hdev->suspend_prepare, hci_prepare_suspend);
 
+	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
+	INIT_LIST_HEAD(&hdev->cmd_sync_work_list);
+	mutex_init(&hdev->cmd_sync_work_lock);
+
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 
 	skb_queue_head_init(&hdev->rx_q);
@@ -4005,6 +4070,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	cancel_work_sync(&hdev->power_on);
 
+	cancel_work_sync(&hdev->cmd_sync_work);
+	hci_cmd_sync_clear(hdev);
+
 	if (!test_bit(HCI_QUIRK_NO_SUSPEND_NOTIFIER, &hdev->quirks)) {
 		hci_suspend_clear_tasks(hdev);
 		unregister_pm_notifier(&hdev->suspend_notifier);
-- 
2.31.1

