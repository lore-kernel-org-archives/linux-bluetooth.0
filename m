Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955E3FE674
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510074; cv=none; b=a+7dfw9YZxJJ3iYh+aJvIsSjfepe92U/zh8BlVaAJQvF3XypOBSTv4reZM1Jwty+IZM1ZVxqJIXpMAbsznNA5hRUR560mBFIgxHFLPX1vo6aV4TO38sVu+rrYYpzlQzeaDMCUtJzpuooxvEOhSX2kGJtJkHYotIBUJAVe6KKGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510074; c=relaxed/simple;
	bh=SLCjylkoYyrSymgTADQUnZN5X5pHLMpZcZL0BMK5TuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXZa9r6vttOxEhYf3m5pKBr4Hh18HSgcHDPAEn2bfzGtLIaGuz31SaNySY6Pbjc/LUehtOOdg0WctLnmggq2TWdaIt/IG5pBzGTirmgivqWNgQ9lNWL6y1RJTdguPQBm4GSI+qsW4xdtOxVMb7otcw5k6ze3hLIemKnk00g5ohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/WCly3B; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/WCly3B"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso45203291cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778510071; x=1779114871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KS/XEaKHIMFF8jDxzt8KXTwiFVllSXPL3p6YrwJsG/Q=;
        b=J/WCly3B7JLxicixynYiCWpTtpaneFRMbAl+9aWqJ9vMOcIMtUgGEf4Iji4ZlS/tr/
         R2kRuxP0WFnLm1BarlPszdS7FuXwzUrOwM8f/XjoUCuYVYEOvMcg5DMKhh8kDCg4vl3L
         xTpoBMghkSK5J0TbTu5ptROEUVYxVZEJXcWkvAv08DQzytY1HRSYRgKgWQ+XbPuPPWqA
         yTDLyNdLcLxkjXNDIwglLztupKvP0cDS3Q2kHQnSQ8GHNA7TQma9RqvGcUS/Ub3TD8PP
         6gzS8G26RLusqmoW0YRpNG4jyhwlkJDa0g9OTv0GnRwULubFjQ8HTHKrXNUVv3hC6lFw
         1eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510071; x=1779114871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KS/XEaKHIMFF8jDxzt8KXTwiFVllSXPL3p6YrwJsG/Q=;
        b=ToY36DMJ7CoTLb2U7rZNy1XeDH3PFIUPHoIrKGqf18Q4IKboDTiMttPCjYWLo0hhlm
         MWM6yun02IR0n1V/hhmsTangpBZV8LfDnEF1PtQaFjmfOAuW0h1EmW6FSixXp0r0r1yn
         A017XBHFFjpZPt8iAII4ay0JLd+oL/1v5IoYxnpmJZ7peh9gdaqmGHKfeOiYlSQnxWBM
         f3BPKIWKI4hkm8PoYLU09B79Jm8LjQybLqkOdlKIU5EZ+J7YJuAUr616S7HackBxs+XA
         VtkY1k0iOFccN4pDvUc0W4CYjzAe0wyDqR9MFzeEBmpBSipfwkvXFBXGT1fh7evNTMA0
         TN3A==
X-Forwarded-Encrypted: i=1; AFNElJ9JF3Vdyqa0xBUnVn4UeQEZ898GKj/bv61eJDS8no6V4KEFxr07CWeVd98rpadRG2Q732Xi15yHCaA/e5s7eGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/6i1iEDPbkSQuc/Tu3ek5JPzUMMQEjLRHSiUZn3xUlriPMl8T
	0Aw7NYCdFfu4sJQ9d1Suefyxo+AncuRYLufXow6CKh1EwMk4a2pnQjcJ
X-Gm-Gg: Acq92OHORc19bPh6zWIQ86u0OSdffPMiGspe88KvsqdGEa38iawy1GA7ZfkbLxLYbPa
	B8XQpCfPrYGE1u6yQiYl9d2hhsHjJv94C65w/GfMhy9OHTNNG8ztmPhuGY0c99Aj5DykAUXuTAr
	KqPZc9BI50xazQcPi7yO2dlpg9UBB1hY1YZStlNjUO3SPvvNx6glUcvdAPcjB7vqVp2NPfA4pG2
	uU8eyiT862S1v43AoU9KrMPpGx5SZT/kKKUuVqd0/XTmQl93P+JxWUou1kM3meSQAIjuEVAVcpe
	oI7zRDAio0nCQPno795E1F4+MTYgJmlFS+Mx48CqLZGB56Pui14337aLH4y+ddipgDQHYD62i8h
	BsIv30uP3utiIMc3q4Yof2LMOTjRumjYGTMZDv8DZuOVutLGU0WVGeW8yjvCA+SI0PXuU0QRzu1
	jbvxLjLegWz591i/3KEclCZgSQ5La52I231HTpTEllrGLsWVY0rFOT010F9CYTg2yrAPbK6O45J
	/AEoX4NqYN4v5fCb8SUd3waIIMqftxo7Srne0x4QMM=
X-Received: by 2002:a05:622a:13d3:b0:50d:3e1e:7998 with SMTP id d75a77b69052e-51461f9dd67mr340927431cf.37.1778510070473;
        Mon, 11 May 2026 07:34:30 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e83aa2bsm90605371cf.28.2026.05.11.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:34:29 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Pauli Virtanen <pav@iki.fi>,
	Aaron Esau <git@aaronesau.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: [PATCH 4/4] Bluetooth: hci_sync: pin conn across hci_acl_create_conn_sync
Date: Mon, 11 May 2026 10:34:04 -0400
Message-ID: <a586369f30357a4efe549f567f0629ba5ee0e7f9.1778506829.git.michael.bommarito@gmail.com>
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

hci_acl_create_conn_sync() shares the TOCTOU pattern with the
three sibling cmd_sync callbacks just fixed: the work item's
void *data is interpreted as a struct hci_conn pointer, validated
with hci_conn_valid() at entry, then immediately written
(conn->state, conn->out, conn->role, conn->attempt++) followed by
a memcpy(conn->dev_class, ie->data.dev_class, 3). If the TOCTOU
race fires the memcpy lands on a freed slot; the three dev_class
bytes are sourced from a remote BR/EDR inquiry response, so a
successful exploit can land attacker-chosen bytes into the heap
object that reused conn's slot.

A KASAN slab-use-after-free splat in cache kmalloc-8k at
conn->state confirms the bug on linux-next tip commit bee6ea30c487
("Add linux-next specific files for 20260421") with the synthetic
harness driving the conn->state write.

The existing queue site at hci_connect_acl_sync() passed a NULL
destroy callback, so the conn was never pinned for the cmd_sync
workqueue dispatch. Introduce create_acl_conn_complete() to balance
the conn pin and convert the queue site to the
hci_cmd_sync_queue_conn_once() helper. The dequeue-on-cancel path
in hci_cancel_connect_sync() now looks up the entry with the same
destroy callback, keeping the hci_cmd_sync_lookup_entry() triple
match consistent.

Prior art: Pauli Virtanen's PATCH v2 8/8 at
https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi/.

Fixes: 45340097ce6e ("Bluetooth: hci_conn: Only do ACL connections sequentially")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/hci_sync.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 47ce9ba63fe2..9a133de16f63 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6994,12 +6994,21 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 					conn->conn_timeout, NULL);
 }
 
+static void create_acl_conn_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_conn *conn = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	hci_conn_put(conn);
+}
+
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync, conn,
-				      NULL);
+	err = hci_cmd_sync_queue_conn_once(hdev, hci_acl_create_conn_sync, conn,
+					   create_acl_conn_complete);
 	return (err == -EEXIST) ? 0 : err;
 }
 
@@ -7054,7 +7063,8 @@ int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	case ACL_LINK:
 		return !hci_cmd_sync_dequeue_once(hdev,
 						  hci_acl_create_conn_sync,
-						  conn, NULL);
+						  conn,
+						  create_acl_conn_complete);
 	case LE_LINK:
 		return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_conn_sync,
 						  conn, create_le_conn_complete);
-- 
2.53.0

