Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811233FE37E
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510073; cv=none; b=LAVMhniA3WVwf9pB0mRM67pCopP3MotRfxPBDLr2YjTEKlHyhWmqidg2H6hS1+fTajwFlbMDeuHVWokMf/tfWGOibP0zuc7ASdXvqF97B7v68E2bqv9Mj4Nl1QVx+CD6CQ2/A8ikrOu3fHK5LFeT7dZ8rKZn/m8rD5JPXSSDgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510073; c=relaxed/simple;
	bh=e2R8DBscIk19IhJxMXZPQpQwLfnAMEQ7rmfH0FSfdQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQrNAWnl2jfopSPxia/VqVEArb8cfEpKPWNMkbiF2o6AGniiPzQP0t2XJrJ1f/G9ckRZyIqbja5anzWd2t4UqM9TR/7hDB8UkWkCGaQGJR1WmbPvq2gofCLPrbSxwEjZtyUrUEksjs9rkC0Rk7MKY2lJBXcbtrL/SiQNi8WKfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxmlJzf0; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxmlJzf0"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5148cbdea08so24468891cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510069; x=1779114869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCibvydRPttcdEiskE4PpFNMkbJQi5uTd3rinfvp+sU=;
        b=oxmlJzf0xewfTMPsqupr+ly44IVcQ+TzJLytQe5KFk2ER+2d7xrGPmI7DKSd/Rqm9c
         +gK+2SU7HdXIQSmBGELR8T66XJvoyL9DYA0rQXvpMlLGb/+Zf69BeQNTLofSMPXhs+3s
         ulCJCJN7kPc3hQxcJE/eOLY/swQsyaJxt+wPmFYLFTvx/dZF3c7dkvmC8r648OSJuCtq
         Kl4U7Mga9XKEUCFhEynyWoqCX4+j5mxIATj2mCaVRW9XggTL2DpcwBOD1eh9A9aBEME8
         tn/RtMzizgaWbj4JM7UgRECUTTbGdRk6tRiZcU7rGAiWPuGxkzxlw1T2DqdY9OoRtHEx
         ZW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510069; x=1779114869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCibvydRPttcdEiskE4PpFNMkbJQi5uTd3rinfvp+sU=;
        b=MSu0Y2mOYUzScSbnAJeHw/VKIyw/N/3CAmi+HHvSWy4sOuXtQTAQOhDJB7TlCuYOb0
         PUGTa9VAtiUfzcMnoxW/XqBkCPtdkfI/efqJQBMduOZyrCLBF/W9dEdk6tWocCesgfrg
         MisYgotY606s3/Ab1APmK6T0ockEH9YhG+tKeSQ+GvUlqIifd0h0GqrqzYPwaNGZEWCX
         otCTd99QyH85vkesrND8TSAgaO/JY0HqDVce6kBdmRa7Bh+NeOHhd2Caray8jLHvH7Ly
         DnfkWzWK4LiHv7Ato640fZHAwN6YNH08/hH/DiC1G0weUBvvr/u0/yY2o0aDWc2kCfUB
         Z22w==
X-Forwarded-Encrypted: i=1; AFNElJ85Wi6KRc1+a5siqoo5at1KsX93C6JNSzImuqUWbMA2NycMoctmwX83ugJqh56kWnMatEBXBcb0kmTpKerw+HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJWpxK270uAGVznhx2ZNSxbhF6ldyBPzTKvL9T8oeaJDsvxT3
	lx0kM3kD/nrshVQN3rAkX/TnI9sZACjRer6SuuTYhORgQIRVucLhkxgL
X-Gm-Gg: Acq92OGamO7l3zqarHr+3eZp/pb0ZNJ3LZVv2C+/MUMcCz2tQhuxYKqtv1BlMpJn3CN
	jMyl9bKLIE2mcMIbHcl9hsR6C0Xu7qvWIPybpYHoZFlsfuOEtD1HNon9eq0yMQp14M5DPMidrjS
	SQ8RlmKuvrcGwbA7z3qKUYmyWbZUFMUIpcS+Il75sZxSAgdzznzRmVHeRZ7yAFRlUYjUypwJamx
	qTMaYlU8IKRqD5lx9T7CSEmpfcfzFQSZOIVT9f5KonWw/gPeeg6HC8t5tHipDUmdfIiZ7syXnyc
	10IY8QxDMNUeAGeds2a7w/AhfDF+qE6seisVAhl3ckIgMWBXgd1WGc4TtDfsDkfBUe1ChbyHExP
	HqImJw0N7RA1jFy1nAYMI472C5T9KkzxtvQzn7Zx2ZPrqEXHpEPIZGGbH/7aUXncWNsUuNsOK3b
	D3bKXxzXncnPbAUKC+si9ZFhoAjTWrLAbKRJQe8jf+1L+M96eWk+HmR96pt6ZkUftKoeAyA+G7Z
	ZGFPRxWxvo2bxFxoYpQ9rPWHSPumbvwW0gzZ/cD0IlQo35+dIJifQ==
X-Received: by 2002:ac8:5783:0:b0:50e:6054:b4 with SMTP id d75a77b69052e-514a0a2a3b1mr143979381cf.7.1778510069079;
        Mon, 11 May 2026 07:34:29 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm90605371cf.28.2026.05.11.07.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:34:28 -0700 (PDT)
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
Subject: [PATCH 3/4] Bluetooth: hci_sync: pin conn across hci_le_big_create_sync
Date: Mon, 11 May 2026 10:34:03 -0400
Message-ID: <745aa080da109c4a698a3f1478b3f08e53f2d4d8.1778506829.git.michael.bommarito@gmail.com>
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

hci_le_big_create_sync() interprets its void *data argument as a
struct hci_conn pointer and dereferences conn->iso_qos,
conn->sync_handle, conn->num_bis, conn->bis, and conn->conn_timeout
after the entry hci_conn_valid() check. As with the sibling
cmd_sync callbacks, hci_disconn_complete_evt() can retire the conn
between the validity check and the body's first deref, and the
blocking wait for HCI_EVT_LE_BIG_SYNC_ESTABLISHED extends the
race window to seconds.

A KASAN slab-use-after-free splat in cache kmalloc-8k at conn->flags
(set_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags)) confirms the bug
on linux-next tip commit bee6ea30c487 ("Add linux-next specific
files for 20260421").

Convert hci_connect_big_sync() to the hci_cmd_sync_queue_conn_once()
helper and balance the conn pin in create_big_complete()'s
-ECANCELED short-circuit. Promote create_big_complete()'s
hci_conn_valid() + clear_bit() pair to run under hci_dev_lock so
that hci_disconn_complete_evt() cannot remove conn from
hdev->conn_hash.list between the check and the write.

Prior art: Pauli Virtanen's PATCH v2 8/8 at
https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/.

Fixes: 024421cf3992 ("Bluetooth: hci_conn: Fix not setting timeout for BIG Create Sync")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/hci_sync.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 43779375209b..47ce9ba63fe2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7265,10 +7265,16 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
+
+	hci_dev_lock(hdev);
 
 	if (hci_conn_valid(hdev, conn))
 		clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
@@ -7320,8 +7326,8 @@ int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
-				      create_big_complete);
+	err = hci_cmd_sync_queue_conn_once(hdev, hci_le_big_create_sync, conn,
+					   create_big_complete);
 	return (err == -EEXIST) ? 0 : err;
 }
 
-- 
2.53.0

