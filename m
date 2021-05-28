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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A362CC47089
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 May 2021 00:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801BD61184
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 May 2021 00:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhE1ADP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 May 2021 20:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbhE1ADP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 May 2021 20:03:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C31C061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 May 2021 17:01:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 69so781950plc.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 May 2021 17:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JivnPwUdgtiMEUtJMjXPlP8jDXsxA2fny+NDGNihgHw=;
        b=sMaGEkYyggxOjrtBow67OfKYWRqlDNyCeQQ9WcvIgOVPwKezeZEtKxNyfr9OHNjSVb
         N9DB1JJEMZgP7TITZDtg4NCKzgHMoEuBzUSnPqfv9MGlfwXs7elCadQqKicIrbpf2+4O
         xcT4g6avWObknTkveKLRkeG8hHAqyxsL6ivAd6E3QlNj31k2CCcEHnneQASztQcaYAgl
         rCRWyjrr3vNACkla89lExeH4UBiEfSI/mdflLptXnsbMvDpfKUgMGSl7rE4LUjLPD3Vr
         U09qMxtBU+UyI9vcANTiPOQ+WbzoiMZBNvHdAbLc0ePvdtTw75WKOajt0m/61GAHW7ZE
         ke3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JivnPwUdgtiMEUtJMjXPlP8jDXsxA2fny+NDGNihgHw=;
        b=IHoPh6DXnT5IRoKF1pxK+UIjhBitkAt+ilI9tJhKHHDMvrWXArH4ZytF3zpJjv9Qvd
         Xz+L17oekSi+Bm2Mej38p63kjRfw97bFnjNhvTf68baSNXZH+5AFK6rs8+XvNVfKG0NL
         0R5cht0TXpDACIi28F9So3CDiAu/prpw6IuRPEHsD3TOpEmBlCoNGPZHaItM/IO0aTzO
         SlhPg2kP+/9o4I8wZVVRdQlaep5xEpcYRIr0bLfeBNm2+PgocO/9SGiyQkt0dwmdOlo8
         RVJUkvabD8ZzRwia0haEXH/i6c8PiHxM3kDXBWRjqKYzMTkop0HQcufsLPG3cbSaE9cP
         1QaQ==
X-Gm-Message-State: AOAM5330qTLjx5669HQqmCsmcrIJxQhJPjfzRXq4ZlaWPOMpd1PZwKFL
        qJ4cI1EHRUdw6gXUz2fFQxhiy4l2WDQ=
X-Google-Smtp-Source: ABdhPJzKbsxWLiy0Aq/pr9YjyO0t7Z1TSxrSPJOiY1G6pu+MJ4vgIqgh/63QI0do2sG8El0LscN8UA==
X-Received: by 2002:a17:90b:354a:: with SMTP id lt10mr110945pjb.202.1622160100245;
        Thu, 27 May 2021 17:01:40 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id o134sm2790270pfd.58.2021.05.27.17.01.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 17:01:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 1/5] Bluetooth: Add helper for serialized HCI command execution
Date:   Thu, 27 May 2021 17:01:32 -0700
Message-Id: <20210528000136.52352-1-luiz.dentz@gmail.com>
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

