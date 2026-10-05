Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D914CDA39
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791224058; cv=pass; b=dsCxCOwudqR3LP/s3dyFef0Ht87Ndjs9gKZQZIFvMOz40/4D4y2lqWTVlq3xopayWJZYZsiOglQRtXUjfENJnlTH473sjgMX7/yX5ZBxGcJF6Xnu37H73itx1R5s07djrlVj9mFWNS2a0xlxek/oeqYcsVcjTZtCjBEpZMp31R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791224058; c=relaxed/simple;
	bh=kkyC9Zx28N0sDRfsKxg6WkEtPg21BcvXk9cmdymRnXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdeunQPHQz3djuK5Y4ZWIlQUR0p1bdRrahQb1IhCISt34VqUAgdgfU4CarkiYtzqYgWuUClnHgOiN1/7LO+RBxtXgTpspHvt5s3qPj3+NrcWuPXHkQxSLF3g3rEyj6wcoc1DQ1Ehgq48lpRnp4yxMiiMrIoCrKKcdmzgysouwBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=gve5lg5v; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="gve5lg5v"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hz6wL6JP6z11GR;
	Mon, 05 Oct 2026 21:14:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791224051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27jM+xjhC7icKggpHY8SIO+IuxtvImJMMSgwQkOkB8Y=;
	b=gve5lg5vBOpWE+9tqQWDoB2z09n9ewouBK8Ixw0IqYPkdIaM01nxTcPbU0XTqZm44wqI+C
	DOncXfMBlLjqilROawdZdCZKEL9m/jNpiUkrR4P0ipVWqofuEdg8B6OhSuowgMkG5B6hno
	2xZwnj4+54bKFQFcdj/vqTlXgx6K5m0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791224051;
	b=HxlL09vkW3QzTf8NHE85VDyoIN+bm6pWG6w7lT2lMu3nvF716S3rFSivVC9cIIaPiyWWiv
	bGI8Gm2ZOjwcVpcnAB53NneZQBRJknCMQJz/8ZpMMJPhUXEvUJFt7+Q+H9b21T4q11CIsH
	ynwLPhUyicacCfZLhKcq0dh3J0jqxmg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791224051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27jM+xjhC7icKggpHY8SIO+IuxtvImJMMSgwQkOkB8Y=;
	b=ylea0PeIYZmc1YggY+wYqWQnHelweVli9GRSkpu6662L3ERAswpbtn97to2kPFrUBabOB4
	zIp5r3g7IM8uKQ6LekxgjIx4UUoghCl5QZ4+yRJDMSRy9AezEtUpdh/qh41GnnFTc4GDhU
	pyEUUEN4RQemVXLL8FId61Pm6iwPXYo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 2/2] Bluetooth: make hdev->adv_instance_timeout a boolean
Date: Mon,  5 Oct 2026 21:13:55 +0300
Message-ID: <c4fae439047da7d16beaf4fef1c3c5eac681c7d9.1791223958.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791223958.git.pav@iki.fi>
References: <cover.1791223958.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mesh uses millisecond time units for advertisements instead of seconds
as normally. These values go to hdev->adv_instance_timeout, which then
has mixed units.  hdev->adv_instance_timeout is however only used as a
true/false flag.

Make hdev->adv_instance_timeout boolean flag, to avoid possible future
problems with its mixed-units values.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_core.c         | 6 +++---
 net/bluetooth/hci_sync.c         | 8 ++++----
 net/bluetooth/mgmt.c             | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f631d9484a0b..aa04dec45153 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -601,7 +601,7 @@ struct hci_dev {
 	struct list_head	adv_instances;
 	unsigned int		adv_instance_cnt;
 	__u8			cur_adv_instance;
-	__u16			adv_instance_timeout;
+	bool			adv_instance_timeout;
 	struct delayed_work	adv_instance_expire;
 
 	struct idr		adv_monitors_idr;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 05d1ca25f44f..416803d8d604 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1617,7 +1617,7 @@ int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance)
 	if (hdev->cur_adv_instance == instance) {
 		if (hdev->adv_instance_timeout) {
 			cancel_delayed_work(&hdev->adv_instance_expire);
-			hdev->adv_instance_timeout = 0;
+			hdev->adv_instance_timeout = false;
 		}
 		hdev->cur_adv_instance = 0x00;
 	}
@@ -1647,7 +1647,7 @@ void hci_adv_instances_clear(struct hci_dev *hdev)
 
 	if (hdev->adv_instance_timeout) {
 		disable_delayed_work(&hdev->adv_instance_expire);
-		hdev->adv_instance_timeout = 0;
+		hdev->adv_instance_timeout = false;
 	}
 
 	list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances, list) {
@@ -2437,7 +2437,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	hdev->adv_tx_power = HCI_TX_POWER_INVALID;
 	hdev->adv_instance_cnt = 0;
 	hdev->cur_adv_instance = 0x00;
-	hdev->adv_instance_timeout = 0;
+	hdev->adv_instance_timeout = false;
 
 	hdev->advmon_allowlist_duration = 300;
 	hdev->advmon_no_filter_duration = 500;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 94dcbbc767e5..7a07aba43262 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -468,7 +468,7 @@ static void reenable_adv(struct work_struct *work)
 static void cancel_adv_timeout(struct hci_dev *hdev)
 {
 	if (hdev->adv_instance_timeout) {
-		hdev->adv_instance_timeout = 0;
+		hdev->adv_instance_timeout = false;
 		cancel_delayed_work(&hdev->adv_instance_expire);
 	}
 }
@@ -568,7 +568,7 @@ static void adv_timeout_expire(struct work_struct *work)
 
 	hci_dev_lock(hdev);
 
-	hdev->adv_instance_timeout = 0;
+	hdev->adv_instance_timeout = false;
 
 	if (hdev->cur_adv_instance == 0x00)
 		goto unlock;
@@ -2099,7 +2099,7 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 
 	/* Only use work for scheduling instances with legacy advertising */
 	if (!ext_adv_capable(hdev)) {
-		hdev->adv_instance_timeout = timeout;
+		hdev->adv_instance_timeout = true;
 		queue_delayed_work(hdev->req_workqueue,
 				   &hdev->adv_instance_expire,
 				   adv->mesh ? msecs_to_jiffies(timeout) :
@@ -5572,7 +5572,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	if (hdev->adv_instance_timeout) {
 		cancel_delayed_work_sync(&hdev->adv_instance_expire);
-		hdev->adv_instance_timeout = 0;
+		hdev->adv_instance_timeout = false;
 	}
 
 	err = hci_dev_shutdown(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index aea3482e3893..2e35b09579d3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1299,7 +1299,7 @@ void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
 static void cancel_adv_timeout(struct hci_dev *hdev)
 {
 	if (hdev->adv_instance_timeout) {
-		hdev->adv_instance_timeout = 0;
+		hdev->adv_instance_timeout = false;
 		cancel_delayed_work(&hdev->adv_instance_expire);
 	}
 }
-- 
2.55.0

