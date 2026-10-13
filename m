Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7F48489D
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909127; cv=none; b=E2879vUP/JWOEqDK/Vpgp5+Umk4EwvAcjTyPET5vLo8kPOV5gRvaF/HwolP7xN/zoffjek4VrfSRaWfGkl+Y8poSAQvijkumysxwXwSL64tmjbwIXDATCsHSJ+O4pEGlMtzwZaesxnnK7n1+QdVM3b4bRJfQ8z28en/DV8XRPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909127; c=relaxed/simple;
	bh=Vgr0WYR5Z4FHX7CgrOaLp4+C+70T/vz4si/Blb6H8Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lRF6tg24Xa7wFZv4ndZnS4Ifs4rbIDeudAYTGCVEgcMstwB2FC3Abhh/t7N1OYaJLkzuKlgCMlzMUwhLlIV+QB09jBTIky9tbeE+92Fs87xv6D8Trl6EdyEFdOjV5hnSiJK3BZfDvodKHoDhxiJHeOnFk4pgTJSTj+HO2pFiJVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZff9MOs; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZff9MOs"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso2416293a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791909126; x=1792513926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/XZgfappexi6EW2yi/fmjgPEZvZ4nymZlscgutlwwIw=;
        b=CZff9MOs9nJhyrmb6ksAEkSvEeAIo0mo0Y3s3OoqGGpQN4XNFwaHzYmxVmAK7CnVeO
         KS/X7lUn2HZcsBTPzuVj1uGa7YmpnB+2OIkIZDa15kmcHmqTktljKpQhSpe4EH1QGovu
         vJpGeVCU227piEQ9EI0qkFtvtdLaZmJz07kcj+vMOeZPc5JmAwyPVrfT1sozTojXEr2e
         DqadcC76WRND4BXZj/KbvhYeCwRJ/m1fKXXdIkY18t4vETEgUjAY9aXOemTTELhmzqbb
         /jgcFd/RnvOHTbBoA4q/5+mfvfkMTn2k4OQlhmraxRwJrFN5q4Xh7afuvgzEZNLhMsJm
         o+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791909126; x=1792513926;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/XZgfappexi6EW2yi/fmjgPEZvZ4nymZlscgutlwwIw=;
        b=xZ4Ij5E2UYpEcjjNaxBjJlCz9ucAsgWh5ceKDJOgQkRyOrdrVzk+Eatr9jokAq/zyS
         DAnC9g0G29UtDBu7CZ+oEip0zurneFYIBaVrbW7bNhs8au7FqCuRQ4oMRzq9PLC7jhk1
         iuMYEoXNr76XGTZGdH/HSuK1e1YG4JV+yX9jNY/NS0eB3VCfhLkKZuIR2t0HqHI/kUdU
         bRMgOGNKg4/9qbR7KsOF20VPpgvQKlRuzaPUJ6ZIq5Nuo44P6u1e3US1jFbmSjQ1mtnE
         LXsIhEX/5g2Rn0Upx9XZPZYUJq3fo/7FWGeuJo6p6c6cwsvc6zZJnB6p0lCUOJIxqeJc
         dCdA==
X-Gm-Message-State: AFq9FYITl7DTpxsK+GZIA7mm1XTWPQV0vgGTZwwgIJMb4x6T2tzUAKt9
	GjG+yHG/DbvKtlvNH+CWT2GaxopGC+p9xR0qPHZ3K9U5WbFXPjuGzZ9U
X-Gm-Gg: AYBFou2V6Fg3JYnxoP5qySWTA9frX5q86cGEBImb2g4URdd6n7eQqL9GSQ1m69tfBlU
	a2OBJOJqFuh4pkL1wGkdiYtUqFNFJuORxiMkNNJ8a8Jou+XTZoYikh92ttxhCN4wumaHooP3wK4
	lmyNpw2/uzDqYKmF5T8+h6tx09b59UnQ0q1H4w6QqmBtDCMfiLTycYVxKim7Lgt5KM8ca6vG8MJ
	LoP06CrVIBjxqTVFKtrKoh0aJfADwb8y6mTrRopMl+ZgUNHQLh3Ltoxb0DDbe0dKzt24Sd6hXT4
	fyDCNODL0getlMbuWgdp8hvgPFZ8ZWxikU6T8iV3pC7GMCcbY94ehlU9hF6PxDoNuLvKv9NwoJj
	1fH7wDCCdcMUHk25u9LBlj7gGzGr67iNHmDIPZYvpz04EfFIwDUA6m31zuqfOfQu9OXxW4ZwHTG
	vE9zcYMANyrhOIUWr59Uy3hPEKyP0ncrZHdhASiT58Jab273LjucxTfxWvLd1KknsK4g==
X-Received: by 2002:a17:90b:2ec3:b0:3a4:d5c0:f826 with SMTP id 98e67ed59e1d1-3ab3ae32be1mr11385868a91.65.1791909125906;
        Tue, 13 Oct 2026 09:32:05 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac60e83ccdsm236454a91.15.2026.10.13.09.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:32:04 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	pav@iki.fi
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: hci_sync: Drain LE timeouts before disconnecting
Date: Wed, 14 Oct 2026 00:31:55 +0800
Message-Id: <pm-bluetooth-objects-candidate-0087-v9-625f001f92d657dbf938@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A pending LE peripheral connection can be deleted by power-off while its
le_conn_timeout callback is running on hdev->workqueue. The callback uses
a raw hci_conn pointer and waits for hdev->lock before calling
hci_conn_failed(). On the request workqueue, hci_disconnect_all_sync() can
abort the same connection first. hci_conn_del() cancels the timeout
without waiting for a running callback, and the walker's final
hci_conn_put() can free the connection before the timeout resumes. The
subsequent conn->hdev read in hci_conn_failed() is a use-after-free.

Disable and drain le_conn_timeout in hci_disconnect_all_sync() before
hci_abort_conn_sync(), while the walker's existing reference still keeps
the connection alive. Do this outside RCU and before taking hdev->lock so
the callback can finish, and prevent the timeout from being requeued
during teardown. If the callback removes the connection, the existing
hash check in hci_abort_conn_sync() avoids deleting it again.

A matching KASAN report from an instrumented kernel showed:
 BUG: KASAN: slab-use-after-free in hci_conn_failed+0x3f8/0x410
    Read of size 8 at addr ffff888119e391b0 by task
    Workqueue: hci0 le_conn_timeout
    [...]
    hci_conn_failed+0x3f8/0x410
    le_conn_timeout+0x286/0x360
    [...]
    Freed by task 509:
    [...]
    bt_link_release+0x87/0x180
    [...]
    put_device+0x24/0x30
    hci_disconnect_all_sync.constprop.0+0x163/0x460
    hci_set_powered_sync+0x48f/0x680
    [...]

Fixes: 94d9ba9f9888 ("Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index efbd2e5387c0b..ba573aeebba88 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6083,6 +6083,15 @@ static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
 		/* Make sure the connection is not freed while unlocking */
 		conn = hci_conn_get(conn);
 		rcu_read_unlock();
+
+		/*
+		 * The LE timeout takes hdev->lock, so drain it before
+		 * deleting the connection. The reference above keeps it
+		 * alive while waiting.
+		 */
+		if (conn->type == LE_LINK)
+			disable_delayed_work_sync(&conn->le_conn_timeout);
+
 		/* Disregard possible errors since hci_conn_del shall have been
 		 * called even in case of errors had occurred since it would
 		 * then cause hci_conn_failed to be called which calls
