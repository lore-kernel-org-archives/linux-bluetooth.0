Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C34327FB35;
	Sun,  2 Nov 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100591; cv=pass; b=bxHvLOnfUIgx8jkXN9WtSuQ5CjOYj2VkI1/PI4nHVnbyuZf4vXYRkOki0Y4mUhn7+PBx8aDTlMZ50XJ9vOPxsNu4CEAonMA3lFhzGlLy+tQjFR3+o4OprrAbWjs/xvhwzMzlJm7CMb3wqQ0nBjl/DLTkY/jmSIlXBQwVhIr9uKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100591; c=relaxed/simple;
	bh=mWwceOnkIC5prK+OgjGAIcv+pEKuyl5rzWl2WLD2vRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7LjaFGfxVW+9pXss90Vr7c5uYJlsVqJG0XEl4IpXEbbOO78t+ctk2YpaDHSharMn5FcnJkLKWrEtj5z9i3mvyszrnIQt8UuAcAp5546U4MqJDsXldo/EExc4MNi1YkQisF1DtmZ9LYY4sa3JqHTBGI3GRYqUsfk9RbjmNacjeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ehfIzdyg; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ehfIzdyg"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d00Pc1bbtz104g;
	Sun,  2 Nov 2025 18:23:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762100580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11ROlgv6b+Co/OXYSYtENy91jzr9hTxW8D8KiamrhIg=;
	b=ehfIzdyg/TKZSCAB/hjqaiikfPwqF7vYyGRlDyFspbjdNGP09i+L4sP8iByBpRqtoLQWJV
	qEpC6Yv30zQlnsiF/Imc5p8ki2iOE3vVySzRv5lP5bAZma02i/Yhx0KknRGqHn7UP8uQan
	jHeIB4UHR3uNnmZSaC8rjqhxw45VVmA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762100580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11ROlgv6b+Co/OXYSYtENy91jzr9hTxW8D8KiamrhIg=;
	b=QpAqOxYjU6MXRldI5frVPKnVM3tR2R3FpLhIMHPyraWkLXsBHmN7l0XBfMj7XhumDGVGIA
	vDxWaBxkbep1WZLafqsl270grb2MnOFKnnBCIqtmupmy71tVPcySYYASQwGG6wkNvWj/ph
	yzIAT80T561T+X9HG/bVC0baJCVoZUQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762100580; a=rsa-sha256; cv=none;
	b=DvyYlQYAhll6/KvqTBy0zxBQIWHK+03QsvDyb8jwLAUtJ4CLE8qVMAigDrVs/a0wPH9FlP
	jgvJdWZCwK8U9htT41B/X+9s0klRhD6lAh6YLv8rNiFZN0r79YFKF3/Eqe7jZ7UcYwxwr8
	cg/1BQ8HvtlzTL/kZbcQ47Q6XVPE4OQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] Bluetooth: hci_sync: make hci_cmd_sync_run* return -EEXIST if not run
Date: Sun,  2 Nov 2025 18:19:37 +0200
Message-ID: <6dc2473624e1d90f10b63371ec05940dc5d22395.1762100290.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1762100290.git.pav@iki.fi>
References: <cover.1762100290.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_sync_run_once() needs to indicate whether a queue item was
added, so caller can know if callbacks are called, so it can avoid
leaking resources.

Change the function to return -EEXIST if queue item already exists.

hci_cmd_sync_run() may run the work immediately. If so, make it behave
as if item was queued successfully. Change it to call also destroy() and
return 0.

Modify all callsites vs. the changes.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - no change

 net/bluetooth/hci_conn.c |  4 +++-
 net/bluetooth/hci_sync.c | 13 ++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d140e5740f92..214fa6ec832b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2959,6 +2959,7 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
 int hci_abort_conn(struct hci_conn *conn, u8 reason)
 {
 	struct hci_dev *hdev = conn->hdev;
+	int err;
 
 	/* If abort_reason has already been set it means the connection is
 	 * already being aborted so don't attempt to overwrite it.
@@ -2995,7 +2996,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
 	 * already queue its callback on cmd_sync_work.
 	 */
-	return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
+	err = hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a71a1b7b2541..6c4c736cf93a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -801,8 +801,15 @@ int hci_cmd_sync_run(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		return -ENETDOWN;
 
 	/* If on cmd_sync_work then run immediately otherwise queue */
-	if (current_work() == &hdev->cmd_sync_work)
-		return func(hdev, data);
+	if (current_work() == &hdev->cmd_sync_work) {
+		int err;
+
+		err = func(hdev, data);
+		if (destroy)
+			destroy(hdev, data, err);
+
+		return 0;
+	}
 
 	return hci_cmd_sync_submit(hdev, func, data, destroy);
 }
@@ -818,7 +825,7 @@ int hci_cmd_sync_run_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			  void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
-		return 0;
+		return -EEXIST;
 
 	return hci_cmd_sync_run(hdev, func, data, destroy);
 }
-- 
2.51.1

