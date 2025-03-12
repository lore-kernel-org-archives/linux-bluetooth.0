Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9414879B
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 06:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741759920; cv=none; b=kJ9ayfCmujBOIQkNCywG7wRTUGaJFL4yHL5CvVed97/0JS7Zgk6k5HqRMbr3XuU0OZ+oMf0u8gc/B249HalYumb74IH1lmoLavmjek9gPEd7g71h1KxiwLxph00OWhTO628DMT2e7pZyl1wZwI1ZnNYD+djNJ/U2sWzboopnL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741759920; c=relaxed/simple;
	bh=3gUYVXUImx1evT7tSBl3zlk/8cB+RVqW6Vd0zD56Ewg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ubOzdJg0Xd/qD+NDzj7gVoDMfRSJ+z490i0rBl421rbgmleoVS2cToYZa62LkmQAKUY8xi0HIXLPTV0DZqH5TVjLJFAo6751mdoaOl3TWege3fewunBMc3XQOMhbZ03kgMi3qggVUVfVbCwJA0xopokX92//QPUyU4ez5ytfBU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Rda6wzJm; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Rda6wzJm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=24AMA
	qZj9+CBjN+19Li4jBovtaXcNsGtNcCbAHy+xs8=; b=Rda6wzJmdf+h6hayJSWu7
	cxoe1idCGTeaV0HLDo56oGmblSHRSB18sayZSfQZ8/b4f8hAodHUkJLom8OT9tba
	WVeAiyaIqophbKW4awapXEooIXw08OOCeJiUOFgJOuzJXJKjYnylPjTw8bbxF4aw
	PrYkof4YRsbEcd/DgsMiD0=
Received: from A207080518.realsil.com.cn (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBHjvOgJdFnHArkKg--.9333S2;
	Wed, 12 Mar 2025 14:11:45 +0800 (CST)
From: michael_kong <kx960506@163.com>
To: linux-bluetooth@vger.kernel.org
Cc: michael_kong <kx960506@163.com>
Subject: [PATCH BlueZ] share/hci: Fix data type in bt_hci_send_data
Date: Wed, 12 Mar 2025 14:11:28 +0800
Message-Id: <20250312061128.1084-1-kx960506@163.com>
X-Mailer: git-send-email 2.29.1.windows.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBHjvOgJdFnHArkKg--.9333S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRCPfQDUUUU
X-CM-SenderInfo: dn0zliqvqwqiywtou0bp/xtbBDxkOumfRH5fPDgAAsd

The data type in bt_hci_send_data shall be ACL, SCO or ISO.
---
 src/shared/hci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/hci.c b/src/shared/hci.c
index 07fdffc82..575254c09 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -620,7 +620,7 @@ bool bt_hci_send_data(struct bt_hci *hci, uint8_t type, uint16_t handle,
 	switch (type) {
 	case BT_H4_ACL_PKT:
 	case BT_H4_SCO_PKT:
-	case BT_H4_EVT_PKT:
+	case BT_H4_ISO_PKT:
 		break;
 	default:
 		return false;
-- 
2.29.1.windows.1

