Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D26437E317
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 23:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889682; cv=none; b=b15wKywAikCJadTJVesUbnwlnOr7qcYg98Ig0Q4RU3IDxX20xXwvGGbJAYhisHeZGd9ITBgE6U/ks0Y1YkEcyGDgtTmGCzZSAw9rxSseEuC40aYeL9fifR5kncBdA/ZLZ6XICB0HE6hhVOiqcEdbHr3fbhJAH71+SD0U8CVAKNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889682; c=relaxed/simple;
	bh=pciwHYBXFB6v/vUAo2tH4GtOQRnTkny9zpmgBJVAQDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPR+EaSuRM6Pu5ZvArombymzgx/I9BFELK6h0FQtOT44sbRTbTjhoLrRyu7Hagpif/6aId971VyI9wKtEsiqXGmBXivch+ZqLpzAlsTC88PiTzrxllssgz2YDj0CI2re7ZV+wmDu0FWIqI/xSbDJfpOF714j7wdFsjtbIKg0SEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dl+GhZpe; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dl+GhZpe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771889668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n90OW/otD7lsfZE/MLcmeBPOW3B5AGA8tFtKamYFmAE=;
	b=Dl+GhZpesQ67jJEcMhTvgf8exYc1C4a8IY85QwoD9nr9dDhk5DFjFGfXaGV6NGyqgSySB3
	J91/WLZggRE/XWLsFfjQBEn6UCqaq/AiKNQ9OdXKE6cLvMCEX/wZ9zp2d48DzZD72gvs/S
	RySFKpe/V/OcxFoZwab00f7fNnJPUac=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel_pcie: Use struct_size to improve hci_drv_read_info
Date: Tue, 24 Feb 2026 00:33:42 +0100
Message-ID: <20260223233341.426067-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use struct_size(), which provides additional compile-time checks for
structures with flexible array members (e.g., __must_be_array()), to
determine the allocation size for a new 'struct hci_drv_rp_read_info'.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/bluetooth/btintel_pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index eda243988cfd..473b2115e637 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/string.h>
 #include <linux/wait.h>
@@ -2373,7 +2374,7 @@ static int btintel_pcie_hci_drv_read_info(struct hci_dev *hdev, void *data,
 	u16 opcode, num_supported_commands =
 		ARRAY_SIZE(btintel_pcie_hci_drv_supported_commands);
 
-	rp_size = sizeof(*rp) + num_supported_commands * 2;
+	rp_size = struct_size(rp, supported_commands, num_supported_commands);
 
 	rp = kmalloc(rp_size, GFP_KERNEL);
 	if (!rp)
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

