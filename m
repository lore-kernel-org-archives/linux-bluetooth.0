Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4810D334C13
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574549; cv=none; b=DwUh+pGwUgtbNyiinS2xcKj1uY/YREb9janY7H91RGrVVPL/WuRp/nOkpRf7hClCNcvgJ4jq6kulnhS13KCWxxpSmr//L8F77imnJhKMz0ozVj5BNxI8+I2O8XVv+UiGbxCZNcaXMNV49mT8rj48cXQQLpU7QG8PiaJBkXzJglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574549; c=relaxed/simple;
	bh=5c1gP6x4dLJeq1KTHb9rDAfWjbYQRtgyLYkYgEkv240=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F98hHiB0tIFrOo9sbKZUuooDoqZ/iEbyMZWj+noR4eRQnM2DoQxqlisKPtdxkG/zzjkEzB1ySroqimcq7xfY1dLriVKi7ehKUEqbXAJX88bmq8WRrNu4mJjeADXpyy6R09+1m7LvPNrhkOpaNrXepQZWJ/rSB6lcN2wF/c0NTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oVyKxb1v; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oVyKxb1v"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771574536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aB4n5OGLZi0GRqIuGAXu+AgsLlHy39nmgJ8AKbZreq4=;
	b=oVyKxb1vH6nf29w2xHflwlpQnNUXJlEyB23K1pClgA8/2jNr8CpzUHrNPUYdeZfP74eTA8
	GA6QMA6vQplh46lTMJS6fyS1mU1mxwsy7rh/Lb6IvcTyLXX+51cuPTe0bbWbQguLfDfG+r
	n0cNCTRI1S8gugayybnBFaq8vUE1sKE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel_pcie: Replace snprintf("%s") with strscpy
Date: Fri, 20 Feb 2026 09:00:59 +0100
Message-ID: <20260220080058.1112042-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace snprintf("%s", ...) with the faster and more direct strscpy().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/bluetooth/btintel_pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index eaf5de46a702..82399ad99d96 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/pci.h>
+#include <linux/string.h>
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -268,7 +269,7 @@ static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
 	if (!skb)
 		return;
 
-	snprintf(buf, sizeof(buf), "%s", "---- Dump of debug registers ---");
+	strscpy(buf, "---- Dump of debug registers ---");
 	bt_dev_dbg(hdev, "%s", buf);
 	skb_put_data(skb, buf, strlen(buf));
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

