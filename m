Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788D2D8379
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511350; cv=pass; b=ma77M0YdAbLutMQL4MXs7oi/5zPLRGbR2hEmBF7MT1GlhQpHXxncyH3pAlbo1AedeBqAILsyfvV9ZrRXrq8ywkOFThu7a+CeirqKH3DjeL4+fPkVDReQVmyPHHCu0ibnukdAmJoSjVjD0JONq2hMeK6/vLFa6zGeXRKgDEabps8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511350; c=relaxed/simple;
	bh=Ra5UiGci3XQAAeGii0p3xiRpm7VByNVHWI/yl0NTgAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=II2sOqWPWycykcNmxoGDBh/SCovSggZPSIZFBSyNsdANIlubxkvj/Nw3B502s/zVRedMQN8oGEqcnrYHtcClIrA+nrw+Q4XiQEHN8POdEE42WOphHTwAUJsnngyLhfzIa8T41BVZ5YadEftriBhz38Ej8uAtGzJpdPBFYruIe7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=McNssdXv; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="McNssdXv"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cdZrX0Bngzyjq;
	Fri,  3 Oct 2025 20:09:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759511340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SteIcmBmdFC2jNVDJIUpxhD8/IHF1WdnsqXMTY/AcTU=;
	b=McNssdXvOBb/OrmpwYnNjsXdlnVogTqA4rPEd8qaLwGpJFXCXK9zhIkRPD6kAzFE6aBJ9O
	9WioX6+d6Gj0CI6P3uNrEnU04nztJcXLbrLt7quo7dJ8S5Db6aBpgqLoSxi6U2jOyGBNxt
	P6Fmmw7a9T2ZpglCZGYCP3a5kO5NtIw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759511340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SteIcmBmdFC2jNVDJIUpxhD8/IHF1WdnsqXMTY/AcTU=;
	b=BIgdJFBvofSid5Lvt2+WWFIHa4cC4A9J4PZW7IUFCYFWPeSQpsuPfV750HWZz+O98yMHmV
	cyke0XNCTheWqY6PVEwyeUDzLFK3vAoOFl5XQO2pFEGyg/X8VmC3L/d+kC1AThAIEXRX4U
	VOsTCNCSpEECh0bNZlNM63oMI80dUJg=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759511340; a=rsa-sha256; cv=none;
	b=UGv9skj8DbjL42nT988lQLgl3BJ3EFDnSAKtgaP+rfX9qy9E5t6QbBbtdJCChUwkozht8p
	gvdDDFO9j8wjviNuZ2sAycL6MalByyiTbxGI8NDIwgbhkX5SzHieD61z0vlwZPmEGqGCZ4
	m4f/ErvzDiaAkZ0lIE0cFHoWxZyqjd0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 2/9] Bluetooth: hci_conn: take hdev lock in set_cig_params_sync
Date: Fri,  3 Oct 2025 20:08:45 +0300
Message-ID: <76828eb8b9b1e5b1596c77f9a08336edcaae2753.1759511032.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759511032.git.pav@iki.fi>
References: <cover.1759511032.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take hdev lock to prevent hci_conn from being deleted or modified
concurrently.

Fixes: a091289218202 ("Bluetooth: hci_conn: Fix hci_le_set_cig_params")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 111f0e37b672..af17884fdf75 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1813,9 +1813,13 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 	u8 aux_num_cis = 0;
 	u8 cis_id;
 
+	hci_dev_lock(hdev);
+
 	conn = hci_conn_hash_lookup_cig(hdev, cig_id);
-	if (!conn)
+	if (!conn) {
+		hci_dev_unlock(hdev);
 		return 0;
+	}
 
 	qos = &conn->iso_qos;
 	pdu->cig_id = cig_id;
@@ -1854,6 +1858,8 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 	}
 	pdu->num_cis = aux_num_cis;
 
+	hci_dev_unlock(hdev);
+
 	if (!pdu->num_cis)
 		return 0;
 
-- 
2.51.0

