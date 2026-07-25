Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E231714F;
	Sat, 25 Jul 2026 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784973574; cv=pass; b=BI6gk5gVy5t2Is6MVq/M9P8nhcVrpx1kKa1opsNXMF6QiUQS/SUiT9vcGrL9SOHid17f5AKhAfq0gtAeuyBEc7xNlrGrFqDVUSIla/+uniF4aFV3SxBcX8jVS3fFYz2IRKRwOpdOiPNCstRlwz1h9/SsUR8fE8XF+FpqG9PmvfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784973574; c=relaxed/simple;
	bh=vbQyhc+5++T1EA3TG3Moz2nX42dPvTgOGjj1AbedJxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hvrA5dYByehkRazph59SgmRFYNn8vDhEKfEG+47ADmcVy++BW80pDlSVq76n91i4oadn01r+4Ls1Yj+xI65bPy0k4lbhjS1oWjQN8wwyJvQ4xQgNDb91PUgXGRYAXZtujWmBTF1tIP36ksnRl3J9YoZixybX3WAkXmW5DKHfD7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=DpUEJixl; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="DpUEJixl"
Received: from monolith.lan (unknown [185.65.133.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4h6gLl46pVzyWx;
	Sat, 25 Jul 2026 12:59:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1784973568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qNKai6aFL/jaZa2uckG0N9ljlP2UXpjyPC5hdQbiols=;
	b=DpUEJixlSE/+bxopq93FYnss5uggoPsXAI4camPY2IZtOe707LNTNQ+699ggYAb1Bko933
	w9IbTihjrnykSIyhbsTbow8m55BkRHa1tpIhC/cd/vw2Z4UsLQ0q/rTS7ZtfDFc7Wu+xs2
	hRhZZXojKPleUZuzU+Dm3MQkCEgGRys=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1784973568;
	b=Uqe5oe0FtwSnq+s6Xt4ugq83qh2l8AvS8QQLlTD2dTzixg9766R7x+EsxAU5TjOjptCL+i
	GZYQSs7KgBwK3xgCFGs8Fy40HVoM+wP52Xxlzvod1tx8CW2Xveqt80SlSHElFXNFEts800
	+9m6vZXDUDLqEJBIp+M+RUpVD6kknwk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1784973568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qNKai6aFL/jaZa2uckG0N9ljlP2UXpjyPC5hdQbiols=;
	b=vSHAUlaH2NoIPhRPXweCeWfuO8idNg9dS/5cLA+YGZVT7A1VOBMEmhW8O1JfGFHSIjfJOa
	Jt25d9iPMNG5FTj+dOkEJOl/H1w+KF7J2zhH5Ohkg1MQalsAee00hf+lMtuRwamk/9GgPg
	sOi8lGIPm9yQjLwPWvw3FCxCxuFy9vs=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] Bluetooth: hci_conn: hold conn references in hci_sync tasks
Date: Sat, 25 Jul 2026 12:59:16 +0300
Message-ID: <cover.1784973264.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have hci_sync tasks hold reference to hci_conn pointer they want to use
later.

Avoids UAFs and passing potentially reused (possible even if very
unlikely) pointers to hci_conn_valid().

hci_conn_del() dequeues running works for the same connection, but this
has no effect if the work is already started running, which is the race
condition here.

v5:
- resend
- no need to check hci_conn_valid() in create_big_complete, the bit is
  safe to clear also if hci_conn_del() has run

v4:
- Check !conn in hci_connect_big_sync() first.
  It's probably bug in iso.c that it may call this with NULL, but
  probably better fixed separately.

v3:
- resending some rebased parts from
  https://lore.kernel.org/linux-bluetooth/cover.1762100290.git.pav@iki.fi/
  https://lore.kernel.org/linux-bluetooth/cover.1758481869.git.pav@iki.fi/

Pauli Virtanen (7):
  Bluetooth: hci_conn: hold conn reference in abort_conn_sync()
  Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks
  Bluetooth: hci_sync: hold conn in hci_connect_big_sync() callback
  Bluetooth: hci_sync: hold conn in hci_connect_pa_sync() callback
  Bluetooth: hci_sync: hold conn in hci_past_sync() callback
  Bluetooth: hci_sync: fix hci_conn_del() use in hci_le_create_conn_sync
  Bluetooth: hci_sync: remove unnecessary hci_conn_get in
    create_conn_sync

 net/bluetooth/hci_conn.c | 12 +++++-
 net/bluetooth/hci_sync.c | 85 +++++++++++++++++++++++++---------------
 2 files changed, 65 insertions(+), 32 deletions(-)

-- 
2.55.0

