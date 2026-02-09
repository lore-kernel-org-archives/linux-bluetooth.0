Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F114E3815CE
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654872; cv=none; b=Fx/0hPFZO4h6FMAcOhuB9XMRlQp7/4SJ5/9u/Ub+0oDRBFicyF2nGtJBaEgKigUbNaXS9SBk3BMPESl4xSbCTol9pV+ER+H/Ye8ut9dlc+jBo3XWnrlHYkWIb0ec4SjGyGZud7zRUcGkis/hu+J7CL0pV/P34ggSqtsEEatj2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654872; c=relaxed/simple;
	bh=LQy0T0Qx8rnmThFB48qLGYZXHp1pkdGMoCoquDi2ZJ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KZBHkUCKfE/Epvl07nY6gR4+X50a+9D/JAu4/r/iUuUOoOlIZP8Fp0jMgY27i6C3TVaHJQY+SgcU9OuwADGlokuzrWvOH7kSvZPHq8Ago16ipUHKdjA3aseBVDf5rblb4RL2xw3ACMFmy8BK42GNJ9eShaqO+6zA7LcL0Ekjb4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmfpaivX; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmfpaivX"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94ac8cbf3feso961872241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Feb 2026 08:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770654871; x=1771259671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jqaOFoicVUpMJ0Lj6hg8AFl7/Zq3Nbq3Krx/1wlpWXc=;
        b=HmfpaivXA+4ngeuUgjKjbDu1MvbcATKCrJTKKIn4bGN+ZgJiKG9USSK5nl4gR+uVbD
         iUF+ihEYbjq0zCdArZKRUyGJCXxpDDkUHQ24B3/C3aaaYzkobqXgG6UHiFwv9s2Z3/vA
         7b/T9dbzSWfNC2PzjyoqE4OSpauvilFIipd32n+TlfFbyWIga0lqS0ykLt8SD5EFR8He
         6bDbcDLTWugkPzepxCwjUukrnZzaxAam7IFi4C84yVtB+bJ88zEKKyhlk3igTJ9Ptl/L
         9gO/AUXe5dIFtZ8BwPlnsz+OGqOPqrGRKLPr6uUly/WBljWJ1SYmWPved+oNB7VZLAML
         mObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770654871; x=1771259671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqaOFoicVUpMJ0Lj6hg8AFl7/Zq3Nbq3Krx/1wlpWXc=;
        b=TDq7muvjLLOIWhO6d1+JOinFOTplWN4a4NLot3rR8CkuVklDQBQqULyScTprr7RvU1
         mxU9nxvpMdesHUKxiXA1oFUPV15P3OtScctXW0cciah1qIJcTCCurrokKQt0Jn2FsOVy
         yrcNP/bY7neRDxGEe3UIADsLQPpKW2UK+b+OO3shhj38hkQwnxYAh/+QIf50/AI7WVIZ
         qQ4HoRstvzdqfTpHFs97SfzukXOZk26Ke0hM14VZpJcJsKdAVtkTFXejoQGp/VmFN7lQ
         BzGB0YAO6x6cVCzbhDuFKK3MDW22iRsYHSXeb2NG7qK3RzGtsu6dmqRzIkDLvpw/YN/S
         jMig==
X-Gm-Message-State: AOJu0Yxj0TDOAmjulbVyKPA7hjgQ3UDrs1NQr3tJHvdjCwYccPeruuIF
	QtAMCmoJBFQthzuXYZcNUvcWnN4Cu3UNbSB3ZRkM/OhjzLZEG+qi54bSXaznMbJt
X-Gm-Gg: AZuq6aKu322ml7nzc85pQ55DZ4h6zwuVScUBbx2rpAxVmWAbDt/tC36hBNytVwhkyPx
	bWrD83RFS+acqKjdNsJmZKrKF+RK7kbO5lOVKJJB7g3UDxZYSRxeECaoUeevtJj3D3xUW/Nyqc+
	B3AgLnqB3FC/BV9J7MsN2z20qLSYyiKXVd/mb13zeIaQ4lkDcI83rL8EBl3aIVYNZInJKQxhQjt
	/YKUJLyNotnzEWWl36X//al7yuhtKT7Eb1zFEfAwpM/qbaSs8Or5+Hne/sB2Z4YfmYfweorDPAh
	FG7UlInS+nO9DqkJ1yV+7Z1HQ5RXStpe+NvzTVIwlbCmsxafbCIea9OchXZMNY8ksDU9RUIEAnt
	JP9CaJT+Bdif8gQfNO3FrMV3bMpljSf31qHFAAU4xvlQ2yORw6l8U76V5ZHfIXHoEWEICKSARSX
	ctkV2gPWLwv3PvnIVMbHxFO3W4G9iFb3IQgGbEBX80wwlu6LYWCnii3cZApLp7UlDEG9zW2u23M
	1EFFA==
X-Received: by 2002:a05:6102:508d:b0:5ef:b159:c65 with SMTP id ada2fe7eead31-5fae8caa06fmr2918244137.44.1770654870612;
        Mon, 09 Feb 2026 08:34:30 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fae8d9ad7csm3578437137.3.2026.02.09.08.34.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 08:34:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] adapter: Add btd_adapter_send_cmd_event_sync
Date: Mon,  9 Feb 2026 11:34:20 -0500
Message-ID: <20260209163420.844741-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds btd_adapter_send_cmd_event_sync which acts as a function
helper to generate MGMT_OP_HCI_CMD_SYNC.
---
 src/adapter.c | 28 ++++++++++++++++++++++++++++
 src/adapter.h | 13 +++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index fb95e8553895..6aa7c0ed0df4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -11022,3 +11022,31 @@ void btd_adapter_cancel_service_auth(struct btd_adapter *adapter,
 		service_auth_cancel(auth);
 	}
 }
+
+unsigned int btd_adapter_send_cmd_event_sync(struct btd_adapter *adapter,
+					uint16_t opcode,
+					uint16_t length, const void *param,
+					uint8_t event,
+					btd_adapter_reply_event_t callback,
+					void *user_data,
+					btd_adapter_destroy_func_t destroy,
+					uint8_t timeout)
+{
+	struct {
+		struct mgmt_cp_hci_cmd_sync cp;
+		uint8_t data[UINT8_MAX];
+	} pkt;
+
+	memset(&pkt, 0, sizeof(pkt));
+	pkt.cp.opcode = cpu_to_le16(opcode);
+	pkt.cp.event = event;
+	pkt.cp.timeout = timeout;
+	pkt.cp.params_len = cpu_to_le16(length);
+
+	if (length)
+		memcpy(pkt.data, param, length);
+
+	return mgmt_send(adapter->mgmt, MGMT_OP_HCI_CMD_SYNC,
+				adapter->dev_id, sizeof(pkt.cp) + length,
+				&pkt, callback, user_data, destroy);
+}
diff --git a/src/adapter.h b/src/adapter.h
index cdcee69385cb..7a7e5c8f9dfd 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -302,3 +302,16 @@ void btd_adapter_store_conn_param(struct btd_adapter *adapter,
 				uint16_t latency, uint16_t timeout);
 void btd_adapter_cancel_service_auth(struct btd_adapter *adapter,
 				struct btd_device *device);
+
+typedef void (*btd_adapter_reply_event_t)(uint8_t status, uint16_t length,
+					const void *param, void *user_data);
+typedef void (*btd_adapter_destroy_func_t)(void *user_data);
+
+unsigned int btd_adapter_send_cmd_event_sync(struct btd_adapter *adapter,
+					uint16_t opcode,
+					uint16_t length, const void *param,
+					uint8_t event,
+					btd_adapter_reply_event_t callback,
+					void *user_data,
+					btd_adapter_destroy_func_t destroy,
+					uint8_t timeout);
-- 
2.52.0

