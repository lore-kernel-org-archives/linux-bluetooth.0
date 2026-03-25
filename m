Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435FF32ED58
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465677; cv=pass; b=qpgphHGEiQ1gzLSzMFA8ZFfbn7Ak3/CKB3vvmcsYyXR7/UxXykXkTK2xfMIU8aOFHZ2uU/exx8fnAVk54le8lBpuXlL2kKAOEwvmXbWfVdQWGGT3tmiQfyiiOw0GJ+WNLr7IXVlnNu6XTQXtqHHWdLruH1JSHsCs8ZWWank5JBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465677; c=relaxed/simple;
	bh=PAule6E6uKRa+1XbWgjO97zn/nbwrA/qcU8NwsdrWL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjwKZ4BzUUiAvmjcXCf2mJtuSkCLSald0DVNWJ9j07idVkbcFliN8xOUWtUPkbKvh2BS2fb48RgixHEi9iXhKrYj4IDgP11DioSP69iRt2LS1p/Zl11vUDEIzV42yvbZJYvsrtGKhM4JrIzeCu1dJVrqDRrFuOkVReu6zs/Zhss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=R8blPQ9Y; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="R8blPQ9Y"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fgxHs2d8hzyWr;
	Wed, 25 Mar 2026 21:07:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774465673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGIO6xgHwCoGBZmfj8yMFBdzphJgkwEUdOeas1+12M4=;
	b=R8blPQ9YEhBQq69UnmCNJ1C75NGcuZdKC8hhTSa0EEGNMm8SFk/KyavP/TqSjA3FEJjI13
	kMdG+DIejYh841seelwsPAleYAyNa8Ou/3pugO0PdceeF5WmOl4A1rsVq1w+y5lBf0OEz8
	3MTJ4mtbImPh0TVWCAAx44u9xJInXbo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774465673;
	b=DdKdX0wpIXYTuGdIE++igC5Y5ZE/VaB3m4UEkSkFIQiGLywX4T+6mdYiO8IP5F0Pa3Lu6M
	OgsONhObYODxw1+tX8kWQy6DfKbwTX3K10GskOSBWEPpurqBmY60KPsJABXSLLGkeML9Jl
	3psEJK6byP6A567GXTGRKNdsc4W6TJM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774465673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGIO6xgHwCoGBZmfj8yMFBdzphJgkwEUdOeas1+12M4=;
	b=AGR/cJdNhh0bw/PO2WbFj4mcHV6tVCxPKOwjTDNPYzjgAFgo4ThGA9AYrCNKCVAehaWC2L
	cl6hnrzRXoxVVi3LHFPMfbg5tdjTnl7UVlTjzcstlGa+02HgnXMyvzTp9H9F+E9gsaUw0e
	iL7qqCEgLUBpqREoGkLGeqLyb3wYLYw=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 3/4] Bluetooth: hci_sync: make hci_cmd_sync_run_once return -EEXIST if exists
Date: Wed, 25 Mar 2026 21:07:45 +0200
Message-ID: <0262dddf553b44dbf7fec4584641e1f0d721180b.1774465559.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774465559.git.pav@iki.fi>
References: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774465559.git.pav@iki.fi>
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

Modify all callsites vs. the changes.  The only callsite is
hci_abort_conn().

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2: no code changes -- previous patch only split into two

 net/bluetooth/hci_conn.c | 4 +++-
 net/bluetooth/hci_sync.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e6393f17576b..8cc2cc58c3f8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -3077,6 +3077,7 @@ static int abort_conn_sync(struct hci_dev *hdev, void *data)
 int hci_abort_conn(struct hci_conn *conn, u8 reason)
 {
 	struct hci_dev *hdev = conn->hdev;
+	int err;
 
 	/* If abort_reason has already been set it means the connection is
 	 * already being aborted so don't attempt to overwrite it.
@@ -3113,7 +3114,8 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	 * as a result to MGMT_OP_DISCONNECT/MGMT_OP_UNPAIR which does
 	 * already queue its callback on cmd_sync_work.
 	 */
-	return hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
+	err = hci_cmd_sync_run_once(hdev, abort_conn_sync, conn, NULL);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 void hci_setup_tx_timestamp(struct sk_buff *skb, size_t key_offset,
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0b28495197c2..e82c44e053df 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -818,7 +818,7 @@ int hci_cmd_sync_run_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			  void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
-		return 0;
+		return -EEXIST;
 
 	return hci_cmd_sync_run(hdev, func, data, destroy);
 }
-- 
2.53.0

