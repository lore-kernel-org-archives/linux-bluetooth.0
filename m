Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8364C2D052
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726246216; cv=none; b=lOokUmudlOktqxe0yOj8AI1Y5sv0cUldPkJA5cGzwvdgv0VV5TyslJDn3CXNl+fnHvroXeSDtjRZsA+SJJX5Cf0VAIeBpR3ov8k8GDWOoDWxpSMdgJOQ9DFTvW2ASg8StPROWLxnZnug0wP+gepPFEqDWBQSfL6mNoZNCe3brg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726246216; c=relaxed/simple;
	bh=kWmGuZVnTzDo2KveH9oQPDZoCNYQ9P0EpnZwPuqGqkY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=acNJeMaK7JZFQcGUbcs9piGI+/axOdtM9EK6d7DOT9r99X+s4sA/o+nEcpp+9pcsya7qO8hayOVt0yiu0gIs9oIXc9JtIFcNum4g6PgJIXVTeyesHwpfcbufSh++yFbW9cwjGFAe0h0odrS4mBZy/zsbSiAZIjm6mpwuKyYRhTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC6GD6HS; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC6GD6HS"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-49bc42bec6dso662180137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2024 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726246212; x=1726851012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cek9ekyfQOUBpTKygkvZa14rqkXHxYtQOwXooXf2RRE=;
        b=JC6GD6HSbkSWVE5zAToQYhqXY9BTFY9Shw6aYFaxUjyUV5/ow+/GkG6xRFuj+RvwRu
         nNni4zuikY/6gbVItNdVI5Gc3a1Lcx27uvjK7S6exFSmgvSbMDrxCyX+dOcu4yIpbrlw
         JdfFeo8iuBabjAE0/HOS0N9GNI/NfwSO7Jme52Xhv7YJxaTLU8UAz7k1F+Vc7GagpyAT
         f+vYhSOQP7JiF7z9EEqMvnZE/LMfbktQQxo8GAyqmINxZLPYrFCgOIL016InHMIvXyes
         oC41/37EQtes6s9IRRJKhFb8vzs3NQWFSyPqR2GP+zMZccVxpTyqc0GnTV7FhwopXIPm
         fgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726246212; x=1726851012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cek9ekyfQOUBpTKygkvZa14rqkXHxYtQOwXooXf2RRE=;
        b=uQYZnJYorWEsN8foETAv4dqHaWYC6gGQI5K0YnqNqyaZS8i35+gVf9WJrSq6XRrnN+
         5zGMeDcf4LVAHs5fd5ykkcIMZtDP8Zi/zccDoqrVQOGpQn48yD9xcAlKJZIKKCv8M/qW
         4WvKtbqRxRx2bcOh+kE51XVFHHVcALzXM+CzljmQ7dZyQ8s4pVYY1Ynk7jgJLZwsjxea
         Ek4/nppBROM1bBAQJkpJxWqr5fYDDeF5yJJN+vSIDvYUv0WLAt8bsq+p+N1EFH4apcKH
         GD7sEmRpJLkHnAVlGclkNvvfqYpTRixYUPnnQ6/nsKEgPA8EZ2FnKh1QZng2qPmqbvuC
         fYtw==
X-Gm-Message-State: AOJu0YzdmX6gpgt21CBtPJJ/4rjreHUFYSK48fhZqQL8KNBnPEynunaS
	Ve32GDSjEfQRAhzYJYjjKtMF2QpYyZuhwTsBCHtKLRPwvV+UxkdmwK5ojA==
X-Google-Smtp-Source: AGHT+IFFmdKSjT0nLmrAh4hWVtcgV4Mcoh0OZjpeA3DbSxywdtlm1bwX6XAu9jxHT2BX5ukc0Lst8Q==
X-Received: by 2002:a05:6102:e07:b0:48f:dfb8:77aa with SMTP id ada2fe7eead31-49d414bab43mr5436602137.17.1726246212207;
        Fri, 13 Sep 2024 09:50:12 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84906d7f8b6sm611452241.18.2024.09.13.09.50.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 09:50:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: MGMT: Fix possible crash on mgmt_index_removed
Date: Fri, 13 Sep 2024 12:50:10 -0400
Message-ID: <20240913165010.3240215-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If mgmt_index_removed is called while there are commands queued on
cmd_sync it could lead to crashes like the bellow trace:

0x0000053D: __list_del_entry_valid_or_report+0x98/0xdc
0x0000053D: mgmt_pending_remove+0x18/0x58 [bluetooth]
0x0000053E: mgmt_remove_adv_monitor_complete+0x80/0x108 [bluetooth]
0x0000053E: hci_cmd_sync_work+0xbc/0x164 [bluetooth]

So while handling mgmt_index_removed this attempts to dequeue
commands passed as user_data to cmd_sync.

Fixes: 7cf5c2978f23 ("Bluetooth: hci_sync: Refactor remove Adv Monitor")
Reported-by: jiaymao <quic_jiaymao@quicinc.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e4f564d6f6fb..4157d9f23f46 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1453,10 +1453,15 @@ static void cmd_status_rsp(struct mgmt_pending_cmd *cmd, void *data)
 
 static void cmd_complete_rsp(struct mgmt_pending_cmd *cmd, void *data)
 {
-	if (cmd->cmd_complete) {
-		u8 *status = data;
+	struct cmd_lookup *match = data;
 
-		cmd->cmd_complete(cmd, *status);
+	/* dequeue cmd_sync entries using cmd as data as that is about to be
+	 * removed/freed.
+	 */
+	hci_cmd_sync_dequeue(match->hdev, NULL, cmd, NULL);
+
+	if (cmd->cmd_complete) {
+		cmd->cmd_complete(cmd, match->mgmt_status);
 		mgmt_pending_remove(cmd);
 
 		return;
@@ -9394,12 +9399,12 @@ void mgmt_index_added(struct hci_dev *hdev)
 void mgmt_index_removed(struct hci_dev *hdev)
 {
 	struct mgmt_ev_ext_index ev;
-	u8 status = MGMT_STATUS_INVALID_INDEX;
+	struct cmd_lookup match = { NULL, hdev, MGMT_STATUS_INVALID_INDEX };
 
 	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
 		return;
 
-	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
+	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
 
 	if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 		mgmt_index_event(MGMT_EV_UNCONF_INDEX_REMOVED, hdev, NULL, 0,
@@ -9450,7 +9455,7 @@ void mgmt_power_on(struct hci_dev *hdev, int err)
 void __mgmt_power_off(struct hci_dev *hdev)
 {
 	struct cmd_lookup match = { NULL, hdev };
-	u8 status, zero_cod[] = { 0, 0, 0 };
+	u8 zero_cod[] = { 0, 0, 0 };
 
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
@@ -9462,11 +9467,11 @@ void __mgmt_power_off(struct hci_dev *hdev)
 	 * status responses.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
-		status = MGMT_STATUS_INVALID_INDEX;
+		match.mgmt_status = MGMT_STATUS_INVALID_INDEX;
 	else
-		status = MGMT_STATUS_NOT_POWERED;
+		match.mgmt_status = MGMT_STATUS_NOT_POWERED;
 
-	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &status);
+	mgmt_pending_foreach(0, hdev, cmd_complete_rsp, &match);
 
 	if (memcmp(hdev->dev_class, zero_cod, sizeof(zero_cod)) != 0) {
 		mgmt_limited_event(MGMT_EV_CLASS_OF_DEV_CHANGED, hdev,
-- 
2.46.0

