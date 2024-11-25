Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9906F06D
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567341; cv=none; b=qMq8llCFwPuDxR2wkQqSiTJ/uNcqZPIlWEgw3djcTgdFVeZPdNu0OinJJJ/DUfOtuNOqmKGsZhgiiK9qlvHy4il0PtmVG2a0VIIuaurvWYr1PB1lWc/4+NnvDQi95iRQpczIyRYCeP/iV0YE3/Ii34DiYJA8MZhcFkCJ29z4bwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567341; c=relaxed/simple;
	bh=6f/uBc7n5e8oF8+eJflC6DsobuxMdiQsZGe0L9W3U3c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKQoXZViTA/scHuiXdkTWCLcqUjr5e/nSlDxCjbKy7+inoCXeYw30z9qSCC1kEt5nln+F2eavBzYmP1sK/PA/IG7kC0oYOJjJGYLjiqWIXC1XYMVXtgQ1yIk8Fx/XkC226jlVX+iekecJqhp1R4sadZu/FgNBDryUgA7u1Y7O0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoeqrL3v; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoeqrL3v"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-515391d9b76so326006e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2024 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732567338; x=1733172138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dh9y/xpYLVKOmP4FcC8zBNA9mfZXS7UcK49A9M1Mj0Y=;
        b=CoeqrL3vPqCoPOal8ipyP6syxzTUChznDWt1w4NG/QgJfrPGDYKb/nyzWf/JFcfVrr
         91/1QxqP5wfU4Fb8d+H9p+BNoPWKXmORvIRvxje/t0oYwRumL2Dk3cMPEJbHLLDA+vDv
         a88+okoTVZhApLjBoYs3hpIpqZnvVs+izv0RVvzkMRIn2m1e7C3HNVK5QZZGEgba5Q6Y
         T6ABCK9fddIIb1uismPAKhjxX0GfeO0wT9UuJIDf5Bt7DiWnwo6+Fo2TWUWZrtD+gmJY
         br/C9SKReJitMeKnkLNUkgPVEPQg31iO/dyn0sRS4FryQp+7v7hBuHbuu7SZk7ca6KeB
         /y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732567338; x=1733172138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dh9y/xpYLVKOmP4FcC8zBNA9mfZXS7UcK49A9M1Mj0Y=;
        b=Lgt1UL9wMHoE/KDhqtGH4ENXBu3IgJcyBv2t1Q3PjCU8ScgY51o+1RULPZO4i17Z1S
         JvA88gN53lERSzD2tSvpoWuDk/YtBmrwJ10krdRierVslU1njaP9GrtOpBkV4V9KV8Pk
         6GDv3dAEIbsHFCoP5BKY6bG315D4io9iUzhlv9JMydPclOGnK7Db5ZAtuOeVt5kLz9If
         dlq92qPWt5O2Ey7/ZMuI62t6yO/3imEk+Cy9Tpjy2zIh9EB6BVaTd90bqSXdPTm7EFEf
         RD2PJZ9mfuE8enhbqFt7JpDv3cWfItxEpl1FCcG8Z1RIutmnzwcKtHpn7Qb6MESpKDWj
         k/rA==
X-Gm-Message-State: AOJu0YwkIgokGtODVfL0D/LEN+L+cSU3CwMLKAJLw3zF08vtTIKLkHjb
	LtYucxvE9+nEJW+LAs5U8ogZps6aGO9KaxxlYKfLHfg3JfFBKdYKY8JG2g==
X-Gm-Gg: ASbGncs2qtiaNgrcxwOHajYKO5bVDrMymoO2Ixb62BKJufZuKvAYMEsCgLz16/qb4bE
	IH1hAeAGoWK615jX4LiO4V+82QLiv2s5CG/+Ws4Uc8u6KY8KrMvEmmPnkQXfhLJmJprr2Lhjrwu
	MQcYaGEnF/zgWK+IKC+f6AtdsIKdiPwjf3VoJ1Umffu7uK3Y4id3XbsZMFX20Cr2cXWzofnpDyC
	Au0lKB9rEiayJQHaGdm9z3DKmVbk8uVVmafq9BrjU0zegxBqUZ2DzuZQ6lNGtp6vIwFiKyAPmNB
	nz2Ea92d56X+aH7iEBUwNQ==
X-Google-Smtp-Source: AGHT+IHA7xDfRm3Sh+6oiM0H/GQ7EHp/CbcQROhZizitW0U6NS5XH4nftZMAQVBUimNfBtNkI92vCA==
X-Received: by 2002:a05:6122:4201:b0:514:eeba:517 with SMTP id 71dfb90a1353d-515009a53femr11274758e0c.10.1732567338492;
        Mon, 25 Nov 2024 12:42:18 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5154456a62dsm49166e0c.44.2024.11.25.12.42.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 12:42:17 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/3] Bluetooth: MGMT: Fix Add Device to responding before completing
Date: Mon, 25 Nov 2024 15:42:10 -0500
Message-ID: <20241125204211.716883-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125204211.716883-1-luiz.dentz@gmail.com>
References: <20241125204211.716883-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add Device with LE type requires updating resolving/accept list which
requires quite a number of commands to complete and each of them may
fail, so instead of pretending it would always work this checks the
return of hci_update_passive_scan_sync which indicates if everything
worked as intended.

Fixes: e8907f76544f ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 3")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b31192d473d0..de47ad999d7b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7655,6 +7655,24 @@ static void device_added(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_DEVICE_ADDED, hdev, &ev, sizeof(ev), sk);
 }
 
+static void add_device_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct mgmt_pending_cmd *cmd = data;
+	struct mgmt_cp_add_device *cp = cmd->param;
+
+	if (!err) {
+		device_added(cmd->sk, hdev, &cp->addr.bdaddr, cp->addr.type,
+			     cp->action);
+		device_flags_changed(NULL, hdev, &cp->addr.bdaddr,
+				     cp->addr.type, hdev->conn_flags,
+				     PTR_UINT(cmd->user_data));
+	}
+
+	mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_ADD_DEVICE,
+			  mgmt_status(err), &cp->addr, sizeof(cp->addr));
+	mgmt_pending_free(cmd);
+}
+
 static int add_device_sync(struct hci_dev *hdev, void *data)
 {
 	return hci_update_passive_scan_sync(hdev);
@@ -7663,6 +7681,7 @@ static int add_device_sync(struct hci_dev *hdev, void *data)
 static int add_device(struct sock *sk, struct hci_dev *hdev,
 		      void *data, u16 len)
 {
+	struct mgmt_pending_cmd *cmd;
 	struct mgmt_cp_add_device *cp = data;
 	u8 auto_conn, addr_type;
 	struct hci_conn_params *params;
@@ -7743,9 +7762,24 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 			current_flags = params->flags;
 	}
 
-	err = hci_cmd_sync_queue(hdev, add_device_sync, NULL, NULL);
-	if (err < 0)
+	cmd = mgmt_pending_new(sk, MGMT_OP_ADD_DEVICE, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
 		goto unlock;
+	}
+
+	cmd->user_data = UINT_PTR(current_flags);
+
+	err = hci_cmd_sync_queue(hdev, add_device_sync, cmd,
+				 add_device_complete);
+	if (err < 0) {
+		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
+					MGMT_STATUS_FAILED, &cp->addr,
+					sizeof(cp->addr));
+		mgmt_pending_free(cmd);
+	}
+
+	goto unlock;
 
 added:
 	device_added(sk, hdev, &cp->addr.bdaddr, cp->addr.type, cp->action);
-- 
2.47.0

