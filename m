Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A8B382F14
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726284; cv=none; b=V8XugWnqcDALQ1F8uH6IcYxbDZ73bHGy57BpATEpLC5i4f1Es2yHawRTbUv0m5I1NKwLDK0WKXVuigog9GkvoOEUYoUXar0enowNb7F5Kqs9B3hz2+GzsUDcQ2PdtlMsO6/SUwHqqy2wgs5RXzCPsdVBGIx3GSt9WoXzoKlngjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726284; c=relaxed/simple;
	bh=S4rxq3l4Wng2W5fVWWjrnjFgVqgExMdH6guqhx0+R30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qciWF/RiJGaQYKGFPYDbm6HvWpABCV+ApHpts5c49JZeQ98WgOrqCAghMCzmGUZjOfQwNNKweaS9Xh0uyraTI1TMFDCRYCnDBnySWhKcYmoHgBAAWxn6k349ZGaJnz/u/I1i7EGX7/jW+yMlJfk0xzPzkiq5LPnIplCuHb4uL9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=YOM3YRRw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="YOM3YRRw"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ebafde87cso1777284f8f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1779726281; x=1780331081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CD2km52FcQoeNC6X1ictk/ljETOFDj0WJ4N8Yv++Si4=;
        b=YOM3YRRw9DJLeZTBVs9Wu0FgYvbwtMxipEm013QWxCZHdmUgRJTB7h6WvZqyOo90rl
         XtNcQNyyGFWMXVYK15c0dF+uyLIdrMeRX44H1WI8OJrtGxSYrCKn9EgcSZZK8nNhtr4Z
         bb1Eny9eSxmUPwf5Zpv6K7luGOvd+rA289W1Ky3YifwDmJl9ZsRib8v19DBYHfOBQdkC
         XNGqTvSmFQkkZmUsdSWQixxXYzRLZZBkPHRHXz+8lXMK6cYRyMY08rV8sfkRzm/evbrJ
         HYFjRIfSjzfJZdN9XUjrqGsKW6g4hRKerl+z9McYUfPGFoc3DAWFXrd+rZZaOzlpOHHN
         9fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779726281; x=1780331081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD2km52FcQoeNC6X1ictk/ljETOFDj0WJ4N8Yv++Si4=;
        b=GkgY436Ia8O0AlzE+KnDxAe/lXVj1VEJ2o8zHVUTkIgDq0/BlC8SFIYeAy6TYHEVE5
         UvciI/wrEOzlsXutv2xfAhwEgCSEn/KetYWaON9nAmBfql1+cK2nW3ogpNNRHGb8Gty/
         umDDXFtsNRJg0qtdOC2cQ6hnCg/fh5a7NyE241QfTUwhLpKEsnclEUtyQCVg+lDnhhIL
         PZ2lWPO2BHE7ZckfB/amvrQ/H5QT7EQWqUbygxCWQcgaJjU06mj0Yc5eVJXMaVAIlMIJ
         +lU98RZCpbD+sAlqQjPiNS7Fja/kSErag0ehkdZC54MuOxIr2/klIkDKfi5Fn2syhFzA
         ow9g==
X-Gm-Message-State: AOJu0YxZiqqULfeiDlR40IXTLmAWoSnaMYZ0oJI55Ci6NZ2gBD3Ucr6k
	CTvmLk2YKJvKFwPWCiy7sV8PbEpDCBxZfgva+wPgw3YFSUVLU0RatcUeZajiedzOEObX
X-Gm-Gg: Acq92OERE56/65iPynEkzuuhv92yOsVKIDVBOGHp0+q0dUdCVCajXBrl9uiqgy7dB2U
	VnI5SPHV67quP5//2hIKt7HBlyPa7OmR0mW46Jr9V7+b1AcoL+WhaYQ8n96XpeWalSnG9bQpZkr
	EbrVot8E4IIiVvx45ZlmLU1tTwOkB99Wr1UjOa+LnNg4yFNsYdnrMcaGgEvJYs5AoRP/WEKfrV5
	t9+8+LNrb26ir3/AXo0nizmSFrv5udD7AiZmWGEGEHpOsyw4a7GShUekJ4T4MRav1yvJMqrbKhz
	Fy2y4DLAv5MMnMn9U3jw8XUX2XT579JxCMAeoqxqmRj+UGNImJIjTFpOCt+le9XNN/pASSLTllU
	ZSCIsDYgyuKzL6KeofS0hYxiwomwhcpuAkDx3o/raM74uaU5kwpXU6PNktzfvy3RoKtAGdQHsk/
	cTosDgG8W/7SwvUIhAyXQanSTpmlk636wCv7ThBeSu8apxYL7+KZWo8zAfcMGJVMn8Mq6TgoQrs
	gocMQuHZOKMIIxPPy4F80YD/QMLYOoGOUWROnNobfvtvHHjGOdpdSs=
X-Received: by 2002:a05:6000:468c:b0:43b:5b25:67f8 with SMTP id ffacd0b85a97d-45eb38b392bmr17953156f8f.20.1779726280391;
        Mon, 25 May 2026 09:24:40 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d6ebf0sm29201800f8f.34.2026.05.25.09.24.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 May 2026 09:24:39 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	security@kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync
Date: Mon, 25 May 2026 18:24:38 +0200
Message-ID: <20260525162438.96881-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_le_create_cis_sync() dereferences conn->conn_timeout after releasing
both rcu_read_lock() and hci_dev_lock(hdev).  The conn pointer was
obtained from an RCU-protected iteration over hdev->conn_hash.list and
is not valid once these locks are dropped.  A concurrent disconnect can
free the hci_conn between the unlock and the dereference, causing a
use-after-free read.

The cancellation mechanism in hci_conn_del() cannot prevent this because
hci_le_create_cis_pending() queues hci_create_cis_sync with data=NULL:

    hci_cmd_sync_queue(hdev, hci_create_cis_sync, NULL, NULL);

While hci_conn_del() dequeues with data=conn:

    hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);

Since NULL != conn, the lookup in _hci_cmd_sync_lookup_entry() never
matches, and the pending work item is not cancelled.

Fix this by saving conn->conn_timeout into a local variable while the
locks are still held, so the stale conn pointer is never dereferenced
after unlock.

This is the same class of bug as the one fixed by commit 035c25007c9e
("Bluetooth: hci_sync: Fix UAF on le_read_features_complete") which
addressed the identical pattern in a different function.

This vulnerability was identified using 0sec.ai, an open-source
automated security auditing platform (https://github.com/0sec-labs).

Fixes: c09b80be6ffc ("Bluetooth: hci_conn: Consolidate code for LE Create CIS")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/bluetooth/hci_sync.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index XXXXXXX..XXXXXXX 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6700,6 +6700,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 	DEFINE_FLEX(struct hci_cp_le_create_cis, cmd, cis, num_cis, 0x1f);
 	size_t aux_num_cis = 0;
 	struct hci_conn *conn;
+	u16 timeout = 0;
 	u8 cig = BT_ISO_QOS_CIG_UNSET;

 	/* The spec allows only one pending LE Create CIS command at a time. If
@@ -6773,6 +6774,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		set_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 		cis->acl_handle = cpu_to_le16(conn->parent->handle);
 		cis->cis_handle = cpu_to_le16(conn->handle);
+		timeout = conn->conn_timeout;
 		aux_num_cis++;

 		if (aux_num_cis >= cmd->num_cis)
@@ -6791,7 +6793,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CIS,
 					struct_size(cmd, cis, cmd->num_cis),
 					cmd, HCI_EVT_LE_CIS_ESTABLISHED,
-					conn->conn_timeout, NULL);
+					timeout, NULL);
 }

 int hci_le_remove_cig_sync(struct hci_dev *hdev, u8 handle)
--
2.45.0
