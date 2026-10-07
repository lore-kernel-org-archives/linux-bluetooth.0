Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE02D4BD379
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387855; cv=none; b=P+BIrmEBl3PLvSW2nGrHZu3iX2Z53orxmwQbXPI3SG07FFlR0RO6+11JoBq7aAIAlTdQz9aWxucaKrwM0ksrhgw88JoN4iLQQMQj2XxmzBC2BmrxZNbt5SDjCNzxaJy5Yh8q6i0xcj4v6iaVgmdVOciJkjtD4t1cTmJps05oSrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387855; c=relaxed/simple;
	bh=wZ6CozmUkheyMWSqRGV6kcV+PJZj5pgj7ODypAQ9KPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBwbbKibFeTkZmFbpKDnDtWe9HGZEGwNlokzOW2FD8ZQm8icWLV9ylFU+kbk4n7aXRCVCIdl7ENhzvtNzlalsUhb4/yk34U4sN2Gt5xOl3WDYU9ATljWctEAllZz0ztcOWvekNUrYlmhJqg1MfV+Czoc3hmYFQt0evJ58F+IDJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akrmrNzh; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akrmrNzh"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-32be7127c64so603173eec.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791387852; x=1791992652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ozb/59ScS84H3e/TnN2LeOjW0OQv9TZinl1O9+31lFs=;
        b=akrmrNzhxTG8QbsB7cDafx4iW8dni2O/jZfhKhAUHBhWrXVROiHc9J7j6GjTry7+Bn
         UzHt7M+Q5K4621XTr0UujVikQT3ywZbSFJbC0jyCb+N78jZxKcVxKtnFD2HcRnypRQGm
         h6a2keRZAZug4y5Qmjb2kW7fz7o196xKfv2sOZXCBQdCcFH3AkHK/fIekxLL5KJvP4yx
         kMR+/8bkla6ls5lyVnPU+xcM2voT++QZCDVxj5ka08FROxnwhKTJ4hI+bRS+ntBzbyQl
         VWgfoT5cX9FUkJznASc1c6nRgqZKgu4vn81EafOU2v6Fjl18d3RFO/ISw13K0d2+zF9+
         4kWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791387852; x=1791992652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ozb/59ScS84H3e/TnN2LeOjW0OQv9TZinl1O9+31lFs=;
        b=gvrQi2u75GoHLDAQ5CdXEDqdJiw7/6VHyH7QsgwVr9EXhWLjFTZV5peQhpljlYlhrb
         Jpne9YD7W3qooRmt6SnSxha14L6aOOHVfwf0szwYb/Ym3UqGdxzUE38dQJyo9lEjFN+M
         LSwk3gzhbvUG6yPhjbQYg+pUNK9CafplknxGxE5oIEvFCSIQE0L1e2SvOxJhFbXJRvdB
         4XGnaF+QsnK6NgVFfC85dZp6hE5jnx1MOVMTdLKavAxl0BAurdcfBrVV0SMLqgjKJVQ4
         MlJfrKrXVv6UvSVV03JT5oEPTL3dhrqbp0Nm924AjgRcWFfMIZ0prQ1BlL7GLf7d4IRK
         zFwg==
X-Gm-Message-State: AFq9FYIWbcIrkrrFnJ/EFrKYhS4jHuARdY+m54W9RnSj5XHaYiS8ratN
	rjB5IsZ1zM5gVXW8gj6uI83S/PdRvDUaMdgSdfhv33SEHrISt3GgLMrURaIdfYnfr50=
X-Gm-Gg: AYBFou0NRmOlHrF/2Vk7P1gSol2wLe3FEJRIUxs7gx27DNKfLFI35gPA1YKlvAVsUW3
	3bnjrgnKBqG1fGzk67tD94hyPWkKcSTKoV+YPh0c8kO8kIPjfaCwDsOxKKWyNmPW+9jPtt6LUSI
	uA4HKSSUaMuwKM1Q5K2W60AmuMA6KbMEQNOGCvyE6wGqXMyINgZ1E1zVtrLLADQJH+D1pz2MKfN
	Jjj3bbO78ab5QYtxavmxiepqUsCqnXabIudDZBgBSGVqvcMoWowQNwULcym8MT8iyljzhF9p7XO
	tSBOFEMXDHfVwNeN2D22fC5lgAzv20uppyNDC/h8c5XSUlfIu4FWxZMs5cAQ5ZSHsM/XwRuqJZE
	H3El01LDHXVyw0Mn82Skv6S1QFXpN1AEMjPpHQlp74zQURMoFKkvyVnFIqDRG2QsLV/BWnwE+e6
	bZTajodLjAl8SFFnI4Xs6kDmbMsBijQA6Y+n+PRxJ5TdeK3C6fbP7x9olcFf8cGoFJbXfrr7gz4
	JuQXqy23xinNXBlQJXElb4/KQwZla9mFq8jOkJ0
X-Received: by 2002:a05:7300:d589:b0:34c:3ae5:ebc with SMTP id 5a478bee46e88-3515d686992mr3751865eec.0.1791387851437;
        Wed, 07 Oct 2026 08:44:11 -0700 (PDT)
Received: from hitalo (190-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515af7ab9fsm7876955eec.18.2026.10.07.08.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 08:44:10 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH 2/3] Bluetooth: hci_conn: Don't set up a SCO link that is already up
Date: Wed,  7 Oct 2026 11:43:52 -0400
Message-ID: <20261007154353.148223-3-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007154353.148223-1-enghitalo@gmail.com>
References: <20261007154353.148223-1-enghitalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for
aborting connections"), a SCO/eSCO setup abandoned while pending can
complete after a new connection to the same device was made, and it is
then matched to that connection by address. The new connection's own
setup may not have been sent yet at that point: Enhanced Setup
Synchronous Connection is sent later from the cmd_sync queue, and any
setup is deferred while the ACL leaves sniff mode. When it runs, it
sets the connection back to BT_CONNECT and sends a second setup, which
the controller rejects since a link already exists. The connection that
is up is then failed by the rejection, or left in BT_CONNECT and later
deleted without a Disconnect when its socket is closed.

This is the order of events in the report: the second Enhanced Setup
Synchronous Connection was sent after the first setup had completed,
and was rejected with Invalid HCI Command Parameters.

Don't send a setup for a connection that already has a handle. In
hci_enhanced_setup_sync(), take hdev->lock before checking that, and
check under it that the connection still exists, as
configure_datapath_sync() runs without the lock.

Closes: https://github.com/bluez/bluez/issues/2562
Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Assisted-by: LLM
Signed-off-by: Hitalo Souza <enghitalo@gmail.com>
---
 net/bluetooth/hci_conn.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 29da3fe2b..399c7db77 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -290,6 +290,22 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 
 	configure_datapath_sync(hdev, &conn->codec);
 
+	hci_dev_lock(hdev);
+
+	/* configure_datapath_sync() runs without the lock */
+	if (!hci_conn_valid(hdev, conn)) {
+		hci_dev_unlock(hdev);
+		return -ECANCELED;
+	}
+
+	/* The link may have come up while this was queued, see
+	 * hci_sco_setup().
+	 */
+	if (!HCI_CONN_HANDLE_UNSET(conn->handle)) {
+		hci_dev_unlock(hdev);
+		return 0;
+	}
+
 	conn->state = BT_CONNECT;
 	conn->out = true;
 
@@ -302,8 +318,6 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
 	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
 
-	hci_dev_lock(hdev);
-
 	switch (conn->codec.id) {
 	case BT_CODEC_MSBC:
 		if (!find_next_esco_param(conn, esco_param_msbc,
@@ -625,6 +639,12 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
 	if (!link || !link->conn)
 		return;
 
+	/* The link may already be up: a setup abandoned while pending can
+	 * complete after a new connection was made and be matched to it.
+	 */
+	if (!HCI_CONN_HANDLE_UNSET(link->conn->handle))
+		return;
+
 	BT_DBG("hcon %p", conn);
 
 	if (!status) {
-- 
2.55.0

