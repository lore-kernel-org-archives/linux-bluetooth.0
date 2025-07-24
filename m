Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AEF237164
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 20:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388678; cv=none; b=HU0aye9zFmUGuMlfHcJ1rJjaqE6gDdGdVykuULAU7hmbPdtA+YebQL5alxhxAAFDodCwUzbC6eg9s7rCQqzwa7+yjeyBSudXViLNeMezbFBrPow5Spc1XgJySwKl+/UTfkenKRhNmaGf9dvT0band4joNCp3a2PmsjU9SIaT5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388678; c=relaxed/simple;
	bh=r398GNyOvte9MO5eTu3XjTqim03F+exwutfcW07hYCs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raT4ItNdxhD2YH5qSG8GNlUkjtwqU4edRaBuDp7oPTgVB0pQYcd4HY5DSIew5DWPCi81k14/6xv4huzkacVMvOyYKg6ZydXdQvZX7tka7NVYxxos9TGPbVJNQPE0jRLdr/KvFTM6wQmdwtXMh6lQGi6bjjwvkK7GcUy/QUDRLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2Meb2h9; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2Meb2h9"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-535ae7eeebeso929972e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 13:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753388674; x=1753993474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sd2Nzjr305prds2rGrhfguyWhpa0srmkFqbOmt/XD9Q=;
        b=A2Meb2h9SXbhRpSkMt7vwG7NySwsTSe77vHM1wCWhVwerSPRvblvppBQrMqRwV3Err
         ZpPc3np708av4DxD4JXA1CQzE1ys8NhcWlmW+LsU+kY3QD3Op7xGylAkNrV9miGXC0x3
         78wZ7CUc3wqjhRIAD9Px9GCpq776puWZ9vW/+FPg1S8owyJdKDC+p/FEqU6n6/ilkK5Z
         fNOyWn6OEPAtHgPxkXZnBAlhMy6Zw71h+wWvOHNED/MB/wyuUwygrJJacKxfWApH5paC
         TaZXpF4rMGVf1uccRm4ZBJck37o5ebGq3CwTmqwPGJtvdt2TSgthX3kdZ6EU74Yo/Rk+
         xSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753388674; x=1753993474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sd2Nzjr305prds2rGrhfguyWhpa0srmkFqbOmt/XD9Q=;
        b=Sbhu6JcE3MF3+/uGL8a4jj4NHQf19EkMJffdZypvekJdwI9DhYd9eC1Tb9JcAzhXgy
         3f6LdK/8lCR/1Xa32+n6iUBZC952Sncj+eghBkit1xtsu9acgT43DCQN8Q5sP1ip4NJH
         hzBP2MIUIEepNRwOSQS6T+OmjyuIK8/iHaGvSVQL13ul2JPyZ4/010jDGdeBpe6wkUX3
         cLS1IpXVpfWk3Kxpvv1n6XcxhprCDcMtA9+VEG0JpOZFz+A0ZiP+U4hx40XgU4RBGkGe
         o4/01rhIEsYo7yCA76aW1ss0r/SF9ayGT7Tv/f9NNHx4N031fxZmBcGz10tlw4wvKl1r
         bltQ==
X-Gm-Message-State: AOJu0YxyAi05u73YX3Bd0RriiHcK7nQSPfip5JFOVNnGHD9DNjeBpgcH
	Pbl93ysXSiZzvNu3fKRKE55W4E7+azBvTdfJWw+cFzPfzz4/vxHE8lMb2TIjNw==
X-Gm-Gg: ASbGncvhOTQqu99IFpg2Fu+TXBYephetcsa96GNhQkU2ZOtMPTqMf564ND5yFF2JQqm
	yL483u5YYqYbm5GGuj/DU9P/aQ6wkypu7BIpXtRmiJJJepQrqzt+eCGnE0Gv1V0UxMv/uKLInZH
	7BcSh6r28tWMsivNeKegLRwf3aJysuX1Sf7oXU5rpbnisg0fsH8LLks4mcSE6RI4+EM3o3AN3UY
	fa68RGXRta441+rfIlSug8k8yMUrpZjeXT9ZSFnNjQByAbkQq0e1+f/nhWLwa0UvuTkl5aHumJr
	h4EJHVVNWgokdfWkjWx1s4PdFuCTBDtm14ieFL+6sOnN2EwTVyHaLgQimeNctlW+cDTc0Kgdcyb
	JDM4zdTU/MCF+533c8RAfKsFJ4lGKJJBzouGJW1nt4f3C+IwDbApzVX6tW+Jx9ePgbz94hkhGs2
	c=
X-Google-Smtp-Source: AGHT+IEHTMVJzL6r2CSAXQ4lWE9z3EhMdOq1/IuK5zcwkjY6LkNg8BbDKKEUDoXya96Z+VsABdP9bw==
X-Received: by 2002:a05:6122:480f:b0:538:d227:a359 with SMTP id 71dfb90a1353d-538d227a9aemr1242996e0c.1.1753388674262;
        Thu, 24 Jul 2025 13:24:34 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-537bf89e500sm593413e0c.33.2025.07.24.13.24.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:24:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] btdev: Fix handling of BT_HCI_CMD_LE_TERM_BIG
Date: Thu, 24 Jul 2025 16:24:23 -0400
Message-ID: <20250724202424.6978-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724202424.6978-1-luiz.dentz@gmail.com>
References: <20250724202424.6978-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BT_HCI_CMD_LE_TERM_BIG shall cleanup the BIS connections and if there
are remote connected then they shall be notified with
BT_HCI_EVT_LE_BIG_SYNC_LOST so they can proceed to cleanup as well.
---
 emulator/btdev.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 7293e2f2e5f1..3747eaaef842 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6538,7 +6538,33 @@ static int cmd_create_big_test(struct btdev *dev, const void *data, uint8_t len)
 
 static int cmd_term_big(struct btdev *dev, const void *data, uint8_t len)
 {
-	cmd_status(dev, BT_HCI_ERR_SUCCESS, BT_HCI_CMD_LE_TERM_BIG);
+	const struct bt_hci_cmd_le_term_big *cmd = data;
+	struct le_big *big;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	/* Check that PA advertising is enabled othewise it is not possible to
+	 * have a BIG.
+	 */
+	if (!dev->le_pa_enable) {
+		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+		goto done;
+	}
+
+	/* If the BIG_Handle does not identify a BIG, the Controller shall
+	 * return the error code Unknown Advertising Identifier (0x42).
+	 */
+	big = queue_find(dev->le_big, match_big_handle,
+			UINT_TO_PTR(cmd->handle));
+	if (!big) {
+		status = BT_HCI_ERR_UNKNOWN_ADVERTISING_ID;
+		goto done;
+	}
+
+done:
+	cmd_status(dev, status, BT_HCI_CMD_LE_TERM_BIG);
+
+	if (status)
+		return -EALREADY;
 
 	return 0;
 }
@@ -6548,6 +6574,9 @@ static int cmd_term_big_complete(struct btdev *dev, const void *data,
 {
 	const struct bt_hci_cmd_le_term_big *cmd = data;
 	struct bt_hci_evt_le_big_terminate rsp;
+	struct le_big *big;
+	struct btdev_conn *conn;
+	struct btdev *remote = NULL;
 
 	memset(&rsp, 0, sizeof(rsp));
 	rsp.reason = cmd->reason;
@@ -6555,6 +6584,40 @@ static int cmd_term_big_complete(struct btdev *dev, const void *data,
 
 	le_meta_event(dev, BT_HCI_EVT_LE_BIG_TERMINATE, &rsp, sizeof(rsp));
 
+	big = queue_find(dev->le_big, match_big_handle,
+			UINT_TO_PTR(cmd->handle));
+
+	if (!big)
+		return 0;
+
+	/* Cleanup existing connections */
+	while ((conn = queue_pop_head(big->bis))) {
+		if (!conn->link) {
+			conn_remove(conn);
+			continue;
+		}
+
+		/* Send BIG Sync Lost event once per remote device */
+		if (conn->link->dev != remote) {
+			struct bt_hci_evt_le_big_sync_lost evt;
+
+			memset(&evt, 0, sizeof(evt));
+			evt.big_handle = cmd->handle;
+			evt.reason = cmd->reason;
+
+			remote = conn->link->dev;
+			le_meta_event(remote, BT_HCI_EVT_LE_BIG_SYNC_LOST,
+				      &evt, sizeof(evt));
+		}
+
+		/* Unlink conn from remote BIS */
+		conn_unlink(conn, conn->link);
+		conn_remove(conn);
+	}
+
+	queue_remove(dev->le_big, big);
+	le_big_free(big);
+
 	return 0;
 }
 
@@ -7587,6 +7650,8 @@ static const struct btdev_cmd *run_cmd(struct btdev *btdev,
 	case -ENOENT:
 		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
 		break;
+	case -EALREADY:
+		return NULL;
 	default:
 		status = BT_HCI_ERR_UNSPECIFIED_ERROR;
 		break;
-- 
2.50.1

