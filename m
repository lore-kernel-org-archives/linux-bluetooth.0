Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F7847A0DA
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062026; cv=none; b=owRy+Xao8RiMbAMizQXIBg2xPXI25ntvMDlcv90bVhFF9XlL/DKhXahgkhCO5sJNhmC6xZj+oM4D/cvz+FmS4kiZTgK9Fz4DCygR+iyhIOOscbgJ/R8QYP9vA+SRz+ie0p8M8zN77UefTQZwJ1ZC/uH26hoW3soOfeMiteB5FkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062026; c=relaxed/simple;
	bh=fdD2dkWEx11AYy5acpD4fWtbCoCRF86yFKJgH4ibf6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkNlhUGPm8mdo/CcW+rKVIGBXcAj305MOHfRGaWihGEHKLTz70hmcHNHITQoA/UtxysSlcZt7PvBAznZD6erxaVIvbsCacJPHO0DdiS7lZenuMjA3EEXneCNIf2ZZuokzP8HMB0QEhnQu+l/vySH3fZQCHiOK+ysNkgX9AHyKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mFPukAJF; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mFPukAJF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775062011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ChnVHQtT43vwwue4olvVGBz1q3RCzPAXXuu/9y9Ty5o=;
	b=mFPukAJFvn8eY3LY+tuCq0UgLNyTcg3eRJaqC/K/nX8Np7OiPpZeyX8XdzQEdaArn9nYV7
	Lz4XbeydKuOd87OccucmMrzKn1AQrPTaQ2HTrhmt6rucC4u5vMUCBzI7eUZbKDyhLnsV2R
	dX5LvgV7WA4JxpvyoS98XQY90oiPUWI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel_pcie: use strscpy to copy plain strings
Date: Wed,  1 Apr 2026 18:46:24 +0200
Message-ID: <20260401164622.752376-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=thorsten.blum@linux.dev; h=from:subject; bh=fdD2dkWEx11AYy5acpD4fWtbCoCRF86yFKJgH4ibf6I=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJlnve/bX1xxVrnOeOnCvMZ9k4Q0wzlWuRVcurfB4ezuB Uxy5y0mdpSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBE5HgY/sps/Hj14AHeA4F9 DfqSWm67n6S1fGIOeZm3TuNLoWnacT1GhpOheVxe3/8eWaLjwmZ09GBr7YrAhsKIBxzHj6+bk1L lzw0A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use strscpy() instead of snprintf() to copy plain strings with no format
specifiers.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/bluetooth/btintel_pcie.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 37b744e35bc4..b4de93b6ef3b 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -340,7 +341,7 @@ static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
 	snprintf(buf, sizeof(buf), "txq: cr_tia: %u cr_hia: %u", cr_tia, cr_hia);
 	skb_put_data(skb, buf, strlen(buf));
 	bt_dev_dbg(hdev, "%s", buf);
-	snprintf(buf, sizeof(buf), "--------------------------------");
+	strscpy(buf, "--------------------------------");
 	bt_dev_dbg(hdev, "%s", buf);
 
 	hci_recv_diag(hdev, skb);
@@ -650,7 +651,7 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 	else
 		return -EINVAL;
 
-	snprintf(vendor, sizeof(vendor), "Vendor: Intel\n");
+	strscpy(vendor, "Vendor: Intel\n");
 	snprintf(driver, sizeof(driver), "Driver: %s\n",
 		 data->dmp_hdr.driver_name);
 
