Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD97196C7C
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149731; cv=none; b=qa92vIpU5Sa3AV1mnTb3cg8WfHtQAjGhzk/BLVhJODJmO9pgX5ezHL5Ld6WUhgD74B5rhhKkUzKQEMvcVzcuvQaddR2mDJym5YmBOe1to2edgcxwnRhC7o3p3ibsm7Y7wkRMN22xzECXqI1Ii9AMqyS7/1XPuZjlDtXvvNpwKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149731; c=relaxed/simple;
	bh=NyIbHuU6R+yIwoMZVJ9F9DKeztvTHmSN6ksFFbFDxXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqZidTopUnDEXMOuQVD+NS00XAz8l2nuXTOt/g2PULA7+2OY1FVpxSINgLfIJAPecsMxp/h4D/977zlA2dHMgcRoWcKYdO2lZj1euswlDqX2F6FgRvR/M2Krt6IVHWIMGWBa7taG8iHMGzRkG5tOCZATs7nYCjFCnx+nQCjuohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOWjfrd5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOWjfrd5"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so29789555ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779149729; x=1779754529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yDUdM1L7Kp6XBqCU+DT1wcZI0PaukiQ8/jCeHRabPc=;
        b=cOWjfrd5coSRbBYC6BfA2yGyiFZFSwMTAztAQkdDmUw7iBI96tNKEYSv2q4xWBUHqG
         Y0PMS9fn/f2y1VnwSF7u1LazYbyistiLlH8W7fSyQouJB2WaL1TXONQVLKg5F7xIHqqz
         oiGxeVgqA/oJ/OR82iDjB+Ryq8uTBgy0Zi0KW81Gkmd4zxfg8mc3mFGMuGVIlDq05mrw
         TYlumByt0DRBHTaLvcrWpqUl5P9N2yEFgOjq67RsYIX/HWxJIMZrdwFmBBT51/rHUxem
         7Jjo9OnEkF8dqCVvaoC9ZOVyp4xfnQBpCxC2OGbXgSzTaboGFkg7iA5dhztBXAfvAbSY
         xRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779149729; x=1779754529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yDUdM1L7Kp6XBqCU+DT1wcZI0PaukiQ8/jCeHRabPc=;
        b=YgKgO5s6H4fsOdcI8OeYA9uid9siukilCaIMoawkVkld3DfrDzIr95bFbFl4GM+KaE
         zlNYFDkt3ZJ6iN1EEAg0aR+n5O11Z+OXg4fIYKofyr0zyvqwmvmljHkG5kKvSCAhNPwG
         bDGFMalvEIb8Pe6ywpqLECLhONfel7StsuJCdywor0SKXC9gg9zPWPg89BT8rOvSFGWH
         dlBuTAQLS6x38nAvK6DA8Iej2naxAGiUizad87aMdl+i86LHDUtjJdT1g0cCQk7oqthh
         IxdbBpwEHi2JY6bBu+lGodBdYTPnlQ03mNaKqqPmSZDQULxjlSWNtM1RDdYL3LQkJcc5
         FlUg==
X-Gm-Message-State: AOJu0YyV7gLEBa7f4F8q8xGrbJ9DZUzvhYGuYytaHocL2A2SUp16tTgb
	rSUF/WHMBXs6fvlcFeW3vpMnaTTOb0y+ws91w5lwKfd+ot59fYH2SVy7NBShCjLX2CM=
X-Gm-Gg: Acq92OFpNcS3I/LHezVtKbP2fcrYVeh7GCfqGw8HLAGTWXAhpHOqEgJgXeLCkJZy0sf
	UALmwEsb0RnhHAyk9cT0BE+stPhR48f/oY6a+HSAYkTu+jZhR1a/mljg6FsaWo4SohIVCNOdpZz
	kdQ9nvqoG3pjxw+yXn/amhZ4GpTrtLF9oXYAQP1h2ZTEZ0DX2ToRXev1KFFLpBUgME/B2O/5ee5
	o69RxQPyG9uLNvzMuUTa3kKogfHTV+ILn9LdUZyoeaskYxoMKHcbPjhJQxYZbQlrad1Nb76otI0
	Yj+5zcttVSxjrM0bRidGqoga5LXa3yhrZr3+gWwq4yB8eGsAXza+Z+pOKo/BV4AbovzyrNrUoOV
	PICH/PmE+/jXwmcGe9NVWWe/WJAxInkndsab1fAc/mW/sD2Zf/pWCEyBnHzNtLznwIYn6+Mt/d2
	EbfqxaNFfuw1dZPJZ658sPS4cVyW+DrA9SrcCbFYKAE47Siw2eRakNGc3lzunA0Rox67dZ2ICe8
	Q==
X-Received: by 2002:a17:902:ce0b:b0:2bc:a577:70c2 with SMTP id d9443c01a7336-2bd7e931f22mr191320255ad.31.1779149729207;
        Mon, 18 May 2026 17:15:29 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f36fsm199132645ad.21.2026.05.18.17.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:15:28 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	pmenzel@molgen.mpg.de,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v2] Bluetooth: SMP: add missing skb len check in smp_cmd_keypress_notify
Date: Mon, 18 May 2026 20:14:37 -0400
Message-ID: <20260519001437.156400-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517145417.31910-1-meatuni001@gmail.com>
References: <20260517145417.31910-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smp_cmd_keypress_notify() accesses the received payload as
struct smp_cmd_keypress_notify without verifying that skb->len
contains enough data.

smp_sig_channel() removes the opcode byte before dispatching to
command handlers, so a SMP_CMD_KEYPRESS_NOTIFY packet without a
payload leaves skb->len equal to zero on entry to the handler,
causing a 1-byte out-of-bounds read from the heap.

Use skb_pull_data() to safely consume the payload; it performs
a bounds check internally and returns NULL when the packet is too
short.  Add a ratelimited warning in that path to aid debugging
of malformed packets, matching the pattern used by hci_event.c.

Fixes: 1408bb6efb04 ("Bluetooth: Add dummy handler for LE SC keypress notification")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/smp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 98f1da4f5..1b237e623 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2930,7 +2930,15 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 static int smp_cmd_keypress_notify(struct l2cap_conn *conn,
 				   struct sk_buff *skb)
 {
-	struct smp_cmd_keypress_notify *kp = (void *) skb->data;
+	struct smp_cmd_keypress_notify *kp;
+
+	kp = skb_pull_data(skb, sizeof(struct smp_cmd_keypress_notify));
+	if (!kp) {
+		bt_dev_warn_ratelimited(conn->hcon->hdev,
+					"Too small packet: skb->len %u < %zu",
+					skb->len, sizeof(struct smp_cmd_keypress_notify));
+		return SMP_INVALID_PARAMS;
+	}
 
 	bt_dev_dbg(conn->hcon->hdev, "value 0x%02x", kp->value);
 
-- 
2.54.0

