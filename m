Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96923FE372
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510072; cv=none; b=r3zxvdt7YpwAWA/vT8HaQ9LD/S7ta59qCEwHepZURbJ0M+N3jTDNDsVszmiKhX5fXNPFSFS3XbyisuTazECsQOvYj6YWXU06oIkFn04ENx1bC0OXajD7/IZbnlIDbyzaRpAHd7D5QjPLS1vTfER07qBNwZ5sMarNV1NgehWLTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510072; c=relaxed/simple;
	bh=iSrkQyeRofMbSPxTLYOsO6qzNQE4SqSEjA5gq66gbDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJnwQ1zCdE65fYwwW/f5PJD1pvSodERYcXW8R0s2wju3YEuxWsdwHoAgPs37ozVThC2lE0cnLQ1AoJUAQnss5rUkqiRiKt+OUIEQVo9reT74m5s22MPXl/fY8q1QNWQwKPhGJFa6CcVgqXZVf5yGa+H5CfF7NgKSN2h011B/oBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCJwHMhH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCJwHMhH"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50faf8ed9c5so22442371cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510068; x=1779114868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L12bZ1vidxYuUv1RmDgLjzPTzLUWYys5d8sestRhEVQ=;
        b=cCJwHMhH1reIR8S7TozaulsbLDWRMhDdyGIV6VTHrUzXDpVT7csg+37DztuIvDGIpU
         u/+DUzI9fqhwIpk++v1R+b84b6hISpFt+863EOjSydfMbuRIzlt3V+G9VCD1+NTIR4AA
         4JJnsXJ4+emkPZpLtlP1lkg3xgdP8gYBlOfIhaqCb3bbme5w2T4141C8jJevGrmPobH3
         p5HDYE3BpyRVff6NIgewEJNPQkkp1VWSqvjw6MHxHyNnTQRqjj8I/FoZqbn5evSleuk/
         8eSxojHyYxmoaHBjwF2PJGEEtP/C3ThxHGY3hsGlPwDVKiK6Z0cISuX10w0o1JAk/Y77
         gt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510068; x=1779114868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L12bZ1vidxYuUv1RmDgLjzPTzLUWYys5d8sestRhEVQ=;
        b=FE/I96aHspsufe22qQEfKXq4zOHDMm0HCgQ/17HW9YeNE0TgPhJkI33cdXKRKJQ+ba
         HVv6o2hH2cI4DINMp4PTg1d0x6bdMC4vFcEWZMLKS39wjoI+9dQ7gws5xZE2VvXhV4Gv
         e95v11BH1EUVxHBdZ32dTSYT565SJCPjvBHBZ4Vrg29Jb0um4i3sP95CmUV0Rmm7YbS8
         gZbXepmja1JN0m1ms0M/iTj3tX6LBGPdd/gCHRT/iK1cKuT8u1XBZ2JwmMyu3Mkin6jQ
         sImGGgINrHI2XstYaDT4Vwr8wBbAO7/8hixz1ZfCyu2gQCBQQ7qn9Rk2TT3xioGhJtO5
         l6DQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RwjqrXprWwzaA/FDqBB87qCUTZ8nVwe3NMsJCCF2EkSjs/HoNzgSSM1Z6hjHA/B+jed1HK/BW5MjCLr/bExc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9Ik3GCXexEocI5lIrr2Mar7AGem1Sej/oD9YTAY8yG2wwmTG
	eRxLBqTjD2K4j25RYewPiY+c7SlcQ33C9xGw7/TxV6PiEJtdLWn5044m
X-Gm-Gg: Acq92OG8jctqsJDWUcP/xle84BXr3Xgp+4Gzl29roFuTxl7e3pfcDBUDJy/9FCEcVNF
	GN8TKG7h8OCN1dgh8ZDWJs06W7DgdeAk/7etkrUM6eSBT5D4OOKK6Pw6HZ2EkmXgbzl5p+4dFPw
	tvw9r2T98iIv/M7A0dyWBiHHLCP5L6HrNEiOjx+yIwNe3s34CVcU+lTFCwfVWbSS9OimBYyFGet
	7HaJyy0K72x9p7c6Y/Yey7O2QjIlPY2/oB+Y/JM65uMDQjq9ZlaqgJTgkOx4Va2Nlz/qZr571ny
	Hyl8fammOqTlqAT1+Jb86GRxK5AE5kd13xej6r8LalxQ6PSby+Dc7k41z+CojugoBJxD0Zj9CRN
	/Ni/3B24NyCT28/0wU9Om1KgTGhozFW956uO4ELE1RjXG8c4DRqt0x9PQ13oOozAh/rGxwcowWU
	FZ1BSOhhdnpGaihUxOhMD4kLy2qOy/sua4Asb3wx1SF2KdBU7HAz7xtz4gaKjeTvTjxVg4JVKbz
	DX6QtX2VP76jYTy/bjib6w+HMQXbX+fQI7Ao4mPQYY=
X-Received: by 2002:a05:622a:540c:b0:50e:63b4:9b9f with SMTP id d75a77b69052e-514621de9b8mr341952601cf.55.1778510067705;
        Mon, 11 May 2026 07:34:27 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm90605371cf.28.2026.05.11.07.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:34:27 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Aaron Esau <git@aaronesau.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH 2/4] Bluetooth: hci_sync: pin conn across hci_le_pa_create_sync
Date: Mon, 11 May 2026 10:34:02 -0400
Message-ID: <56cb0a32170c0b2df8986d5afa7691e3d1fda094.1778506829.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778506829.git.michael.bommarito@gmail.com>
References: <cover.1778506829.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_le_pa_create_sync() exhibits the same TOCTOU pattern as
hci_le_create_conn_sync(): the cmd_sync callback receives a struct
hci_conn pointer via void *data, calls hci_conn_valid() at entry,
and then dereferences conn->sync_handle, sets a bit on conn->flags,
reads conn->dst / conn->dst_type / conn->iso_qos / conn->sid /
conn->conn_timeout, and blocks waiting for HCI_EV_LE_PA_SYNC_ESTABLISHED.
The wait can run for conn->conn_timeout milliseconds (typically
multiple seconds for periodic-advertising-sync), giving
hci_disconn_complete_evt() a wide window to retire the conn out
from under the callback.

A KASAN slab-use-after-free splat ("Read of size 2 at addr ... The
buggy address is located 52 bytes inside of freed 8192-byte
region", cache kmalloc-8k) confirms the bug on linux-next tip
commit bee6ea30c487 ("Add linux-next specific files for 20260421").
Offset 52 corresponds to conn->sync_handle.

Convert hci_connect_pa_sync() to the hci_cmd_sync_queue_conn_once()
helper introduced in the previous patch, and balance the conn pin
in create_pa_complete()'s -ECANCELED short-circuit.

Prior art: Pauli Virtanen's PATCH v2 8/8 at
https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/.

Fixes: 6d0417e4e1cf ("Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/hci_sync.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b20e07474257..43779375209b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7089,7 +7089,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
 
 	hci_dev_lock(hdev);
 
@@ -7113,6 +7113,8 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 
 unlock:
 	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
@@ -7251,8 +7253,8 @@ int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
-				      create_pa_complete);
+	err = hci_cmd_sync_queue_conn_once(hdev, hci_le_pa_create_sync, conn,
+					   create_pa_complete);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.53.0

